'use strict'
import { LightningElement ,track} from 'lwc';
import countCon from '@salesforce/apex/contactSubject.countCon';
import MyModal from 'c/myModal';


export default class Firstuiparent extends LightningElement {


    @track ct;
    bool=false;
    @track crd;

    bool2=true;
    connectedCallback(){
        countCon().then(res=>{
            this.ct=res;
            console.log(typeof this.ct+'   value:',this.ct);
            if(this.ct==0){
                console.log('false it');
                this.bool2=false;
            }

        }).catch(err=>{
            this.error=err;
            console.log(this.error);
        });

        console.log('out')
       
    }  

    handleclick(ev)
    {
        if(this.bool==false)
        {
            this.bool=true;
        }
        else
            this.bool=false;

            this.dispatchEvent(new RefreshEvent());
        
    }

    handleCount(ev)
    {
       //this.var=ev.detail.value;
       this.var= ev.detail.value;
       console.log('clicked',this.var);
      
        this.ct=this.ct+this.var;
        
        if(this.ct==0){
            this.bool2=false;
        }
        else{
            this.bool2=true;
        }
        console.log('count unread',this.ct);

    }

    handleshow(evt)
    {
        this.crd=evt.detail.value;
        console.log('show card details '+crd.Name);
    }

    handlemodal() {
        console.log('modal');
        const result =  MyModal.open({
            // `label` is not included here in this example.
            // it is set on lightning-modal-header instead
            size: 'large',
            description: 'Accessible description of modal\'s purpose',
            content: 'Passed into content api',
        }).then().catch(e=>{console.log(e);});

        console.log(result);
        }
    }