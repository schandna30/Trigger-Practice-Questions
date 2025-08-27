
public with sharing class batchClassSyntax implements Database.Batchable() {
    public Database.QueryLocator start (Database.BatchableContext Bc){
        //query the records
        return Database.QueryLocator(
        'select id , name description from Account where CreatedDate =Last_n_days:30'
        );

    }
    public void execute (Database.BatchableContext BC ,List<Account> scope){

    }
    public void finish(Database.BatchableContext BC){

    }
}
// /* Aggregate Query*/
// Int count= [select Count(Id) from Account];// error Illegal assignment from string to intrggwr
// // Beacuse SOQL query always returns sobject or list of sobject

// //Correct way

// List<AggregateResult> groupedResults= [select Count(Name) Total from Account];
// Integer AccountCount = (Integer)groupedResults[0].get('Total');


// /*SOQL in for loops*/
// // 1. when records are less
// for(Account acc: [select id, name from account where rating='Hot']){
    
// }
// // 2. when records are more , this way records are proccessed in batches
// for (List<Account> acc:[[select id, name from account where rating='Hot']){

// }