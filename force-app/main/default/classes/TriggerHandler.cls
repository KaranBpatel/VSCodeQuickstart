public class TriggerHandler {
    public static boolean flag=false;
    public static void beforeInsert(List<Account> newList)
    {
        Account[] accList= new Account[]{};
            
        for(Account accv:newList)
        {
            if(accv.Industry!=null && accv.Industry=='Media')
            {
                accv.Rating='Hot';
               // accv.ParentId
                
            }
           
        }
         Account acc= new Account();
        	acc.id='0015h00001cQ1awAAC';
            acc.Phone='123456';
           		accList.add(acc);
        update accList;
        
    }
    public static void afterInsertRelatedOpp(List<Account> newList)
    {
        List<Opportunity> opList= new List<Opportunity>();
        for(Account acc:newList)
        {
            Opportunity opp= new Opportunity();
            opp.name=acc.name;
            opp.AccountId=acc.id;
            opp.StageName='Closed Won';
            opp.CloseDate=System.today();
            oplist.add(opp);
        }
        if(!oplist.isEmpty())
        {
            insert opList;
        }
    }
    public static void beforeUpdateDes(List<Account> newList,Map<Id,Account> oldMap)
    {
        for(Account acc:newList)
        {					   //newPhone!=OldPhone in before events not need of DML use Assignments because not committed in DataBAsae. 
            if(oldMap!=null && acc.phone!=oldMap.get(acc.Id).Phone)
            {
                acc.Description='Phone is updated to '+acc.phone;
            }
        }
        
    }
    
    public static void afterUpdate(List<Account> newList,Map<Id,Account> oldMap)
    {
        Map<id,Account> accMap= new Map<id,Account>();
        for(Account acc:newList)
        {
            if(acc.Description!=oldMap.get(acc.Id).Description)
            {
                accMap.put(acc.id,acc);
            }
        }
        
        Opportunity[] updateList= new Opportunity[]{};
        Opportunity[] getList=[SELECT id,Description,AccountId FROM Opportunity WHERE AccountId IN :accMap.keyset()];
        
        if(!getList.isEmpty())
        {
            for(Opportunity opp:getList)
            {
                if(accMap.containskey(opp.AccountId)){
                Opportunity op= new Opportunity();
                op.id=opp.Id;
                op.Description=accMap.get(opp.AccountId).Description;
                updateList.add(op);
                }
            }
        }
        if(!getList.isEmpty())
        {
            update updateList;
            System.debug('Update Desciption');
        }
    }
    
    public static void afterUpdateContact(List<Account> newList, Map<Id,Account> oldMap)
    {
        Set<id> accids= new Set<id>();
        Map<id,String> idphone= new Map<id,String>();
        
        for(Account acc:newList)
        {
            accids.add(acc.Id);
   			idphone.put(acc.Id,acc.Phone);
            if(acc.Phone == oldMap.get(acc.Id).phone)
            {
                System.debug('Not changed');
            }
        }
        List<Contact> relatedcon= [SELECT Name,Phone,Id,AccountId from Contact WHERE AccountId IN :accids];
        List<Contact> updateList = new List<Contact>();
        
        for(Contact con:relatedcon)
        {
            System.debug('105>>'+con.Phone);
            if(con.phone == '' || con.phone==null)
            {
                System.debug('108>Update Contact'+idphone.get(con.AccountId));
                Contact cn= new Contact();
                cn.id=con.Id;
                cn.Phone=idphone.get(con.AccountId);
           		updateList.add(cn);
            }
        }
        if(!updateList.isEmpty()){
            System.debug('116>UpdateList'+updateList);
         update updateList;
        }
            }
    
    public static void preventDuplicecy(List<Account> newList)
    {
        
        for(Account acc:newList)
        {
            Account[] accNameList= [SELECT name,id FROM Account WHERE name=:acc.Name];
            if(accNameList.size()>0)
            {
                acc.addError('Can not create account of same name');
            }
        }       
        
    }
    
    public static void updateHello(List<Account> newList)
    {
        for(Account acc:newList)
        {
            if(acc.Site!='World')
            {
			 acc.Site='World';

            }
        }
        
    }
    public static void updateafterHello(List<Account> newList,Map<id,Account> oldMap)
    {
        for(Account acc:newList)
        {
            if(acc.Site!='World')
            {
                acc.Site='World';
            }
        }
    }
    
    public static void numContacts(List<Account> newList)
    {
        Contact[] conList= new Contact[]{};
        for(Account acc:newList)
        {
            for(Integer i=0;i<acc.Total_contacts__c;i++)
            {
            Contact con= new Contact();
            con.AccountId=acc.Id;
            con.LastName='NameLat';
            conList.add(con);
                }
        }
        if(!conList.isEmpty())
        {
            insert conList;
        }
        
    }

    public static void addOwner(List<Account> newList)
    {
        Set<id> acOwnerIds= new Set<id>();
        for(Account acc:newList)
        {
            acOwnerIds.add(acc.OwnerId);
        }
        
        Map<id,User> use= new Map<id,User>([SELECT id,name FROM User WHERE id IN :acOwnerIds]); 
        
        for(Account acc:newList)
        {
            User usr= use.get(acc.OwnerId);
            acc.Description=usr.Name;
            
        }
    }
    
    public static void changeOwner(List<Account> newList)
    {
        Set<id> ownids = new Set<id>();
        for(Account acc:newList)
        {
            ownids.add(acc.OwnerId);//Takes Account's updated all 's  OwnerId put into set for remove duplicecy
        }
        User[] listUser= [SELECT id,name FROM User WHERE id IN: ownids];//Take Users which are in  Set of OwnerId updated account
        Map<id,String> idtoUser= new Map<id,String>();
        
        if(!listUser.isEmpty())
        {
        for(User us:listUser)
        {
            idtoUser.put(us.Id,us.name);//put id and user.name into empty Map idtoUserName
        }
        
        for(Account acc:newList)
        {
            if(acc.OwnerId!=null)//if its ownwer is not null 
            {
                acc.Description=idtoUser.get(acc.OwnerId);//then add owner to description form Map idtoUserName
            }
        }
        }
        
    }
    
    public static void afterDeleteContact(List<Account> oldList)
    {
        Set<id> accId= new Set<id>();
        for(Account acc:oldList)
        {
            accId.add(acc.Id);//put deleted Account's id into set of id 
        }
        
 Contact[] conAcc= [SELECT id,AccountId,Name FROM Contact WHERE AccountId IN :accId];//get Contacts which are associated within deleted id set
        
        if(!conAcc.isEmpty())
        {
            delete conAcc;
        }
    }
    
    public static void afterUndeleteAccount(List<Account> newList)
    {
        Set<id> accIds= new Set<id>();
        for(Account acc:newList)
        {
            accIds.add(acc.Id);
        }
        Contact[] consDeletedRelated=[SELECT id,AccountId FROM Contact WHERE isDeleted=TRUE AND AccountId IN: accIds ];
        
        if(!consDeletedRelated.isEmpty())
        {
            Undelete consDeletedRelated;
        }
    }
    
    public static void countContact(List<Account> newList)
    {
        Set<id> accids= new Set<id>();
        for(Account acc:newList)
        {
           accids.add(acc.Id); 
        }
        
        Contact[] conRelAcc=[SELECT id,AccountId FROM Contact WHERE AccountId IN: accids];
        Map<id,Decimal> accIdtoCount= new Map<id,Decimal>();
        for(Contact con:conRelAcc )
        {
            if(accIdtoCount.containskey(con.AccountId))
            {
                    Decimal count=1;
                    count= count+accIdtoCount.get(con.AccountId);
                    accIdtoCount.put(con.AccountId,count);
                
            }
            else
            {
					accIdtoCount.put(con.AccountId,1);         
            }            
        }
        Account[] accUpdated= new Account[]{};
        for(Id idv:accIdtoCount.keyset())
        {
            Account acc= new Account();
            acc.id=idv;
            acc.Total_contacts__c= accIdtoCount.get(idv);
            accUpdated.add(acc);
        }
    }

    public static void sendNotiToGroup(List<Account> newList)
    {
        Group pubGroup = [SELECT DeveloperName,Id FROM Group WHERE DeveloperName='public_Group'];
       // GroupMember userIds= [SELECT UserOrGroupId from GroupMember WHERE GroupId=:pubGroup.Id];
        Map<Id,User> userList = new Map<Id,User>();
        List<User> userEmail = new List<User>();
        List<Messaging.Email> mailList= new List<Messaging.Email>();
        List<String> mailString= new List<String>();
        
        for(GroupMember uid:[SELECT UserOrGroupId from GroupMember WHERE GroupId=:pubGroup.id])
        {
            User nuser = [SELECT name,Id,email FROM USER WHERE id=:uid.UserOrGroupId];
            nuser.Id= uid.UserOrGroupId;
            userEmail.add(nuser);
            mailString.add(nuser.Email);
            userList.put(nuser.Id,nuser);
        }
        System.debug(mailString);
        CustomNotificationType customNotificationType = [SELECT id,DeveloperName FROM CustomNotificationType WHERE DeveloperName='customnoti2'];
         Set<String> setPublic= new Set<String>();
        for(Account acc:newList){
  
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        notification.setTitle('Account updated by'+acc.LastModifiedById);
        notification.setBody('ACcount updaed to  this to this');
        notification.setNotificationTypeId(customNotificationType.id);
        notification.setTargetId(newList[0].Id);
   		setPublic.add(pubGroup.Id);
        notification.send(setPublic);
            
         Messaging.SingleEmailMessage mail= new Messaging.SingleEmailMessage();
            //String[] toAddresses= new List<String>{mailString};
            mail.setToAddresses(mailString);
            String subject= 'Acccount is updated by '+acc.OwnerId;
            mail.setSubject(subject);
            String disSenderName='Karan Patel';
            mail.setSenderDisplayName(disSenderName);
            String body= 'Account is updateed in body';
            mail.setHtmlBody(body);
            mailList.add(mail);
        }
        Messaging.SendEmail(mailList);
    }
}