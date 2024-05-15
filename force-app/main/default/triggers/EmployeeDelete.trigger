trigger EmployeeDelete on Employee__c (after Undelete) {
    
    if(Trigger.isDelete)
    {
        if(Trigger.isBefore)
        {
            System.debug('Before Delete');
           EmployeeTriggger.BeforeDeleteEmp(Trigger.old);
        }
        else if(Trigger.isAfter)
        {
            System.debug('After Delete');
            EmployeeTriggger.AfterDelete(Trigger.old);
        }
    }
    
    if(Trigger.isUndelete)
    {
        System.debug('Undelete');
        EmployeeTriggger.afterUndelete(Trigger.new);
    }
}