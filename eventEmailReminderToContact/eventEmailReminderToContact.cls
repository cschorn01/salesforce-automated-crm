public class eventEmailReminderToContact implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Name, Event_Reminder_Email_Subject__c, Event_Reminder_Email_Datetime__c, Contact_Rating__c, Primary_Email__c, Advisor__c, Advisor__r.Name, Assistant__c, Preferred_Phone__c, Portable_Phone__c, Home_Phone__c, Business_Phone__c FROM Contact LIMIT 5');
    }

    public void execute(Database.BatchableContext bc, List<Contact> allReminderContacts){
        eventEmailReminderToContact.startingEventEmailReminderToContact(allReminderContacts);
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Email Reminders works my dudes');
    }

    public static void startingEventEmailReminderToContact(List<Contact> allContacts){

        //sending reminder emails to contacts about phone calls and meetings
        //detect if the current contact has any meetings today or tomorrow
        //if the event is a phone call an email is sent that morning
        //if the event is a meeting an email is sent the day before

        List<Contact> contactsToUpdate  = new List<Contact>();
        /*
        These for loops are checking the calendar for phone calls today, and meetings tomorrow for each contact.
        Then changes holding fields in the Contact object for each contact about what kind of
        calendar event it is and the datetime of the calendar event
        The for loops are split like this so that nothing will hit a per-transaction governor limit within the for loops
		*/
        for(Contact i : allContacts){
            String populateSubjectPUA = i.Name + ': Portfolio Review (' + i.Advisor__r.Name + ')';
            Datetime puaDatetime = eventEmailReminderToContact.checkingForCalendarEvents(i, populateSubjectPUA);
            if(puaDatetime.date() == System.Date.today().addDays(1)){
                i.Event_Reminder_Email_Subject__c = 'Portfolio Review';
                i.Event_Reminder_Email_Datetime__c = puaDatetime;
                contactsToUpdate.add(i);
            }
        }

        Database.update(contactsToUpdate, False);
        contactsToUpdate.clear();
        /*
        this function uses the newly updated information about the holding fields to send the email
        to the contact and fill out merge fields in the email template. Then resets the hoding
        fields back to null so the next for loop does n ot resend the email's
        */
        eventEmailReminderToContact.sendingEmailAndResetingHoldingFields(allContacts);

        for(Contact i : allContacts){
            String populateSubjectEstate = i.Name + ': Estate Review (' + i.Advisor__r.Name + ')';
            Datetime estateDatetime = eventEmailReminderToContact.checkingForCalendarEvents(i, populateSubjectEstate);
            if(estateDatetime.date() == System.Date.today().addDays(1)){
                i.Event_Reminder_Email_Subject__c = 'Estate Review';
                i.Event_Reminder_Email_Datetime__c = estateDatetime;
                contactsToUpdate.add(i);
            }
        }
        Database.update(contactsToUpdate, False);
        contactsToUpdate.clear();
        eventEmailReminderToContact.sendingEmailAndResetingHoldingFields(allContacts);

        for(Contact i : allContacts){
            String populateSubject30mincall = i.Name + ': 30 Minute Phone Call (' + i.Advisor__r.Name + ')';
            Datetime thirtyMinCallDatetime = eventEmailReminderToContact.checkingForCalendarEvents(i, populateSubject30mincall);
            if(thirtyMinCallDatetime.date() == System.Date.today()){
                i.Event_Reminder_Email_Subject__c = '30 Minute Phone Call';
                i.Event_Reminder_Email_Datetime__c = thirtyMinCallDatetime;
                contactsToUpdate.add(i);
            }
        }
        Database.update(contactsToUpdate, False);
        contactsToUpdate.clear();
        eventEmailReminderToContact.sendingEmailAndResetingHoldingFields(allContacts);

        for(Contact i : allContacts){
            String populateSubject15mincall = i.Name + ': 15 Minute Phone Call (' + i.Advisor__r.Name + ')';
            Datetime fifteenMinCallDatetime = eventEmailReminderToContact.checkingForCalendarEvents(i, populateSubject15mincall);
            if(fifteenMinCallDatetime.date() == System.Date.today()){
                i.Event_Reminder_Email_Subject__c = '15 Minute Phone Call';
                i.Event_Reminder_Email_Datetime__c = fifteenMinCallDatetime;
                contactsToUpdate.add(i);
            }
        }
        Database.update(contactsToUpdate, False);
        contactsToUpdate.clear();
        eventEmailReminderToContact.sendingEmailAndResetingHoldingFields(allContacts);
    }

    public static Datetime checkingForCalendarEvents(Contact currentContact, String populateSubject){
        //detecting whether an appointment has been scheduled
        Datetime todayDate = System.now();
        Boolean stringContainsCurrentContactEmail = False;

        //checks the event subject is populateSubject
        List<Event> calendarEventCheck = [SELECT StartDateTime, EndDateTime, Subject, Description
                                             		  FROM Event
                                           	 		  WHERE (Subject =: populateSubject AND StartDateTime >=: todayDate)];

        if(calendarEventCheck.size() != NULL){
            for(Event i : calendarEventCheck){
                System.debug(i.StartDateTime);
                stringContainsCurrentContactEmail = i.Description.contains(currentContact.Primary_Email__c);
                if(stringContainsCurrentContactEmail){ //checks that currentContact.Primary_Email__c is in the description
                    return i.StartDateTime;
                }
            }
        }

        return Datetime.newInstance(System.today().year(), 1, 1, 1, 1, 1);
    }

    public static void sendingEmailAndResetingHoldingFields(List<Contact> currentContactBatch){
        // ensures that the holding fields for the Contact are not empty, then sends the email
        // with the corresponding information in the holding fields, resets those fields back to NULL,
        // and repeats the process with the next type of calendar event

        List<Contact> contactsToUpdate = new List<Contact>();

        for(Contact i : currentContactBatch){
            if(i.Event_Reminder_Email_Subject__c != NULL && i.Event_Reminder_Email_Datetime__c != NULL){
                sendingEmail.sendingEmailWithTemplate(i, 'Calendar Event Reminder');
            }
            i.Event_Reminder_Email_Subject__c = NULL;
            i.Event_Reminder_Email_Datetime__c = NULL;
            contactsToUpdate.add(i);
        }
        Database.update(contactsToUpdate, False);
    }

}
