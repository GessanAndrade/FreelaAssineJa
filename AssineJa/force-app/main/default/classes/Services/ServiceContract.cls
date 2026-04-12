public with sharing class ServiceContract {
    
    private InterfaceSelectorContract IScontract;
    private InterfaceControllerStripe IcontrollerStripe;

    public ServiceContract(InterfaceSelectorContract IScontract, InterfaceControllerStripe IcontrollerStripe){
        this.IScontract = IScontract;
        this.IcontrollerStripe = IcontrollerStripe;
    }

    public void processContractsAsync(Set<Id> contractIds) {

        Map<String, String> mapCustomers = new Map<String, String>();
        
        List<Contract> contractsWithData = IScontract.getContractsByIds(contractIds);
        
        for (Contract contract : contractsWithData) {

            String stripeId = createStripeCustomer(contract);
            if (String.isNotBlank(stripeId)) {
                mapCustomers.put(contract.Customer__c, stripeId);
            }
        }

        if (!mapCustomers.isEmpty()) {
            FactoryCustomer.getServiceCustomer().updateStripeIdCustomer(mapCustomers);
        }
    }

    public String createStripeCustomer(Contract contract) {
        
        String id = '';
        
        if (contract.Customer__r != null) {

            id = IcontrollerStripe.createStripeCustomer(                
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

    public void createStripeSubscription(String customerId, String priceId) {

        if (customerId != null && priceId != null) {

            IcontrollerStripe.createStripeSubscription(
                    customerId, 
                    priceId

            );
        }     
    }

}