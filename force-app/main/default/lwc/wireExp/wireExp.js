import { LightningElement ,api,wire,track } from 'lwc';
//import getName from '@salesforce/schema/Account.Name';
import getRecord from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
export default class WireExp extends LightningElement {

    @api recordId;
    @track contacts;
    @track error;

    @wire(getRecord,{recordId:'$recordId',fields:['Account.Name']})
    record({data,error})
    {
        if(data){
            contacts.this=data;
        }
        else if(error)
        {
            error.this=error;
        }
    };
    
    get getName()
    {
        return this.contacts.fields.Name.value;
    }
    refreshData() { 
        return refreshApex(this. wiredAccountResult);
        }
}