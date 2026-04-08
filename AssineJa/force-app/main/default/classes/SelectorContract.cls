public with sharing class SelectorContract {
    public static Contract getContractById(Id contractId) {
        return [SELECT Customer__r.Stripe_Customer_ID__c, Customer__r.email__c FROM Contract WHERE Id = :contractId LIMIT 1];
    }
}