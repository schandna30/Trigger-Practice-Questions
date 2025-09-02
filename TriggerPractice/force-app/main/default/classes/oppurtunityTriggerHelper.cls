public with sharing class oppurtunityTriggerHelper {
    /* prevent deletion of oppurtunity if it has any related Activites*/
  // object - deletion, operation - deletion , validation, before delete
  
  
  //1. Check if there is any activities related to oppurtunties,
  //2. Add error Message if found
  public statuc void oppurDeletion(List<Opportunity> oldOppur){
    List<Task> task = new List<Task>();
    task= [SELECT id , name from task where whatid IN:oldOppur.Id]
    
    for (Opportunity opp: oldOppur){
        if(!opp.Opportunity.isBlank){
            opp.addError('Cannot delete Opprtunity');
        }
    }
  }
//  Trigger to find sum of all related Opportunities Amount of an Account.
//whenever  an oppurtunity is updated inserted deleted undeleted then update account's field
public static void oppInsert(List<Opportunity> newOpp){
  set<id> accId = new Set<Id>();
  // get the parent record Ids
  for(Opportunity opp : newOpp){
    accId.add(opp.AccountId);
  }
  // use aggregate query on child records of parent Acocunt 
  List<AggregateResult> aggresults =[select AccountId , SUM(Amount) Total from Opportunity where id in :accId GROUP BY AccountId];
  //MAp amount and Acocunts
  Map<Id, Decimal> accToAmount = new Map<Id,Decimal>();
  for (AggregateResult ar:aggresults){
    accToAmount.put((Id) ar.get(AccountId),(Decimal) ar.get(Total));
  }
  //update account's field 
  List<Account> accToUpdateList = new List<Account>();
  for(Account acc: accId){
    Decimal total = accToAmount.getContainsKey(acc.id)? accToAmount.get(acc.Id):0;
    Account accToUpdate = new Account();
    accToUpdate.Id= acc.Id;
    accToUpdate.Amount= total;
    accToUpdateList.add(accToUpdate);

  }
  if(!accToUpdateList.isEmpty()){
    update accToUpdateList;
  }
}


}