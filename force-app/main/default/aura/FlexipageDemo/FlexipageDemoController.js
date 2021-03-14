({
    addContact : function(component, event, helper) {
          
           var fName=component.get("v.firstName");
           var lName=component.get("v.lastName");
           var action=component.get('c.insertContact');  // Calling Apex Controller method
           action.setParams({
             
               parentAccountId:component.get("v.recordId"),  // Passing parameter
   
               firstName1:component.get("v.firstName"),
   
               lastName1:component.get("v.lastName")
              
           });
           action.setCallback(this,function(response){
               var state=response.getState();
               if(state==="SUCCESS")
               {
                   alert('Contact inserted successfully');               
               }
              
           });
           $A.enqueueAction(action);
          
    }
   
   })