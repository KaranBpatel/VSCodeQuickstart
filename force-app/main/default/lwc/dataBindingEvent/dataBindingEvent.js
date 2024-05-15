import { LightningElement } from 'lwc';

export default class DataBindingEvent extends LightningElement {

    greeting='Kara,';

    handelChange()
    {
        //this.greeting=event.detail.value;
        console.log('Changed');
        //console.log(event.target.value);
    }
}