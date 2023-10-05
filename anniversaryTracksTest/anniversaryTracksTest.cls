@isTest
public class anniversaryTracksTest {

	@isTest static void startingAnniversaryTracksTest(){
        User temp = [SELECT Id, A_Plus_Anniversary_Email__c, A_Anniversary_Email__c, B_Anniversary_Email__c,
                                C_Anniversary_Email__c, A_Plus_Anniversary_Card__c, A_Anniversary_Card__c,
                                B_Anniversary_Card__c, C_Anniversary_Card__c, A_Plus_Anniversary_Flowers__c,
                                A_Anniversary_Flowers__c, B_Anniversary_Flowers__c, C_Anniversary_Flowers__c
                     From User
                     WHERE Name = 'Chris Schorn'];

        Contact contact1 = new Contact(FirstName='LL', LastName='CoolJ', Anniversary__c=System.Date.today(), Contact_Rating__c='A+', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id);
        Contact contact2 = new Contact(FirstName='Asap', LastName='Rocky', Anniversary__c=System.Date.today(), Contact_Rating__c='A', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id);
		Contact contact3 = new Contact(FirstName='Anderson', LastName='Paak', Anniversary__c=System.Date.today(), Contact_Rating__c='B', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id);
		Contact contact4 = new Contact(FirstName='Michael', LastName='Jordan', Anniversary__c=System.Date.today(), Contact_Rating__c='C', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id);
        Contact contact5 = new Contact(FirstName='Chad', LastName='Boseman', Anniversary__c=System.Date.today().addDays(5), Contact_Rating__c='A+', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id);
        Contact contact6 = new Contact(FirstName='Robert', LastName='Downey', Anniversary__c=System.Date.today().addDays(5), Contact_Rating__c='A', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id);
        Contact contact7 = new Contact(FirstName='Clint', LastName='Eastwood', Anniversary__c=System.Date.today().addDays(5), Contact_Rating__c='B', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id);
        Contact contact8 = new Contact(FirstName='Shakari', LastName='Richards', Anniversary__c=System.Date.today().addDays(5), Contact_Rating__c='C', Email='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id);
        insert contact1;
        insert contact2;
        insert contact3;
        insert contact4;
        insert contact5;
        insert contact6;
        insert contact7;
        insert contact8;

        //anniversaryTracks.startingAnniversaryTracks();
		anniversaryTracks anni = new anniversaryTracks();
        Id anniBatchId = Database.executeBatch(anni, 10);
    }
}
