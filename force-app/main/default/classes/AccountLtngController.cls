public with sharing class AccountLtngController {
    
    @AuraEnabled
    public static List<Account> getAccounts(String accountName){
        try { 
              String name = '%'+accountName+'%';
            return [SELECT Id , Name , Rating , Type FROM Account WHERE Name like : name ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}