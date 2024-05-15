trigger messageCreate on message__c (after insert) {

    if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
             //List<message__c> newList=[SELECT message__c,messageDate__c,check__c,contactId__c,id FROM message__c  ORDER BY  messageDate__c DESC];
        Set<id> ids= new Set<id>();
		Set<id> idm = new Set<id>();
        for(message__c mv:Trigger.new)
        {
           ids.add(mv.contactId__c);
            idm.add(mv.id);
        }
            System.debug(idm);
        
        	List<Contact> clist= [SELECT id,Name,Phone from Contact WHERE id IN :ids];
        	
        	List<message__c> uplist= new List<message__c>();
        for(Contact cv:clist)
        {
            if(ids.contains(cv.id))
            {
                system.debug('1');
                for(Id iv:idm){
                    system.debug('2');
                message__c msg= new message__c();
                    
                        system.debug('3');
               			 msg.id=iv;
                    	 msg.Name=cv.Name;
                			msg.phone__c=cv.Phone;
                        uplist.add(msg);
                    
                }
            }
        }
            if(!uplist.isEmpty()){
                update uplist;
            }
        }
    }
}