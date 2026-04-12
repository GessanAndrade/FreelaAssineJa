@RestResource(urlMapping='/stripe/webhooks/*')
global without sharing class HandlerStripeWebhook {

    @HttpPost
    global static void handleNotification() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        if (req.requestBody == null) {
            res.statusCode = 400;
            res.responseBody = Blob.valueOf('Empty body');
            return;
        }

        String jsonBody = req.requestBody.toString();
        
        try {
            Map<String, Object> event = (Map<String, Object>) JSON.deserializeUntyped(jsonBody);
            String eventType = (String) event.get('type');
            Map<String, Object> dataMap = (Map<String, Object>) event.get('data');
            Map<String, Object> objMap = (Map<String, Object>) dataMap.get('object');

            // Roteamento de eventos
            if (eventType == 'invoice.paid') {
                handleInvoicePaid(objMap);
            } else if (eventType == 'customer.subscription.deleted') {
                handleSubscriptionDeleted(objMap);
            } else if (eventType == 'invoice.payment_failed') {
                handlePaymentFailed(objMap);
            }

            res.statusCode = 200; 
            res.responseBody = Blob.valueOf(JSON.serialize(new Map<String, String>{'status' => 'success'}));
        } catch (Exception e) {
            System.debug('--- ERRO FATAL WEBHOOK ---');
            System.debug('Mensagem: ' + e.getMessage());
            
            res.statusCode = 400;
            res.responseBody = Blob.valueOf('Erro: ' + e.getMessage());
        }
    }

    private static void handleInvoicePaid(Map<String, Object> stripeObject) {
        handleGeneralApply('Fatura Paga!', 'Baixa', stripeObject);  
    }

    private static void handleSubscriptionDeleted(Map<String, Object> stripeObject) {
        handleGeneralApply('Assinatura cancelada!', 'Media', stripeObject);   
    }

    private static void handlePaymentFailed(Map<String, Object> stripeObject) {
        handleGeneralApply('Fatura Falhou!', 'Alta', stripeObject);
    }

    private static void handleGeneralApply(String msg, String priority, Map<String, Object> stripeObject) {
        String customerIdStripe = (String) stripeObject.get('customer');
        String customerEmail = (String) stripeObject.get('customer_email');
        String add_info = JSON.serialize(stripeObject);

        Map<String, Object> parentMap = (Map<String, Object>) stripeObject.get('parent');
    
        String subscriptionId = null;

        if (parentMap != null) {

            Map<String, Object> subDetailsMap = (Map<String, Object>) parentMap.get('subscription_details');
            
            if (subDetailsMap != null) {

                subscriptionId = (String) subDetailsMap.get('subscription');
            }
        }
        
        // Conversão segura de valor
        Object rawAmount = stripeObject.get('amount_paid');
        Decimal amountFinal = (rawAmount != null) ? Decimal.valueOf(String.valueOf(rawAmount)) / 100 : 0;

        // 2. Montagem da descrição detalhada
        String description = msg + 
                             '\n| Id Stripe: ' + customerIdStripe + 
                             '\n| E-mail: ' + customerEmail +
                             '\n| Assinatura Stripe: ' + (subscriptionId != null ? subscriptionId : 'N/A') + 
                             '\n| Valor: R$ ' + amountFinal;

        // 3. Tenta criar o Ticket de Suporte
        try {
            // Tentativa padrão (com ou sem o ID do cliente)
            ServiceCustomerSupport.createTicket(customerIdStripe, description, priority, add_info); 
        } catch (Exception e) {
            // Se falhar (ex: erro de permissão cruzada), tentamos uma última vez sem o vínculo do ID
            System.debug('Erro de Cross-Reference. Tentando criar ticket órfão.');
            ServiceCustomerSupport.createTicket(null, description + '\n[ERRO DE ACESSO AO VINCULAR ID]', priority, add_info);
        }
    }
}