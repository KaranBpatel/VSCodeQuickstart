import { LightningElement } from 'lwc';

export default class Subscribe extends LightningElement {

    connectedCallback()
    {
        console.log('Connectd callBack');
      
    }

    handlemessage(evt)
    {
        console.log('subs '+evt.detail.value);
    }
}