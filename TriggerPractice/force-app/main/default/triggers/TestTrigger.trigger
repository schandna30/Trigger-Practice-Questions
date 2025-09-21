trigger TestTrigger on SOBJECT (before insert) {

}


// Write an Apex trigger for the Account object to handle updates. If the 'Count of Contacts' field is updated, 
// check if there are any related Contacts. If no Contacts exist, create the number of Contacts specified in the
// updated field. If there are already related Contacts, do not create any new Contacts. 



public class UpdateonAccount{

public static void AccountUpdateHelper(List<Account> newRecords, Map<Id,Account> oldMap){

Set<Id> accIds= new set<id>();
if(!newRecords.isEmpty()){

    for(Account acc:newRecords ){

        Account oldRecord= oldMap.get(acc.id);

        if(oldRecord.Count_of_contacts__c!=newRecords.Count_of_contacts__c){
            accIds.add(acc.id);

        }
    }
}
Map<Account,Integer> accConMap= new Map<Acoount,Integer>();

for(Account acc : (Select id, name, (select id from contacts) from Account where id in:accIds )){

    if(acc.contacts.size=0){

        accConMap.put(acc,acc.Count_of_contacts__c);

    }



}
List<Contact> conToBeinserted= new List<Contact>();
for(Account acc: newRecords){
    if(accConMap.containsKey(acc.id)){

        for(i=0;i<Count_of_contacts__c;i++){

            contact con = new Contact(name='test',accountId=acc.Id);
            conToBeinserted.add(con);


        }
    }

}
if(!conToBeinserted.isEmpty()){
    insert conToBeinserted;
}

}

}




