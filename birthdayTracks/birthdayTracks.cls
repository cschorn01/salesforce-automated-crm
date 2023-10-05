public class birthdayTracks implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Name, Primary_Birthday__c, Contact_Rating__c, Email, Assistant__c, Advisor__c, Portable_Phone__c, Home_Phone__c, Business_Phone__c, Preferred_Phone__c, Lookup_Assistant_Phone__c, Advisor__r.A_Plus_Birthday_Email__c, Advisor__r.A_Birthday_Email__c, Advisor__r.B_Birthday_Email__c, Advisor__r.C_Birthday_Email__c, Advisor__r.A_Plus_Birthday_Call__c, Advisor__r.A_Birthday_Call__c, Advisor__r.B_Birthday_Call__c, Advisor__r.C_Birthday_Call__c, Advisor__r.A_Plus_Birthday_Card__c, Advisor__r.A_Birthday_Card__c, Advisor__r.B_Birthday_Card__c, Advisor__r.C_Birthday_Card__c FROM Contact LIMIT 10');
    }

    public void execute(Database.BatchableContext bc, List<Contact> allBirthdayContacts){
        birthdayTracks.performingBirthdayOperations(allBirthdayContacts);
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Birthdays works my dudes');
    }

    public static void performingBirthdayOperations(List<Contact> allContacts){

        /*
        Redoing v1 in 'startingBirthdayTracks' method
        Complete v2
		Takes in all of the clients' info related to the Primary Contacts' birthdays.
		If else statements triggered using boolean values in the User Standard Object
		for sending birthday emails, birthday cards, and making birthday calls.
        */

        for(Contact i : allContacts){
            if(i.Primary_Birthday__c == NULL || i.Contact_Rating__c == NULL || i.Email == NULL || i.Name == NULL || i.Assistant__c == NULL || i.Advisor__c == NULL){
				//checking all of these records from the batch SOQL call
                //if any of these records are NULL PUA tracks will return an error and not finish the rest of the batch, at least I think that's how it works
                continue;
            }

            String clientRating = i.Contact_Rating__c;
            if(System.today().daysBetween(date.newInstance(System.today().year(), i.Primary_Birthday__c.month(), i.Primary_Birthday__c.day())) == 0){
                if(i.Advisor__r.A_Plus_Birthday_Email__c == True && clientRating == 'A+'){
                    sendingEmail.sendingEmailWithTemplate(i, 'Happy Birthday Contact');
                }
                else if(i.Advisor__r.A_Birthday_Email__c == True && clientRating == 'A'){
                    sendingEmail.sendingEmailWithTemplate(i, 'Happy Birthday Contact');
                }
                else if(i.Advisor__r.B_Birthday_Email__c == True && clientRating == 'B'){
                    sendingEmail.sendingEmailWithTemplate(i, 'Happy Birthday Contact');
                }
                else if(i.Advisor__r.C_Birthday_Email__c == True && clientRating == 'C'){
                    sendingEmail.sendingEmailWithTemplate(i, 'Happy Birthday Contact');
                }

                if(i.Advisor__r.A_Plus_Birthday_Call__c == True && clientRating == 'A+'){
                    birthdayTracks.assigningBirthdayCall(i);
                }
                else if(i.Advisor__r.A_Birthday_Call__c == True && clientRating == 'A'){
                    birthdayTracks.assigningBirthdayCall(i);
                }
                else if(i.Advisor__r.B_Birthday_Call__c == True && clientRating == 'B'){
                    birthdayTracks.assigningBirthdayCall(i);
                }
                else if(i.Advisor__r.C_Birthday_Call__c == True && clientRating == 'C'){
                    birthdayTracks.assigningBirthdayCall(i);
                }
            }
            else if(System.today().daysBetween(date.newInstance(System.today().year(), i.Primary_Birthday__c.month(), i.Primary_Birthday__c.day())) == 5){
                if(i.Advisor__r.A_Plus_Birthday_Card__c == True && clientRating == 'A+'){
                    birthdayTracks.assigningBirthdayCard(i);
                }
                else if(i.Advisor__r.A_Birthday_Card__c == True && clientRating == 'A'){
                    birthdayTracks.assigningBirthdayCard(i);
                }
                else if(i.Advisor__r.B_Birthday_Card__c == True && clientRating == 'B'){
                    birthdayTracks.assigningBirthdayCard(i);
                }
                else if(i.Advisor__r.C_Birthday_Card__c == True && clientRating == 'C'){
                    birthdayTracks.assigningBirthdayCard(i);
                }
            }
        }

    }

    public static void assigningBirthdayCall(Contact currentContact){
        String birthdayCallTaskSubject = 'Call';
        String birthdayCallTaskDescription = 'Call ' + currentContact.Name + ' at ' + getPreferredPhoneNumber.gettingPreferredPhoneNumber(currentContact) + ' for their birthday';
        createNewTask.creatingNewTask(currentContact, system.today(), False, system.Time.newInstance(1, 1, 1, 1), birthdayCallTaskSubject, birthdayCallTaskDescription, 'Other', False, True);
    }

    public static void assigningBirthdayCard(Contact currentContact){
        String birthdayCardTaskSubject = 'Send Letter/Quote';
		String birthdayCardTaskDescription = 'Sign and Send Birthday Card to ' + currentContact.Name;
        createNewTask.creatingNewTask(currentContact, system.today(), False, system.Time.newInstance(1, 1, 1, 1), birthdayCardTaskSubject, birthdayCardTaskDescription, 'Other', False, True);
    }

}
