/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-10-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   02-07-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class ContactTrigger {
    public static void beforeInsert(List<Contact> newContacts){
        Id RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType='Account' LIMIT 1].Id;
        Map<Integer,Account> conAccountMap = new Map<Integer,Account>();
        Integer keyIndex = 0;
        for(Contact record : newContacts){
            if(record.AccountId == null){
                Account acc = new Account();
                acc.Name = record.LastName;
                acc.recordTypeId = RecordTypeId;
                conAccountMap.put(keyIndex,acc);
                keyIndex++;
            }
        }
    if(conAccountMap.values().size() > 0){
            AccountTrigger.isExecute = false;
            upsert conAccountMap.values();
            for(Integer index : conAccountMap.keyset()){
                newContacts[index].AccountId = conAccountMap.get(index).Id;
            }
        }

    }

    public static void afterInsert(map<Id,contact> newContactMap){
        updatePrimaryContact(newContactMap);
         new AccountContactRollup().afterInsert(newContactMap);
    }

    private static void updatePrimaryContact(map<Id,contact> newContactMap){
        Set<Id> accids = new Set<Id>();
        for(Contact con : newContactMap.values()){
            accids.add(con.AccountId);
        }

        Map<Id,Account> newAccMaps = new Map<Id,Account>([SELECT ID , Primary_Contact__c FROM Account WHERE Id IN: accids AND Primary_Contact__c = null]);
        for(Contact con : newContactMap.values()){
            if(newAccMaps.get(con.AccountId) != null){
                newAccMaps.get(con.AccountId).Primary_Contact__c = con.Id;
            }
        }
        if(newAccMaps.values().size() > 0 ){
            Update newAccMaps.values();
        }
    }
    public static void afterDelete(Map<Id,Contact> oldContactMap){
        new AccountContactRollup().afterDelete(oldContactMap);
    }
    public static void afterUpdate(Map<Id,Contact> newContactMap,Map<Id,Contact> oldContactMap){
        new AccountContactRollup().afterUpdate(newContactMap,oldContactMap);

    }
    public static void afterUndelete(Map<Id,Contact> newContactMap){
        new AccountContactRollup().afterUndelete(newContactMap);

    }
}