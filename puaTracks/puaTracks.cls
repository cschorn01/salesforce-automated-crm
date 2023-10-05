public class puaTracks implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Name, PUA_Frequency__c, Next_PUA__c, Contact_Rating__c, Email, Advisor__c, PUA_Scheduling_Active__c, Assistant__c, Preferred_Phone__c, Portable_Phone__c, Home_Phone__c, Business_Phone__c, Advisor__r.Name FROM Contact LIMIT 10');
    }

    public void execute(Database.BatchableContext bc, List<Contact> allPuaContacts){
        puaTracks.startingPuaTracks(allPuaContacts);
    }

    public void finish(Database.BatchableContext bc){
        System.debug('PUA works my dudes');
    }

    public static void startingPuaTracks(List<Contact> allContacts){

        List<Contact> contactsToUpdate = new List<Contact>();

        for(Contact i : allContacts){
            if(i.Next_PUA__c == NULL){
                //Next_PUA__c will only be empty if a contact is new, so a date will be added the next day and PUA scheduling will begin
                i.Next_PUA__c = System.Date.today();
            }

            if(i.Name == Null || i.PUA_Frequency__c == Null || i.Email == Null || i.Assistant__c == NULL || i.Advisor__c == NULL){
                //checking all of these records from the batch SOQL call
                //if any of these records are NULL, PUA tracks will return an error and not finish the rest of the batch, at least I think that's how it works
                continue;
            }

            Datetime nextPuaDate = puaTracks.checkingForPuaScheduleCompletion(i);
            //System.debug('@nextPuaDate: '+nextPuaDate);
            if(nextPuaDate != Datetime.newInstance(System.today().year(), 1, 1, 1, 1, 1)){
                system.debug('PUA_Frequency__c: '+i.PUA_Frequency__c);
                if(i.PUA_Frequency__c == 'Monthly'){
                    i.Next_PUA__c = nextPuaDate.date().addDays(30);
                }
                else if(i.PUA_Frequency__c == 'Quarterly'){
                    i.Next_PUA__c = nextPuaDate.date().addDays(90);
                }
                else if(i.PUA_Frequency__c == 'Semi-Annual'){
                    i.Next_PUA__c = nextPuaDate.date().addDays(180);
                }
                else if(i.PUA_Frequency__c == 'Annual'){
                    i.Next_PUA__c = nextPuaDate.date().addDays(361);
                }

                //have to start keep in touch call tracks here due to the requirement
                //of the date of the next PUA
                keepInTouchCallTracks.updatingKeepInTouchCallDate(i, nextPuaDate);

                i.PUA_Scheduling_Active__c = False;

				contactsToUpdate.add(i);
            }
            else if(i.Next_PUA__c == System.date.today() && i.PUA_Scheduling_Active__c == False){
                //send email to create calendar event with task for follow up
                puaTracks.sendingPuaSchedulingEmail(i);
            }
            else if(math.mod(i.Next_PUA__c.daysBetween(System.today()), 60) == 0 && i.PUA_Scheduling_Active__c == True){//checking to see if last reach out was 60 days ago and currently trying to schedule PUA
                //resend email to create calendar event with task for follow up every 60 days from the beginning date
                puaTracks.resendingPuaSchedulingEmail(i);
            }
        }

        Database.update(contactsToUpdate, False);
    }

    public static void sendingPuaSchedulingEmail(Contact currentContact){

        //starting the PUA Tracks automation by sending the first email, creating a task for the assistant for follow up call, and changing the PUA Scheduling Boolean to True so it is active
        sendingEmail.sendingEmailWithTemplate(currentContact, 'Portfolio Review Scheduling');
        currentContact.PUA_Scheduling_Active__c = True;
        createNewTask.creatingNewTask(currentContact, System.today().addDays(3), False, Time.newInstance(1, 1, 1, 1), 'Portfolio Update Appoinment', 'Call' + currentContact.Name, 'Call', False, True);
        update currentContact;
    }

    public static void resendingPuaSchedulingEmail(Contact currentContact){

        //resending the scheduling email for PUA
        sendingEmail.sendingEmailWithTemplate(currentContact, 'Portfolio Review Scheduling');
        createNewTask.creatingNewTask(currentContact, System.today().addDays(3), False, Time.newInstance(1, 1, 1, 1), 'Portfolio Update Appoinment', 'Call' + currentContact.Name, 'Call', False, True);
    }

    public static Datetime checkingForPuaScheduleCompletion(Contact currentContact){
        //detecting whether a portfolio update appointment has been scheduled
        Datetime todayDate = System.now();
        String populateSubject= currentContact.Name + ': Portfolio Review (' + currentContact.Advisor__r.Name + ')';
        try{
        	Event puaCalendarEventCheck = [SELECT StartDateTime, EndDateTime, Subject
                                           FROM Event
                                           WHERE (Subject = : populateSubject AND StartDateTime >= :todayDate)];
            System.debug(currentContact.Name + '  ' + currentContact.Advisor__r.Name);
			return puaCalendarEventCheck.StartDateTime;
        }
        catch(System.QueryException e){
            System.debug(e.getMessage());
            return Datetime.newInstance(System.today().year(), 1, 1, 1, 1, 1);
        }

    }

}
