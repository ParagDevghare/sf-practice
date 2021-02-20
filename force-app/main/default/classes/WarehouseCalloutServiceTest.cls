@IsTest
private class WarehouseCalloutServiceTest {
    // implement your mock callout test here
    
    public static String CRON_EXP = '0 0 0 15 3 ? *';
    
    @isTest
    static void WarehouseEquipmentSync(){
        
        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock()); 
        
        WarehouseCalloutService.runWarehouseEquipmentSync();
        
        Test.stopTest();        
        
        // get the list of products inserted (should be 1)      
        List<Product2> updatedProds = [SELECT Replacement_Part__c, Cost__c, Current_Inventory__c, 
                                       Lifespan_Months__c, Maintenance_Cycle__c, Name FROM Product2];
        
        System.assertEquals(1, updatedProds.size());
        
        for (Product2 p : updatedProds) {
            System.assertEquals(true, p.Replacement_Part__c);
            System.AssertEquals(5000, p.Cost__c);
            System.assertEquals(5, p.Current_Inventory__c);
            System.assertEquals(120, p.Lifespan_Months__c);
            System.assertEquals(365, p.Maintenance_Cycle__c);
            System.assertEquals('Generator 1000 kW', p.Name);
        }
    }
    
    @isTest
    static void warehouseSyncScheduleTest() {
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock()); 
        
        String jobId = System.schedule('WarehouseSyncTest', CRON_EXP, new WarehouseSyncSchedule());
        
        CronTrigger cTId = [SELECT State FROM CronTrigger WHERE Id = :jobID];
        System.assertEquals('WAITING', String.valueOf(cTId.State));
        
        Test.stopTest();
    }
}