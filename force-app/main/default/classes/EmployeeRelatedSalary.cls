public class EmployeeRelatedSalary {
    public static void CalculateRelatedSalary()
    {
        //Child relationship name in sub query
        Account[] acc= [SELECT id,Total_Salary__c,(SELECT Salary__c,Id FROM Employees__r) FROM Account WHERE  CreatedDate=THis_YEAR];
        for(Account accv:acc)
        {
            Decimal TotalSalary=0;
            //accv.Employees__r is relationa name of Contact(child) to Account(Parrent) which has id of childId if account has no related contacts relation field will be Null.
            for(Employee__c empv:accv.Employees__r)
            {
                TotalSalary=TotalSalary+empv.Salary__c;
            }
            accv.Total_Salary__c=TotalSalary;
        }
    
    if(!acc.isEmpty())
    {
        update acc;
        System.debug('Updated');
    }
    }
}