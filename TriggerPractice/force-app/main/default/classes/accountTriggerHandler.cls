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

}