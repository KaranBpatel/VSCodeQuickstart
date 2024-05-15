import { LightningElement } from 'lwc';
export default class Utility extends LightningElement {

        renderedCallback(){
            window.scrollTo(0,9999);
        }
}