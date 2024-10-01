local display = false
local currentUI = ""


function HideUI()
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "closeUI"
    })
    display = false
    currentUI = ""
end


AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    HideUI()
end)

RegisterNUICallback('nuiReady', function(data, cb)
    HideUI()
    cb('ok')
end)
RegisterNetEvent('PixelDev_Invoice:callback')
AddEventHandler('PixelDev_Invoice:callback', function(responseJson)
    SendNUIMessage({
        type = "invoiceCallback",
        data = responseJson
    })
end)

RegisterNUICallback('sendInvoice', function(data, cb)
    local playerJob = GetPlayerJob()
    TriggerServerEvent('PixelDev_Invoice:sendInvoice', data.playerId, data.description, data.amount, playerJob)
    cb('ok')
end)

RegisterNUICallback('payInvoice', function(data, cb)
    TriggerServerEvent('PixelDev_Invoice:payInvoice', data.invoiceId)
    cb('ok')
end)

RegisterNUICallback('collectInvoice', function(data, cb)
    TriggerServerEvent('PixelDev_Invoice:collectInvoice', data.invoiceId)
    cb('ok')
end)

RegisterNUICallback('closeUI', function(data, cb)
    CloseInvoiceUI()
    cb('ok')
end)

RegisterNUICallback('getOnlinePlayers', function(data, cb)
    TriggerServerEvent('PixelDev_Invoice:getOnlinePlayers')
    cb('ok')
end)

RegisterNUICallback('getUnpaidBills', function(data, cb)
   -- print("Getting unpaid bills for player:", data.playerId)
    TriggerServerEvent('PixelDev_Invoice:getUnpaidBills', data.playerId)
    cb('ok')
end)

RegisterNUICallback('showNotification', function(data, cb)
    if data.type == 'error' then
        TriggerEvent('vorp:TipBottom', data.message, 5000)
    else
        TriggerEvent('vorp:Tip', data.message, 5000)
    end
    cb('ok')
end)



function OpenSendInvoiceUI()
    if not display then
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "openUI",
            uiType = "sendInvoice",
            lang = Config.Language[Config.DefaultLanguage]
        })
        display = true
        currentUI = "sendInvoice"
        TriggerServerEvent('PixelDev_Invoice:getOnlinePlayers')
    end
end

function OpenPayInvoiceUI()
    if not display then
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "openUI",
            uiType = "payInvoice",
            lang = Config.Language[Config.DefaultLanguage]
        })
        display = true
        currentUI = "payInvoice"
        TriggerServerEvent('PixelDev_Invoice:getPlayerInvoices')
    end
end

function OpenCollectInvoiceUI()
    if not display then
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "openUI",
            uiType = "collectInvoice",
            lang = Config.Language[Config.DefaultLanguage]
        })
        display = true
        currentUI = "collectInvoice"
        TriggerServerEvent('PixelDev_Invoice:getJobInvoices')
    end
end

function CloseInvoiceUI()
    HideUI()
end

function CloseInvoiceUI()
    if display then
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = "closeUI"
        })
        display = false
        currentUI = ""
    end
end

-- Command to open the send invoice UI (for authorized jobs only)
RegisterCommand('sendinvoice', function()
    OpenSendInvoiceUI()
end, false)

-- Command to open the pay invoice UI (for all players)
RegisterCommand('invoice', function()
    OpenPayInvoiceUI()
end, false)

-- Command to open the collect invoice UI (for authorized jobs only)
RegisterCommand('collectinvoice', function()
    OpenCollectInvoiceUI()
end, false)

-- Close UI when pressing ESC
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if display then
            if IsControlJustReleased(0, 0x3C3DD371) then -- ESCAPE key
                CloseInvoiceUI()
            end
        end
    end
end)

RegisterNetEvent('PixelDev_Invoice:updateInvoices')
AddEventHandler('PixelDev_Invoice:updateInvoices', function(invoices)
    if display and currentUI == "payInvoice" then
        SendNUIMessage({
            type = "updateInvoices",
            invoices = invoices
        })
    end
end)



RegisterNetEvent('PixelDev_Invoice:refreshJobInvoices')
AddEventHandler('PixelDev_Invoice:refreshJobInvoices', function()
    TriggerServerEvent('PixelDev_Invoice:getJobInvoices')
end)
RegisterNetEvent('PixelDev_Invoice:invoicePaid')
AddEventHandler('PixelDev_Invoice:invoicePaid', function(data)
    SendNUIMessage({
        type = "invoicePaid",
        success = data.success,
        message = data.message,
        invoiceId = data.invoiceId
    })
    if data.success then
        -- Refresh the player's invoices immediately after payment
        TriggerServerEvent('PixelDev_Invoice:getPlayerInvoices')
    end
end)

RegisterNetEvent('PixelDev_Invoice:invoiceCollected')
AddEventHandler('PixelDev_Invoice:invoiceCollected', function(data)
    SendNUIMessage({
        type = "invoiceCollected",
        success = data.success,
        message = data.message,
        invoiceId = data.invoiceId
    })
    if data.success then
        -- Refresh the job invoices immediately after collection
        TriggerServerEvent('PixelDev_Invoice:getJobInvoices')
    end
end)

RegisterNetEvent('PixelDev_Invoice:updateJobInvoices')
AddEventHandler('PixelDev_Invoice:updateJobInvoices', function(invoices)
    if display and currentUI == "collectInvoice" then
        SendNUIMessage({
            type = "updateJobInvoices",
            invoices = invoices
        })
    end
end)

RegisterNetEvent('PixelDev_Invoice:refreshInvoices')
AddEventHandler('PixelDev_Invoice:refreshInvoices', function(invoiceType)
    if invoiceType == 'player' then
        TriggerServerEvent('PixelDev_Invoice:getPlayerInvoices')
    elseif invoiceType == 'job' then
        TriggerServerEvent('PixelDev_Invoice:getJobInvoices')
    end
end)

RegisterNetEvent('PixelDev_Invoice:receiveOnlinePlayers')
AddEventHandler('PixelDev_Invoice:receiveOnlinePlayers', function(players)
    if display and currentUI == "sendInvoice" then
        SendNUIMessage({
            type = "updateOnlinePlayers",
            players = players
        })
    end
end)

RegisterNUICallback('deleteInvoice', function(data, cb)
   -- print("Deleting invoice:", data.invoiceId)
    TriggerServerEvent('PixelDev_Invoice:deleteInvoice', data.invoiceId)
    cb('ok')
end)
RegisterNetEvent('PixelDev_Invoice:invoiceDeleted')
AddEventHandler('PixelDev_Invoice:invoiceDeleted', function(success)
    SendNUIMessage({
        type = "invoiceDeleted",
        success = success
    })
end)
RegisterNetEvent('PixelDev_Invoice:deleteInvoiceResponse')
AddEventHandler('PixelDev_Invoice:deleteInvoiceResponse', function(responseJson)
  --  print("Received delete invoice response:", responseJson)
    SendNUIMessage({
        type = "deleteInvoiceResponse",
        response = responseJson
    })
end)
RegisterNetEvent('PixelDev_Invoice:updateUnpaidBills')
AddEventHandler('PixelDev_Invoice:updateUnpaidBills', function(billsJson)
  --  print("Received unpaid bills update:", billsJson)
    SendNUIMessage({
        type = "updateUnpaidBills",
        bills = billsJson
    })
end)

-- New function to get player's current job
function GetPlayerJob()
    local job = nil
    TriggerEvent('vorp:getCharacter', function(user)
        job = user.job
    end)
    return job
end



RegisterNetEvent('PixelDev_Invoice:invoiceSent')
AddEventHandler('PixelDev_Invoice:invoiceSent', function(success, message)
    SendNUIMessage({
        type = "invoiceSent",
        success = success,
        message = message
    })
end)
-- Add this new function to handle fetching unpaid bills
function FetchUnpaidBills(targetPlayerId)
    TriggerServerEvent('PixelDev_Invoice:getUnpaidBills', targetPlayerId)
end

-- Update the onPlayerSelect function
function onPlayerSelect()
    local playerSelect = document.getElementById('playerSelect')
    if playerSelect and playerSelect.value then
        FetchUnpaidBills(playerSelect.value)
    end
end
-- Initialize the UI as hidden when the resource starts
Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "closeUI"
    })
end)