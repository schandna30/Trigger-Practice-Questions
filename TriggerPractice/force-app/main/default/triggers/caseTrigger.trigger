trigger caseTrigger on Case (before insert) {
    if(trigger.isBefore && trigger.isInsert){
        caseTriggerHandler.updateCase(trigger.new);
    }

}