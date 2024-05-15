import { LightningElement,track,wire,api } from 'lwc';
import fetchfields from '@salesforce/apex/fetchLightningRecordPage.fetchfields';
import { getRecord } from 'lightning/uiRecordApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';

const FIELDS=['fielUploader__message__c.fielUploader__check__c','fielUploader__message__c.Name','fielUploader__message__c.fielUploader__phone__c','fielUploader__message__c.fielUploader__message__c','fielUploader__message__c.fielUploader__bool2__c','fielUploader__message__c.Owner.Name','fielUploader__message__c.fielUploader__messageDate__c','fielUploader__message__c.fielUploader__ContactId__r.Name'];
export default class FieldsFromLightningPage extends LightningElement {

    @track data;
    @track sectionData=[];
    @track finaldata=[];
    @api recordId;
    newval;
    editing=false;
    flds=['fielUploader__message__c.Name'];
    @wire(getRecord,{recordId:'$recordId',fields:FIELDS})
    wiredata({data,err}){
        if(data){
            console.log('valuedata'+JSON.stringify(data));
        }
        else{
            console.log('valuedata'+err)
        }
    }

    @api objectApiName; // Object API name for which you want to retrieve field information
    @api flexipageRegionWidth;
    objectInfo;
    @wire(getObjectInfo, { objectApiName: 'fielUploader__message__c' })
    wiredObjectInfo({ error, data }) {
        if (data) {
            this.objectInfo = data;
            console.log('objectApiName'+this.objectApiName);
            console.log('object data'+JSON.stringify(data.fields));

        } else if (error) {
            console.error('Error fetching object info: ', error);
        }
    }

    get isFieldEditable() {
        // Check if objectInfo and fieldName are available
        return (fieldName) => {
            if (this.objectInfo && this.objectInfo.fields[fieldName]) {
                return this.objectInfo.fields[fieldName].updateable;
            }
            return false;
        };
    }
    connectedCallback() {
        console.log('firld connected lnp recordId',this.recordId);
        console.log('flexipageRegionWidth'+this.flexipageRegionWidth);
        fetchfields().then(res=>{
            this.data=JSON.parse(res);
            console.log('res'+JSON.stringify(this.data));
            //var recdata=this.data.records;
            console.log('data fields fetch',JSON.stringify(this.data.records[0].Metadata.flexiPageRegions[1].itemInstances[0].fieldInstance.fieldItem));
            // this.data.records[0].Metadata.flexiPageRegions[2].itemInstances.forEach(itm => {
            //     console.log('fields',JSON.stringify(itm.fieldInstance.fieldItem));
            // });
                this.sectionData=this.data.records[0].Metadata.flexiPageRegions;
                var secFields=[];
            for(let i=0;i<this.data.records[0].Metadata.flexiPageRegions.length;i++)
            {
                if(i != 0)
                {
                    this.data.records[0].Metadata.flexiPageRegions[i].itemInstances.forEach(itm => {
                        if(itm.fieldInstance!=null){
                            //console.log('itemInstances',JSON.stringify(itm.fieldInstance));
                            console.log('fields',JSON.stringify(itm.fieldInstance.fieldItem));
                            var fieldApiName= itm.fieldInstance.fieldItem.split('.')[1];

                            this.flds.push('fielUploader__message__c'+fieldApiName);
                            console.log('updatabel'+this.objectInfo.fields[fieldApiName].updateable);
                            var label=this.objectInfo.fields[fieldApiName].label;
                            var iconName='';
                            var avatar='';
                            if(fieldApiName=='OwnerId' || fieldApiName=='CreatedById' || fieldApiName=='LastModifiedById')
                            {
                                if(fieldApiName=='OwnerId')
                                {
                                    iconName='utility:change_owner';
                                }
                                avatar=true;         
                            }
                            else
                            {
                                iconName='utility:edit';
                            }
                            secFields.push({id:itm.fieldInstance.fieldItem,apiName:fieldApiName,isEditable:this.objectInfo.fields[fieldApiName].updateable,iconName:iconName,isAvatar:avatar,label:label});
                        }
                        else
                        {
                           // console.log('itm.componentInstance'+JSON.stringify(itm.componentInstance));
                            itm.componentInstance.componentInstanceProperties.forEach(sect=>{
                               // console.log('sect.name',sect.name)
                                if(sect.name=='label')
                                {

                                console.log('section,'+JSON.stringify(sect.value));
                                this.finaldata.push({id:sect.name,apiName:sect.value,fields:secFields})
                                secFields=[];
                                }
                            })
                        }
            });
                }
            }
            console.log('this.finaldata'+JSON.stringify(this.finaldata));
            
        }).catch(err=>{
            console.log('errror in data fetching '+err);
        });
    }


    handleEdit(){
        console.log('handleEdit');
        if(this.editing)
        {
            this.editing=false;
        }
        else this.editing=true;
    }

    handleSuccess(event) {
        this.newval=event.detail.id;
        console.log('onsuccess event recordEditForm',event.detail.id);
        this.editing=false;
    }
    handleSubmit(event) {
        console.log('onsubmit event recordEditForm'+ event.detail.fields);
    }
    handleCancel(){
        this.editing=false;
    }
}