({
    getAccountsHelper : function(component , event ,helper){
        // Get your action name (Apex Method Name)
        let action = component.get("c.getAccounts");
        // Set parameters for the action 
        action.setParams({
            accountName : component.find("accountName").get("v.value")
        });
        // Invoke the Callback action from the Action method
        action.setCallback(this,function(response){
            let state = response.getState();
            if(state === "SUCCESS"){
                let data = response.getReturnValue();
                helper.getTableColumns(component);
                component.set("v.accounts",data);

            }
            else{
                let error = response.getError();
                alert("ERROR :"+JSON.stringify(error));
            }
            component.set("v.isLoading",false);
        });
        $A.enqueueAction(action);
    },
    getTableColumns : function(component){
        let columns = [
            {label: 'Account Name', fieldName: 'Name', type: 'text'},
            {label: 'Rating', fieldName: 'Rating', type: 'text'}, 
            {label: 'Type', fieldName: 'Type', type: 'text'}
        ];
        component.set("v.columns",columns);
    }
})