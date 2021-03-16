({
    addContactRecord: function (component, event, helper) {

        let fName = component.get("v.firstName1");
        let lName = component.get("v.lastName1");
        let action = component.get('c.insertContact');  // Calling Apex Controller method
        action.setParams({

            parentAccountId: component.get("v.recordId"),  // Passing parameter
            firstName1: component.get("v.firstName1"),
            lastName1: component.get("v.lastName1")

        });
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                alert('Contact inserted successfully');
            }
            else{
                let error = response.getError();
                alert("ERROR :"+JSON.stringify(error));
            }
        });
        $A.enqueueAction(action);
    }
})