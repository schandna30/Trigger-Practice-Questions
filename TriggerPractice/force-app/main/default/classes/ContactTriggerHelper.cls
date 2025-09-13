public with sharing class ContactTriggerHelper {
   public static void removeContact(List<Account> oldAccount){
        Set<id> accIds = new Set<Id>();
        for(Account acc: oldAccount){
            if(!oldAccount.isEmpty()){
            accIds.add(acc.id);}
        }
        List<Contact> conToUpdate = new List<Contact>();

        for(Account acc :[select id , name , (select id ,name from Contacts) from account where id in:accIds] ){
            
       
                for(Contact con : acc.Contacts){
                    con.AccountId=null;
                    conToUpdate.add(con);
                }
            


        }
        if(!conToUpdate.isEmpty()){
            update conToUpdate;
        }
    }
    //Trigger to show an Error if there are already two Contacts present on an Account and the User tries to add one more Contact on it.
    //should run on before insert
    public static void preventInsertion(List<Contact> newList){
        set<Id> parentaccIds= new set<Id>();
        for(Contact con: newList){
            parentaccIds.add(con.AccountId);

        }
    // got the list of accounts check the count of contacts in account and add error if count >2
    map<Id,Integer> conSize = new Map<Id,String>();

    for(Account acc: [select id , (select id , name from contacts) from Acocunt where id in:parentaccIds]){
        conSize.put(acc.id, acc.contacts.size());
       
    }
    for(Contact newcon: newList){
        Integer countsize= conSize.get(newcon.id);
        if(countsize>=2){
            newcon.addError('cannot add this contact');
        }
    }

    }
}