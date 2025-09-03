// Write a batch apex to populate Account Billing Address on related Contact's Mailing address
public  class UpdateContactMailingAddressBatch implements Database.Batchable<sobject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([select id , billingStreet, BillingPostalCode, BillingCountry,(select id , MailingCity , MailingPostalCode, MailingCountry,MailingStreet from contacts )from Account where BillingCountry = 'USA'])

    }
    public void  excecute (Database.BatchableContext bc,List<Account> accList){
        List<contact> conList = new List<Contact>();
        for(Account acc: accList)
        {
            for(Contact con: acc.contacts){
                con.MailingPostalCode=acc.BillingPostalCode;
                 con.MailingCity=acc.BillingPostalCode;
                  con.MailingCountry=acc.BillingPostalCode;
                  con.MailingStreet=acc.BillingPostalCode;
                  conList.add(con);
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }
    public void finish(Database.BatchableContext bd){

    }
}