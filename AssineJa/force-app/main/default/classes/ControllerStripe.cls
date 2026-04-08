public with sharing class ControllerStripe {

    public static String createStripeCustomer(String name, String email) {
        
            String response = ServiceStripe.createStripeCustomer(
                name,
                email
            );
            
            return response;
    }

    public static String createStripeSubscription(String customerId, String priceId) {
           
        String response = ServiceStripe.createStripeSubscription(
            customerId, 
            priceId
        );
        
        return response;
       
    }
}