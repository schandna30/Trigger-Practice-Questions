trigger OppurtunityTrigger on Opportunity (before delete, after insert, after update , after delete, after undelete) {
    if(isDelete && isBefore){
        oppurtunityTriggerHelper.oppurDeletion(trigger.old);
    }
 if(isAfter && (isInsert)){
        
    }

}