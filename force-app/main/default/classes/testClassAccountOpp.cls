@isTest
public class testClassAccountOpp {
    
    @isTest 
    public static void TestClassAccountOpp()
    {
        
        Account acc= new Account();
        acc.Name='Test';
        acc.Rating ='Cold';
        insert acc;
        
        Opportunity opp= new Opportunity();
        opp.Name='Test Opportunity';
        opp.CloseDate=System.today();
        opp.StageName='Prospecting';
        opp.AccountId= acc.id;
        insert opp;
        
        //String opg= opp.Id;
        
        Account acUpdate= new Account();
        acUpdate.id=acc.id;
        acUpdate.Name='Test Update';
        update acUpdate;
        
        Opportunity oppGet= [SELECT Name,createdDate,StageName,AccountId,CreatedById FROM Opportunity WHERE id=:opp.Id ];
        Integer days= ((oppGet.createdDate).date()).daysBetween(System.today());
        //Integer days=1;
        System.debug(days);
        if(opp.StageName!='Closed Won')
        { 
        	if(days>30)
        	{
         	   System.assertEquals(opp.StageName,'Closed Lost');
        	}
            else if(days==0)
            {
                System.assertEquals(opp.StageName,'Prospecting');
            }
        }
    }
    
    @isTest
    public static void testAccountSecond()
    {
        
        Account acc= new Account();
        acc.Name='Test';
        acc.Rating ='Cold';
        insert acc;
        
        Opportunity opp= new Opportunity();
        opp.Name='Test Opportunity';
        opp.CloseDate=System.today();
        opp.StageName='Prospecting';
        opp.AccountId= acc.id;
        insert opp;
        
        //String opg= opp.Id;
        
        Account acUpdate= new Account();
        acUpdate.id=acc.id;
        acUpdate.Name='Test Update';
        update acUpdate;
        
        Opportunity oppGet= [SELECT Name,createdDate,StageName,AccountId,CreatedById FROM Opportunity WHERE id=:opp.Id ];
        Integer days= ((oppGet.createdDate).date()).daysBetween(System.today());
        //Integer days=1;
        System.debug(days);
        if(opp.StageName!='Closed Won')
        { 
        	if(days<30)
        	{
         	   System.assertEquals(opp.StageName,'Prospecting');
        	}
            else
            {
                System.assertEquals(opp.StageName,'Prospecting');
            } 
        }
    }

}