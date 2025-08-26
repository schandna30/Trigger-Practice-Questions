trigger OppurtunityTrigger on Opportunity (before delete) {
    if(isDelete && isBefore){
        oppurtunityTriggerHelper.oppurDeletion(trigger.old);
    }

}