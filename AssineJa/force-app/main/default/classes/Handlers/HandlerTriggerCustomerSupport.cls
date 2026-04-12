public with sharing class HandlerTriggerCustomerSupport {
    
    @future(callout=true)
    public static void processoCustomerSupportsAsync(Set<Id> idsSupports){

        List<Customer_Support__c> updateSupportList = new List<Customer_Support__c>();

        List<Customer_Support__c> supportWithData = SelectorCustomerSupport.getCustomerSupportsByIds(idsSupports);   
        
        for (Customer_Support__c data : supportWithData){

            String idNew =  SelectorCustomer.getCustomerByStripeID(data.CustuomerID__c);

            data.CustuomerID__c = idNew;

            updateSupportList.add(data);
        }

        update updateSupportList;

    }
}