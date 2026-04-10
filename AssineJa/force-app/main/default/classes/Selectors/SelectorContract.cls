public with sharing class SelectorContract {
    public static Contract getContractById(Id contractId) {
        return [SELECT Customer__r.Stripe_Customer_ID__c, 
                       Customer__r.email__c, 
                       Status,
                       Product__r.Stripe_price_ID__c FROM Contract WHERE Id = :contractId LIMIT 1];
    }

    public static List<Contract> getContractsByIds(Set<Id> contractIds) {
        return [
            SELECT Id, Status, 
                   Customer__r.Stripe_Customer_ID__c, 
                   Customer__r.email__c,
                   Customer__r.Name,
                   Customer__c,
                   Product__r.Stripe_price_ID__c                   
            FROM Contract 
            WHERE Id IN :contractIds
        ];
    }

    public static List<Contract> getAllContracts(){
        return [
            SELECT Id, 
                   Status, 
                   Name,
                   Customer__r.Stripe_Customer_ID__c, 
                   Customer__r.email__c,
                   Product__r.Stripe_price_ID__c,
                   Product__c,
                   Customer__c

            FROM Contract 
            LIMIT 10
        ]; 
    }
}