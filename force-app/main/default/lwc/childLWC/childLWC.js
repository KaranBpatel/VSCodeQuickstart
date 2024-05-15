import { LightningElement,api } from 'lwc';

export default class ChildLWC extends LightningElement {

    @api val;

    sliderValueChange(event)
    {
        const valueChangeEvent= new CustomEvent('changeevent',
        {
            detail: {sliderValue: event.target.value}
        });

        this.dispatchEvent(valueChangeEvent);
    }
}