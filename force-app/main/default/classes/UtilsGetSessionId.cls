/**
* @description       : This class is used to get Session Id of logged In User.
* @coverage          : ExecuteCodeCtrlTest | @CC100%
* @author            : Techdicer
* @group             : Techdicer
* @last modified on  : 06-19-2023
* @last modified by  : Techdicer
* Modifications Log
* Ver   Date         Author                        Modification
* 1.0   06-16-2023   Techdicer                       Initial Version
**/
global class UtilsGetSessionId{
    /**
    * @description get Session Id of logged In User.
    * @author Techdicer | 06-16-2023
    * @param PageReference visualforcePage nam
    * @return String
    **/
    global static String getSessionIdFromVFPage(PageReference visualforcePage){
        String content = Test.isRunningTest() ? 'Start_Of_Session_Idtest1234567889999999999999End_Of_Session_Id' : visualforcePage.getContent().toString();
        Integer s = content.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length(),
                e = content.indexOf('End_Of_Session_Id');
        return content.substring(s, e);
    }
}