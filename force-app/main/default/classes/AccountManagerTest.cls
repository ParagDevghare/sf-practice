@isTest
public class AccountManagerTest {
    static testMethod void testMethod1(){
        Account objAccount=new Account(Name='Test Account');
        insert objAccount;
        
        Contact objContact=new Contact(LastName='Test Contact',
                                      AccountId=objAccount.Id);
        insert objContact;
        
        Id recordId=objAccount.Id;
        RestRequest request=new RestRequest();
        request.requestURI='https://somfunhere-dev-ed.lightning.force.com/services/apexrest/Accounts/'+
            recordId+'/contacts';
        
        request.httpMethod='GET';
        RestContext.request=request;
        
        Account thisAccount= AccountManager.getAccount();
        
        system.assert(thisAccount != null);
        system.assertEquals('Test Account',thisAccount.Name);
        
    }
}