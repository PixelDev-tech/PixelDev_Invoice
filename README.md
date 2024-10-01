**PixeLDev Invoice System Features**


![Screenshot_226](https://github.com/user-attachments/assets/31dde8b5-7271-4f27-9f42-91a20f8598a1)

**Invoice Creation and Management**

Authorized jobs can create and send invoices to other players
Invoices include sender details, receiver details, description, and amount
Maximum invoice amount can be configured


**User Interface**

Separate UIs for sending invoices, paying invoices, and collecting payments
Commands to open different UIs: /sendinvoice, /invoice, /collectinvoice
UI can be closed using the ESC key



**Payment Processing**

Players can view and pay their unpaid invoices
Automatic currency transfer from payer to invoice sender upon payment
Real-time updates of invoice status


**Job-based Authorization**

Configurable list of jobs allowed to create and manage invoices
Job-specific invoice collection and management


**Invoice Lifecycle Management**

Invoices can be marked as Paid or Unpaid
Paid invoices can be collected by authorized job holders
Automatic cleanup of expired unpaid invoices


**Real-time Updates**

Dynamic updating of invoice lists and unpaid bills
Immediate reflection of changes in the UI


**Webhook Integration**

Configurable webhooks for various events (invoice sent, paid, collected)
Helps in monitoring and logging invoice activities


**Language Localization**

Support for multiple languages through a configuration file

****    Requirements****
