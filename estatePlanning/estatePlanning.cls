public class estatePlanning implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Name, Last_Estate_Contact__c, Last_Estate_Review__c, Investment_Status_Change__c, Will__c, Date_Created__c, Contact_Rating__c, Primary_Email__c, Advisor__c, Investment__c, Assistant__c, Preffered_Phone__c, Portable_Phone__c, Home_Phone__c, Business_Phone__c FROM Contact LIMIT 10');
    }

    public void execute(Database.BatchableContext bc, List<Contact> allEstatePlanningContacts){
        estatePlanning.startingEstatePlanningTracks(allEstatePlanningContacts);
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Estate Planning works my dudes');
    }

    Public static void startingEstatePlanningTracks(List<Contact> allContacts){

        List<Contact> contactsToUpdate = new List<Contact>();

        for(Contact i : allContacts){

            if(i.Investment_Status_Change__c == NULL || i.Contact_Rating__c == NULL || i.Advisor__c == NULL || i.Investment__c == NULL || i.Assistant__c == NULL){
                continue;
            }

            Datetime nextEstateReviewDate = estatePlanning.checkingForEstateReviewScheduleCompletion(i);
            if(nextEstateReviewDate != Datetime.newInstance(System.today().year(), 1, 1, 1, 1, 1)){
                if(i.Last_Estate_Contact__c != NULL){
                    i.Last_Estate_Review__c =  nextEstateReviewDate.date();
                }
                /*else if(i.Last_Estate_Contact__c == NULL){
                    //filling the date for the initial
                    i.Last_Estate_Contact__c = nextEstateReviewDate.date();
                }*/
            }

            if((i.Contact_Rating__c == 'A+' || i.Contact_Rating__c == 'A' || i.Contact_Rating__c == 'B') && i.Investment__c == 'Client' && i.Investment_Status_Change__c.daysBetween(System.date.today()) == 180 && i.Last_Estate_Contact__c == NULL){

                //the conditional for empty email address field, must print papers and envelope, and create task for assistant to get them from their printers and mail them
                if(i.Primary_Email__c == NULL){
                    createNewTask.creatingNewTask(i, System.Date.today(), True, System.Time.newInstance(10, 0, 0, 0), 'Estate Initial Print', 'Initial print of estate documents for ' + i.Name + ' can be printed here <add link>. As well as the envelope here <add link>.', 'Other', False, True);
                }
                else{
                    //send estate planning initial meeting email with Estate profile document attached
                	List<String> attachementIds = new List<String>();
                	attachementIds.add('06911000001yp56AAA');
                	sendingEmail.sendingEmailWithTemplateAndAttachments(i, 'Estate Initial', attachementIds);
                }

                //update Last_Estate_Contact__c to day the documents were emailed or printed
                i.Last_Estate_Contact__c = System.Date.today();
                contactsToUpdate.add(i);

                //assign a call for assistant for 3 days from the day the documents were emailed or printed
                createNewTask.creatingNewTask(i, System.today().addDays(3), False, Time.newInstance(1, 1, 1, 1), 'Estate Initial Call', 'Call' + i.Name + ' at ' + getPreferredPhoneNumber.gettingPreferredPhoneNumber(i) + ' to schedule their Initial Estate Review Meeting and begin the Estate Plannign process.', 'Call', False, True);
            }
            else if((i.Contact_Rating__c == 'A+' || i.Contact_Rating__c == 'A' || i.Contact_Rating__c == 'B') && i.Investment__c == 'Client' && math.mod(i.Last_Estate_Contact__c.daysBetween(System.date.today()), 730) == 0 && i.Will__c == NULL && i.Last_Estate_Review__c == NULL){
                //resend initial documents every two years if we do not have a will, nor do we have an estate review date

                //conditional for empty email address field, must print papers and envelope, and create task for assistant to get them from their printers and mail them
                if(i.Primary_Email__c == NULL){
                    createNewTask.creatingNewTask(i, System.Date.today(), True, System.Time.newInstance(10, 0, 0, 0), 'Estate Review Print', 'Print of estate documents for ' + i.Name + ', it has been 2 years since our last attempted contact. The documents can be printed here <add link>. As well as the envelope here <add link>.', 'Other', False, True);
                }
                else{
                	List<String> attachementIds = new List<String>();
                	attachementIds.add('06911000001yp56AAA');
                	sendingEmail.sendingEmailWithTemplateAndAttachments(i, 'Estate Initial', attachementIds);
                }

                //update Last_Estate_Contact__c to day the documents were emailed or printed
                i.Last_Estate_Contact__c = System.Date.today();
                contactsToUpdate.add(i);

                //assign a call for assistant for 3 days from the day the documents were emailed or printed
                createNewTask.creatingNewTask(i, System.today().addDays(3), False, Time.newInstance(1, 1, 1, 1), 'Estate Initial', 'Call' + i.Name + ' at ' + getPreferredPhoneNumber.gettingPreferredPhoneNumber(i) + ' to reschedule their Initial Estate Review Meeting and begin the Estate Planning process. It has been two years since we have contacted them about their Estate', 'Call', False, True);
            }

            //next date for scheduling next estate review appointment is 5 years from the date of the most recently completed estate review
            else if((i.Contact_Rating__c == 'A+' || i.Contact_Rating__c == 'A' || i.Contact_Rating__c == 'B') && i.Investment__c == 'Client' && i.Last_Estate_Review__c.daysBetween(System.Date.today()) == 1825){
                //send estate planning review meeting email with Estate profile document attached
                if(i.Primary_Email__c == NULL){
                    createNewTask.creatingNewTask(i, System.Date.today(), True, System.Time.newInstance(10, 0, 0, 0), 'Estate Review Print', 'Print of estate documents for ' + i.Name + '. The documents can be printed here <add link>. As well as the envelope here <add link>.', 'Other', False, True);
                }
                else{
                	List<String> attachementIds = new List<String>();
                	attachementIds.add('06911000001yp56AAA');
                	sendingEmail.sendingEmailWithTemplateAndAttachments(i, 'Estate Initial', attachementIds);
                }

                //update Last_Estate_Contact__c to day the documents were emailed or printed
                i.Last_Estate_Contact__c = System.Date.today();
                contactsToUpdate.add(i);

                //assign a call for assistant for 3 days from the day the documents were emailed or printed
                createNewTask.creatingNewTask(i, System.today().addDays(3), False, Time.newInstance(1, 1, 1, 1), 'Estate Review', 'Call' + i.Name + ' at ' + getPreferredPhoneNumber.gettingPreferredPhoneNumber(i) + ' to schedule their Estate Review Meeting and assist in the Estate Planning process.', 'Call', False, True);
            }
        }

        Database.update(contactsToUpdate, False);
    }

    public static Datetime checkingForEstateReviewScheduleCompletion(Contact currentContact){
        //detecting whether a portfolio update appointment has been scheduled
        Datetime todayDate = System.now();
        String populateSubject = currentContact.Name + ': Estate Review (' + currentContact.Advisor__r.Name + ')';
        Boolean stringContainsCurrentContactEmail = False;

        //checks the event subject is populateSubject
        List<Event> estateReviewCalendarEventCheck = [SELECT StartDateTime, EndDateTime, Subject, Description
                                             		  FROM Event
                                           	 		  WHERE (Subject =: populateSubject AND StartDateTime >=: todayDate)];

        if(estateReviewCalendarEventCheck.size() != NULL){
            for(Event i : estateReviewCalendarEventCheck){
                stringContainsCurrentContactEmail = i.Description.contains(currentContact.Primary_Email__c);
                if(stringContainsCurrentContactEmail){ //checks that currentContact.Primary_Email__c is in the description
                    return i.StartDateTime;
                }
            }
        }

        return Datetime.newInstance(System.today().year(), 1, 1, 1, 1, 1);
    }

}
