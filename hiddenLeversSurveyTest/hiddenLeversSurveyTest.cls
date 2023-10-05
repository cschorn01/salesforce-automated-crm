@isTest
public class hiddenLeversSurveyTest {

    @isTest static void startingHiddenLeversSurvey(){
        User temp = [SELECT Id, Name From User WHERE Name = 'Chris Schorn'];

        //Primary_First_Name__c, Primary_Last_Name__c, Contact_Rating__c, Hidden_Levers_Date__c, Hidden_Levers_Previously_Attempt__c, Hidden_Levers_Score__c, Investment__c, Contact_Type__c, Primary_Email__c, Related_Advisor__c, Assistant__c

        Contact contact1 = new Contact(FirstName='contact1', LastName='1', Contact_Rating__c='A', Hidden_Levers_Date__c=System.Date.today().addDays(-720), Hidden_Levers_Score__c=NULL, Investment__c=NULL, Contact_Type__c=NULL, Primary_Email__c='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id);

        hiddenLeversSurvey hls = new hiddenLeversSurvey();
        Id hldBatchId = Database.executeBatch(hls, 10);
    }

}
