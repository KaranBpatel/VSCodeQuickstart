public class ParkLocator {
	
    public static List<String> country()
    {
        ParkService.ParksImplPort park= new  ParkService.ParksImplPort();
        System.debug(park);
        return park.byCountry('country');
    }
}