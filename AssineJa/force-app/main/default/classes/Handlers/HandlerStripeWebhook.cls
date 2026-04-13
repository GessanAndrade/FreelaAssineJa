@RestResource(urlMapping='/stripe/webhooks/*')
global without sharing class HandlerStripeWebhook {

    @HttpPost
    global static void handleNotification() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        if (req.requestBody == null || String.isBlank(req.requestBody.toString())) {
            res.statusCode = 400;
            res.responseBody = Blob.valueOf(JSON.serialize(new Map<String, String>{'error' => 'Empty body'}));
            return;
        }

        String jsonBody = req.requestBody.toString();

        try {
            FactoryStripeWebHook.getServiceStripeWebHook().handleNotification(jsonBody);

            System.debug('--- WEBHOOK ---');

            res.statusCode = 200;
            res.responseBody = Blob.valueOf(JSON.serialize(new Map<String, String>{'status' => 'success'}));
            
        } catch (Exception e) {
            
            System.debug('--- ERRO NO PROCESSAMENTO DO WEBHOOK ---');
            System.debug('Mensagem: ' + e.getMessage());
            System.debug('StackTrace: ' + e.getStackTraceString());
            
            res.statusCode = 400;
            res.responseBody = Blob.valueOf(JSON.serialize(new Map<String, String>{
                'error' => e.getMessage(),
                'type' => e.getTypeName()
            }));
        }
    }
}