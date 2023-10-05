public class spouseBirthdayTracks implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Name, Spouse_Birthday__c, Contact_Rating__c, Spouse_Email__c, Spouse_Last_Name__c, Assistant__c, Advisor__c, Advisor__r.A_Plus_Birthday_Email__c, Advisor__r.A_Birthday_Email__c, Advisor__r.B_Birthday_Email__c, Advisor__r.C_Birthday_Email__c, Advisor__r.A_Plus_Birthday_Call__c, Advisor__r.A_Birthday_Call__c, Advisor__r.B_Birthday_Call__c, Advisor__r.C_Birthday_Call__c, Advisor__r.A_Plus_Birthday_Card__c, Advisor__r.A_Birthday_Card__c, Advisor__r.B_Birthday_Card__c, Advisor__r.C_Birthday_Card__c FROM Contact LIMIT 10');
    }

    public void execute(Database.BatchableContext bc, List<Contact> allSpouseBirthdayContacts){
        spouseBirthdayTracks.performingSpouseBirthdayOperations(allSpouseBirthdayContacts);
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Spouse Birthday Works my dudes');
    }

	public static void performingSpouseBirthdayOperations(List<Contact> allContacts){//comment

        for(Contact i : allContacts){
            //checking all of these records from the batch SOQL call
            //if any of these records are NULL PUA tracks will return an error and not finish the rest of the batch, at least I think that's how it works
            if(i.Spouse_Birthday__c == NULL || i.Contact_Rating__c == NULL || i.Spouse_Email__c == NULL || i.Spouse_Last_Name__c == NULL || i.Assistant__c == NULL || i.Advisor__c == NULL){
                continue;
            }
            String clientRating = i.Contact_Rating__c;
            if(System.today().daysBetween(date.newInstance(System.today().year(), i.Spouse_Birthday__c.month(), i.Spouse_Birthday__c.day())) == 0){
                if(i.Advisor__r.A_Plus_Birthday_Email__c == True && clientRating == 'A+'){
                    sendingEmailToSpouse.sendingEmailToSpouseWithTemplate(i, 'Happy Birthday Spouse');
                }
                else if(i.Advisor__r.A_Birthday_Email__c == True && clientRating == 'A'){
                    sendingEmailToSpouse.sendingEmailToSpouseWithTemplate(i, 'Happy Birthday Spouse');
                }
                else if(i.Advisor__r.B_Birthday_Email__c == True && clientRating == 'B'){
                    sendingEmailToSpouse.sendingEmailToSpouseWithTemplate(i, 'Happy Birthday Spouse');
                }
                else if(i.Advisor__r.C_Birthday_Email__c == True && clientRating == 'C'){
                    sendingEmailToSpouse.sendingEmailToSpouseWithTemplate(i, 'Happy Birthday Spouse');
                }

                if(i.Advisor__r.A_Plus_Birthday_Call__c == True && clientRating == 'A+'){
                    spouseBirthdayTracks.assigningSpouseBirthdayCall(i);
                }
                else if(i.Advisor__r.A_Birthday_Call__c == True && clientRating == 'A'){
                    spouseBirthdayTracks.assigningSpouseBirthdayCall(i);
                }
                else if(i.Advisor__r.B_Birthday_Call__c == True && clientRating == 'B'){
                    spouseBirthdayTracks.assigningSpouseBirthdayCall(i);
                }
                else if(i.Advisor__r.C_Birthday_Call__c == True && clientRating == 'C'){
                    spouseBirthdayTracks.assigningSpouseBirthdayCall(i);
                }
            }
            else if(System.today().daysBetween(date.newInstance(System.today().year(), i.Spouse_Birthday__c.month(), i.Spouse_Birthday__c.day())) == 5){
                if(i.Advisor__r.A_Plus_Birthday_Card__c == True && clientRating == 'A+'){
                    spouseBirthdayTracks.assigningSpouseBirthdayCard(i);
                }
                else if(i.Advisor__r.A_Birthday_Card__c == True && clientRating == 'A'){
                    spouseBirthdayTracks.assigningSpouseBirthdayCard(i);
                }
                else if(i.Advisor__r.B_Birthday_Card__c == True && clientRating == 'B'){
                    spouseBirthdayTracks.assigningSpouseBirthdayCard(i);
                }
                else if(i.Advisor__r.C_Birthday_Card__c == True && clientRating == 'C'){
                    spouseBirthdayTracks.assigningSpouseBirthdayCard(i);
                }
            }
        }

    }

    public static void assigningSpouseBirthdayCall(Contact currentContact){
        String birthdayCallTaskSubject = 'Call';
        String birthdayCallTaskDescription = 'Call '; //+ currentContact.Spouse_Contact_Name__c + ' at ' + getPreferredPhoneNumber.gettingPreferredPhoneNumber(currentContact) + ',Primary Contacts preferred number, for their birthday';
        createNewTask.creatingNewTask(currentContact, system.today(), False, system.Time.newInstance(1, 1, 1, 1), birthdayCallTaskSubject, birthdayCallTaskDescription, 'Other', False, True);
    }

    public static void assigningSpouseBirthdayCard(Contact currentContact){
        String birthdayCardTaskSubject = 'Send Letter/Quote';
		String birthdayCardTaskDescription = 'Sign and Send Birthday Card to '; //+ currentContact.Spouse_Contact_Name__c;
        createNewTask.creatingNewTask(currentContact, system.today(), False, system.Time.newInstance(1, 1, 1, 1), birthdayCardTaskSubject, birthdayCardTaskDescription, 'Other', False, True);
    }

}
