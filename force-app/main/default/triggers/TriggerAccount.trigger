trigger TriggerAccount on Account (after update) {
    
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            //if(Trigger.New.ParentId==null){
                //TriggerHandler.flag=true;
       		 System.debug('Insert before');
    		//TriggerHandler.preventDuplicecy(Trigger.new);
    		//TriggerHandler.updateHello(Trigger.New);
            TriggerHandler.addOwner(Trigger.new);
            
            //TriggerHandler.beforeInsert(Trigger.New);
           // }
        }
   	 if(Trigger.isAfter)
    {
       		 System.debug('Insert After');
        	TriggerHandler.countContact(Trigger.new);
        	//TriggerHandler.numContacts(Trigger.new);
        	//TriggerHandler.afterInsertRelatedOpp(Trigger.New);
    }
    }
    if(Trigger.isUpdate)
    {
        if(Trigger.isBefore)
        {
            //TriggerHandler.beforeUpdateDes(Trigger.New,Trigger.oldMap);
           // TriggerHandler.updateafterHello(Trigger.new,Trigger.oldMap);
            TriggerHandler.changeOwner(Trigger.New);
        }
        else if(Trigger.isAfter)
        {
            //TriggerHandler.AfterUpdate(Trigger.New,Trigger.oldMap);
             TriggerHandler.afterUpdateContact(Trigger.New,Trigger.oldMap);
        }
    }
    if(Trigger.isDelete)
    {
        if(Trigger.isBefore)
        {
            //TriggerHandler.beforeDelete(Trigger.old);
        }
        else if(Trigger.isAfter)
        {
            TriggerHandler.afterDeleteContact(Trigger.old);
        }
    }
    if(Trigger.isUndelete)
    {
        TriggerHandler.afterUndeleteAccount(Trigger.new);
    }
}