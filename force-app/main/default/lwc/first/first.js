import { LightningElement,track,api } from 'lwc';



export default class First extends LightningElement {



        constructor()
        {
            super();
            
            console.log('Constructor call');
        }

        connectedCallback()
        {
            console.log(' Parent connectdCallBack');
        }

        renderedCallback()
        {
            console.log('Parent Renderedcallback');
        }
        disconnectedCallback()
        {
            console.log('Disconnected CAll');
        }

        errorCallback()
        {
            console.log('Error occcurred Parent');
        }
}