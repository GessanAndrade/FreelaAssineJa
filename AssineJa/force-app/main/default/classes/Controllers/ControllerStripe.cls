public with sharing class ControllerStripe {

    public static String createStripeCustomer(String name, String email) {
        
       String response;
       Id responseId = '';

       if (HelperUtils.haveContentJson(ServiceStripe.customerExists(email))) {
           response = ServiceStripe.createStripeCustomer(
                name,
                email
            );
            
            responseId = HelperUtils.returnKeyJson(response, 'id');
        }

        return responseId;

    }

    public static Id createStripeSubscription(String customerId, String priceId) {
          
        Id response;

        response = ServiceStripe.createStripeSubscription(
            customerId, 
            priceId
        );
        
        return response;
       
    }
}