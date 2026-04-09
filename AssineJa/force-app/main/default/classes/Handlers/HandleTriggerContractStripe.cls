public with sharing class HandleTriggerContractStripe {

    public static void processContracts(List<Contract> contracts) {
        
        Set<Id> contractIds = new Map<Id, Contract>(contracts).keySet();
        
        List<Contract> contractsWithData = SelectorContract.getContractsByIds(contractIds);
        
        for (Contract contract : contractsWithData) {
            
            createStripeCustomer(contract);

            createStripeSubscription(contract);
        }
    }

    public static void createStripeCustomer(Contract contract) {
        if (contract.Customer__r != null) {
            ControllerStripe.createStripeCustomer(
                contract.Customer__r.name,
                contract.Customer__r.email__c
            );
        }      
    }

    public static void createStripeSubscription(Contract contract) {

        if (contract.Customer__r.Stripe_Customer_ID__c != null && contract.Product__r.Stripe_price_ID__c != null) {

                ControllerStripe.createStripeSubscription(
                contract.Customer__r.Stripe_Customer_ID__c, 
                contract.Product__r.Stripe_price_ID__c

            );
        }     
    }
}