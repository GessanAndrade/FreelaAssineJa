trigger TriggerContractStripe on Contract (after insert, after update) {
  
    if (Trigger.isAfter) {

        Set<Id> idsToProcess = new Set<Id>();
        
        for (Contract c : Trigger.new) {
            Boolean statusChanged = (Trigger.isInsert || (Trigger.isUpdate && c.Status != Trigger.oldMap.get(c.Id).Status));
            
            System.debug('statusChanged' + statusChanged);

            if (c.Status == 'Activated' && statusChanged) {
                idsToProcess.add(c.Id);
            }
        }

        System.debug('idsToProcess' + idsToProcess);
        
        if (!idsToProcess.isEmpty()) {
            HandleTriggerContractStripe.processContractsAsync(idsToProcess);
        }
    }
}