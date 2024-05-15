@isTest
public class TestVerifyDate {
    
    @isTest static void testDate(){
        
        Date date1= Date.newInstance(2002,6,7);
        Date date2= Date.newInstance(2002,6,8);
        Date dat= VerifyDate.CheckDates(date1,date2);
        System.debug(dat);
        System.assertEquals(date2,dat);
    }
    
    @isTest static void testLastDate(){
        
        Date date1= Date.newInstance(2002,6,7);
        Date date2= Date.newInstance(2002,7,14);
        Date date3= Date.newInstance(2002,7,31);
        Date dat= VerifyDate.CheckDates(date1,date2);
        System.debug(dat);
        System.assertEquals(date3,dat);
    }
}