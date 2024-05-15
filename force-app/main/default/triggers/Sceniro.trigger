trigger Sceniro on Top_X_Designation__c (before insert,after insert,after Update,after Delete) {
    
    if(Trigger.isInsert)
    {
        if(Trigger.isAfter)
        {
            System.debug('After Insert');
            TopXobjectHandler.afterInsert(Trigger.new);
        }
    }
    if(Trigger.isUpdate)
    {
        TopXobjectHandler.afterUpdate(Trigger.new);
    }
    if(Trigger.isDelete)
    {
        TopXobjectHandler.afterDelete(Trigger.old);
    }

}