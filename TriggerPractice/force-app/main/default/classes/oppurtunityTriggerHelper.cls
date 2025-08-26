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
}