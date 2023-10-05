public class sendingEmail {

    public static void sendingEmailWithTemplate(Contact emailRecipient, String emailTemplateName){
        /*
         Using SingleEmailMessage standard method to send emails based on a lightning html template
         Complete v1
		 Will send an email based on the input Client__c, and the lightning template name
		 Needs workaround which created a contact w/ the Client__c email, salutation and last name
		 because the system will not allow custom or user objects to populate targetObjectId
        */

        EmailTemplate newEmailTemplateId = [SELECT Id FROM EmailTemplate WHERE Name =: emailTemplateName LIMIT 1]; //requesting the template ID
        //Creating temporary contact to fill targetObjectId and have an email address to send to
        //Contact tempContact = new Contact(email = emailRecipient.Primary_Email__c, LastName = emailRecipient.Primary_Last_Name__c);//, Salutation__c = emailRecipient.Primary_Salutation__c);
        //insert tempContact; //DML insert for the temporary contact for system use

        //this section creates the email, with the targetObjectId being Contact type and WhatId being Client__c type
        //WhatId is used to fill the merge fields on the Lightning Template
        Messaging.SingleEmailMessage newEmail = new Messaging.SingleEmailMessage();
        newEmail.setTemplateId(newEmailTemplateId.Id);
		newEmail.setTargetObjectId(emailRecipient.Id);
        //newEmail.setWhatId(emailRecipient.Id);


        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {newEmail};
        //this sends the email and error checks
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
		/*if (results[0].success) {
    		System.debug('The email was sent successfully.');
		} else {
    		System.debug('The email failed to send: '+ results[0].errors[0].message);
		}*/

        //delete tempContact; //DML delete for the temporary contact so it isn't hanging around causing trouble
    }

    public static void sendingEmailWithTemplateAndAttachments(Contact emailRecipient, String emailTemplateName, List<String> attachmentIds){ //must test to be sure it works
        /*
         Using SingleEmailMessage standard method to send emails based on a lightning html template, with an attachment
         Complete v1
		 Will send an email based on the input Custom_Contact__c, and the lightning template name
		 Needs workaround which created a contact w/ the Custom_Contact__c email, salutation and last name
		 because the system will not allow custom or user objects to populate targetObjectId
        */

        EmailTemplate newEmailTemplateId = [SELECT Id FROM EmailTemplate WHERE Name =: emailTemplateName LIMIT 1]; //requesting the template ID
        //Creating temporary contact to fill targetObjectId and have an email address to send to
        //Contact tempContact = new Contact(email = emailRecipient.Primary_Email__c, LastName = emailRecipient.Primary_Last_Name__c);//, Salutation__c = emailRecipient.Primary_Salutation__c);
        //insert tempContact; //DML insert for the temporary contact for system use

        //this section creates the email, with the targetObjectId being Contact type and WhatId being Custom_Contact__c type
        //WhatId is used to fill the merge fields on the Lightning Template
        Messaging.SingleEmailMessage newEmail = new Messaging.SingleEmailMessage();
        newEmail.setTemplateId(newEmailTemplateId.Id);
		newEmail.setTargetObjectId(emailRecipient.Id);
        newEmail.setEntityAttachments(attachmentIds);
        //newEmail.setWhatId(emailRecipient.Id);


        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {newEmail};
        //this sends the email and error checks
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
		/*if (results[0].success) {
    		System.debug('The email was sent successfully.');
		} else {
    		System.debug('The email failed to send: '+ results[0].errors[0].message);
		}*/

        //delete tempContact; //DML delete for the temporary contact so it isn't hanging around causing trouble
    }
}
