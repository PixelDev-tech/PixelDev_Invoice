local VorpCore = {}

TriggerEvent("getCore", function(core)
    VorpCore = core
end)

-- Helper function to safely convert to number
function safeNumber(value)
   -- debugPrint("safeNumber input:", value, "Type:", type(value))
    if type(value) == "number" then
        return value
    elseif type(value) == "string" then
        return tonumber(value) or 0
    elseif type(value) == "table" then
        -- If it's a table, first check for a 'money' key
        if value.money then
            --debugPrint("Found 'money' key in table:", value.money, "Type:", type(value.money))
            return safeNumber(value.money)  -- Recursive call to handle the 'money' value
        end
        -- If no 'money' key, try to find any numeric value
        for k, v in pairs(value) do
           -- debugPrint("Table key:", k, "Value:", v, "Type:", type(v))
            if type(v) == "number" then
                return v
            elseif type(v) == "string" then
                local num = tonumber(v)
                if num then return num end
            end
        end
    end
    return 0
end
--pixeldev.tebex.io
-- Safe comparison function
local function safeCompare(a, b, operation)
    if type(a) ~= "number" or type(b) ~= "number" then
       -- debugPrint("Error: Attempting to compare non-numbers")
        --debugPrint("a:", a, "Type:", type(a))
        --debugPrint("b:", b, "Type:", type(b))
        return false
    end
    
    if operation == ">" then
        return a > b
    elseif operation == ">=" then
        return a >= b
    elseif operation == "<" then
        return a < b
    elseif operation == "<=" then
        return a <= b
    elseif operation == "==" then
        return a == b
    else
       -- debugPrint("Error: Unknown comparison operation", operation)
        return false
    end
end

-- Enhanced debug print function
function debugPrint(...)
    local args = {...}
    local printString = "[VORP Invoice Debug] "
    for i, v in ipairs(args) do
        printString = printString .. tostring(v) .. " "
    end
    print(printString)
end

-- Function to fetch player invoices
function FetchPlayerInvoices(playerId, callback)
   -- debugPrint("Fetching invoices for player:", playerId)
    exports.oxmysql:execute('SELECT * FROM invoices WHERE receiver_id = ? AND status = ?', {tostring(playerId), 'Unpaid'},
        function(results)
           -- debugPrint("Fetched invoices. Count:", #results)
            callback(results)
        end
    )
end

-- Update the SaveInvoice function to ensure job is stored
function SaveInvoice(senderId, senderName, senderJob, receiverId, receiverName, description, amount)
    exports.oxmysql:insert('INSERT INTO invoices (sender_id, sender_name, sender_job, receiver_id, receiver_name, description, amount, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        {senderId, senderName, senderJob, receiverId, receiverName, description, amount, 'Unpaid'},
        function(id)
            if id then
              --  debugPrint("Invoice saved to database with ID:", id)
            else
               -- debugPrint("Failed to save invoice to database")
            end
        end
    )
end

-- Function to send webhook
function SendWebhook(url, message)
   -- debugPrint("SendWebhook called with URL:", url, "and message:", message)
    PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('PixelDev_Invoice:sendInvoice')
AddEventHandler('PixelDev_Invoice:sendInvoice', function(targetPlayerId, description, amount)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local senderName = Character.firstname .. ' ' .. Character.lastname
    local senderJob = Character.job

    -- Check if sender's job is allowed to send invoices
    if not Config.AllowedJobs[senderJob] then
        TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].unauthorized, 5000)
        return
    end

    -- Validate input
    if not targetPlayerId or not description or not amount then
        TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].invalidInput, 5000)
        return
    end

    -- Convert amount to number and check if it's valid
    amount = tonumber(amount)
    if not amount or amount <= 0 then
        TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].invalidAmount, 5000)
        return
    end

    -- Check if amount exceeds maximum allowed
    if amount > Config.MaxInvoiceAmount then
        TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].amountTooHigh, 5000)
        return
    end

    local targetCharacter = VorpCore.getUser(tonumber(targetPlayerId)).getUsedCharacter
    if targetCharacter then
        local receiverName = targetCharacter.firstname .. ' ' .. targetCharacter.lastname

        SaveInvoice(_source, senderName, senderJob, targetPlayerId, receiverName, description, amount)
        TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].invoiceSent:format(receiverName), 5000)
        TriggerClientEvent('PixelDev_Invoice:updateInvoices', tonumber(targetPlayerId))

        -- Update unpaid bills for the sender
        FetchUnpaidBills(targetPlayerId, function(bills)
            TriggerClientEvent('PixelDev_Invoice:updateUnpaidBills', _source, bills)
        end)

        -- Send webhook for invoice sent
        local webhookMessage = string.format("New invoice sent: %s (%s) sent an invoice of $%s to %s for %s", senderName, senderJob, amount, receiverName, description)
        SendWebhook(Config.Webhooks.InvoiceSent, webhookMessage)

        -- Notify the sender of success
        TriggerClientEvent('PixelDev_Invoice:invoiceSent', _source, true, Config.Language[Config.DefaultLanguage].invoiceSentSuccess)
    else
        TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].playerNotFound, 5000)
        TriggerClientEvent('PixelDev_Invoice:invoiceSent', _source, false, Config.Language[Config.DefaultLanguage].playerNotFound)
    end
end)
--pixeldev.tebex.io
-- Make sure to add these functions if they don't exist already


function SendWebhook(url, message)
    PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('PixelDev_Invoice:payInvoice')
AddEventHandler('PixelDev_Invoice:payInvoice', function(invoiceId)
    local _source = source
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter

    if User then
        local playerMoney = safeNumber(Character.money)
        
        exports.oxmysql:execute('SELECT * FROM invoices WHERE id = ?', {invoiceId}, function(results)
            if #results > 0 then
                local invoice = results[1]
                local invoiceAmount = safeNumber(invoice.amount)
                
                if safeCompare(playerMoney, invoiceAmount, ">=") then
                    -- Remove money from player
                    Character.removeCurrency(0, invoiceAmount)
                    
                    -- Add money to sender
                    VorpCore.getUser(tonumber(invoice.sender_id), function(sender)
                        if sender then
                            local senderCharacter = sender.getUsedCharacter
                            senderCharacter.addCurrency(0, invoiceAmount)
                            TriggerClientEvent('vorp:TipBottom', sender.source, Config.Language[Config.DefaultLanguage].invoicePaid, 5000)
                        end
                    end)

                    -- Update invoice status
                    exports.oxmysql:execute('UPDATE invoices SET status = ? WHERE id = ?', {'Paid', invoiceId}, function(result)
                        if result.affectedRows > 0 then
                            TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].invoicePaid, 5000)
                            
                            -- Send success response to client
                            local response = json.encode({
                                success = true,
                                message = Config.Language[Config.DefaultLanguage].invoicePaid,
                                invoiceId = invoiceId
                            })
                            TriggerClientEvent('PixelDev_Invoice:callback', _source, response)
                            
                            -- Send webhook
                            local webhookMessage = string.format("Invoice paid: %s paid an invoice of $%s", Character.firstname .. ' ' .. Character.lastname, invoiceAmount)
                            SendWebhook(Config.Webhooks.InvoicePaid, webhookMessage)
                        else
                            TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].errorPaying, 5000)
                            local response = json.encode({
                                success = false,
                                message = Config.Language[Config.DefaultLanguage].errorPaying,
                                invoiceId = invoiceId
                            })
                            TriggerClientEvent('PixelDev_Invoice:callback', _source, response)
                        end
                    end)
                else
                    TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].insufficientFunds, 5000)
                    local response = json.encode({
                        success = false,
                        message = Config.Language[Config.DefaultLanguage].insufficientFunds,
                        invoiceId = invoiceId
                    })
                    TriggerClientEvent('PixelDev_Invoice:callback', _source, response)
                end
            else
                TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].invoiceNotFound, 5000)
                local response = json.encode({
                    success = false,
                    message = Config.Language[Config.DefaultLanguage].invoiceNotFound,
                    invoiceId = invoiceId
                })
                TriggerClientEvent('PixelDev_Invoice:callback', _source, response)
            end
        end)
    end
end)

--pixeldev.tebex.io
RegisterServerEvent('PixelDev_Invoice:getPlayerInvoices')
AddEventHandler('PixelDev_Invoice:getPlayerInvoices', function()
    local _source = source
    FetchPlayerInvoices(_source, function(invoices)
        TriggerClientEvent('PixelDev_Invoice:updateInvoices', _source, invoices)
    end)
end)

RegisterServerEvent('PixelDev_Invoice:getJobInvoices')
AddEventHandler('PixelDev_Invoice:getJobInvoices', function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local playerJob = Character.job

    --debugPrint("Get job invoices attempt - Player ID:", _source, "Job:", playerJob)

    if Config.AllowedJobs[playerJob] then
        exports.oxmysql:execute('SELECT * FROM invoices WHERE sender_job = ? AND status = ?', {playerJob, 'Paid'},
            function(results)
                --debugPrint("Fetched job invoices. Count:", #results)
                TriggerClientEvent('PixelDev_Invoice:updateJobInvoices', _source, results)
            end
        )
    else
        --debugPrint("Unauthorized job invoices request")
        TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].unauthorized, 5000)
    end
end)

RegisterServerEvent('PixelDev_Invoice:collectInvoice')
AddEventHandler('PixelDev_Invoice:collectInvoice', function(invoiceId)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local playerJob = Character.job

    if Config.AllowedJobs[playerJob] then
        exports.oxmysql:execute('SELECT * FROM invoices WHERE id = ? AND sender_job = ? AND status = ?', {invoiceId, playerJob, 'Paid'}, function(results)
            if #results > 0 then
                local invoice = results[1]
                local invoiceAmount = safeNumber(invoice.amount)

                -- Add money to collector
                Character.addCurrency(0, invoiceAmount)

                -- Remove the invoice from the database
                exports.oxmysql:execute('DELETE FROM invoices WHERE id = ?', {invoiceId}, function(result)
                    if result.affectedRows > 0 then
                        TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].invoiceCollected, 5000)
                        
                        -- Send success response to client
                        local response = json.encode({
                            success = true,
                            message = Config.Language[Config.DefaultLanguage].invoiceCollected,
                            invoiceId = invoiceId
                        })
                        TriggerClientEvent('PixelDev_Invoice:callback', _source, response)

                        -- Send webhook
                        local webhookMessage = string.format("Invoice collected: %s (%s) collected an invoice of $%s", Character.firstname .. ' ' .. Character.lastname, playerJob, invoiceAmount)
                        SendWebhook(Config.Webhooks.InvoiceCollected, webhookMessage)
                    else
                        TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].errorCollecting, 5000)
                        local response = json.encode({
                            success = false,
                            message = Config.Language[Config.DefaultLanguage].errorCollecting,
                            invoiceId = invoiceId
                        })
                        TriggerClientEvent('PixelDev_Invoice:callback', _source, response)
                    end
                end)
            else
                TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].invoiceNotFound, 5000)
                local response = json.encode({
                    success = false,
                    message = Config.Language[Config.DefaultLanguage].invoiceNotFound,
                    invoiceId = invoiceId
                })
                TriggerClientEvent('PixelDev_Invoice:callback', _source, response)
            end
        end)
    else
        TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].unauthorized, 5000)
        local response = json.encode({
            success = false,
            message = Config.Language[Config.DefaultLanguage].unauthorized,
            invoiceId = invoiceId
        })
        TriggerClientEvent('PixelDev_Invoice:callback', _source, response)
    end
end)
--pixeldev.tebex.io
-- Update the GetOnlinePlayers function
function GetOnlinePlayers()
    local players = {}
    for _, playerId in ipairs(GetPlayers()) do
        local user = VorpCore.getUser(playerId)
        if user then
            local character = user.getUsedCharacter
            table.insert(players, {
                id = playerId,
                name = character.firstname .. ' ' .. character.lastname
            })
        end
    end
    return players
end

-- Event to request online players
RegisterServerEvent('PixelDev_Invoice:getOnlinePlayers')
AddEventHandler('PixelDev_Invoice:getOnlinePlayers', function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local playerJob = Character.job

    --debugPrint("Get online players attempt - Player ID:", _source, "Job:", playerJob)

    if Config.AllowedJobs[playerJob] then
        local onlinePlayers = GetOnlinePlayers()
       -- debugPrint("Sending online players list. Count:", #onlinePlayers)
        TriggerClientEvent('PixelDev_Invoice:receiveOnlinePlayers', _source, onlinePlayers)
    else
       -- debugPrint("Unauthorized online players request")
        TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].unauthorized, 5000)
    end
end)

-- Add this new event handler
RegisterServerEvent('PixelDev_Invoice:deleteInvoice')
AddEventHandler('PixelDev_Invoice:deleteInvoice', function(invoiceId)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local playerJob = Character.job

  --  debugPrint("Delete invoice attempt - Player ID:", _source, "Invoice ID:", invoiceId, "Job:", playerJob)

    if Config.AllowedJobs[playerJob] then
        exports.oxmysql:execute('DELETE FROM invoices WHERE id = ? AND status = ?', {invoiceId, 'Unpaid'},
            function(result)
                if result and result.affectedRows and result.affectedRows > 0 then
                   -- debugPrint("Invoice deleted successfully")
                    TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].invoiceDeleted, 5000)
                    -- Send a separate event to update the client-side UI
                    TriggerClientEvent('PixelDev_Invoice:invoiceDeleted', _source, true)
                else
                   -- debugPrint("Failed to delete invoice")
                    TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].errorDeletingInvoice, 5000)
                    TriggerClientEvent('PixelDev_Invoice:invoiceDeleted', _source, false)
                end
                
                -- Fetch and send updated unpaid bills
                FetchUnpaidBills(_source)
            end
        )
    else
        --debugPrint("Unauthorized delete attempt")
        TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].unauthorized, 5000)
        TriggerClientEvent('PixelDev_Invoice:invoiceDeleted', _source, false)
    end
end)


--pixeldev.tebex.io

-- Add this helper function for debug printing
function debugPrint(...)
    if Config.Debug then
        print(string.format("[VORP Invoice] %s", table.concat({...}, " ")))
    end
end
-- Add this new event handler
RegisterServerEvent('PixelDev_Invoice:getUnpaidBills')
AddEventHandler('PixelDev_Invoice:getUnpaidBills', function(targetPlayerId)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local playerJob = Character.job

    --debugPrint("Get unpaid bills attempt - Requester ID:", _source, "Target ID:", targetPlayerId, "Job:", playerJob)

    if Config.AllowedJobs[playerJob] then
        FetchUnpaidBills(targetPlayerId)
    else
        --debugPrint("Unauthorized unpaid bills request")
        TriggerClientEvent('vorp:TipBottom', _source, Config.Language[Config.DefaultLanguage].unauthorized, 5000)
    end
end)

-- Update the FetchUnpaidBills function
function FetchUnpaidBills(playerId)
    --debugPrint("Fetching unpaid bills for player:", playerId)
    exports.oxmysql:execute('SELECT id, sender_name, sender_job, description, amount, created_at FROM invoices WHERE receiver_id = ? AND status = ? ORDER BY created_at DESC', {tostring(playerId), 'Unpaid'},
        function(results)
            if not results then
                results = {}
            end
           -- debugPrint("Fetched unpaid bills. Count:", #results)
            local jsonResponse = json.encode(results)
            --debugPrint("Sending unpaid bills response:", jsonResponse)
            TriggerClientEvent('PixelDev_Invoice:updateUnpaidBills', playerId, jsonResponse)
        end
    )
end


--pixeldev.tebex.io
-- Function to clean up expired invoices
function CleanupExpiredInvoices()
    local currentTime = os.time()
    local expirationTime = currentTime - (Config.InvoiceExpirationDays * 24 * 60 * 60) -- Convert days to seconds

    exports.oxmysql:execute('DELETE FROM invoices WHERE created_at < ? AND status = ?', {expirationTime, 'Unpaid'},
        function(result)
            local deletedCount = result.affectedRows or 0
           -- debugPrint("Cleaned up expired invoices. Count:", deletedCount)
        end
    )
end

-- Run cleanup periodically (e.g., once a day)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(24 * 60 * 60 * 1000) -- Wait for 24 hours
        CleanupExpiredInvoices()
    end
end)

-- Initialize the script
Citizen.CreateThread(function()
    --debugPrint("VORP Invoice System Initialized")
    -- Perform any necessary initialization here
end)
-- New event to handle showing notifications
RegisterServerEvent('PixelDev_Invoice:showNotification')
AddEventHandler('PixelDev_Invoice:showNotification', function(message, type)
    local _source = source
    if type == 'error' then
        TriggerClientEvent('vorp:NotifyLeft', _source, "Invoice System", message, "generic_textures", "tick", 4000, "COLOR_RED")
    else
        TriggerClientEvent('vorp:NotifyLeft', _source, "Invoice System", message, "generic_textures", "tick", 4000, "COLOR_GREEN")
    end
end)
