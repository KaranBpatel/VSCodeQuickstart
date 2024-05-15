import { LightningElement } from 'lwc';

export default class Child extends LightningElement {

    constructor()
    {
        //super();
        console.log('Child Constructor');
    }

    connectedcallback()
    {
        console.log('Child Connectedcallback');
    }

    renderedCallback()
    {
        console.log('Child Renderedcallback');
    }
    
    disconnectedCallback()
    {
        console.log('Child disconnectedcallback');
    }

    errorcallback()
    {
        console.log('Error occurred child');
    }
}