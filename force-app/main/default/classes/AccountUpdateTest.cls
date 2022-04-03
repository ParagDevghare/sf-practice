@isTest(SeeAllData = true)
public class AccountUpdateTest {
	/* 
	*when : User creates new Accounts
	*given : when Accounts have no Phone field value populated
	*then : throw error on Phone field from the missing Accounts
	*/
    @isTest static void beforeInsert(){
        //Create Account as parameter with Phone = null
        Account acc = new Account();
        acc.Name = 'Test Account 1';
        try{
        insert acc;
        }
        catch(Exception e){
            system.assert(e.getMessage().contains('Please add Phone Number to save Account.'), 'Actual and Expected are different.');
        }
            
        List<Account> accountlist=[select Id, Name from Account];
        System.debug('Total records' + accountlist.size() );
        
        for(Account acc1 : accountlist){
            acc1.Name='Parag';                
        }
        //update accountlist;
        database.update(accountlist, false);
        
        for(Account acc2: [select Id, Name from Account]){
            system.debug('Account Name'+acc2.Name);
        }
        
        //Call the target method from the try{} block
        //catch the exception fromthe catch block
        //Do assert on the return exception merssage containing Phone is missing
           	
        
    }
}