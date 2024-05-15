import { LightningElement } from 'lwc';

export default class Publish extends LightningElement {

    handleClick()
    {
        console.log('On publish click');
        let event= new CustomEvent('message',{
            detail:{value:'message'}
             , bubbles:true});
             this.dispatchEvent(event);

    }
}