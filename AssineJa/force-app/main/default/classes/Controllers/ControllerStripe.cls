public with sharing class ControllerStripe {

    /**
     * Cria ou valida um cliente no Stripe.
     * Retorna o Stripe Customer ID (String).
     */
    public static String createStripeCustomer(String name, String email) {
        String response;
        String stripeCustomerId;

        // Verifica se o cliente já existe no Stripe
        String searchResponse = ServiceStripe.customerExists(email);
        
        // Lógica para extrair ID se existir ou criar novo
        // Nota: Ajuste a lógica do HelperUtils para verificar a lista 'data' do search
        if (!HelperUtils.haveContentJson(searchResponse)) {
            response = ServiceStripe.createStripeCustomer(name, email);
            stripeCustomerId = HelperUtils.returnKeyJson(response, 'id');
            
            // IMPORTANTE: Para testes, anexamos um cartão fake imediatamente
            // Em produção, isso seria feito via Stripe Elements no Front-end
            ServiceStripe.attachTestPaymentMethod(stripeCustomerId);
        } else {
            // Se o search encontrou, você precisaria pegar o ID dentro do array 'data'
            // Aqui simplificamos assumindo que se não existe, criamos.
            response = ServiceStripe.createStripeCustomer(name, email);
            stripeCustomerId = HelperUtils.returnKeyJson(response, 'id');
            ServiceStripe.attachTestPaymentMethod(stripeCustomerId);
        }

        return stripeCustomerId;
    }

    /**
     * Cria uma assinatura. 
     * Retorna o Stripe Subscription ID como String para evitar erro de "Invalid ID".
     */
    public static String createStripeSubscription(String customerId, String priceId) {
        if (String.isBlank(customerId) || String.isBlank(priceId)) {
            return 'Erro: Dados incompletos';
        }

        String response = ServiceStripe.createStripeSubscription(customerId, priceId);
        
        // Verifica se o Stripe retornou erro no JSON
        if (response.contains('"error"')) {
            System.debug('Erro retornado pelo Stripe: ' + response);
            return 'Erro Stripe: ' + HelperUtils.returnKeyJson(response, 'message');
        }
        
        return HelperUtils.returnKeyJson(response, 'id');
    }
}