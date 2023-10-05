public class anniversaryTracks implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Name, Anniversary__c, Assistant__c, Contact_Rating__c, Email, Advisor__c, Advisor__r.A_Plus_Anniversary_Email__c, Advisor__r.A_Anniversary_Email__c, Advisor__r.B_Anniversary_Email__c, Advisor__r.C_Anniversary_Email__c, Advisor__r.A_Plus_Anniversary_Card__c, Advisor__r.A_Anniversary_Card__c, Advisor__r.B_Anniversary_Card__c, Advisor__r.C_Anniversary_Card__c, Advisor__r.A_Plus_Anniversary_Flowers__c, Advisor__r.A_Anniversary_Flowers__c, Advisor__r.B_Anniversary_Flowers__c, Advisor__r.C_Anniversary_Flowers__c FROM Contact LIMIT 10');
    }

    public void execute(Database.BatchableContext bc, List<Contact> allAnniversaryContacts){
        anniversaryTracks.startingAnniversaryTracks(allAnniversaryContacts);
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Anniversaries works my dudes');
    }

    public static void startingAnniversaryTracks(List<Contact> allContacts){

		/*
    	Method that begins the anniversary tracks
		Started from base automations class used to
		begin all automations
    	*/

        for(Contact i : allContacts){
            if(i.Anniversary__c == NULL || i.Contact_Rating__c == NULL || i.Email == NULL || i.Advisor__c == NULL || i.Assistant__c == NULL){
                //checking all of these records from the batch SOQL call
                //if any of these records are NULL PUA tracks will return an error and not finish the rest of the batch, at least I think that's how it works
                continue;
            }
            String clientRating = i.Contact_Rating__c;
            if(System.today().daysBetween(date.newInstance(System.today().year(), i.Anniversary__c.month(), i.Anniversary__c.day())) == 0){
                if(i.Advisor__r.A_Plus_Anniversary_Email__c == True && clientRating == 'A+'){
                    sendingEmail.sendingEmailWithTemplate(i, 'Happy Anniversary');
                }
                else if(i.Advisor__r.A_Anniversary_Email__c == True && clientRating == 'A'){
                    sendingEmail.sendingEmailWithTemplate(i, 'Happy Anniversary');
                }
                else if(i.Advisor__r.B_Anniversary_Email__c == True && clientRating == 'B'){
                    sendingEmail.sendingEmailWithTemplate(i, 'Happy Anniversary');
                }
                else if(i.Advisor__r.C_Anniversary_Email__c == True && clientRating == 'C'){
                    sendingEmail.sendingEmailWithTemplate(i, 'Happy Anniversary');
                }

            }
            else if(System.today().daysBetween(date.newInstance(System.today().year(), i.Anniversary__c.month(), i.Anniversary__c.day())) == 5){
                if(i.Advisor__r.A_Plus_Anniversary_Card__c == True && clientRating == 'A+'){
                    anniversaryTracks.assigningAnniversaryCard(i);
                }
                else if(i.Advisor__r.A_Anniversary_Card__c == True && clientRating == 'A'){
                    anniversaryTracks.assigningAnniversaryCard(i);
                }
                else if(i.Advisor__r.B_Anniversary_Card__c == True && clientRating == 'B'){
                    anniversaryTracks.assigningAnniversaryCard(i);
                }
                else if(i.Advisor__r.C_Anniversary_Card__c == True && clientRating == 'C'){
                    anniversaryTracks.assigningAnniversaryCard(i);
                }
                if(i.Advisor__r.A_Plus_Anniversary_Flowers__c == True && clientRating == 'A+'){
                    anniversaryTracks.assigningAnniversaryFlowers(i);
                }
                else if(i.Advisor__r.A_Anniversary_Flowers__c == True && clientRating == 'A'){
                    anniversaryTracks.assigningAnniversaryFlowers(i);
                }
                else if(i.Advisor__r.B_Anniversary_Flowers__c == True && clientRating == 'B'){
                    anniversaryTracks.assigningAnniversaryFlowers(i);
                }
                else if(i.Advisor__r.C_Anniversary_Flowers__c == True && clientRating == 'C'){
                    anniversaryTracks.assigningAnniversaryFlowers(i);
                }
            }
        }

    }

	public static void assigningAnniversaryFlowers(Contact currentContact){
        String birthdayCallTaskSubject = 'Send Letter/Quote';
        String birthdayCallTaskDescription = 'Send flowers to ' + currentContact.Name + ' for their anniversary.';
        createNewTask.creatingNewTask(currentContact, system.today(), False, system.Time.newInstance(1, 1, 1, 1), birthdayCallTaskSubject, birthdayCallTaskDescription, 'Other', False, True);
    }

    public static void assigningAnniversaryCard(Contact currentContact){
        String birthdayCardTaskSubject = 'Send Letter/Quote';
		String birthdayCardTaskDescription = 'Sign and send anniversary card to ' + currentContact.Name;
        createNewTask.creatingNewTask(currentContact, system.today(), False, system.Time.newInstance(1, 1, 1, 1), birthdayCardTaskSubject, birthdayCardTaskDescription, 'Other', False, True);
    }

}
