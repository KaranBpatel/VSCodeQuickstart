import { LightningElement,api,track,wire } from 'lwc';
import creTask from '@salesforce/apex/createTask.createTask';
import getFileNames from '@salesforce/apex/FileController.getFileNames';
import SUBJECT_FIELD from '@salesforce/schema/Task.Subject';
import STATUS from'@salesforce/schema/Task.Status';
import OWNERID from'@salesforce/schema/Task.OwnerId';
import PRIORITY from'@salesforce/schema/Task.Priority';
import CONTACTNAME from '@salesforce/schema/Task.WhoId';
import ACCRELATED from '@salesforce/schema/Task.WhatId';
import { getRelatedListRecords } from "lightning/uiRelatedListApi";

export default class Task extends LightningElement {

    value='inProgress';
    @api recordId;
    get options() {
        return [
            { label: 'Working', value: 'working' },
            { label: 'In Progress', value: 'inProgress' },
            { label: 'Finished', value: 'finished' },
            { label: 'Defferred', value: 'defferred' },
            { label: 'Waiting on someone else', value: 'waiting on someone else' }
        ];
    }

    get optionsPriority() {
        return [
            { label: 'High', value: 'High' },
            { label: 'Low', value: 'Low' },
            { label: 'Normal', value: 'Normal' },
        ];
    }

    records;
    @wire(getRelatedListRecords , {
        parentRecordId: '$recordId',
        relatedListId: 'ContentDocumentLink',
        fields: ['ContentDocumentLink.ContentDocumentId','ContentDocumentLink.LinkedEntityId'],
      })wireRelated({data,err}){
        if(data)
        {
            this.records=data;
            console.log('Related data',this.records);
            err=undefined;

        }
        else{
            data=undefined;
            console.log('Erro related',err);
        }
      }


   //@api recordId;

   @track subject= SUBJECT_FIELD;
   @track status=STATUS;
   @track priority=PRIORITY;
   @track ownerId=OWNERID;
   @track name=CONTACTNAME;
   @track whatId=ACCRELATED;

   
   recs={
       Subject:this.subject,
       Status:this.status,
       Priority: this.priority,
       OwnerId:'0055h00000AlqutAAB',
       Name: this.name,
       WhatId:this.whatId
    };

    
    connectedCallback(){
        console.log('kkk');
        getFileNames({id:this.recordId}).then(data=>{
            console.log('relatedDaata',data);
        }).catch(err=>{
            console.log('Error ocurred>>',err);
        });
        //console.log(recordId);
    }
    
   

   handleSubject(event) {
    this.recs.Subject = event.target.value;

   // this.recs.WhatId = {$recordId};
    console.log("Subject "+this.recs.Subject);
    //console.log(this.recordId);
    }

    handleStatus(event) {
        this.recs.Status = event.target.value;
        console.log("Status "+this.recs.Status);
       
        }
    
        handlePriority(event)
        {
            this.recs.Priority=event.target.value;
        }

        handleName(event)
        {
            this.recs.Name=event.detail.recordId;
            console.log(this.recs.Name);
            console.log(typeof(this.recs.Name));
        }

        handleAccName(event)
        {
            this.recs.WhatId=event.detail.recordId;
            console.log( this.recs.WhatId);
            console.log(typeof(this.recs.WhatId));
            
        }

    handleClick(event)
    {
        creTask({  a:this.recs.Subject , b:this.recs.OwnerId , c:this.recs.Status ,
            d:this.recs.Priority, e:this.recs.Name , f:this.recs.WhatId }).then(result=>
           
                {console.log('Data')
            this.recs.Subject='';
            this.recs.Status='';
            this.recs.Priority='';
            this.recs.OwnerId='';
            this.recs.Name='';
            this.recs.WhatId='';

            }).catch(error => {console.log('Error occurred'); console.log(error);});
    }
}