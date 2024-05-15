public class EmployeeTriggger {
    
     public static void BeforeDeleteEmp(List<Employee__c> oldList)
            {
                for(Employee__c empv:oldList)
                {
                    if(empv.Salary__c!=null)
                    {
                        empv.addError('Cant delete salary isnot null');
                    }
                }
            }
    
    public static void AfterDelete(List<Employee__c> oldList)
    {
        Account[] accList= new Account[]{};//Account List
        Set<id> accIds= new Set<id>();//To get unique Account 's Ids
        Map<id,Decimal> accToLeftEmp= new Map<id,Decimal>();//Account's Id : Total Left employee
        List<Employee__c> empList= new List<Employee__c>();//List of employee
        
        for(Employee__c empv:oldList)
        {
            if(empv.AccountEMp__c!=null)//To check emplyee is Related with Account AccountEmp__c(RealtionShip)
            {
                accIds.add(empv.AccountEMp__c);//add Employee related Account 's Id  unique to set
                empList.add(empv);//add Employee which are related with Account in this All employee reocrds
            }
        }
            
        Map<Id,Account> accIdMap= new Map<Id,Account>([SELECT Id,Total_Employee_Left__c FROM Account WHERE id IN :accIds]);//Fetch records in MAp id(Account):Account which Account's id in set of ids which has related employee
        
        for(Employee__c empv:empList)
        {
            if(accIdMap.containsKey(empv.AccountEMp__c))//check accIdMap has key of Employee's related Account 's id= AccountEmp__c
            {
                if(accToLeftEmp.containsKey(empv.AccountEMp__c))//Check for Total left employee Map has key(AccountId) with current employee's(empv) AccountId
                {
					//IF second related employee left so thatwe get id ** If same related Account employee occured so it incremnet LeftCOunt 
                    
                    Decimal count = accToLeftEmp.get(empv.AccountEMp__c)+1;
                    accToLeftEmp.put(empv.AccountEMp__c,count);
                    System.debug('ContainsKey Id'+empv.AccountEMp__c);
                    System.debug(accToLeftEmp.get(empv.AccountEMp__c));
                }
                else
                {
                    //First time employee deleted  AccountId is not in Map of accToLeftEmp
                    
                     accToLeftEmp.put(empv.AccountEMp__c,accIdMap.get(empv.AccountEMp__c).Total_Employee_Left__c=1);
                    System.debug('Not contains Key AccountEmp '+empv.AccountEMp__c);
                    System.debug(accToLeftEmp.get(empv.AccountEMp__c));
                }
            }
        }
        
        for(Id accId:accToLeftEmp.keySet())
        {
            Account acc= new Account();
            acc.id=accId;
            acc.Total_Employee_Left__c=accToLeftEmp.get(accId);
            accList.add(acc);
        }
        
        
        if(!accList.isEmpty())
        {
            update accList;
        }
    }
    
    public static void afterUndelete(List<Employee__c> newList)
    {
        Account[] updateList= new Account[]{};
        Employee__c[] addList= new Employee__c[]{};
            //Map<id,Account> mapAcctoId= new Map<id,Account>();
           System.debug('Undelete After occureed');
       
        Set<id> accIds= new Set<id>();
        for(Employee__c emp:newList)
        {
            if(emp.AccountEMp__c!=null)
            {
                accIds.add(emp.AccountEMp__c);
               	addList.add(emp);
            }           
        }
        // Employee__c[] empl=[SELECT AccountEmp__c,id,Address__c FROM Employee__c WHERE AccountEmp__c IN :accIds];
        // 
        Map<id,Account> mapAcctoId= new Map<id,Account>([SELECT id FROM Account WHERE Id IN :accIds]);
        Map<id,Decimal> totalCountemp= new Map<id,Decimal>();
        
        for(Employee__c empv:addList)
        {
           // boolean first=true;
            if(mapAcctoId.containskey(empv.AccountEMp__c))
            {
                if(totalCountemp.containsKey(empv.AccountEMp__c))
                {
                    
                    Decimal counter = totalCountemp.get(empv.AccountEMp__c)+1;
                    totalCountemp.put(empv.AccountEMp__c,counter);
                    System.debug('Contains'+counter);
                    
                    
                }
                 else
                    {
                        totalCountemp.put(empv.AccountEMp__c,mapAcctoId.get(empv.AccountEMp__c).Total_Employee_Left__c=1);
                    }
               // else
               // {
                //    totalCountemp.put(empv.AccountEMp__c,totalCountemp.get(empv.AccountEMp__c)-1);
               // }
            }
        }
        
        
        
        for(Id iv:totalCountemp.keyset())
        {
                Account acc=new Account();
                acc.id=iv;
                acc.Total_Employee_Left__c= totalCountemp.get(iv);
                
                updateList.add(acc);     
        }
        update updateList;
    }

}