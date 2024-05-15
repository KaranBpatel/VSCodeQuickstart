import { LightningElement } from 'lwc';

export default class CustomEvent extends LightningElement {


    handlemessage(ev)
    {
        console.log('customEvent '+ev.detail.value);
    }
}