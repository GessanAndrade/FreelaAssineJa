public with sharing class HandleTriggerContractStripe {

    public static void processContracts(List<Contract> contracts) {
        
        Set<Id> contractIds = new Map<Id, Contract>(contracts).keySet();

        Map<String, String> mapCustomers = new Map<String, String>();

        Map<String, String> mapProducts = new Map<String, String>();
        
        List<Contract> contractsWithData = SelectorContract.getContractsByIds(contractIds);
        
        for (Contract contract : contractsWithData) {
            
            mapCustomers.put(contract.Customer__c, createStripeCustomer(contract)) ;

            createStripeSubscription(contract);
        }

        ServiceCustomer.updateStripeIdCustomer(mapCustomers);

    }

    public static String createStripeCustomer(Contract contract) {
        
        String id = '';
        
        if (contract.Customer__r != null) {
            id = ControllerStripe.createStripeCustomer(
                contract.Customer__r.name,
                contract.Customer__r.email__c
            );
        } 
        
        return id;
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