public with sharing class caseTriggerHandler {
public static void updateCase(List<Case> newCases){

/* Question:3 Create a Salesforce trigger that automatically searches for a Contact based on 
the Web Email field of a Case when the Case is created, 
and then populates the Contact field on the Case object with the matching Contact.*/
if(!newCases.isEmpty()){
  //  List<Contact> cons =[select id , ContactEmail, ContactName from Contact where id=:]
    List<Case> caseList= new List<Case>();
    Set<String> webEmailSet=new Set<String>();
    //get all the web emails
    for (Case caseRec: newCases)
    {
        if(String.isNotBlank(caseRec.SuppliedEmail)){
            webEmailSet.add(caseRec.SuppliedEmail.toLowerCase());
            
        }
    }
    //get contacts based on web emails
    Map<String,Id> emailMap= new Map<String,Id>();
    for (Contact con: [select id , email from contact where email in: webEmailSet]){
        emailMap.put(con.Email,Con.Id);
    }
    //populate the contact on case
    for(Case caseRec: newCases){
      
        if(String.isNotBlank(caseRec.SuppliedEmail)){
          if(emailMap.containsKey(caseRec.SuppliedEmail.toLowerCase())){
            caseRec.ContactId=emailMap.get(caseRec.SuppliedEmail);
          }
            
        }
    }
}
}

/* Question 4:
Create a Salesforce trigger that automatically searches for an Account based on the Phone field of a
 Case when the Case is created, and then populates the Account field on the Case object with the matching Account.*/

 public static void updateAccountOnCase(List<Case> newCaseList){
  // get the phone feild from the cases to be created
  Set<String> PhoneList = new Set<String>();
  if(!newCaseList.isEmpty()){
    for(Case caserec:newCaseList ){
      if(String.isNotBlank(caserec.SuppliedPhone)){
        PhoneList.add(caserec.SuppliedPhone);
      }
    }
  }
  //get accounts based on phone feild
  Map<String,Id> phoneMap= new Map<String,Id>();
      for (Account acc: [select id , Phone from account where Phone in: PhoneList]){
        phoneMap.put(acc.Phone,Acc.Id);
    }


  //populate the case with the account id
      for(Case caserec:newCaseList ){
      if(String.isNotBlank(caserec.SuppliedPhone)){
       if(phoneMap.containsKey(caserec.SuppliedPhone)){
       caserec.AccountId= phoneMap.get(caserec.SuppliedPhone);
       }
      }
    }

 }
//When a Case is inserted on any Account, put the latest Case Number on the Account in Latest Case Inserted field.
// run after insert beacuse we are updaitng related records
public static void updateAccountfield(List<Case> newList){
  Map<id,Integer> caseAccMap= new Map<id,Integer>();
  set<Id> accountIds= new set<Id>();
  if(!newList.isEmpty()){
  for ( Case cases: newList){
//case oldrecord= oldcases.get(cases.Id);
if(cases.AccountId!= null){
  caseAccMap.put(cases.AccountId,cases.Name);
  //accountIds.add(casesAccountId)
  
}
List<Account> accToBeUpdated = new List<Account>();
for (Account acc: [select id , name from Account where id in :caseAccMap.keySet()]){
  if(caseAccMap.containsKey(acc.id)){
    acc.Latest_case_inserted__c= caseAccMap.get(acc.id);
    accToBeUpdated.add(acc);
  }
}
if(!accToBeUpdated.isEmpty){
  update accToBeUpdated;
}
   

  }}
}

}
