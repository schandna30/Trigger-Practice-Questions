trigger LeadTrigger on Lead (before insert , before update) {
    if(trigger.isBefore && trigger.isInsert){
        leadTriggerHandler.setLeadSource(trigger.new);
    }
      if(trigger.isBefore && (trigger.isInsert|| trigger.isUpdate)){
        leadTriggerHandler.clearEmailFieldAfterUpdate(trigger.new,trigger.oldMap);
    }


}