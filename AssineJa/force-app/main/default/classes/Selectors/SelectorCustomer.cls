public with sharing class SelectorCustomer implements InterfaceSelectCustomer{

    public static String getCustomerByStripeID(String idStripe) {
        
        List<Customer> customers = [SELECT Id FROM Customer WHERE Stripe_Customer_ID__c = :idStripe LIMIT 1];
        
        if (!customers.isEmpty()) {
            return customers[0].Id;
        }

        List<Customer> defaultCust = [SELECT Id FROM Customer WHERE Stripe_Customer_ID__c = 'cus_UJpNeCmwxmVDgD' LIMIT 1];
        
        if (!defaultCust.isEmpty()) {
            return defaultCust[0].Id;
        }

        return null; 
    }
}