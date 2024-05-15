import { LightningElement,wire,api,track } from 'lwc';
import  { getRecord, getFieldValue }  from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';
export default class GetAccount extends LightningElement {

   
     //@wire(getAccount)wiredAccount;
     @api acc;
     @api recordId;
      //name="Karan";

      @wire(getRecord,{recordId:'$recordId',fields:[NAME_FIELD]})
      wiredAccount;
         
      get Name() {
        return getFieldValue(this.wiredAccount.data, NAME_FIELD);
      }
    //acc=this.record.data;

}