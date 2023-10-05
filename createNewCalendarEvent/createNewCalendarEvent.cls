public class createNewCalendarEvent{

    public static void creatingNewCalendarEvent(Contact primaryAttendee, Date eventDate, Time eventTime, Integer Duration, Boolean reminder, Time eventReminderTime, String eventSubject, String eventDescription, Boolean forAdvisor, Boolean forAssistant){
        /*
         Using Event standard object to create events on the calendar
         Complete v1
		 Can create event objects one at a time with one attendee
		 Intended as first iteration to be able to add events to advisors calendars
        */

        Datetime eventDatetime = Datetime.newInstance(eventDate.year(), eventDate.month(), eventDate.day(), eventTime.hour(), eventTime.minute(), eventTime.second());
        DateTime eventReminderDateTime = Datetime.newInstanceGmt(eventDate.year(), eventDate.month(), eventDate.day(), eventReminderTime.hour(), eventReminderTime.minute(), eventReminderTime.second());

        if(forAdvisor == True && reminder == False){
            try{
				Event newEvent = new Event(StartDateTime = eventDateTime, DurationInMinutes = Duration, Subject = eventSubject, Description = eventDescription, OwnerId = primaryAttendee.Advisor__c, WhatId = primaryAttendee.Id, isReminderSet = False);
				insert newEvent;
        	}
        	catch(DmlException e){
        		system.debug('A DML exception has occurred: ' + e.getMessage());
        	}
        }
        else if(forAdvisor == True && reminder == True){
            try{
				Event newEvent = new Event(StartDateTime = eventDateTime, DurationInMinutes = Duration, Subject = eventSubject, Description = eventDescription, OwnerId = primaryAttendee.Advisor__c, WhatId = primaryAttendee.Id, isReminderSet = True, ReminderDateTime = eventReminderDateTime);
				insert newEvent;
        	}
        	catch(DmlException e){
        		system.debug('A DML exception has occurred: ' + e.getMessage());
        	}
        }

        if(forAssistant == True && reminder == False){
            try{
				Event newEvent = new Event(StartDateTime = eventDateTime, DurationInMinutes = Duration, Subject = eventSubject, Description = eventDescription, OwnerId = primaryAttendee.Assistant__c, WhatId = primaryAttendee.Id, isReminderSet = False);
				insert newEvent;
        	}
        	catch(DmlException e){
        		system.debug('A DML exception has occurred: ' + e.getMessage());
        	}
        }
        else if(forAssistant == True && reminder == True){
            try{
				Event newEvent = new Event(StartDateTime = eventDateTime, DurationInMinutes = Duration, Subject = eventSubject, Description = eventDescription, OwnerId = primaryAttendee.Assistant__c, WhatId = primaryAttendee.Id, isReminderSet = True, ReminderDateTime = eventReminderDateTime);
				insert newEvent;
        	}
        	catch(DmlException e){
        		system.debug('A DML exception has occurred: ' + e.getMessage());
            }

    	}
    }

}
