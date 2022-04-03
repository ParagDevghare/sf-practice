public with sharing class AccountTrigger {
    
   public Static Boolean isExecute = true;
   
   public static void beforeInsert(List<Account> newAccounts){
    /*
     * Given : When User Creates a New Account from Account Tab
     * When :  Type = Prospects and Rating = Hot and click Save
     * Then : Chcek Phone and Website is provided else throw an error saying Phone and website required
     */
    for(Account record : newAccounts){
        Boolean isError = false;
            if(record.Type == 'Prospect' && record.Rating == 'Hot'){
                if(record.Phone == null){
                    isError = true;
                    record.Phone.addError('Phone is Required');
                }
                if(record.Website == null){
                    isError = true;
                    record.Website.addError('Website is required');
                }
            }
            if(isError ){
                record.addError('Account Trigger validation error');
            }
            // Overriding the Current record Value in Before Insert Trigger event
            record.Description = 'Account Name : '+record.Name+'\n Phone : '+record.Phone +'\n Website : '+record.Website;
    }
     
    }

    public static void afterInsertOld(Map<Id,Account> newAccountMap){
        Id BusinessRecordTypeId = [Select Id FROM RecordType WHERE DeveloperName ='Business' AND sObjectType='Contact'].Id;
        List<Contact> newContacts = new List<Contact>();
        Set<Id> accountIds = new Set<Id>();
        for(Account record : newAccountMap.values()){
            if(record.Primary_Contact__c == null){
                Contact con = new Contact();
                con.LastName = record.Name;
                con.Account_Type__c ='Business Account';
                con.RecordTypeId = BusinessRecordTypeId;
                con.AccountId = record.Id;
                newContacts.add(con);
                accountIds.add(record.Id);
            }
        }

        if(newContacts.size() > 0){
            Insert newContacts;
            Map<Id,Account> accMap = new Map<Id,Account>([SELECT Id , Primary_Contact__c FROM Account WHERE ID IN:accountIds]);
            for(Contact con : newContacts){
                accMap.get(con.AccountId).Primary_Contact__c = con.Id;
            }
            Update accMap.values();
        }
        
    }

    public static void afterInsert(Map<Id,Account> newAccountMap){
        if(!isExecute){
            return ;
        }
        Id BusinessRecordTypeId = [Select Id FROM RecordType WHERE DeveloperName ='Business' AND sObjectType='Contact'].Id;

       Map<Id,Contact> newContactmap = new Map<Id,Contact>();
        for(Account record : newAccountMap.values()){
            if(record.Primary_Contact__c == null){
                Contact con = new Contact();
                con.LastName = record.Name;
                con.Account_Type__c ='Business Account';
                con.RecordTypeId = BusinessRecordTypeId;
                con.AccountId = record.Id;
                newContactmap.put(record.Id , con);
               
            }
        }

        if(newContactmap.values().size() > 0){
            newContactmap = perfomDMlContacts(newContactmap);
            List<Account> accList = new List<Account>();
            for(Id key : newContactmap.keyset()){
                Account acc = new Account();
                acc.Id = key;
                acc.Primary_Contact__c = newContactmap.get(key).Id;
                accList.add(acc);
            }
            Update accList;
        }
        
    }

    private static Map<Id,Contact> perfomDMlContacts(Map<Id,Contact> dataMap){
        Integer i = 0;
        List<Contact> conDeatils = dataMap.values();
        List<Database.saveResult> results = Database.insert( dataMap.values(),false );
        for(Database.saveResult result : results){
        if(!result.isSuccess()){
            for(Database.Error error : result.getErrors()){
                    if(error instanceof Database.DuplicateError){
                        Database.DuplicateError duplicateError = (Database.DuplicateError) error;
                        Datacloud.DuplicateResult duplicateResult = duplicateError.getDuplicateResult();
                        List<DataCloud.MatchResult> matchResults = duplicateResult.getMatchResults();
                        for(DataCloud.MatchResult dmr : matchResults){
                                DataCloud.MatchResult mr = dmr;
                                List<DataCloud.MatchRecord> matchRecords = mr.getMatchRecords();
                                for(DataCloud.MatchRecord matchRecord : matchRecords){
                                    Contact con = (Contact)matchRecord.getRecord();
                                    Contact actual = conDeatils[i];
                                    String name = actual.FirstName+ ' '+actual.LastName;
                                    if(name == con.Name){
                                        conDeatils[i].Id = matchRecord.getRecord().Id;
                                    }
                                    
                                }

                        }
                    }
                
            }
        }
        i++;
    }
      return dataMap;
    }
    
}