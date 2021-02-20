public class ParkLocator {
	
    public static String[] country(string CountryName) {
        
        ParkService.ParksImplPort parkService=new ParkService.ParksImplPort();
        return parkService.byCountry(CountryName);
        
    }
    
}