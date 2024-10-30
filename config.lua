--pixeldev.tebex.io-----https://discord.gg/eYaRkWAM2U
--pixeldev.tebex.io  --Join Discord https://discord.gg/eYaRkWAM2U

Config = {}

-- Jobs allowed to send invoices
Config.AllowedJobs = {
    ["sheriff"] = true,
    ["marshal"] = true,
    ["police"] = true,
    ["medic"] = true,
    ["doctor"] = true
    -- Add any other jobs that should have access
}
-- Default language
Config.DefaultLanguage = "en"
-- Maximum invoice amount
Config.MaxInvoiceAmount = 1000
Config.Debug = true

-- Time (in days) before an unpaid invoice expires
Config.InvoiceExpirationDays = 7

-- Notification settings
Config.Notifications = {
    ShowToSender = true,
    ShowToReceiver = true
}

-- Webhook URLs
Config.Webhooks = {
    InvoiceSent = "https://discord.com/api/webhooks/your_webhook_url_here",
    InvoicePaid = "https://discord.com/api/webhooks/your_webhook_url_here",
    InvoiceCollected = "https://discord.com/api/webhooks/your_webhook_url_here"
}
--pixeldev.tebex.io  --Join Discord https://discord.gg/eYaRkWAM2U
-- Language settings
Config.Language = {
    ["en"] = {
        invoiceSent = "Invoice sent to %s",
        invoicePaid = "Invoice paid successfully",
        insufficientFunds = "Not enough cash to pay the invoice",
        invoiceNotFound = "Invoice not found",
        unauthorized = "You are not authorized to perform this action",
        collectInvoice = "Collect Invoice",
        invoiceCollected = "Invoice collected successfully",
        sendInvoice = "Send Invoice",
        selectPlayer = "Select a player",
        description = "Description",
        amount = "Amount",
        from = "From",
        job = "Job",
        actions = "Actions",
        pay = "Pay",
        to = "To",
        collect = "Collect",
        yourInvoices = "Your Invoices",
        collectInvoices = "Collect Invoices",
        invoiceCollected = "Invoice collected successfully",
        errorCollecting = "Error collecting invoice",
        errorPaying = "Error paying invoice",
        errorProcessing = "Error processing the invoice. Please try again.",
        invalidInput = "fill allDetails correct",
        invalidAmount = "Amount is not valid.",
        amountTooHigh = "amount is to high.",
        invoiceSentSuccess = "invoice sent",
        invoiceDeleted = "Invoice deleted successfully",
        errorDeletingInvoice = "Error deleting invoice. Please try again.",
        refreshInvoices = "Refresh Invoices",
        refreshCollect = "Refresh Collect",
    },
    ["es"] = {
        invoiceSent = "Factura enviada a %s",
        invoicePaid = "Factura pagada con éxito",
        insufficientFunds = "No hay suficiente dinero para pagar la factura",
        invoiceNotFound = "Factura no encontrada",
        unauthorized = "No estás autorizado para realizar esta acción",
        collectInvoice = "Cobrar Factura",
        invoiceCollected = "Factura cobrada con éxito",
        sendInvoice = "Enviar Factura",
        selectPlayer = "Seleccionar jugador",
        description = "Descripción",
        amount = "Cantidad",
        from = "De",
        job = "Trabajo",
        actions = "Acciones",
        pay = "Pagar",
        to = "Para",
        collect = "Cobrar",
        yourInvoices = "Tus Facturas",
        collectInvoices = "Cobrar Facturas",
        invoiceCollected = "Factura cobrada con éxito",
        errorCollecting = "Error al cobrar la factura",
        errorPaying = "Error al pagar la factura",
        errorProcessing = "Error al procesar la factura. Por favor, inténtelo de nuevo.",
        invalidInput = "fill allDetails correct",
        invalidAmount = "Amount is not valid.",
        amountTooHigh = "amount is to high.",
        invoiceDeleted = "Factura eliminada con éxito",
        errorDeletingInvoice = "Error al eliminar la factura. Por favor, inténtelo de nuevo.",
        invoiceSentSuccess = "invoice sent",
        refreshInvoices = "Actualizar Facturas",
        refreshCollect = "Actualizar Cobros",
    }
    -- Add more languages as needed
}

--pixeldev.tebex.io  --Join Discord https://discord.gg/eYaRkWAM2U



-- New option for command-based invoice sending
Config.SendInvoiceUI = false  -- Set to false to use command-based invoice sending
