
trigger accountTrigger on Account (before insert, after update) {

  //  List<Account> accList =new List<Account>(); // In a before insert trigger,
  // you can directly modify Trigger.newrecords without adding them to another list.

    if(trigger.isBefore && trigger.isInsert){
        accountTriggerHandler.setAccountRating(trigger.new);
   }
   if(trigger.isAfter && trigger.isUpdate){
        accountTriggerHandler.updateContacts(trigger.newMap,trigger.oldMap);
   }
}