({
    getAccountsctr : function(component, event, helper) {
        component.set("v.isLoading",true);
        helper.getAccountsHelper(component, event, helper);
        
    },
    selectedAccounts : function(component , event , helper){
        let selectedRows = event.getParam('selectedRows');
        //alert("DATA SELECTED : "+JSON.stringify(selectedRows));
    },
    getTotalNoOfRecordsSelected : function(component , event , helper){
        let dataTable = component.find("accountTable");
        let data = dataTable.getSelectedRows();
        alert("Total Rows Selected :"+data.length);
    }
})