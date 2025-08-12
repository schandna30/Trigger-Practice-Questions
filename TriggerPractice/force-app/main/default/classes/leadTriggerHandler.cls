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


}