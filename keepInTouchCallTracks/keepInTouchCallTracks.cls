public class keepInTouchCallTracks {

    public static void updatingKeepInTouchCallDate(Contact contactToCall, Datetime scheduledPuaDatetime){

        /*
        Updating the Keep in Touch call date in contactToCall, and creating a task due on that same date
        Complete v1
		A new date for the keep in touch call is created by using the Portfolio Update Appointment scheduled date and subsequent, Next_PUA__c, date to reschedule another appointment.
		Taking the number of days between by the standard date method 'daysBetween' and dividing in half gave the number of days to add to Next_PUA__c for a check in
		halfway between the PUA meeting and the next date, Next_PUA__c to begin schedulding another PUA.
		scheduledPuaDateTime is a Datetime variable holding the date and time of the date the next PUA scheduling email will be sent
		*/
        																//Next_PUA__c is after ScheduledPuaDatetime so this value will be negative
        																//adding it to Next_PUA__c will put a date halfway between Next_PUA__c and scheduledPuaDatetime
        Date kitCallDate = contactToCall.Next_PUA__c.addDays(contactToCall.Next_PUA__c.daysBetween(scheduledPuaDatetime.Date())/2);
        contactToCall.Next_KIT_Call__c = kitCallDate;
        update contactToCall;
        String kitCallDescription = 'Call ' + contactToCall.Name + ' at ' + getPreferredPhoneNumber.gettingPreferredPhoneNumber(contactToCall) + ' for their Keep In Touch (KIT) call.';
        createNewTask.creatingNewTask(contactToCall, kitCallDate, False, time.newInstance(1, 1, 1, 1), 'Keep In Touch Call', kitCallDescription, 'Other', False, True);
    }

}

// 5/27 connect salesforce to gmail and figure out how to link all the fields
// 		figure out email workaround for merge fields to work
// 		write test classes
// 		make UI
// 		finish creating data fields for Custom_Contact__c
//
// 		gmail inbox integration apparently allows for a gui calendar to schedule meetings
