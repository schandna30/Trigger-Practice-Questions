// Fetch the account with the maximum number of opportunities.


select id 
SELECT AccountId, COUNT(Id) 
FROM Opportunity
GROUP BY AccountId
ORDER BY  COUNT(Id) DESC
LIMIT 1


// Retrieve the latest 10 Account records.
SELECT id , Createddate from account ORDER BY Createddate DESC limit 10

// Fetch Account-related Contacts and Opportunities in a single query.
select id , name ,(selecct id , name from contacts),(select id , name from opportunities) from Account



// Retrieve only active Contacts that are related to Accounts.
select id , name from contact where accountid!=null and active__c=true

// Write a SOQL query to get the Account IDs of all Accounts with more than 5 Contacts.
//select id from Account where id in (select AccountId from contact group by accountid Having count(Id)>5)
//cannot use groupby or aggregates in sub queries
select accountId from contact group By accountId having count(id)>5

// Fetch all Accounts that have no associated Contacts.
select id, name from account where id not in (select AccountId from Contact)

// Retrieve an Account that has at least one Contact.
select id ,name from account where id in (select AccounId from Contact)

// Fetch all Users with the profile "System Administrator."

select id from user where profile.name='System Administrator'

// Retrieve only those Accounts that have at least one Contact record where the IsActive checkbox is set to true.
select id ,name from account where id in (select AccounId from Contact where isActive__c =true)

// Fetch all Accounts created in the last 30 days.
SELECT Id FROM Account WHERE CreatedDate = LAST_N_DAYS:30