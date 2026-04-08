trigger TriggerContractStripe on Contract (before insert) {

    HandleTriggerContractStripe.processContractes(Trigger.new);

}