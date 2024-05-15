@isTest
public class ParkLocatorTest {

    @isTest static void testCallout()
    {
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
                     
        String[] expectedParks= new List<String>{'Pakistan','Srilanka','US'};
        String country='US';
        System.assertEquals(expectedParks,ParkLocator.country());
    }
}