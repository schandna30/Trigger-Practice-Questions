public with sharing class getContactRecords {
    @AuraEnabled(cacheable=true)
  
    public static List<Contact> getContactRecordsMethod(String contactKey) 
    {
        if(contactKey==null){
            return [select FirstName, Lastname , email from Contact Limit 20];
        }
        String searchQuery='%'+contactKey+'%';
        
        
        List<contact> cons = [select FirstName, Lastname , email from Contact where name like:searchQuery Limit 20];
        return cons;
    }
    
}