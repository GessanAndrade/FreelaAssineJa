public with sharing class HandleTriggerContractStripe {

    @future(callout=true)
    public static void processContractsAsync(Set<Id> contractIds) {

       FactoryContract.getServiceContract().processContractsAsync(contractIds);
        
    }

}