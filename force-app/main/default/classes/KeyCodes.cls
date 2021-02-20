public class KeyCodes {
 /*
  1) Data || Records --> SOQL (Salesforce Object Query Language) or SOSL (Salesforce Object Search Language)
		i) You should know the sObject Name
			a) Standard Objects
			b) Custom Objects
			c) External Objects
			d) Custom Settings
			e) Custom Metadata
		Types of sobjects :
			1) Non-setup Objects --> User Data
			2) setup objects --> Configurations and other system administrative things
	What are the data base operations :
		1) Insert
		2) Delete 
		3) Update 
		4) Upsert	
	Note || Warning : You are not allowed to do DML on Setup and non-setup objects in same transaction. We will get error "Mixed DML not allowed" 
	
	How to find the Required Details for SOQL 
		1) sObject API Name (API name of sobject)
		2) Fileds (FiledName / API Name)
		3) Child Relationship Name (Standard) --> Open Lookup / MD field and Find Child Realtionship Name --> Contacts 
		4) Parent Relationship Name (Standard) --> Field Name
		5) Parent Record Id (Standard) ---> Parent Relationship Name+Id == Account+Id --> AccountId
		6) How to get parent Fields in Child Query --> Parent Relationship Name +.+FieldName/APIname of parent fields  --> Account.ID
		7) How to get Child Record in Parent SOQL --> Inner SOQL using ChildRelationship name
*/
}