@isTest public class AnimalLocatorTest {
	
    ///first test method
    @isTest static  void AnimalLocatorMock() {
        
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        string resultAnimalName=AnimalLocator.getAnimalNameById(1);
        system.debug(resultAnimalName);
        string expectedResult='chicken';
        system.assertEquals(expectedResult, resultAnimalName);
    }
    
}