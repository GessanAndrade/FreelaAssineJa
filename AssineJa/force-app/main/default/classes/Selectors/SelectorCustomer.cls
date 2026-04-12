public with sharing class SelectorCustomer {

    public static String getCustomerByStripeID(String idStripe) {
        // 1. Tenta achar o cliente real
        List<Customer> customers = [SELECT Id FROM Customer WHERE Stripe_Customer_ID__c = :idStripe LIMIT 1];
        
        if (!customers.isEmpty()) {
            return customers[0].Id;
        }

        // 2. Se não achou, tenta achar o padrão (cus_UJpNeCmwxmVDgD)
        List<Customer> defaultCust = [SELECT Id FROM Customer WHERE Stripe_Customer_ID__c = 'cus_UJpNeCmwxmVDgD' LIMIT 1];
        
        if (!defaultCust.isEmpty()) {
            return defaultCust[0].Id;
        }

        return null; 
    }
}