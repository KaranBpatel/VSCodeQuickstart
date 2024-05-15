import { LightningElement,api,wire,track } from 'lwc';
import getContact from 'lightning/uiRecordApi';


export default class GetContact extends LightningElement {

    @track record;
    @track error;
   
    @api recordId;
    @wire(getContact,{ContactId:'$recordId',fields:['Contact.LastName']})
    contacts({data,err}){
        if(data){
            this.record = data;
            this.error= undefined;
        }else if(err){
            this.error = err;
            this.data=undefined;
        }
    }

    get getName()
    {
        return this.record.fields.LastName.value;
    }

}