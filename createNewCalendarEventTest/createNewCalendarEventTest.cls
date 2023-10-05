@isTest
private class createNewCalendarEventTest {

    @isTest static void creatingNewCalendarEventTest(){

        User owner = [SELECT Id
                      FROM User
                      WHERE Name = 'Chris Schorn'];

        Contact attendee = new Contact(LastName='Test1', Advisor__c=owner.Id, Assistant__c=owner.Id);

        createNewCalendarEvent.creatingNewCalendarEvent(attendee, System.Date.today(), Time.newInstance(12, 0, 0, 0), 60, False, Time.newInstance(1, 1, 1, 1), 'Test1', 'Test1', True, False);
        createNewCalendarEvent.creatingNewCalendarEvent(attendee, System.Date.today(), Time.newInstance(12, 0, 0, 0), 60, True, Time.newInstance(11, 45, 0, 0), 'Test2', 'Test2', True, False);
        createNewCalendarEvent.creatingNewCalendarEvent(attendee, System.Date.today(), Time.newInstance(12, 0, 0, 0), 60, False, Time.newInstance(1, 1, 1, 1), 'Test3', 'Test3', False, True);
        createNewCalendarEvent.creatingNewCalendarEvent(attendee, System.Date.today(), Time.newInstance(12, 0, 0, 0), 60, True, Time.newInstance(11, 45, 0, 0), 'Test4', 'Test4', False, True);
    }

}
