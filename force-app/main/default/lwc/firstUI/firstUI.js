import { LightningElement,track } from 'lwc';
import getCons from '@salesforce/apex/contactSubject.contactSub';
import upCons from '@salesforce/apex/contactSubject.updateRead';
import upConList from '@salesforce/apex/contactSubject.updateAll';
import getAllRead from '@salesforce/apex/contactSubject.getAllRead';
import updateAllRead from '@salesforce/apex/contactSubject.updateAllRead';
import showcheck from '@salesforce/apex/contactSubject.showcheck';
import updateshow from '@salesforce/apex/contactSubject.updateshow';
import updateshowTrue from '@salesforce/apex/contactSubject.updateshowTrue';
import getshowTrue from '@salesforce/apex/contactSubject.getshowTrue';
import getAllUnread from '@salesforce/apex/contactSubject.getAllUnread';
import updateAllUnread from '@salesforce/apex/contactSubject.updateAllUnread';
import { loadStyle } from 'lightning/platformResourceLoader';
import customCss from '@salesforce/resourceUrl/customCss'


export default class FirstUI extends LightningElement {


    @track
    crd
    @track data=[];

        bool=false;
        bool2=true;

        @track undata=[];
        @track count=0;

    @track fdata=[];
        datalas
        showbool;
        connectedCallback(){

            //loadStyle(this,customCss);
            // fetchfields().then(res=>{
            //     console.log('response mdata',res);
            // }).catch(err=>{
            //     this.error=err;
            //     console.log(err);
            // });
            getCons().then(res=>{
                this.data=res;
                console.log('data',this.data);
            }).catch(err=>{
                this.error=err;
                console.log(this.error);
            });

            getAllRead().then(re=>{
                this.fdata= re;
                console.log('fdata',this.fdata);
            }).catch(err=>{
                this.error=err;
                console.log(this.error);
            });
            
            showcheck().then(res=>{
                this.showbool=res;
                console.log('showbool',this.showbool);
            }).catch(err=>{
                this.error=err;
                console.log(this.error);
            });

            getshowTrue().then(res=>{

                this.crd=res;
                console.log("child card",this.crd);
            }).catch(err=>{
                this.error=err;
                console.log(this.error);
            });

            getAllUnread().then(res=>{
                this.undata=res;
                console.log('undata',this.undata);
            }).catch(err=>{
                this.error=err;
                console.log(this.error);
            });
            
        }
    
    onShow(event)
    {
        this.showbool=true;
        this.name=event.target.name;
        console.log('Show '+this.name);
        this.bool=true;
        this.bool2=false;

        this.count=-1;
        const ent = new CustomEvent('count',{
            detail:{value:this.count}
        });
        this.dispatchEvent(ent);
        
        
        for(let i=0;i<this.data.length;i++)
        {
            if(this.data[i].Id==this.name)
            {
               
                console.log(this.data[i].check__c);
                this.data[i].check__c=true;
                this.crd={Name:this.data[i].Name,phone__c:this.data[i].phone__c,message__c:this.data[i].message__c,messageDate__c:this.data[i].messageDate__c,check__c:this.data[i].check__c,Id:this.data[i].Id};
            }
        }
        upCons({b:this.crd.Id,c:this.crd.check__c}).then(res=>{
            console.log('Successfull '+res);
        }).catch(err=>{
            console.log('Error '+err);
        });

        updateshowTrue({b:this.crd.Id}).then(res=>{
        
            console.log(this.showbool);
        }).catch(err=>{
            this.error=err;
            console.log(this.error);
        });

        const cevent = new CustomEvent('showcard',{
            detail:{value:this.crd}
        });

    }

   
     onBack(evt)
    {
        
        this.bool=false;
        this.bool2=true;
        this.showbool=false;
        updateshow().then(res=>{
            console.log(this.showbool);
        }).catch(err=>{
            this.error=err;
            console.log(this.error);
        });
    }

    objboll={};
    boolbold=true;
    //fcheck=false;
    val='false';

    handleChange(evt)
    {
        this.op= evt.target.name;
        this.opval=evt.target.value;
        console.log(this.op);
        console.log(this.opval);
        this.dummy={};
        this.darray=[];
        if(this.opval=='false')
        {

        this.val='true';
        for(let i in this.data)
        {
            if(this.data[i].Name==this.op)
            {
                this.data[i].check__c=true;
                this.dummy={check__c:this.data[i].check__c,Id:this.data[i].Id};
              
            }
        }
       
    }
    else{

            this.val='false';
            console.log('now true');
        for(let i in this.data)
        {
            if(this.data[i].Name==this.op)
            {
                this.data[i].check__c=false;
                this.dummy={check__c:this.data[i].check__c,Id:this.data[i].Id};
                
               
            }
        }

        
    }
       
    upCons({b:this.dummy.Id,c:this.dummy.check__c}).then(res=>{
        console.log('Successfull '+res);
    }).catch(err=>{
        console.log('Error '+err);
    });
        
    }

    onread(evt){

        this.pt= evt.target.name;
        console.log('Read');
        console.log(this.pt);

        this.count=-1;
        const cevent = new CustomEvent('count',{
            detail:{value:this.count}
        });
        this.dispatchEvent(cevent);
        this.ut={};

        for(let i in this.data)
        {
            if(this.data[i].Id == this.pt)
            {
                this.data[i].check__c=true;
                this.ut={Id:this.data[i].Id,check__c:this.data[i].check__c};
            }
        }

        upCons({b:this.ut.Id,c:this.ut.check__c}).then(res=>{
            console.log('Successfull '+res);
        }).catch(err=>{
            console.log('Error '+err);
        });

        this.allread=true;
        this.undata.unreadall__c=false;
        updateAllUnread({b:this.allread}).then(res=>{
            console.log('unreadall updated '+this.undata);
        }).catch(err=>{
            console.log(''+err);
        }); 
    }

    onunread(evt)
    {
        this.yt= evt.target.name;
        console.log('UnREAD');
        console.log(this.yt);

        this.count=1;
        const cevent = new CustomEvent('count',{
            detail:{value:this.count}
        });
        this.dispatchEvent(cevent);

        this.um={};
        for(let i in this.data)
        {
            if(this.yt==this.data[i].Id)
            {
                this.data[i].check__c=false;
                this.um={Id:this.data[i].Id,check__c:this.data[i].check__c};

            }
        }

        upCons({b:this.um.Id,c:this.um.check__c}).then(res=>{
            console.log('Successfull '+res);
        }).catch(err=>{
            console.log('Error '+err);
        });

        this.allread=true;
            this.fdata.markread__c=false;
            updateAllRead({b:this.allread}).then(res=>{
                
                console.log(''+this.fdata);
            }).catch(err=>{
                console.log(''+err);
            });
    }

allread=false;
allunread=true;
alval='false';
alunval='true';

sall=false;
    
     readAll(evt)
    {
        this.temp= evt.target.value;
        console.log('ALL Read  '+this.temp);
        
            this.sall=true;
            this.count=0;
            if(this.fdata.markread__c==false){

              this.data.forEach(dt=>{
                    
                   if(dt.check__c==false){
                    this.count=this.count+1;
                    dt.check__c=true;
                   }
                    
                });

              this.tep=-this.count;
             this.count=this.tep;  
            const cevent = new CustomEvent('count',{
                     detail:{value:this.count}
                      });
                 this.dispatchEvent(cevent);

                this.fdata.markread__c=true;

               this.allread=false;
               console.log('1');
                upConList({b:this.allread}).then(res=>
                    {
                        
                        console.log('succ  '+this.data);
                    }).catch(err=>
                        {
                            console.log('Failed  '+err);
                        });
                console.log('2');

             updateAllRead({b:this.allread}).then(res=>{
                    
                console.log(''+this.fdata);
            }).catch(err=>{
                console.log(''+err);
            });  

            this.allunr=true;
        this.undata.unreadall__c=false;
        updateAllUnread({b:this.allunr}).then(res=>{
            console.log('unreadall updated '+this.undata);
        }).catch(err=>{
            console.log(''+err);
        }); 


        }
        else
        {
            this.allread=true;
            this.fdata.markread__c=false;
            updateAllRead({b:this.allread}).then(res=>{
                
                console.log(''+this.fdata);
            }).catch(err=>{
                console.log(''+err);
            });
        }

        
           
    }
  
    unreadAll(eve)
    {

        console.log(this.undata.unreadall__c);
        if(this.undata.unreadall__c==false){

            this.count=0;
            this.data.forEach(dt=>{
                if(dt.check__c==true){
                        this.count=this.count+1;
                        dt.check__c=false;
                }
                
            });

            
            const cevent = new CustomEvent('count',{
                     detail:{value:this.count}
                      });
                 this.dispatchEvent(cevent);

            this.undata.unreadall__c=true;

           this.allread=true;
           console.log('1');
            upConList({b:this.allread}).then(res=>
                {
                    
                    console.log('succ  '+this.data);
                }).catch(err=>
                    {
                        console.log('Failed  '+err);
                    });
            console.log('2');

            this.boolunread=false;

            updateAllUnread({b:this.boolunread}).then(res=>{
            console.log('unreadall updated '+this.undata);
        }).catch(err=>{
            console.log(''+err);
        });  

        this.alread=true;
            this.fdata.markread__c=false;
            updateAllRead({b:this.alread}).then(res=>{
                
                console.log(''+this.fdata);
            }).catch(err=>{
                console.log(''+err);
            });
    }
    else
    {
        this.allread=true;
        this.undata.unreadall__c=false;
        updateAllUnread({b:this.allread}).then(res=>{
            console.log('unreadall updated '+this.undata);
        }).catch(err=>{
            console.log(''+err);
        }); 
    }  
    }

    showoption(eve)
    {
        this.var= eve.target.name;
        console.log(this.var);
        
        var divList= this.template.querySelectorAll('[data-id="abc"]').forEach(re=>{
            if(re.className==this.var)
            {
                this.divb=re;
            }
        });
        console.log(this.divb);

        if(this.divb.style.display=="none")
        {
           console.log('None');
            this.divb.style.display="";
            this.show=0;
        }
        else{

            this.divb.style.display="none";
            this.show=1;
        }
    }

    renderedCallback(){
        // console.log('scrollto down');
        // window.scrollTo(0,9999);
    }
}