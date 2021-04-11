import { LightningElement } from 'lwc';

export default class Basic extends LightningElement {
    firstName = "";
    lastName = "";

    handleChanges(event) {
        const fieldName = event.target.name;

        if (fieldName == "firstName") {
            this.firstName = event.target.value;
        }
        else if (fieldName == "lastName") {
            this.lastName = event.target.value;
        }
    }
    get fullName() {
        return this.firstName + " " + this.lastName;
    }
    updateName(event){
        
    }
}
