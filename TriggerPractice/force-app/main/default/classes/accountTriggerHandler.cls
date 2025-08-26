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
    // // "Write a trigger: If the phone number on an Account is updated, 
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
    

 


}

