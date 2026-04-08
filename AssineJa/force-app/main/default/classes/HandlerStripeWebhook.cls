@RestResource(urlMapping='/stripe/webhooks/*')
global class HandlerStripeWebhook {

    @HttpPost
    global static void handleNotification() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        // O corpo da requisição enviado pela Stripe
        String jsonBody = req.requestBody.toString();
        
        try {
            // Transformar o JSON em um mapa para ler os dados
            Map<String, Object> event = (Map<String, Object>) JSON.deserializeUntyped(jsonBody);
            String eventType = (String) event.get('type');

            System.debug('Evento recebido da Stripe: ' + eventType);

            // Lógica para diferentes tipos de eventos
            if (eventType == 'invoice.paid') {
                // Lógica para quando uma fatura é paga
                handleInvoicePaid(event);
            } else if (eventType == 'customer.subscription.deleted') {
                // Lógica para quando uma assinatura é cancelada
                //handleSubscriptionDeleted(event);
            }

            res.statusCode = 200; // Avisa à Stripe que recebemos com sucesso
        } catch (Exception e) {
            res.statusCode = 400;
            System.debug('Erro no Webhook: ' + e.getMessage());
        }
    }

    private static void handleInvoicePaid(Map<String, Object> event) {
        // Aqui você atualizaria um registro no Salesforce, por exemplo.
        System.debug('Sucesso! Fatura paga recebida.');
    }
}