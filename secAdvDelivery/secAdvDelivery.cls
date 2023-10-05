public class secAdvDelivery implements Database.Batchable<sObject> {

    //tpojero@salesforce.com

    /*
    - send out ADV’s 
    - check to see if someone is a client or referral or prospect
        - only send if contact is one of these
    - ADV Delivery date
        - date an ADV is last emailed to someone
        - yearly intervals
    - if client doesn’t have email —> print ADV 2A 2B and 3 Forms
        - send to client via mail
            - if sent via mail update delivery date to the day it was printed
        - send all when 2a, 2b, and 3 together yearly
        - 3 gets sent individually also when they want to
    */

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Name, ADV_Delivery__c, Contact_Type__c, Email, Advisor__c, Assistant__c, Preferred_Phone__c, Portable_Phone__c, Home_Phone__c, Business_Phone__c FROM Contact LIMIT 10');
        //return Database.getQueryLocator([SELECT FirstName, LastName, ADV_Delivery__c, Contact_Type__c, Email, Advisor__c, Assistant__c, Preferred_Phone__c, Portable_Phone__c, Home_Phone__c, Business_Phone__c FROM Contact LIMIT 10]);
    }

    public void execute(Database.BatchableContext bc, List<Contact> allAdvContacts){
        secAdvDelivery.startingsecAdvDelivery(allAdvContacts);
    }

    public void finish(Database.BatchableContext bc){
        System.debug('ADV works my dudes');
    }

	public static void startingsecAdvDelivery(List<Contact> allContacts){

		List<Contact> contactsToUpdate = new List<Contact>();

		//List<ContentDocument> attachments = [SELECT Id FROM ContentDocument WHERE Title LIKE 'FP ADV Part'];
        List<String> attachmentIds = new List<String>();

        //the Id’s of ADV 2A, 2B, and 3 added to the list
		attachmentIds.add('0698G000000Cs6xQAC'); //0694x000004GI7MAAW
        attachmentIds.add('0698G000000Cs6wQAC'); //
        attachmentIds.add('0698G000000Cs6rQAC');

        //List<Document> secAdvAttachments = [SELECT Id FROM Document WHERE ];

        /*for(String i : attachmentIds){
            System.debug(i);
        }*/

		for(Contact i : allContacts){
			//System.debug(i.ADV_Delivery__c);
            if(i.Contact_Type__c == NULL || i.Email == NULL || i.Advisor__c == NULL || i.Assistant__c == NULL){
                //|| i.Assistant__c == NULL || i.Advisor__c == NULL
                continue;
            }

			if(i.ADV_Delivery__c == NULL){
				i.ADV_Delivery__c = System.Date.today();
			}

			system.debug(i.ADV_Delivery__c);
			if((i.Contact_Type__c == 'Client' || i.Contact_Type__c == 'Referral' || i.Contact_Type__c == 'Prospect') && i.ADV_Delivery__c == System.Date.today().addDays(-365)){
				if(i.Email == NULL){
					//print ADV 2A, 2B, 3 to send to the contact
					//create task for the assistant to grab the ADV forms and envelopes from their printers and send them to the contacts
					createNewTask.creatingNewTask(i, System.Date.today(), True, System.Time.newInstance(10, 0, 0, 0), 'Send ADV Documents', 'ADV documents for ' + i.FirstName + ' ' + i.LastName + ' can be printed here <add link>. As well as the envelope here <add link>.', 'Other', False, True);
					i.ADV_Delivery__c = System.Date.today();
					contactsToUpdate.add(i);
				}
				else{
					sendingEmail.sendingEmailWithTemplateAndAttachments(i, 'ADV Delivery', attachmentIds);
					i.ADV_Delivery__c = System.Date.today();
					contactsToUpdate.add(i);
				}
			}
		}
		Database.update(contactsToUpdate, False);
	}

}
