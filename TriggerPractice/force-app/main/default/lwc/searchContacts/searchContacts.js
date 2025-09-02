import { LightningElement ,wire} from 'lwc';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FirstName from '@salesforce/schema/Contact.FirstName';
import LastName from '@salesforce/schema/Contact.LastName';
import Email from '@salesforce/schema/Contact.Email';

import getContactRecords from '@salesforce/apex/getContactRecords.getContactRecordsMethod';
const COLUMNS =[
    {label:'First Name',fieldName:'FirstName', type:'text'},
     {label:'Last Name',fieldName:'LastName', type:'text'},
      {label:'Email',fieldName:'Email', type:'email'}
];


export default class SearchContacts extends LightningElement {
    columns=COLUMNS;

 @wire (getContactRecords)
 contacts;
}