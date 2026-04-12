public with sharing class HandlerTriggerCustomerSupport {
    
    @future(callout=true)
    public static void processoCustomerSupportsAsync(Set<Id> idsSupports){

        FactoryCostumerSupport.getServiceCustomerSupport().processoCustomerSupportsAsync(idsSupports);

    }
}