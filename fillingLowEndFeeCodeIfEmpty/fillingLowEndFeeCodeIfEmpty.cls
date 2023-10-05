trigger fillingLowEndFeeCodeIfEmpty on User (before insert, before update) {

    List<User> updatedUserInfo = Trigger.New;
    List<User> usersToUpdate = new List<User>();
    List<Custom_Contact__c> updatedContacts = new List<Custom_Contact__c>();

	for(User i : updatedUserInfo){
        if(!checkRecursive.SetOfIDs.contains(i.Id)){

            if(i.Fee_Code_A_0_100_000__c == NULL && i.Fee_Code_A_100_000_250_000__c != NULL){
                i.Fee_Code_A_0_100_000__c = i.Fee_Code_A_100_000_250_000__c;
            }

            if(i.Fee_Code_B_0_100_000__c == NULL && i.Fee_Code_B_100_000_250_000__c != NULL){
                i.Fee_Code_B_0_100_000__c = i.Fee_Code_B_100_000_250_000__c;
            }

            if(i.Fee_Code_C_0_100_000__c == NULL && i.Fee_Code_C_100_000_250_000__c != NULL){
                i.Fee_Code_C_0_100_000__c = i.Fee_Code_C_100_000_250_000__c;
            }

            if(i.Fee_Code_D_0_100_000__c == NULL && i.Fee_Code_D_100_000_250_000__c != NULL){
                i.Fee_Code_D_0_100_000__c = i.Fee_Code_D_100_000_250_000__c;
            }

            if(i.Fee_Code_E_0_100_000__c == NULL && i.Fee_Code_E_100_000_250_000__c != NULL){
                i.Fee_Code_E_0_100_000__c = i.Fee_Code_E_100_000_250_000__c;
            }

            if(i.Fee_Code_F_0_100_000__c == NULL && i.Fee_Code_F_100_000_250_000__c != NULL){
                i.Fee_Code_F_0_100_000__c = i.Fee_Code_F_100_000_250_000__c;
            }

            if(i.Fee_Code_G_0_100_000__c == NULL && i.Fee_Code_G_100_000_250_000__c != NULL){
                i.Fee_Code_G_0_100_000__c = i.Fee_Code_G_100_000_250_000__c;
            }

            if(i.Fee_Code_H_0_100_000__c == NULL && i.Fee_Code_H_100_000_250_000__c != NULL){
                i.Fee_Code_H_0_100_000__c = i.Fee_Code_H_100_000_250_000__c;
            }

            if(i.Fee_Code_I_0_100_000__c == NULL && i.Fee_Code_I_100_000_250_000__c != NULL){
                i.Fee_Code_I_0_100_000__c = i.Fee_Code_I_100_000_250_000__c;
            }

            if(i.Fee_Code_J_0_100_000__c == NULL && i.Fee_Code_J_100_000_250_000__c != NULL){
                i.Fee_Code_J_0_100_000__c = i.Fee_Code_J_100_000_250_000__c;
            }

            if(i.Fee_Code_K_0_100_000__c == NULL && i.Fee_Code_K_100_000_250_000__c != NULL){
                i.Fee_Code_K_0_100_000__c = i.Fee_Code_K_100_000_250_000__c;
            }

            checkRecursive.SetOfIDs.add(i.Id);
        }

        Database.update(usersToUpdate, False);
	}
}
