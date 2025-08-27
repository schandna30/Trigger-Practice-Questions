public with sharing class dealTriggerHandler {
//   /"Write a trigger on the Deal object to validate that the Deal
//    Amount matches the Amount field of the associated Opportunity
//     during record insert or update."
// 1. get the deal amount from deal object
//2.Get the assocaited opportunity amount
//3.Match them both
public static void matchDealAmountBeforeInsert(List<Deal> newDeals){
  Map<Id, Decimal> oppAmountMap = new Map<Id, Decimal>( [select id , Amount from  Opportunity where id in:OppuId]);
  set<Id> OppuId = new Set<Id>();
  List<DEal> listToBeUpdated= new List<DEal>();
  for( Deal d: [select Opportunity__c,Deal_Amount__c from Deal where id in: newDeals]){
    if(d.Opportunity__c!=null){
          OppuId.add(d.Opportunity__c);
      //  oppList.add(d);
       // oppAmountMap.put(d.Opportunity__c,d.Deal_Amount__c);// We have a map of Oppurtunites ID's and deal amount
    }
  }
  //List<Opportunity> oppList= [select id , Amount from  Opportunity where id in:OppuId]// List of all the parent records
  // traverse through parents records and check if amount is equal to Amount in mao
 for( deal d : newDeals){
    if(d.Opportunity!= null && oppAmountMap.containsKey(d.Opportunity)){
        Decimal dealAmount= d.Deal_Amount__c;
        Decimal OpportunityAmount = oppAmountMap.get(d.Opportunity).Amount;
        if(dealAmount!=OpportunityAmount){
           addError('Amount not Equal');
        }
      
    }
 }

