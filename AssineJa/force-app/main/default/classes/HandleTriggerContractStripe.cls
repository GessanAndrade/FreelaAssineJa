public with sharing class HandleTriggerContractStripe {
   
    public static void processContractes(List<Contract> contracts) {
        for (Contract contract : contracts) {
            if (contract.Status == 'Ativo') {
                createStripeCustomer(contract);
                createStripeSubscription(contract);
            }
        }
    }

    public static void createStripeCustomer(Contract contract) {
        ServiceStripe.createStripeCustomer(contract.Customer__r.Stripe_Customer_ID__c, contract.Customer__r.email__c);
    }

    public static void createStripeSubscription(Contract contract) {
        ServiceStripe.createStripeSubscription(contract.Customer__r.Stripe_Customer_ID__c, contract.Product__r.Stripe_price_ID__c);
    }
}