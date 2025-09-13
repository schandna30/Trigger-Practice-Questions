public with sharing class accountTriggerHandler {



    public static void setAccountRating(List<Account> newAccounts){

/*Question 1:Create a trigger on the Account object that automatically sets the Rating field of the Account based on its AnnualRevenue whenever a new Account is created.
If AnnualRevenue is null or less than 1,000,000, set Rating to Cold.
If AnnualRevenue is greater than or equal to 1,000,000 but less than 10,000,000, set Rating to Warm.
If AnnualRevenue is greater than or equal to 10,000,000, set Rating to Hot.*/
    if(!newAccounts.isEmpty()){
    for(Account acc: newAccounts){
        if(acc.AnnualRevenue==null || acc.AnnualRevenue<1000000 ){
            acc.Rating='Cold';
        }
        else if(acc.AnnualRevenue>=1000000 && acc.AnnualRevenue< 10000000){
            acc.Rating='Warm';
        }
        else{
            acc.Rating='Hot';
        }
    }
    // accList.add(acc);
}
    }
  /*  // // "Write a trigger: If the phone number on an Account is updated, 
    // update the related Contacts with the new phone number, but only if their phone 
    // // numbers are currently blank or match the old phone number of the Account."/

    public static void updateContacts(Map<Id, Account> newMap, Map<Id, Account> oldMap){
    List<Contact> contactsToUpdate = new List<Contact>();
       //check if phone number is changed
        // Get related Accounts with Contacts
    List<Account> accounts = new List<Account>();
    if (!newMap.isEmpty()) {
        accounts = [SELECT Id, Phone, (SELECT Id, Phone FROM Contacts)
                    FROM Account
                    WHERE Id IN :newMap.keySet()];
    }

        //2.check if related contacts phone feild is blank or it macthes with the accounts previous phone number
        for(Account acc: accounts){
           Account oldacc= oldMap.get(acc.Id);
           Account newacc= newMap.get(acc.Id);
           for(Contact con: acc.Contacts){
            if(String.isBlank(con.Phone) || con.Phone == oldacc.Phone){
                con.phone=newacc.phone;
                contactsToUpdate.add(con);
            }

           }
        }
        //3.Update the related contacts
        if(!contactsToUpdate.isEmpty()){
            update contactsToUpdate;
        }
    }
    

//  Whenever Account’s Phone field is updated then all related Contact’s phone field should
// also get updated with Parent Account’s Phone.
/* -------UPDATE CHILD BY PARENT---------*/
/*public static void ContatUpdate(Map<Id,Account> newAccount, Map<Id,Account> oldAccount){
    List<Account> accList = new List<Account>();
    List<Contact> conList = new List<Contact>();
    accList= [select id , name (select id , AccountId from Contacts) where id in: newAccount.keySet()];
    for (Account acc: accList){
        Account newAccount= newAccount.get(acc.Id);
    for (Contact con:Contacts){
        con.phone= newAccount.phone;
        conList.add(con);
    }
        
    }

}*/
//Prevent duplication of record based on the name
//before insert 
//Check if the record exists with the same name
// throw a error that the same account exists
public static void duplicateAccount(List<Account> newAccList){
   Set<String> accNames = new Set<String>();
for(Account acc : newAccList){
    if(acc.Name != null){
        accNames.add(acc.Name);
    }
}

List<Account> existingAccList = [SELECT Id, Name FROM Account WHERE Name IN :accNames];   if(!newList.isEmpty())
        for (Account acc : newAccList){
            if(acc)
            acc.addError('Duplicate value');
        }
    }

// "Write an apex trigger to hold user from modifying account 
//again until 1 hour is passed"
// Also check if the same user has updated or not
// Trigger Before update
public static void preventAccountUpdation(List<Account> accList, Map<Id,Account> oldMap){
    // we have to check if the old value of the lastModified System.now();
    Id currentUserId = userInfo.getUserId();
    if(!accList.isEmpty()){
    for(Account acc : accList)
    {  if(oldMap!=null){
         Account oldAccount =oldMap.get(acc.id);
         if(oldAccount.LastModifiedById==currentUserId){
        Datetime dt1 =oldAccount.LastModifiedDate;
        Integer diff = System.now().getTime - dt1.getTime();
        if(diffSeconds<1){
            addError('last Modified 1 hr ago');
        }}
    }}
}}
// "Write a trigger to prevent deletion of an Account that has Contact marked as Potential Buyer"
public static void preventDeletion(Map<Id,Account> oldMap){
    //get all the related contacts
    Map<Id,Boolean> conMap= new Map<Id,Boolean>();
    set<id> accIds = oldMap.keySet();
    //check if those contacts has PotentialBuyer Marked true
    //Throw Error
    List<Account> accList= oldmap.keySet();
    for(Account acc:[select id , name ,(select id,Potential_buyer__c from contacts) from Account where id in: accIds]){
        Boolean HasPotentialBuyer=false;
        for(Contact con: acc.Contacts){
             if(con.Potential_buyer__c){
                HasPotentialBuyer=true;
                break;
             }
        }
        if(HasPotentialBuyer){
            oldMap.get(acc.Id).addError('Cannot delete acount')
        }
    }
  
}
//Trigger to create a related Contact of Account with same phone as Account’s phone 
//if custom checkbox field on Account is checked.
public static void createContactafterUpdate(List<Account> newList,Map<Id,Account> oldMap){
//check if account is checkbox is update
//checck if Account phn field is not blank
//create contact records
//insert contact records
List<Contact> conList= new List<Contact>();
if(!newList.isEmpty()){
    for(Account acc: newList){
         Account oldAccount= oldMap.get(acc.id);
         if(acc.custom__c  && !oldAccount.custom__c && acc.Phone!= null)
         {
            Contact con= new Contact();
            con.AccountId= acc.Id;
            con.LastName='Test'+acc.Id;
            con.Phone=acc.Phone;
            conList.add(con);
         }
    }
    if(!conList.isEmpty()){
        insert conList;
    }
}


}
//prevent user from deleting an old acocunt
// run this on before delete
public static void preventDeletion(List<Account> oldList){
    set<Id> activeAccountIds = new Set<Id>();
    for(Account acc : oldList){
        if(acc.isActive__c == true){
          addError('Active account cannot be deleted');
        }
    }


}
}



