import { LightningElement } from 'lwc';

export default class Parentcmp extends LightningElement {

    countValue=0;
    handleaddition()
    {
        this.countValue++;
    }
    handlesub()
    {
        this.countValue--;
    }

    handlemul(event)
    {
        let mulValue= event.detail;
        
        this.countValue= this.countValue*mulValue;
        console.log(this.countValue);
    }
}