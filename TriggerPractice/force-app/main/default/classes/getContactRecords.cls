public with sharing class getContactRecords {
    @AuraEnabled(cacheable=true)
  
    public static List<Contact> getContactRecordsMethod() {
        List<contact> cons = [select FirstName, Lastname , email from Contact Limit 20];
        return cons;
    }
}