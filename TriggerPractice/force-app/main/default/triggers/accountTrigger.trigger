trigger accountTrigger on Account (before delete) {
    if(trigger.isbefore && trigger.isDelete){
        ContactTriggerHelper.removeContact(trigger.old);
    }

}