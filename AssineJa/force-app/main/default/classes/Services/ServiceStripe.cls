public class ServiceStripe {
    // Chave Secreta da Stripe
    private static final String STRIPE_API_KEY = 'sk_test_51TJKU55t2okTvzPmtaEjZAlfZRwy8v4qiDJWRCccmoPLJwFz26NL24uc8rjaTvU2yYHHTRmaTXedSagDTCN8YUAd00rTNLjvDU';
    private static final String BASE_URL = 'https://api.stripe.com/v1';

    /**
     * Busca um cliente pelo e-mail e retorna o JSON bruto (getBody).
     */
    public static String customerExists(String email) {
        
        HttpRequest req = new HttpRequest();
        
        String queryValue = 'email:"' + email + '"';
        String endpoint = BASE_URL + '/customers/search?query=' + EncodingUtil.urlEncode(queryValue, 'UTF-8');
        
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + STRIPE_API_KEY);
        
        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            String body = res.getBody();
            
            return body; 
        } catch (Exception e) {
            System.debug('Erro fatal na chamada: ' + e.getMessage());
            return '{"error": "' + e.getMessage() + '"}';
        }
    }

    /**
     * Busca um preço pelo ID e retorna o JSON bruto (getBody).
     */
    public static String priceExists(String priceId) {
        HttpRequest req = new HttpRequest();
        
        // Busca direta pelo ID do preço
        req.setEndpoint(BASE_URL + '/prices/' + EncodingUtil.urlEncode(priceId, 'UTF-8'));
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + STRIPE_API_KEY);
        
        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            return res.getBody(); // Retorna o objeto Price completo ou erro em JSON
        } catch (Exception e) {
            System.debug('Erro ao validar Price: ' + e.getMessage());
            return '{"error": "' + e.getMessage() + '"}';
        }
    }

    /**
     * Cria um novo cliente e retorna o JSON bruto (getBody).
     */
    public static String createStripeCustomer(String name, String email) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BASE_URL + '/customers');
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + STRIPE_API_KEY);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        System.debug('Service.createStripeCustomer name: ' + name);
        System.debug('Service.createStripeCustomer email: ' + email);
        
        String body = 'name=' + EncodingUtil.urlEncode(name, 'UTF-8') + 
                      '&email=' + EncodingUtil.urlEncode(email, 'UTF-8');
        req.setBody(body);

        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            return res.getBody();
        } catch (Exception e) {
            System.debug('Erro ao criar cliente: ' + e.getMessage());
            return '{"error": "' + e.getMessage() + '"}';
        }
    }

    public static String deleteStripeCustomer(String customerId) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BASE_URL + '/customers/' + EncodingUtil.urlEncode(customerId, 'UTF-8'));
        req.setMethod('DELETE');
        req.setHeader('Authorization', 'Bearer ' + STRIPE_API_KEY);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        System.debug('String request: ' + req);

        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            return res.getBody();
        } catch (Exception e) {
            System.debug('Erro ao deletar cliente: ' + e.getMessage());
            return '{"error": "' + e.getMessage() + '"}';
        }
    }

    /**
     * Cria uma assinatura e retorna o JSON bruto (getBody).
     */
    public static String createStripeSubscription(String customerId, String priceId) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BASE_URL + '/subscriptions');
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + STRIPE_API_KEY);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        String body = 'customer=' + EncodingUtil.urlEncode(customerId, 'UTF-8') + 
                      '&items[0][price]=' + EncodingUtil.urlEncode(priceId, 'UTF-8');
        req.setBody(body);

        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            return res.getBody();
        } catch (Exception e) {
            System.debug('Erro ao criar assinatura: ' + e.getMessage());
            return '{"error": "' + e.getMessage() + '"}';
        }
    }

    /**
     * Cria uma conta Standard e retorna o JSON bruto (getBody).
     */
    public static String createStripeAccount(String email, String businessName) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BASE_URL + '/accounts');
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + STRIPE_API_KEY);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        String body = 'type=standard' +
                      '&email=' + EncodingUtil.urlEncode(email, 'UTF-8') +
                      '&business_profile[name]=' + EncodingUtil.urlEncode(businessName, 'UTF-8') +
                      '&capabilities[card_payments][requested]=true' +
                      '&capabilities[transfers][requested]=true' +
                      '&tos_acceptance[service_agreement]=full';
        req.setBody(body);

        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            return res.getBody();
        } catch (Exception e) {
            System.debug('Erro ao criar conta: ' + e.getMessage());
            return '{"error": "' + e.getMessage() + '"}';
        }
    }
}