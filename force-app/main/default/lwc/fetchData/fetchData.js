import { LightningElement, track,api } from 'lwc';
import  getAccountRecs  from '@salesforce/apex/getAccountRecs.getAccountRecs';

export default class FetchData extends LightningElement {

    columns = [
        { label: 'Acc Name', fieldName: 'Name' },
        { label: 'Phone', fieldName: 'Phone', type: 'Phone' }
    ];
            
    @track data=[];
    @api recordId;

    connectedCallback()
    {
        getAccountRecs().then((res)=>{this.data=res;
        console.log(this.data)});

    }
    
}