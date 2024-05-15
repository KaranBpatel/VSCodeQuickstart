import { LightningElement,api } from 'lwc';

export default class MyModal extends LightningElement {

    @api content;
    handleOkay() {
        this.close('okay');
    }
}