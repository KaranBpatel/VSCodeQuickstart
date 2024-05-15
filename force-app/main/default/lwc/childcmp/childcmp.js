import { LightningElement } from 'lwc';

export default class Childcmp extends LightningElement {

    handleAdd(event)
    {
        this.dispatchEvent(new CustomEvent('add'));
    }

    handleSub(event)
    {
        this.dispatchEvent(new CustomEvent('sub'));
    }

    handleMultiply(event)
    {
        let mulval= event.target.value;
        console.log(mulval);
        this.dispatchEvent(new CustomEvent('multiply',{
            detail: mulval
        }));
    }
}