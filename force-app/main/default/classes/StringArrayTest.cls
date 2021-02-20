public class StringArrayTest {

    public static List<String> generateStringArray(Integer numberOfRetStr) {
        List<String> varToBeReturned =new List<String>();
        
        for(Integer i=0; i<numberOfRetStr; i++)
        {
            varToBeReturned.add('Test ' + i);
                System.debug(varToBeReturned[i]);
        }
        
        return varToBeReturned;
    }
    
}