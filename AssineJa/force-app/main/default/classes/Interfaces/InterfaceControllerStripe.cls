public interface InterfaceControllerStripe {

    String createStripeCustomer(String name, String email);

    String createStripeSubscription(String customerId, String priceId);

}