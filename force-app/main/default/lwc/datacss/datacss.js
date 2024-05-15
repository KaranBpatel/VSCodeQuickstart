import { LightningElement,track } from 'lwc';
export default class Datacss extends LightningElement {



    @track data=[{name:'karannnnnnnnn', value:'1'},
               {name:'karan', value:'2'},
               {name:'karan', value:'3'},
               {name:'karan', value:'4'},
               {name:'karan', value:'5'} 
                ];
                
                connectedCallback() {
                    console.log(this.data);
                     window.addEventListener('resize', this.myFunction);
                     
                }

                @track count = 0;
myFunction = () => {

   /* this.height= window.innerHeight;
    console.log(this.height)
    if(this.height>750){
        
        var divlist= this.template.querySelector('.tooltip');
        console.log(divlist);
        divlist.style.overflow="visible";
        }
        else{

             var divlist= this.template.querySelector('.tooltip');
        console.log(divlist);
        divlist.style.overflow="hidden";
        }*/
    this.count = this.count += 1;
    console.log('resized => ', this.count);
    
};

handleclick(ev){

    this.var= window.innerHeight;
    this.wi=window.innerWidth;
    console.log(this.var);
    console.log(this.wi);
}

}