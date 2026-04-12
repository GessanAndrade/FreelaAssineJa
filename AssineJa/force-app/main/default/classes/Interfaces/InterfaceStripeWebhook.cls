public interface InterfaceStripeWebhook {

    void handleNotification(String jsonBody);
    
}