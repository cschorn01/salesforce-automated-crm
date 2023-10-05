@isTest
public class eventEmailReminderToContactTest {

    @isTest static void startingEventEmailReminderToContactTest(){
        User temp = [SELECT Id, Name From User WHERE Name = 'Chris Schorn'];

        //FirstName, LastName, Event_Reminder_Email_Subject__c, Event_Reminder_Email_Datetime__c, Contact_Rating__c, Email, Advisor__c, Advisor__r.Name, Assistant__c
        Contact contact1 = new Contact(FirstName='contact1', LastName='1',  Event_Reminder_Email_Subject__c=NULL, Event_Reminder_Email_Datetime__c=NULL, Contact_Rating__c='A', Primary_Email__c='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Preferred_Phone__c='Portable');
        //Contact contact2 = new Contact(FirstName='contact2', LastName='2',  Event_Reminder_Email_Subject__c=NULL, Event_Reminder_Email_Datetime__c=NULL, Contact_Rating__c='A', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id);
        insert contact1;

        Contact getContact1 = [SELECT Name, Event_Reminder_Email_Subject__c, Event_Reminder_Email_Datetime__c, Contact_Rating__c, Primary_Email__c, Advisor__c, Advisor__r.Name, Assistant__c FROM Contact WHERE FirstName='contact1' AND LastName='1'];

        //Portfolio Review Event
        Event event1 = new Event(Subject=getContact1.Name + ': Portfolio Review (' + getContact1.Advisor__r.Name + ')', Description='cschorn01@gmail.com', StartDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(1).day(), 13, 0, 0), EndDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(1).day(), 14, 0, 0));
        //Estate Review Event
        Event event2 = new Event(Subject=getContact1.Name + ': Estate Review (' + getContact1.Advisor__r.Name + ')', Description='cschorn01@gmail.com', StartDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(1).day(), 13, 0, 0), EndDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(1).day(), 14, 0, 0));
        //30 minute call event
        Event event3 = new Event(Subject=getContact1.Name + ': 30 Minute Phone Call (' + getContact1.Advisor__r.Name + ')', Description='cschorn01@gmail.com', StartDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().day(), 13, 0, 0), EndDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(1).day(), 14, 0, 0));
        //15 minute call event
        Event event4 = new Event(Subject=getContact1.Name + ': 15 Minute Phone Call (' + getContact1.Advisor__r.Name + ')', Description='cschorn01@gmail.com', StartDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().day(), 13, 0, 0), EndDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(1).day(), 14, 0, 0));
        insert event1;
        insert event2;
        insert event3;
        insert event4;

        //eertc = Event Email Reminder To Contact
        eventEmailReminderToContact eertc = new eventEmailReminderToContact();
        Id eertcBatchId = Database.executeBatch(eertc, 5);

    }

}
