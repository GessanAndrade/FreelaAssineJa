public with sharing class ServiceCustomer {

   public static void updateStripeIdCustomer(Map<String, String> customers) {

        List<Customer> listToUpdate = new List<Customer>();

        List<Customer> sfCustomers = [
            SELECT Id, email__c, Stripe_Customer_ID__c 
            FROM Customer 
            WHERE Id IN :customers.keySet()
        ];

        for (Customer sc : sfCustomers) {
            
            if (customers.containsKey(sc.email__c)) {

                sc.Stripe_Customer_ID__c = customers.get(sc.email__c);
                
                listToUpdate.add(sc);
            }
        }

        if (!listToUpdate.isEmpty()) {
            update listToUpdate;
        }
    }
}