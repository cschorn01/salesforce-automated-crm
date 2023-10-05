public class createNewTask {

    public static void creatingNewTask(Contact primaryAttendee, Date taskDate, Boolean reminder, Time taskReminderTime, String taskSubject, String taskDescription, String taskType, Boolean forAdvisor, Boolean forAssistant){
        /*
         Using Task standard object to create tasks
         Complete v1
		 Can create task objects one at a time with one attendee
		 Intended as first iteration to be able to add tasks to users
        */

        Datetime reminderDatetime = Datetime.newInstance(taskDate.year(), taskDate.month(), taskDate.day(), taskReminderTime.hour(), taskReminderTime.minute(), taskReminderTime.second());
        if(forAdvisor == True && reminder == False){
            try{
				Task newTask = new Task(ActivityDate = taskDate, Subject = taskSubject, Description = taskDescription, Type = taskType, OwnerId = primaryAttendee.Advisor__c);
				insert newTask;
        	}
        	catch(DmlException e){
        		system.debug('A DML exception has occurred: ' + e.getMessage());
        	}
        }
        else if(forAdvisor == True && reminder == True){
            try{
				Task newTask = new Task(ActivityDate = taskDate, Subject = taskSubject, Description = taskDescription, Type = taskType, OwnerId = primaryAttendee.Advisor__c);
				insert newTask;
        	}
        	catch(DmlException e){
        		system.debug('A DML exception has occurred: ' + e.getMessage());
        	}
        }

        if(forAssistant == True && reminder == False){
            try{
				Task newTask = new Task(ActivityDate = taskDate, Subject = taskSubject, Description = taskDescription, Type = taskType, IsReminderSet = True, ReminderDateTime = reminderDatetime, OwnerId = primaryAttendee.Advisor__c);
				insert newTask;
        	}
        	catch(DmlException e){
        		system.debug('A DML exception has occurred: ' + e.getMessage());
        	}
        }
        else if(forAssistant == True && reminder == True){
            try{
				Task newTask = new Task(ActivityDate = taskDate, Subject = taskSubject, Description = taskDescription, Type = taskType, IsReminderSet = True, ReminderDateTime = reminderDatetime, OwnerId = primaryAttendee.Assistant__c);
				insert newTask;
        	}
        	catch(DmlException e){
        		system.debug('A DML exception has occurred: ' + e.getMessage());
        	}
        }
    }

}
