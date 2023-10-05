@isTest
public class secAdvDeliveryTest {

    @isTest static void startingSecAdvDeliveryTest(){
        User temp = [SELECT Id, Name From User WHERE Name = 'Chris Schorn'];

        //							   Name, ADV_Delivery__c, Contact_Type__c, Email, Advisor__c, Assistant__c, Preferred_Phone__c, Portable_Phone__c, Home_Phone__c, Business_Phone__c

        Contact contact1 = new Contact(FirstName='Bubba', LastName='Lepew', ADV_Delivery__c=System.Date.today().addDays(-365), Contact_Type__c='Client', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027');
        Contact contact2 = new Contact(FirstName='Forest', LastName='Gump', ADV_Delivery__c=NULL, Contact_Type__c='Client', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027');
        Contact contact3 = new Contact(FirstName='Rich', LastName='Homie Quan', ADV_Delivery__c=System.Date.today().addDays(-365), Contact_Type__c='Client', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027');
        insert contact1;
        insert contact2;
        insert contact3;

        secAdvDelivery sad = new secAdvDelivery();
        Id sadBatchId = Database.executeBatch(sad, 10);
    }

}
