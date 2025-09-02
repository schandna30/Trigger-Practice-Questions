trigger contactTrigger on Contact ( after insert, after update, after delete, after undelete, before insert, before Update) {
    switch on trigger.operationType {
        when AFTER_INSERT {
           // contactTriggerHandler.afterInsert(trigger.new);
            
        }
        when AFTER_UPDATE {
           // contactTriggerHandler.afterUpdate(trigger.new, trigeer.oldMap);
           contactTriggerHandler.UpdateAccountFromContact(trigger.new,trigger.oldMap);
        }
        when AFTER_DELETE{
            //contactTriggerHandler.afterDelete(trigger.old);
        }
        When AFTER_UNDELETE{
            //contactTriggerHandler.afterUndelete(trigger.new);
        }
        if( trigger.isBefore &&( trigger.isUpdate || trigger.isInsert)){
            if(trigger.isInsert){
            contactTriggerHandler.primaryContact(trigger.new)}
        }
    }

}