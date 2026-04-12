public with sharing class SelectorCustomerSupport {
   
    public static List<Customer_Support__c> getCustomerSupportsByIds(Set<Id> idsSupports){
        return [
            SELECT Id, CustuomerID__c                 
            FROM Customer_Support__c 
            WHERE Id IN :idsSupports
        ];
    }
}