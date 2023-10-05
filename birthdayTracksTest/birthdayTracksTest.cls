@isTest
private class birthdayTracksTest {

    @isTest static void startingBirthdayTracksTest(){
        User temp = [SELECT Id, A_Plus_Birthday_Email__c, A_Birthday_Email__c, B_Birthday_Email__c,
                                C_Birthday_Email__c, A_Plus_Birthday_Call__c, A_Birthday_Call__c,
								B_Birthday_Call__c, C_Birthday_Call__c, A_Plus_Birthday_Card__c,
                                A_Birthday_Card__c, B_Birthday_Card__c, C_Birthday_Card__c
                     From User
                     WHERE Name = 'Chris Schorn'];

        Contact client1 = new Contact(FirstName='jeepers', LastName='creepers', Primary_Birthday__c=System.Date.today(), Contact_Rating__c='A+', Email='cschorn01@gmail.com', Assistant__c=temp.Id, Advisor__c=temp.Id);
        Contact client2 = new Contact(FirstName='scrappy', LastName='doo', Primary_Birthday__c=System.Date.today(), Contact_Rating__c='A', Email='cschorn01@gmail.com', Assistant__c=temp.Id, Advisor__c=temp.Id);
		Contact client3 = new Contact(FirstName='scooby', LastName='doo', Primary_Birthday__c=System.Date.today(), Contact_Rating__c='B', Email='cschorn01@gmail.com', Assistant__c=temp.Id, Advisor__c=temp.Id);
		Contact client4 = new Contact(FirstName='T', LastName='Pain', Primary_Birthday__c=System.Date.today(), Contact_Rating__c='C', Email='cschorn01@gmail.com', Assistant__c=temp.Id, Advisor__c=temp.Id);
        Contact client5 = new Contact(FirstName='Danny', LastName='Trejo', Primary_Birthday__c=System.Date.today().addDays(5), Contact_Rating__c='A+', Email='cschorn01@gmail.com', Assistant__c=temp.Id, Advisor__c=temp.Id);
        Contact client6 = new Contact(FirstName='Rocky', LastName='Balboa', Primary_Birthday__c=System.Date.today().addDays(5), Contact_Rating__c='A', Email='cschorn01@gmail.com', Assistant__c=temp.Id, Advisor__c=temp.Id);
        Contact client7 = new Contact(FirstName='Bat', LastName='Man', Primary_Birthday__c=System.Date.today().addDays(5), Contact_Rating__c='B', Email='cschorn01@gmail.com', Assistant__c=temp.Id, Advisor__c=temp.Id);
        Contact client8 = new Contact(FirstName='Michael', LastName='Jordan', Primary_Birthday__c=System.Date.today().addDays(5), Contact_Rating__c='C', Email='cschorn01@gmail.com', Assistant__c=temp.Id, Advisor__c=temp.Id);
        insert client1;
        insert client2;
        insert client3;
        insert client4;
        insert client5;
        insert client6;
        insert client7;
        insert client8;

        //birthdayTracks.performingBirthdayOperations();
        birthdayTracks bday = new birthdayTracks();
        Id bdayBatchId = Database.executeBatch(bday, 10);
    }

}
