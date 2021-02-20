/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-10-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   02-10-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class AccountContactRollup {
    
    /**
    * @description : this will update the Account object Contacts total field with total related contacts Count on create of contact record from Tab
    * @author ChangeMeIn@UserSettingsUnder.SFDoc | 02-10-2021 
    * @param newContactMap --> Trigger.newMap
    **/
    public void afterInsert(Map<Id,Contact> newContactMap){
       Set<Id> accountIds = this.getAccountIds(newContactMap);
       if(accountIds.size() > 0){
            this.rollupContacts(accountIds);
       }
    }

    /**
    * @description : On delete of Contact we need to Update Account Total Contacts
    * @author ChangeMeIn@UserSettingsUnder.SFDoc | 02-10-2021 
    * @param oldContactMap 
    **/
    public void afterDelete(Map<Id,Contact> oldContactMap){
        Set<Id> accountIds = this.getAccountIds(oldContactMap);
       if(accountIds.size() > 0){
            this.rollupContacts(accountIds);
       }
    }

    /**
    * @description : On restrore from the Recycle Bin 
    * @author ChangeMeIn@UserSettingsUnder.SFDoc | 02-10-2021 
    * @param newContactMap 
    **/
    public void afterUndelete(Map<Id,Contact> newContactMap){
        Set<Id> accountIds = this.getAccountIds(newContactMap);
        if(accountIds.size() > 0){
             this.rollupContacts(accountIds);
        }
    }

    /**
    * @description : On update of Contact Account Id we need to recaluculate the Total Contacts
    * @author ChangeMeIn@UserSettingsUnder.SFDoc | 02-10-2021 
    * @param newContactMap --> Trigger.newMap
    * @param oldContactMap --> Trigger.oldMap
    **/
    public void afterUpdate(Map<Id,Contact> newContactMap , Map<Id,Contact> oldContactMap){
        // Get the AccountIds of Old AccountId and New AccountId from the Updated Contacts
        Set<Id> accountIds = new Set<Id>();
        for (Id key: newContactMap.keyset()){
                Contact nRecord = newContactMap.get(key);
                Contact oRecord = oldContactMap.get(key);
                // check whether the Account Id is Changed
                if(nRecord.AccountId != oRecord.AccountId){
                    if(nRecord.AccountId != null ){
                        accountIds.add(nRecord.AccountId);
                    }
                    if(oRecord.AccountId != null ){
                        accountIds.add(oRecord.AccountId);
                    }
                }
        }

        // fetech the Accounts based on the Account Ids
       if(accountIds.size() > 0){
            this.rollupContacts(accountIds);
       }
    }


    private set<Id> getAccountIds(Map<Id,Contact> conMap){
        /******************* Extract the Required information from the Trigger Context values ********************** */ 
                    // Add accountids to update the count
                    Set<Id> accountIds = new set<Id>();
                    for (Contact record: conMap.values()){
                        if (record.AccountId != null) {
                            accountIds.add(record.AccountId);
                        }
                    }

        return accountIds;
    }
    private void rollupContacts(Set<Id> accountIds){
        Map<Id,Account> accountMap = new Map<Id,Account>([SELECT Id , Total_Contacts__c , (SELECT ID FROM Contacts) FROM Account WHERE Id IN: accountIds]); 
        for (Account record: accountMap.values()){
            record.Total_Contacts__c = record.Contacts.size();
        }
        if(accountMap.values().size() > 0 ){
            update accountMap.values();
        }
    }
}