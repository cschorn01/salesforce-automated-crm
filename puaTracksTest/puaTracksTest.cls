@isTest
public class puaTracksTest {

    @isTest static void startingPuaTracksTest(){
        User temp = [SELECT Id, Name From User WHERE Name = 'Chris Schorn'];

        Contact client1 = new Contact(FirstName='JJ', LastName='Watt', Next_Pua__c=System.Date.today(), Contact_Rating__c='A+', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable', PUA_Scheduling_Active__c=False);
        Contact client2 = new Contact(FirstName='Lamar', LastName='Odom', Next_Pua__c=System.Date.today().addDays(60), Contact_Rating__c='A', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable', PUA_Scheduling_Active__c=True);
		Contact client3 = new Contact(FirstName='Mariah', LastName='Carey', Next_Pua__c=System.Date.today().addDays(-20), Contact_Rating__c='B', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable', PUA_Scheduling_Active__c=True, PUA_Frequency__c='Monthly');
		Contact client4 = new Contact(FirstName='Adam', LastName='Sandler', Next_Pua__c=System.Date.today().addDays(-20), Contact_Rating__c='B', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable', PUA_Scheduling_Active__c=True, PUA_Frequency__c='Quarterly');
        Contact client5 = new Contact(FirstName='David', LastName='Spade', Next_Pua__c=System.Date.today().addDays(-20), Contact_Rating__c='B', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable', PUA_Scheduling_Active__c=True, PUA_Frequency__c='Semi-Annual');
        Contact client6 = new Contact(FirstName='Tom', LastName='Brady', Next_Pua__c=System.Date.today().addDays(-20), Contact_Rating__c='B', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable', PUA_Scheduling_Active__c=False, PUA_Frequency__c='Annual');
        Contact client7 = new Contact(FirstName='Shaquille', LastName='Oneal', Contact_Rating__c='B', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable', PUA_Scheduling_Active__c=True, PUA_Frequency__c='Annual');
        insert client1;
        insert client2;
        insert client3;
        insert client4;
        insert client5;
        insert client6;
        insert client7;

        Contact contact3 =[SELECT Id, Name, Advisor__r.Name from Contact where Name='Mariah Carey'];
        Contact contact4 =[SELECT Id, Name, Advisor__r.Name from Contact where Name='Adam Sandler'];
        Contact contact5 =[SELECT Id, Name, Advisor__r.Name from Contact where Name='David Spade'];
        Contact contact6 =[SELECT Id, Name, Advisor__r.Name from Contact where Name='Tom Brady'];

        Event event1 = new Event(Subject=contact3.Name + ': Portfolio Review (' + contact3.Advisor__r.Name + ')', StartDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(5).day(), 13, 0, 0), EndDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(5).day(), 14, 0, 0));
        Event event2 = new Event(Subject=contact4.Name + ': Portfolio Review (' + contact4.Advisor__r.Name + ')', StartDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(5).day(), 13, 0, 0), EndDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(5).day(), 14, 0, 0));
        Event event3 = new Event(Subject=contact5.Name + ': Portfolio Review (' + contact5.Advisor__r.Name + ')', StartDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(5).day(), 13, 0, 0), EndDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(5).day(), 14, 0, 0));
        Event event4 = new Event(Subject=contact6.Name + ': Portfolio Review (' + contact6.Advisor__r.Name + ')', StartDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(5).day(), 13, 0, 0), EndDateTime=System.Datetime.newInstance(System.Date.today().year(), System.Date.today().month(), System.Date.today().addDays(5).day(), 14, 0, 0));
        insert event1;
        insert event2;
        insert event3;
        insert event4;

        //puaTracks.startingPuaTracks();
        puaTracks puat = new puaTracks();
		Id puatBatchId = Database.executeBatch(puat, 10);

    }

}
