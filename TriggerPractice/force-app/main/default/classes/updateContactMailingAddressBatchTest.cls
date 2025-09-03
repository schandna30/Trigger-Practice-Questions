@isTest
public class UpdateContactMailingAddressBatchTest {
    @testSetup
    static void setupData(){
        Account acc = new Account(
         Name = 'Test Account',
            BillingStreet = '123 Test St',
            BillingCity = 'New York',
            BillingPostalCode = '10001',
            BillingCountry = 'USA');
        insert acc;
        
         Contact con = new Contact(
             LastName = 'Contact',
                AccountId = acc.Id,
                MailingStreet = 'Old Street',
                MailingCity = 'Old City',
                MailingPostalCode = '00000',
                MailingCountry = 'OldCountry');
        insert con;
             
    }
    @isTest
    static void testBatchExecution(){
        test.startTest();
        UpdateContactMailingAddressBatch batch = new UpdateContactMailingAddressBatch();
        Database.executeBatch(batch,200);
        test.stopTest();
    }

}