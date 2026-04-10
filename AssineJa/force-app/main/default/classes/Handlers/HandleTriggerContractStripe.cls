public with sharing class HandleTriggerContractStripe {

    @future(callout=true)
    public static void processContractsAsync(Set<Id> contractIds) {
        
        Map<String, String> mapCustomers = new Map<String, String>();
        
        // Buscamos os dados aqui dentro
        List<Contract> contractsWithData = SelectorContract.getContractsByIds(contractIds);
        
        for (Contract contract : contractsWithData) {

            String stripeId = createStripeCustomer(contract);
            if (String.isNotBlank(stripeId)) {
                mapCustomers.put(contract.Customer__c, stripeId);
            }
        }

        if (!mapCustomers.isEmpty()) {
            ServiceCustomer.updateStripeIdCustomer(mapCustomers);
        }
    }

    public static String createStripeCustomer(Contract contract) {
        
        String id = '';
        
        if (contract.Customer__r != null) {

            id = ControllerStripe.createStripeCustomer(                
                contract.Customer__r.Name,
                contract.Customer__r.email__c
            );

            System.debug('createStripeCustomer id: ' + id);

            if (id <> ''){
               createStripeSubscription(id, contract.Product__r.Stripe_price_ID__c);
            }
        } 
        
        return id;
    }

    public static void createStripeSubscription(String customerId, String priceId) {

        if (customerId != null && priceId != null) {

                ControllerStripe.createStripeSubscription(
                    customerId, 
                    priceId

            );
        }     
    }
}