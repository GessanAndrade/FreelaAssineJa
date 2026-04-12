public with sharing class ControllerStripe implements InterfaceControllerStripe{

    public static String createStripeCustomer(String name, String email) {
        String response;
        String stripeCustomerId;

        String searchResponse = ServiceStripe.customerExists(email);
        
        if (!HelperUtils.haveContentJson(searchResponse)) {
            response = ServiceStripe.createStripeCustomer(name, email);
            stripeCustomerId = HelperUtils.returnKeyJson(response, 'id');
            
            ServiceStripe.attachTestPaymentMethod(stripeCustomerId);
        } else {
            response = ServiceStripe.createStripeCustomer(name, email);
            stripeCustomerId = HelperUtils.returnKeyJson(response, 'id');
            ServiceStripe.attachTestPaymentMethod(stripeCustomerId);
        }

        return stripeCustomerId;
    }

    public static String createStripeSubscription(String customerId, String priceId) {
        if (String.isBlank(customerId) || String.isBlank(priceId)) {
            return 'Erro: Dados incompletos';
        }

        String response = ServiceStripe.createStripeSubscription(customerId, priceId);
        
        if (response.contains('"error"')) {
            System.debug('Erro retornado pelo Stripe: ' + response);
            return 'Erro Stripe: ' + HelperUtils.returnKeyJson(response, 'message');
        }
        
        return HelperUtils.returnKeyJson(response, 'id');
    }
}