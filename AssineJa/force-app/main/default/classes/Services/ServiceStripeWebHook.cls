public without sharing class ServiceStripeWebHook implements InterfaceStripeWebhook {
    
    private InterfaceCustomerSupport icustomerSupport;
    
    public ServiceStripeWebHook(InterfaceCustomerSupport icustomerSupport) {
        this.icustomerSupport = icustomerSupport;
    }

    public void handleNotification(String jsonBody) {
        
        Map<String, Object> event = (Map<String, Object>) JSON.deserializeUntyped(jsonBody);
        String eventType = (String) event.get('type');
        
        Map<String, Object> dataMap = (Map<String, Object>) event.get('data');
        if (dataMap == null) return;
        
        Map<String, Object> objMap = (Map<String, Object>) dataMap.get('object');
        if (objMap == null) return;

        if (eventType == 'invoice.paid') {
            handleGeneralApply('Fatura Paga!', 'Baixa', objMap);
        } else if (eventType == 'customer.subscription.deleted') {
            handleGeneralApply('Assinatura cancelada!', 'Media', objMap);
        } else if (eventType == 'invoice.payment_failed') {
            handleGeneralApply('Fatura Falhou!', 'Alta', objMap);
        }
    }

    private void handleGeneralApply(String msg, String priority, Map<String, Object> stripeObject) {
       
        String customerIdStripe = (String) stripeObject.get('customer');
        String customerEmail = (String) stripeObject.get('customer_email');
        String add_info = JSON.serialize(stripeObject);

        String subscriptionId = (String) stripeObject.get('subscription');

        if (String.isBlank(subscriptionId) && stripeObject.containsKey('parent')) {
            Map<String, Object> parentMap = (Map<String, Object>) stripeObject.get('parent');
            if (parentMap != null) {
                Map<String, Object> subDetails = (Map<String, Object>) parentMap.get('subscription_details');
                if (subDetails != null) {
                    subscriptionId = (String) subDetails.get('subscription');
                }
            }
        }
        
        Object rawAmount = stripeObject.get('amount_paid');
        if (rawAmount == null) rawAmount = stripeObject.get('total'); 
        
        Decimal amountFinal = (rawAmount != null) ? Decimal.valueOf(String.valueOf(rawAmount)) / 100 : 0;

        String description = msg + 
                             '\n| Id Stripe: ' + (customerIdStripe != null ? customerIdStripe : 'N/A') + 
                             '\n| E-mail: ' + (customerEmail != null ? customerEmail : 'N/A') +
                             '\n| Assinatura Stripe: ' + (subscriptionId != null ? subscriptionId : 'N/A') + 
                             '\n| Valor: R$ ' + amountFinal.setScale(2);

        try {

            icustomerSupport.createTicket(customerIdStripe, description, priority, add_info); 
        } catch (Exception e) {
            System.debug('Falha ao vincular Ticket ao Cliente Stripe. Criando ticket órfão. Erro: ' + e.getMessage());
            
            icustomerSupport.createTicket(null, description + '\n[AVISO: Registro órfão - Falha no vínculo automático]', priority, add_info);
        }
    }
}