public with sharing class SessionIdHelper
{
    
    /** @description Get the current user session Id
    *  @param 
    *  @return String */
    public static String getCurrentUserSessionId()
    {
        PageReference pg = Page.SessionId;
        Blob b;
        if(Test.isRunningTest()){
            b = blob.valueOf('<div id="SessionId">Unit.Test</div>');
        }else{
            b = pg.getContent();
        }
        String htmlBody = b.toString();
        htmlBody = htmlBody.split('<div id="SessionId">')[1];
        htmlBody = htmlBody.split('</div>')[0];        
        return htmlBody;
    }
}