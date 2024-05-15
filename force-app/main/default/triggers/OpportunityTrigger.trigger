trigger OpportunityTrigger on Opportunity (after Undelete) {

    if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
            System.Debug('Aftere Insert');
            OpportunityHandler.afterInsert(Trigger.new);
        }
        else if(Trigger.isUpdate)
        {
            System.debug('After Update');
            OpportunityHandler.afterUpdate(Trigger.new);
        }
        else if(Trigger.isDelete)
        {
            System.debug('After delete');
            OpportunityHandler.afterDelete(Trigger.old);
        }
    }
}