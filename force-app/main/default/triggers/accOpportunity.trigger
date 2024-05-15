trigger accOpportunity on Account (after Update) {

    if(Trigger.isAfter)
    {
        if(Trigger.isUpdate)
        {
            System.debug('After Update');
            updateOpportunity.updateOpportunity(Trigger.New);
        }
    }
}