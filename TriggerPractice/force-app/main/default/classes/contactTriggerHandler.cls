public with sharing class contactTriggerHandler {
   /* public static void afterInsert(List<contact> newconList){
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


    /* Whenever a Contact’s description is updated then its Parent Account’s 
    description should also get updated by it.*/
    /* -------UPDATE PARENT BY CHILD---------*/
    public static void UpdateAccountFromContact(List<Contact> conList,Map<Id,Contact> oldMap){
        // Get all the  parent records in a set
        set<Id> accIdSet= new set<Id>();
        for(Contact con: conList){
            Contact oldCon= oldMap.get(con.Id);
         
            if(string.isNotBlank(con.AccountId) && con.Description!=oldCon.Description){//also check if user updatedd the description value

                accIdSet.add(con.AccountId);
            }
        }
    
        // create a map of parent record id and description
            Map<Id, String> accIdToDescMap = new Map<Id, String>();
            for(Contact con: conList){
                if(con.AccountId!=null && con.Description!=null){
                    accIdToDescMap.put(con.AccountId,con.Description);
                }
            }
        // itrate over the map to update accounts
            List <Account> accList =[select id , Description from Account where id in:accIdSet];
        for ( Account acc :accList){
            if(accIdToDescMap.containsKey(acc.Id)){
                acc.Description=accIdToDescMap.get(acc.Id);
            }

        }
        update accList;
    }
    // We have Primary_Contact__c checkbox field on contact object. Ensure only one primary contact present on Account if user try to maintain more than one primary Contact then show error.
    public static void primaryContact(List<Contact> newList){
        //Get the parent Account records
        Set<Id> accIds = new Set<Id>();
        if(!newList.isEmpty()){
        for(Contact con: newList){
            if(con.AccountId!= null && con.Primary_Contact__c== true){
                accIds.add(con.AccountId);
            }
        }}
        //check if there is any other primary record in Parent Account
        if(!accIds.isEmpty()){
        for(Accounts acc: [select id , name ,(select id , name , AcocuntId ,Primary_Contact__c from Contacts ) from Account where id in: accIds]){
            for(Contact con : acc.Contacts){
                Boolean hasPrimary = false;
               if(con.Primary_Contact__c==true){
                hasPrimary = true;
               }
               
            }


        }}
        // add error if we find any other primary account
    }


}