import { LightningElement,track } from 'lwc';
import emailTemp from '@salesforce/apex/emailTemplate1.emailTemp';

export default class Twillioui extends LightningElement {

    opt=[{label:'Schedule Immediately',value:'immediate'},
            {label:'Specify a Date and Time', value:'schedule'}
            ];

    frmsender=[{label:'abcd',value:'abcd'},
                {label:'Create a new sender', value:'new'}
                ];

                vr='abcd';
                
                showDateTimePicker=false;

                styleTemplate="display:flex;width: 359px;height:690px;";

                handleChange(ev)
                {
                 var temp= ev.target.value;
                 console.log(temp);
                 if(temp=='schedule')
                 {
                        this.showDateTimePicker=true;
                        //var divList= this.template.querySelectorAll('[data-id="abc"]');
                        console.log(divList);
                        this.styleTemplate="display:flex;width: 359px;height:760px;";

                 }
                 else{
                        this.showDateTimePicker=false;
                       /* var divList= this.template.querySelectorAll('[data-id="abc"]');
                        console.log(divList);
                        divList.style.height="690px";*/
                 }
                }

                handleSubjectChange(ev)
                {
                        this.subject=ev.target.value;
                }
                @track emaildata=[];;
                @track body
                @track subject
                @track emlTemplate=[];
                connectedCallback(){
                                console.log('connected')
                        emailTemp().then(res=>{
                                this.emaildata=res;
                                this.body=res[0].Body;
                                console.log('emaildata',this.emaildata);
                                 
                        }).catch(err=>{
                                console.log(err)
                        });
                         
                        console.log('2')
                        
                }

                @track opt=[];; 
                get options()
                {
                        this.opt= this.emaildata.map(res=>{
                                return {label:res.Name , value:res.Id};
                        });
                    return  this.opt;
                }

                @track template;
                handleTemplate(ev)
                {
                        this.template=ev.target.value;
                        console.log('template',this.template);
                        this.emaildata.forEach(res=>{
                                console.log(res.Name+'  id:'+res.Id);
                                if(res.Id == this.template)
                                {
                                        console.log('body');
                                        this.body=res.Body;
                                        console.log(this.body);
                                      
                                }
                        });
                }
               


}