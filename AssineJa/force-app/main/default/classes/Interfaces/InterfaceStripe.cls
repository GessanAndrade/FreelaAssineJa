public interface InterfaceStripe {
    
    String customerExists(String email);

    String createStripeCustomer(String name, String email);

    void attachTestPaymentMethod(String customerId);

    String createStripeSubscription(String customerId, String priceId);

}