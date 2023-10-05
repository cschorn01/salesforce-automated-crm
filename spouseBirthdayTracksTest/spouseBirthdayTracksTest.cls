@isTest
private class spouseBirthdayTracksTest {

    @isTest static void startingSpouseBirthdayTracksTest(){
        User temp = [SELECT Id From User WHERE Name = 'Chris Schorn'];
        Contact client1 = new Contact(Spouse_Last_Name__c='1', Spouse_Birthday__c=System.Date.today(), Contact_Rating__c='A+', Spouse_Email__c='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable');
        Contact client2 = new Contact(Spouse_Last_Name__c='2', Spouse_Birthday__c=System.Date.today(), Contact_Rating__c='A', Spouse_Email__c='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable');
		Contact client3 = new Contact(Spouse_Last_Name__c='3', Spouse_Birthday__c=System.Date.today(), Contact_Rating__c='B', Spouse_Email__c='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable');
		Contact client4 = new Contact(Spouse_Last_Name__c='4', Spouse_Birthday__c=System.Date.today(), Contact_Rating__c='C', Spouse_Email__c='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable');
        Contact client5 = new Contact(Spouse_Last_Name__c='5', Spouse_Birthday__c=System.Date.today().addDays(5), Contact_Rating__c='A+', Spouse_Email__c='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable');
        Contact client6 = new Contact(Spouse_Last_Name__c='6', Spouse_Birthday__c=System.Date.today().addDays(5), Contact_Rating__c='A', Spouse_Email__c='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable');
        Contact client7 = new Contact(Spouse_Last_Name__c='7', Spouse_Birthday__c=System.Date.today().addDays(5), Contact_Rating__c='B', Spouse_Email__c='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable');
        Contact client8 = new Contact(Spouse_Last_Name__c='8', Spouse_Birthday__c=System.Date.today().addDays(5), Contact_Rating__c='C', Spouse_Email__c='cschorn01@gmail.com', Advisor__c=temp.Id, Assistant__c=temp.Id, Portable_Phone__c='4845612027', Preferred_Phone__c='Portable');
        insert client1;
        insert client2;
        insert client3;
        insert client4;
        insert client5;
        insert client6;
        insert client7;
        insert client8;

        //spouseBirthdayTracks.performingSpouseBirthdayOperations();
        spouseBirthdayTracks sbday = new spouseBirthdayTracks();
        Id sbdayBatchId = Database.executeBatch(sbday, 10);
    }

}
