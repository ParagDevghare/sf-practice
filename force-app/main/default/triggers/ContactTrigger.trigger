/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-13-2021
 * @last modified by  : i.lakshmideepak@gmail.com
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   02-07-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
trigger ContactTrigger on Contact (before insert , after insert ,after Update , after Delete , after undelete) {
     if(Trigger.isAfter && Trigger.isUpdate){
        new ContactUserSync().updateUserDetails(Trigger.newMap,Trigger.oldMap);
    }
   

}