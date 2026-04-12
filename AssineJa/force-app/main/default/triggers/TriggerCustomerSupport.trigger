trigger TriggerCustomerSupport on Customer_Support__c (after insert) {

    Set<Id> idsToProcess = new Set<Id>();

    for (Customer_Support__c cs : Trigger.new){
        idsToProcess.add(cs.Id);
    }

    if (!idsToProcess.isEmpty()){
        HandlerTriggerCustomerSupport.processoCustomerSupportsAsync(idsToProcess);
    }

}