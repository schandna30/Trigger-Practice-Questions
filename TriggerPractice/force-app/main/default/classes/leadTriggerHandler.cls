public with sharing class leadTriggerHandler {


public static void setLeadSource(List<Lead> newLeads){
    /*Question 2:Create a trigger on the Lead object to automatically set the LeadSource based on the Company field when a new Lead is created.
If the Company field is blank, set LeadSource to Other.
If the Company starts with "Sales", set LeadSource to Phone Inquiry.
For all other values of Company, set LeadSource to Web.*/
    if(!newLeads.isEmpty()){
        for (Lead leadVar: newLeads ){
            if(leadVar.Company == null){
                leadVar.LeadSource='Other';

            }
            else if(leadVar.Company.startsWith('Sales') ){
                leadVar.LeadSource='Phone Inquiry';
                
            }
            else{
                   leadVar.LeadSource='Web';
            }
        }
    }
}
public static void clearEmailField(List<Lead> newLeads){
    Set<String> allowedDomains= new Set<String>();
    allowedDomains.add('example.com');
    allowedDomains.add('company.com');
    // On the Lead object, validate the Email field. 
    //If the email domain is not from an allowed list (e.g., "example.com" or "company.com"), clear the email field.
    if(!newLeads.isEmpty()){
        for(Lead lead: newLeads){
         //Validate after @
         //check for lower case
         if(string.isNotBlank(lead.Email)){
         string domain=lead.Email.SubstringAfter('@').toLowerCase();
         if(!allowedDomains.contains(domain)){
            lead.Email=null;
         }
        }
    }}
}
public static void clearEmailFieldAfterUpdate(List<Lead> newLeads, Map<id,Lead> oldrec){
    Set<String> allowedDomains= new Set<String>();
    allowedDomains.add('example.com');
    allowedDomains.add('company.com');
    
    if(!newLeads.isEmpty()){
        for(Lead lead: newLeads){
       Lead oldLead = oldrec.get(lead.Id);
       if(oldLead != null && lead.Email!=oldLead.Email){
         if(string.isNotBlank(lead.Email)){
         string domain=lead.Email.SubstringAfter('@').toLowerCase();
         if(!allowedDomains.contains(domain)){
            lead.Email=null;
         }
        }
    }}}
}


}