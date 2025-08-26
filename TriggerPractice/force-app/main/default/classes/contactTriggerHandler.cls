public with sharing class contactTriggerHandler {
    public static void afterInsert(List<contact> newconList){
        set<id> accIdSet = new Set<Id>();
        //get all the contacts which have account id, not all contacts might have account
        for (Contacts con : newConList){
            if(con.AccountId!= null){
                accIdSet.add(con.AccountId);
            }
        }

        // another way
        updateAccount(accIdSet);
       // List<AggregateResults> groupedResults =[select Count(id)  contactCount,AccountId where AccountId in :accIdSet GROUP BY AccountId  ]

    }
     public static void afterUpdate(List<contact> newconList, Map<Id,Contact> oldConMap){
        Set<Id> accIdset= new Set<Id>();
        for(Contact con: newconList ){
            Contcat oldCon= oldConMap.get(con.Id);
            if(oldcon.AccountId!= con.AccountId){
                if(string.isNotBlank(con.AccountId)){
                accIdset.add(con.AccountId);}
                if(string.isNotBlank(oldcon.AccountId)){
                    accIdset.add(oldcon.AccountId);
                }
            }
        }
        accIdSet(accIdSet);
     
    }
    public static void afterDelete( List<contact> oldConMap){
        afterInsert(oldConMap);
    }
     public static void afterUndelete(List<contact> newconList){
        afterInsert(newconList);
    }
    public static void updateAccount(Set<Id> accIdSet){
        // get the accounts  related contacts  parent to child query
         if(!accIdSet.isEmpty()){
            List<Account> accList= [select id, name , (select id , name from Contacts) where id in :accIdSet];
            for(Account acc: accList){
                List<Contact> conlist = acc.Contacts;
                Contact_Count__c=conlist.size();
            }
         }
         
        //populate custom field
        if(!accList.isEmpty()){
            try{
                update accList

            }
            catch(Exception ex){
                system.debug(ex.getMessage());


            }
        }
    }
}