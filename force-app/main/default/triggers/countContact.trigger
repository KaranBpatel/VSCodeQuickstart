trigger countContact on Contact (after insert,after  delete) {

    if(Trigger.isInsert){
    contactCounter.countContact(Trigger.new);
    }
    if(Trigger.isDelete)
    {
        contactCounter.afterDelete(Trigger.old);
    }
}