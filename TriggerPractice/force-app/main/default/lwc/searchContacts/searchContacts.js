import { LightningElement ,wire,track} from 'lwc';


import getContactRecords from '@salesforce/apex/getContactRecords.getContactRecordsMethod';
const COLUMNS =[
    {label:'First Name',fieldName:'FirstName', type:'text'},
     {label:'Last Name',fieldName:'LastName', type:'text'},
      {label:'Email',fieldName:'Email', type:'email'}
];


export default class SearchContacts extends LightningElement {
    columns=COLUMNS;
    contactKey='';
     @track contacts;
handleSearchKey(event)
{
    this.contactKey=event.target.value;

}



 handleSearch(){
    getContactRecords({contactKey: this.contactKey})
        .then(result=>{
            this.contacts=result;
        })
        .catch(error=>{
           this.contacts=undefined;
            console.error('error',error);
        });
    
 }
}