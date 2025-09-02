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
}