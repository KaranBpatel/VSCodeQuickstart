import { LightningElement,api,wire } from 'lwc';
import {NavigationMixin} from 'lightning/navigation'
import getFilePreview from '@salesforce/apex/FileController.getFilePreview'; 

export default class FilePreview extends NavigationMixin(LightningElement) {

    @api recordId;
    fileList=[];

   connectedCallback(){
    console.log('RecordId  ',this.recordId);
    getFilePreview({id:this.recordId}).then(data=>{
        console.log('data',data);
        this.fileList = Object.keys(data).map(item=>({
             "label":data[item],
             "value": item,
             "url":`/sfc/servlet.shepherd/document/download/${item}`
            }))
            console.log(this.fileList[0].label)
    }).catch(err=>{
        console.log(err);
    })
   }
previewHandler(event){
        console.log(event.target.dataset.id)
        const condocId= event.target.dataset.id;
        this.navigateToFiles(condocId);
    }
navigateToFiles(ContentDocumentId) {
        this[NavigationMixin.Navigate]({
          type: 'standard__namedPage',
          attributes: {
              pageName: 'filePreview'
          },
          state : {
              selectedRecordId:ContentDocumentId
          }
        })
      }

}