trigger fillingFeeCodes on Custom_Contact__c (before insert, before update) {

    List<Custom_Contact__c> updatedContactInfo = Trigger.New;
    //List<Custom_Contact__c> contactsToUpdate = new List<Custom_Contact__c>();
    List<Custom_Contact__c> updatedContacts = new List<Custom_Contact__c>();
    Integer count = 0;

	System.Debug('1 ' + updatedContactInfo[0].Id);
    for(Custom_Contact__c i : updatedContactInfo){

		if(i.Fee_Code__c != NULL){
            if(i.Fee_Code__c == 'A'){
                i.Fee_Code_0_100_000__c = i.Lookup_Fee_Code_A_0_100_000__c;
                i.Fee_Code_100_000_250_000__c = i.Lookup_Fee_Code_A_100_000_250_000__c;
                i.Fee_Code_250_000_500_000__c = i.Lookup_Fee_Code_A_250_000_500_00__c;
                i.Fee_Code_500_000_1_000_000__c = i.Lookup_Fee_Code_A_500_000_1_000_000__c;
                i.Fee_Code_1_000_000__c = i.Lookup_Fee_Code_A_1_000_000__c;
			}
            else if(i.Fee_Code__c == 'B'){
            	i.Fee_Code_0_100_000__c = i.Lookup_Fee_Code_B_0_100_000__c;
                i.Fee_Code_100_000_250_000__c = i.Lookup_Fee_Code_B_100_000_250_000__c;
                i.Fee_Code_250_000_500_000__c = i.Lookup_Fee_Code_B_250_000_500_000__c;
                i.Fee_Code_500_000_1_000_000__c = i.Lookup_Fee_Code_B_500_000_1_000_000__c;
                i.Fee_Code_1_000_000__c = i.Lookup_Fee_Code_B_1_000_000__c;
            }
            else if(i.Fee_Code__c == 'C'){
            	i.Fee_Code_0_100_000__c = i.Lookup_Fee_Code_C_0_100_000__c;
                i.Fee_Code_100_000_250_000__c = i.Lookup_Fee_Code_C_100_000_250_000__c;
                i.Fee_Code_250_000_500_000__c = i.Lookup_Fee_Code_C_250_000_500_000__c;
                i.Fee_Code_500_000_1_000_000__c = i.Lookup_Fee_Code_C_500_000_1_000_000__c;
                i.Fee_Code_1_000_000__c = i.Lookup_Fee_Code_C_1_000_000__c;
            }
            else if(i.Fee_Code__c == 'D'){
            	i.Fee_Code_0_100_000__c = i.Lookup_Fee_Code_D_0_100_000__c;
                i.Fee_Code_100_000_250_000__c = i.Lookup_Fee_Code_D_100_000_250_000__c;
                i.Fee_Code_250_000_500_000__c = i.Lookup_Fee_Code_D_250_000_500_000__c;
                i.Fee_Code_500_000_1_000_000__c = i.Lookup_Fee_Code_D_500_000_1_000_000__c;
                i.Fee_Code_1_000_000__c = i.Lookup_Fee_Code_D_1_000_000__c;
            }
            else if(i.Fee_Code__c == 'E'){
            	i.Fee_Code_0_100_000__c = i.Lookup_Fee_Code_E_0_100_000__c;
                i.Fee_Code_100_000_250_000__c = i.Lookup_Fee_Code_E_100_000_250_000__c;
                i.Fee_Code_250_000_500_000__c = i.Lookup_Fee_Code_E_250_000_500_000__c;
                i.Fee_Code_500_000_1_000_000__c = i.Lookup_Fee_Code_E_500_000_1_000_000__c;
                i.Fee_Code_1_000_000__c = i.Lookup_Fee_Code_E_1_000_000__c;
            }
            else if(i.Fee_Code__c == 'F'){
            	i.Fee_Code_0_100_000__c = i.Lookup_Fee_Code_F_0_100_000__c;
                i.Fee_Code_100_000_250_000__c = i.Lookup_Fee_Code_F_100_000_250_000__c;
                i.Fee_Code_250_000_500_000__c = i.Lookup_Fee_Code_F_250_000_500_000__c;
                i.Fee_Code_500_000_1_000_000__c = i.Lookup_Fee_Code_F_500_000_1_000_000__c;
                i.Fee_Code_1_000_000__c = i.Lookup_Fee_Code_F_1_000_000__c;
            }
            else if(i.Fee_Code__c == 'G'){
            	i.Fee_Code_0_100_000__c = i.Lookup_Fee_Code_G_0_100_000__c;
                i.Fee_Code_100_000_250_000__c = i.Lookup_Fee_Code_G_100_000_250_000__c;
                i.Fee_Code_250_000_500_000__c = i.Lookup_Fee_Code_G_250_000_500_000__c;
                i.Fee_Code_500_000_1_000_000__c = i.Lookup_Fee_Code_G_500_000_1_000_000__c;
                i.Fee_Code_1_000_000__c = i.Lookup_Fee_Code_G_1_000_000__c;
            }
            else if(i.Fee_Code__c == 'H'){
            	i.Fee_Code_0_100_000__c = i.Lookup_Fee_Code_H_0_100_000__c;
                i.Fee_Code_100_000_250_000__c = i.Lookup_Fee_Code_H_100_000_250_000__c;
                i.Fee_Code_250_000_500_000__c = i.Lookup_Fee_Code_H_250_000_500_000__c;
                i.Fee_Code_500_000_1_000_000__c = i.Lookup_Fee_Code_H_500_000_1_000_000__c;
                i.Fee_Code_1_000_000__c = i.Lookup_Fee_Code_H_1_000_000__c;
            }
            else if(i.Fee_Code__c == 'I'){
            	i.Fee_Code_0_100_000__c = i.Lookup_Fee_Code_I_0_100_000__c;
                i.Fee_Code_100_000_250_000__c = i.Lookup_Fee_Code_I_100_000_250_000__c;
                i.Fee_Code_250_000_500_000__c = i.Lookup_Fee_Code_I_250_000_500_000__c;
                i.Fee_Code_500_000_1_000_000__c = i.Lookup_Fee_Code_I_500_000_1_000_000__c;
                i.Fee_Code_1_000_000__c = i.Lookup_Fee_Code_I_1_000_000__c;
            }
            else if(i.Fee_Code__c == 'J'){
                i.Fee_Code_0_100_000__c = i.Lookup_Fee_Code_J_0_100_000__c;
                i.Fee_Code_100_000_250_000__c = i.Lookup_Fee_Code_J_100_000_250_000__c;
                i.Fee_Code_250_000_500_000__c = i.Lookup_Fee_Code_J_250_000_500_000__c;
                i.Fee_Code_500_000_1_000_000__c = i.Lookup_Fee_Code_J_500_000_1_000_000__c;
                i.Fee_Code_1_000_000__c = i.Lookup_Fee_Code_J_1_000_000__c;
            }
            else if(i.Fee_Code__c == 'K'){
                i.Fee_Code_0_100_000__c = i.Lookup_Fee_Code_K_0_100_000__c;
                i.Fee_Code_100_000_250_000__c = i.Lookup_Fee_Code_K_100_000_250_000__c;
                i.Fee_Code_250_000_500_000__c = i.Lookup_Fee_Code_K_250_000_500_000__c;
                i.Fee_Code_500_000_1_000_000__c = i.Lookup_Fee_Code_K_500_000_1_000_000__c;
                i.Fee_Code_1_000_000__c = i.Lookup_Fee_Code_K_1_000_000__c;
            }
		}
    }
}
