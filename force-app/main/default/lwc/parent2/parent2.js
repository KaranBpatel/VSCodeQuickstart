import { LightningElement } from 'lwc';

export default class Parent2 extends LightningElement {

    sliderValue=45;
    inputValue;
    handleSliderValue(event)
    {
        this[event.target.name]=this[event.target.value];
       // console.log(event.detail.sliderValue);
     //   console.log(event.target.name);
       // console.log(event.target.value);
        this.inputValue= event.detail.sliderValue;
    }

    handleChange(event)
    {
        this.inputValue= event.detail.sliderValue;
        //console.log(this.inputValue);
    }
}