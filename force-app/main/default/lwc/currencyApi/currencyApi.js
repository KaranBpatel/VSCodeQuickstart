import { LightningElement,wire,track,api } from 'lwc';
import dataRates from '@salesforce/apex/callApi.callRates';
import dataCurrency from '@salesforce/apex/callApi.callCurrency';
export default class CurrencyApi extends LightningElement {

    columns1=[{label:'Currencies',fieldName:'key'},
             {label:'ExchangeRate', fieldName:'value'}];

             columns2=[{label:'Currencies',fieldName:'key'}];

   

    //@wire(dataApi)getCurrency;
    @track dataCurr=[];
    @track currencies=[];
    @track error;
    @track cur=[];
    @track val=[];
    @track curval=[];
    @track currRate=[];
    @track cu=[];
    
   // @track merge=[{key:'AFF', value:222,id:'1'}];
    connectedCallback() {
        dataRates().then(res=>{
            console.log('Currency');
            var parsedata= JSON.parse(res);
            this.dataCurr=parsedata;

            this.currencies = this.dataCurr.meta.effective_params.quote_currencies;
            console.log(this.currencies);

            console.log(obj.key+''+obj.value);

            for(let x in this.currencies )
            {
                
                this.cu.push(this.currencies[x]);
                console.log(this.currencies[x]);
                
            }
            this.val= this.dataCurr.quotes;
            for(let x in this.val )
            {
                
                this.currRate.push(this.val[x].ask);
                console.log(x+' value:'+this.val[x].ask);
                
            }
            bool;
           this.bool=true;
                //console.log(this.val['ADF'].bid);
           
         
        }).catch(err=>{
            this.error=err;
            console.log(this.error);
        });

    }

     
    get option()
    {
        
        this.opt=this.currencies.map(res=>{
            return {label:res , value:res}

        });
        this.opt.splice(1,0,{label:'ADP',value:'ADP'});
        return this.opt;
    }
    //option=[{label:'ADF',value:'ADF'}]

   //cur= this.dataCurr.meta.effective_params.quote_currencies[0];

   @track curData=[];
   @track curRates=[];
   @api lastRate=[];
   @api lastCur=[];
    temp =[]
     oppp=[];
     limit=[];
    @track final=[{}];
     curval;
    value='';
    handleChange(event)
    {
        this.bool=true;
        this.value= event.target.value;
        this.cur=this.value;
        dataCurrency({b:this.value}).then(res=>{
            this.curData=JSON.parse(res);
            this.curRates= this.curData.quotes;
            console.log(this.curRates);


            this.oppp = []
            this.temp = []

            let count = 1
            for(let x in this.curRates )
            {
                this.temp.push({key:x, value: this.curRates[x].ask, Id : count})
                count++
            }
            this.oppp=this.temp;
            this.limit=[]
            this.glb;
            for(let j=0;j<10;j++)
            {
                 this.limit.push({key:this.temp[j].key, value: this.temp[j].value, Id :this.temp[j].Id});
                 this.glb=j;
            }
        this.bool2=true;

            console.log(this.limit[1].key);
                      
        });
       

    }

    
    queryTerm;

    handleKeyUp(event) {
        
            this.bool=false;
            this.queryTerm = event.target.value;
            //console.log('Enetr');
            console.log(this.oppp[5].value+'  '+this.oppp.length);

            console.log(this.curRates);
            this.fin=[];
            this.seach=[];


            

            this.fin=this.oppp;

          for(let j=0 ;j< this.fin.length;j++)
          {
              if(this.fin[j].key.includes(this.queryTerm))
              {
              console.log('loop '+j);
              this.seach.push({key:this.fin[j].key,value:this.fin[j].value,Id:this.fin[j].Id});
              }
          }

        
          console.log(this.seach.length);
          this.fin=this.seach;
          this.bool2=true;
          console.log(this.oppp.length);
          
        
    }

     m=0;
     bool3=false;
    handleNext(event)
    {
        console.log('Next'+this.glb); 

        this.next=[]
        
       // this.ten= this.glb +11;
        if(this.bool2==true){
            this.ten= this.glb +11;
        for(let j=this.glb+1 ;j<this.ten;j++)
          {
              console.log(j);
              this.next.push({key:this.oppp[j].key,value:this.oppp[j].value,Id:this.oppp[j].Id});
              //console.log('loop next '+this.oppp[j].key+''+this.oppp[j].value+' '+this.oppp[j].Id+'  lp'+j);
              //this.next.push({key:this.oppp[j].key, value:this.oppp[j].value, Id:this.oppp[j].Id });
              this.m=j;
              this.bool2=false;
          }
          this.limit=this.next;
        }

        else{
            
            if(this.m<217){

            if(this.bool3==false){
                this.mten=this.m+11;
            for(let j=this.m+1 ;j<this.mten;j++)
          {
              console.log(j);
              this.next.push({key:this.oppp[j].key,value:this.oppp[j].value,Id:this.oppp[j].Id});
              //console.log('loop next '+this.oppp[j].key+''+this.oppp[j].value+' '+this.oppp[j].Id+'  lp'+j);
              //this.next.push({key:this.oppp[j].key, value:this.oppp[j].value, Id:this.oppp[j].Id });
              this.m=j;
          }
          this.limit=this.next;
          }
          else{
                this.next=[];
                this.met=this.m+8;
                   for(let j=this.m+1 ;j<this.met;j++)
                    {
                      console.log(j);
                      
                     // this.nextet.push({key:this.oppp[j].key,value:this.oppp[j].value,Id:this.oppp[j].Id});
                     //console.log('loop next '+this.nextet[j].key+''+this.nextet[j].value+' '+this.nextet[j].Id+'  lp'+j);
                     this.next.push({key:this.oppp[j].key, value:this.oppp[j].value, Id:this.oppp[j].Id });
                     this.m=j;
                     }
          
            this.limit=this.next;
            this.bool4=true;
            this.bool3=false;
          }
        }
        if(this.m == 209)
        {
            this.bool3=true;
        }
        console.log(this.next[this.m].key);
        
        
        }
    }
    bool4=false;
     handlePre(event)
    {
        console.log('Previous');   
        this.prev=[];

        if(this.m>=0){
        let tem=0;
        if(this.bool4==false){
            this.pr=this.m-19;
       for(let j=this.pr ;j<=this.m-10;j++)
          {
              console.log('prev  '+j);
              this.prev.push({key:this.oppp[j].key, value:this.oppp[j].value, Id:this.oppp[j].Id});
              //console.log('loop prev '+this.oppp[j].key+''+this.oppp[j].value+' '+this.oppp[j].Id+'  lp'+j);
              //this.next.push({key:this.oppp[j].key, value:this.oppp[j].value, Id:this.oppp[j].Id });
              
              this.tem=j;
          }
          this.m=this.tem;
          console.log('prev cou'+this.m);
          this.limit=this.prev;
        }
        else{
            this.pr=this.m-16;
             for(let j=this.pr ;j<=this.m-7;j++)
          {
              console.log('prev  '+j);
              this.prev.push({key:this.oppp[j].key, value:this.oppp[j].value, Id:this.oppp[j].Id});
              //console.log('loop prev '+this.oppp[j].key+''+this.oppp[j].value+' '+this.oppp[j].Id+'  lp'+j);
              //this.next.push({key:this.oppp[j].key, value:this.oppp[j].value, Id:this.oppp[j].Id });
              
              this.tem=j;
          }
         
        this.m=this.tem;
          console.log('prev cou'+this.m);
          this.limit=this.prev;
        }
         this.bool4=false;
        }
    }
    }