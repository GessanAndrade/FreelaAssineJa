trigger TriggerContractStripe on Contract (after insert, after update) {
  
    if (Trigger.isAfter) {
        // Filtramos os contratos que mudaram para o status 'Ativo' para evitar chamadas desnecessárias
        List<Contract> contractsToProcess = new List<Contract>();
        
        for (Contract c : Trigger.new) {
            // Se for inserção ou se o Status mudou para 'Ativo'
            Boolean statusChanged = (Trigger.isInsert || (Trigger.isUpdate && c.Status != Trigger.oldMap.get(c.Id).Status));
            
            if (c.Status == 'Activated' && statusChanged) {
                contractsToProcess.add(c);
            }
        }
        
        if (!contractsToProcess.isEmpty()) {
            HandleTriggerContractStripe.processContracts(contractsToProcess);
        }
    }
}