trigger LeadTrigger on Lead (before insert) {
    if(trigger.isBefore && trigger.isInsert){
        leadTriggerHandler.setLeadSource(trigger.new);
    }

}