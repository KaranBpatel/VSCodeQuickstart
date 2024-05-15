import { LightningElement,wire,track,api } from 'lwc';
import getTask from '@salesforce/apex/getTask.getTask';
import upTask from '@salesforce/apex/updateTask.updateTask';
import getdata from '@salesforce/apex/fetchLightningRecordPage.getdata';

import Id from '@salesforce/schema/Task.Id';
import deleteTask from '@salesforce/apex/deleteTask.deleteTask';
import { RefreshEvent } from 'lightning/refresh';
import { refreshApex } from '@salesforce/apex';

export default class Taskdis extends LightningElement {

    @api recordId;

    columns=[ 
        {label:'id' , fieldName:'Id',displayReadOnlyIcon: true},
        {label:'Subject', fieldName:'Subject', editable:true},
                {label:'Priority', fieldName:'Priority',editable:true},
                
                {
                    type: 'button', label: 'Delete', initialWidth: 110, typeAttributes: {
                        label: 'Delete',
                        name: 'delete',
                        title: 'Delete',
                        disabled: false,
                        value: 'delete',
                        iconPosition: 'left',
                        iconName:'utility:delete',
                        variant:'destructive',
                        
                    }
                },
                {
                    type: 'button', label: 'icon', initialWidth: 110, typeAttributes: {
                        label: 'Delete',
                        name: 'icon',
                        title: 'Delete',
                        disabled: false,
                        value: 'delete',
                        iconPosition: 'left',
                        iconName:'utility:lead',
                        variant:'destructive',
                        
                    }
                }                     
                
            ]

      @track data=[];
      @track form=true;
      @track error;
      @track wiredata;
       
      @wire(getTask)
      wireTask(value){
        this.wiredata=value;
        let res=value.data;
        console.log('value 43',JSON.stringify(value))
        if(res)
        {
            this.data=res;
            console.log('43>>',JSON.stringify(this.data));
            var newIcon=[];
            this.data.forEach(it=>{
                // it.push({iconName:'utility:action'});
                console.log('it'+JSON.stringify(it));
                var newobj = Object.assign({}, it, {icon :"action:approval"});
                console.log('newobj'+JSON.stringify(newobj));
                newIcon.push(newobj);

            })
            console.log('iconAdded',JSON.stringify(newIcon));
            this.data=newIcon;
            // value.error=undefined;
        }
        else
        {
            this.data=undefined;
            console.log(value.error);
        }
      }
      refreshData() { 
        return refreshApex(this.wiredata);
        }
       connectedCallback(){
        getdata().then(res=>{
            console.log('coonected pagelayout active',res);
        }).catch(err=>{
            console.log('errr'+err);
        })
       }

       //@track id=Id;
      
       

       handleRowAction(event)
       {

        let actionName= event.detail.action.name;
        console.log('Action Name',actionName);
        if(actionName=='update')
        {

            console.log('Update');
            //this.form=false;
            alert('Input');

      
        }
        else{
            let taskId= event.detail.row.Id;
            this.ondelete(taskId);
            console.log('Delete '+taskId);
        }
       }

       @track resp;
       @track errors; 
       ondelete(Id)
       {
        console.log('delete 75',Id);
            deleteTask({i:Id}).then(res=>
                {
                    this.resp=res;
                    console.log(resp);
                }).catch(err=>
                    {
                        this.errors=err;
                        console.log(errors);
                    });
       }
      
       saveDraftValues=[];

       handlesave(event)
       {
            let updatedField= event.detail.draftValues;
            
            console.log('Saved');
            console.log(updatedField);


           upTask({tas:updatedField}).then(res=>{
                this.resp=res;
                console.log('Success');

                refreshApex(this.wiredata).then(()=>{
                    this.saveDraftValues=[];
                    console.log('data updted');
                })
                this.dispatchEvent(new RefreshEvent());
           }).catch(err => {
            this.errors=err;
            console.log('Failure '+this.errors);
           });
       }
    }