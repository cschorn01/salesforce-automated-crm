@isTest
private class sendingEmailTest {

    @isTest static void sendingEmailWithTemplateTest(){
        Test.startTest();

        User temp = [SELECT Id From User WHERE Name = 'Chris Schorn'];

        Contact newestContact = new Contact(LastName='James', Primary_Email__c='cschorn01@gmail.com', Primary_Salutation__c='Mr.', Advisor__c=temp.Id);
        insert newestContact;

        sendingEmail.sendingEmailWithTemplate(newestContact, 'Happy Birthday Contact');

        Test.stopTest();
    }

}
