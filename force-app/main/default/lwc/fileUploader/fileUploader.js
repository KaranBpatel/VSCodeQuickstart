import { LightningElement,api } from 'lwc';

export default class FileUploader extends LightningElement {

     myRecordId='0015h00001ezA2SAAU';

    get acceptedFormats() {
        return ['.pdf', '.png'];
    }
    handleUploadFinished(ev){
        const file= ev.detail.files;
        console.log('Files >7>',file.length);
    }
}