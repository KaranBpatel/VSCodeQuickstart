public class PageMessageController {

    String recordId;
    public String accName{get;set;}
    public String accPhone{get;set;}
    public String cnName{get;set;}
    public String cnPhone{get;set;}
    
    public List<Account> accounts{get;set;}
    public List<Contact> contacts{get;set;}
    public Account acc{get;set;}
    public PageMessageController(){
        acc= new Account();
        accounts= new List<Account>();
        contacts= new List<Contact>();
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.info,'Enter alphabetic order'));
        recordId= System.currentPageReference().getParameters().get('Id');
        //recordId='0015h00001bebjgAAA';
        System.debug('RecordId ln-18 >'+recordId);
       // acc=[SELECT name,phone,rating,id FROM Account WHERE  id =:recordId];
    }
    public void saveRecord(){
        System.debug('Save Record '+accName);
        /*if(acc.Rating == 'hot'){
                     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm, 'Rating is Hot.'));  
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info, 'Rating isnot Hot.'));
        }*/
        Account acc= new Account();
        acc.id=recordId;
        acc.Name=accName;
        acc.Phone=accPhone;
          upsert acc;
        
        /*Contact con= new Contact();
        con.LastName=cnName;
        con.Phone=cnPhone;
        con.AccountId=acc.Id;
        insert con;*/
    }
    
    public void getAccounts(){
        accounts=[SELECT Name,Id,Phone,Rating FROM Account LIMIT 10];
    }
    public void getContacts()
    {
        contacts=[SELECT Name, Id, Phone FROM Contact LIMIT 10];
    }
}