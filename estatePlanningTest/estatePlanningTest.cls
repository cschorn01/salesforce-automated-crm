@isTest
public class estatePlanningTest {

    @isTest static void startingEstatePlanningTest(){
        User temp = [SELECT Id, Name From User WHERE Name = 'Chris Schorn'];

        //Last_Estate_Contact__c, Last_Estate_Review__c, Investment_Status_Change__c, Will__c, Date_Created__c, FirstName, LastName, Contact_Rating__c, Primary_Email__c, Advisor__c, Investment__c, Assistant__c, Preferred_Phone__c, Portable_Phone__c, Home_Phone__c, Business_Phone__c;

        Contact contact1 = new Contact(Investment_Status_Change__c = System.Date.today().addDays(-180), FirstName = 'contact1', LastName = '1', Contact_Rating__c = 'A', Advisor__c = temp.Id, Investment__c = 'Client', Assistant__c = temp.Id, Primary_Email__c = 'cschorn01@gmail.com', Will__c = NULL, Last_Estate_Contact__c = NULL, Last_Estate_Review__c = NULL, Portable_Phone__c='4845612027');
        Contact contact2 = new Contact(Investment_Status_Change__c = System.Date.today().addDays(-180), FirstName = 'contact2', LastName = '2', Contact_Rating__c = 'A', Advisor__c = temp.Id, Investment__c = 'Client', Assistant__c = temp.Id, Primary_Email__c = NULL, Will__c = NULL, Last_Estate_Contact__c = NULL, Last_Estate_Review__c = NULL, Portable_Phone__c='4845612027');
        Contact contact3 = new Contact(Investment_Status_Change__c = System.Date.today().addDays(-740), FirstName = 'contact3', LastName = '3', Contact_Rating__c = 'A', Advisor__c = temp.Id, Investment__c = 'Client', Assistant__c = temp.Id, Primary_Email__c = 'cschorn01@gmail.com', Will__c = NULL, Last_Estate_Contact__c = System.Date.today().addDays(-180), Last_Estate_Review__c = NULL, Portable_Phone__c='4845612027');
        Contact contact4 = new Contact(Investment_Status_Change__c = System.Date.today().addDays(-740), FirstName = 'contact4', LastName = '4', Contact_Rating__c = 'A', Advisor__c = temp.Id, Investment__c = 'Client', Assistant__c = temp.Id, Primary_Email__c = NULL, Will__c = NULL, Last_Estate_Contact__c = System.Date.today().addDays(-180), Last_Estate_Review__c = NULL, Portable_Phone__c='4845612027');
        Contact contact5 = new Contact(Investment_Status_Change__c = System.Date.today().addDays(-740), FirstName = 'contact5', LastName = '5', Contact_Rating__c = 'A', Advisor__c = temp.Id, Investment__c = 'Client', Assistant__c = temp.Id, Primary_Email__c = 'cschorn01@gmail.com', Will__c = NULL, Last_Estate_Review__c = System.Date.today().addDays(-1825), Portable_Phone__c='4845612027');
        Contact contact6 = new Contact(Investment_Status_Change__c = System.Date.today().addDays(-740), FirstName = 'contact6', LastName = '6', Contact_Rating__c = 'A', Advisor__c = temp.Id, Investment__c = 'Client', Assistant__c = temp.Id , Primary_Email__c = NULL, Will__c = NULL, Last_Estate_Review__c = System.Date.today().addDays(-1825), Portable_Phone__c='4845612027');
        insert contact1;
        insert contact2;
        insert contact3;
        insert contact4;
        insert contact5;
        insert contact6;

        estatePlanning espl = new estatePlanning();
        ID estatePlanningId = Database.executeBatch(espl, 10);
    }
}
