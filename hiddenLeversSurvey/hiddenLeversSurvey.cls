public class hiddenLeversSurvey implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Name, Contact_Rating__c, Hidden_Levers_Date__c, Hidden_Levers_Score__c, Investment__c, Contact_Type__c, Primary_Email__c, Advisor__c, Assistant__c, Preferred_Phone__c, Portable_Phone__c, Home_Phone__c, Business_Phone__c FROM Contact LIMIT 10');
    }

    public void execute(Database.BatchableContext bc, List<Contact> allAdvContacts){
        hiddenLeversSurvey.sendingHiddenLeversSurvey(allAdvContacts);
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Hidden Lever Survey works my dudes');
    }

    public static void sendingHiddenLeversSurvey(List<Contact> allContacts){

		List<Contact> contactsToUpdate = new List<Contact>();

		for(Contact i : allContacts){

            if(i.Contact_Rating__c == NULL || i.Hidden_Levers_Date__c == NULL || i.Hidden_Levers_Score__c== NULL || i.Investment__c == NULL || i.Contact_Type__c == NULL || i.Primary_Email__c == NULL || i.Advisor__c == NULL || i.Assistant__c == NULL){
            	continue;
        	}

			if(i.Hidden_Levers_Date__c == System.Date.today().addDays(-720)){
				//task for assistant to call the contact
				createNewTask.creatingNewTask(i, System.Date.today(), True, System.Time.newInstance(10, 0, 0, 0), 'Call about Hidden Levers Survey', 'The Hidden Levers Survery was sent to ' + i.Name + ' two years ago.  Call them to follow up at ' + getPreferredPhoneNumber.gettingPreferredPhoneNumber(i), 'Other', False, True);
			}
		}
	}

}
