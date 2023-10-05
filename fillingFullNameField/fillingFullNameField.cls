trigger fillingFullNameField on Custom_Contact__c (before insert, before update) {

    List<Custom_Contact__c> updatedContacts = new List<Custom_Contact__c>();
    
    if(Trigger.isInsert){
		//holding the information of the contact to update based on the name change
        List<Custom_Contact__c> contactsToUpdate = new List<Custom_Contact__c>();

        //looping through the list of updated contacts and info
        for(Custom_Contact__c i: Trigger.New){
            if(!checkRecursive.SetOfIDs.contains(i.Id)){
            //checking if the first or last name is not null
                if(i.Primary_First_Name__c != NULL && i.Primary_Last_Name__c != NULL){
                    //combining the first and last names into their full name for the built in 'Name' field
                    i.Name = i.Primary_First_Name__c + ' ' + i.Primary_Last_Name__c;
                }
				checkRecursive.SetOfIDs.add(i.Id);
            }
    	}
    }
    else if(Trigger.isUpdate){

        //checkRecursive.firstcall = true;

        List<Custom_Contact__c> newContactNames = Trigger.New; //list of the updated information on a contact
        List<Custom_Contact__c> oldContactNames = Trigger.Old; //list of the old information on a contact

        //looping through the list of updated contacts and info
        for(Custom_Contact__c i: newContactNames){

            //put comment explaining
            if(!checkRecursive.SetOfIDs.contains(i.Id)){

                //looping through the list of old contacts and info
                for(Custom_Contact__c j: oldContactNames){

                    //checking to see if the first name only got updated
                    if(i.Primary_First_Name__c != j.Primary_First_Name__c){
                        i.Name = i.Primary_First_Name__c + ' ' + j.Primary_Last_Name__c;
                    }

                    //checking to see if the last name only got updated
                    if(i.Primary_Last_Name__c != j.Primary_Last_Name__c){
                        i.Name = j.Primary_First_Name__c + ' ' + i.Primary_Last_Name__c;
                    }

                    //checking to see if the first name and last name got updated
                    if(i.Primary_First_Name__c != j.Primary_First_Name__c && i.Primary_Last_Name__c != j.Primary_Last_Name__c){
                        i.Name = i.Primary_First_Name__c + ' ' + i.Primary_Last_Name__c;
                    }

                }
                checkRecursive.SetOfIDs.add(i.Id);
            }
        }
    }
}
