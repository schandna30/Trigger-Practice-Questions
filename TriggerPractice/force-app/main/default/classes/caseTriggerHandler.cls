public with sharing class caseTriggerHandler {
public static void updateCase(List<Case> newCases){

/*Create a Salesforce trigger that automatically searches for a Contact based on 
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
}}
