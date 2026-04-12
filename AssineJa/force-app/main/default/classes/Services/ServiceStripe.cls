public class ServiceStripe {
    private static final String STRIPE_API_KEY = 'sk_test_51TJKU55t2okTvzPmtaEjZAlfZRwy8v4qiDJWRCccmoPLJwFz26NL24uc8rjaTvU2yYHHTRmaTXedSagDTCN8YUAd00rTNLjvDU';
    private static final String BASE_URL = 'https://api.stripe.com/v1';

    public static String customerExists(String email) {
        HttpRequest req = new HttpRequest();
        String queryValue = 'email:"' + email + '"';
        req.setEndpoint(BASE_URL + '/customers/search?query=' + EncodingUtil.urlEncode(queryValue, 'UTF-8'));
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + STRIPE_API_KEY);
        
        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            return res.getBody(); 
        } catch (Exception e) {
            return '{"error": "' + e.getMessage() + '"}';
        }
    }

    public static String createStripeCustomer(String name, String email) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BASE_URL + '/customers');
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + STRIPE_API_KEY);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        String body = 'name=' + EncodingUtil.urlEncode(name, 'UTF-8') + 
                      '&email=' + EncodingUtil.urlEncode(email, 'UTF-8');
        req.setBody(body);

        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            return res.getBody();
        } catch (Exception e) {
            return '{"error": "' + e.getMessage() + '"}';
        }
    }

    /**
     * NOVO: Anexa um meio de pagamento de teste e define como padrão.
     * Isso resolve o erro "This customer has no attached payment source".
     */
    public static void attachTestPaymentMethod(String customerId) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BASE_URL + '/customers/' + customerId);
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + STRIPE_API_KEY);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        // 'tok_visa' é um token de teste do Stripe que representa um cartão válido
        String body = 'source=tok_chargeCustomerFail'; 
        req.setBody(body);

        Http http = new Http();
        try {
            http.send(req); // Atualiza o cliente com o cartão de teste
        } catch (Exception e) {
            System.debug('Erro ao anexar cartão de teste: ' + e.getMessage());
        }
    }

    public static String createStripeSubscription(String customerId, String priceId) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BASE_URL + '/subscriptions');
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + STRIPE_API_KEY);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        // Definimos collection_method como charge_automatically
        String body = 'customer=' + EncodingUtil.urlEncode(customerId, 'UTF-8') + 
                      '&items[0][price]=' + EncodingUtil.urlEncode(priceId, 'UTF-8') +
                      '&payment_behavior=default_incomplete'; // Ajuda a gerenciar falhas iniciais
        req.setBody(body);

        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            return res.getBody();
        } catch (Exception e) {
            return '{"error": "' + e.getMessage() + '"}';
        }
    }
}