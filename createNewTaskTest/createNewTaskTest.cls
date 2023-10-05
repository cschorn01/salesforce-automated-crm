@isTest
public class createNewTaskTest {

    @isTest static void startingcreateNewTaskTest(){

        User owner = [SELECT Id
                      FROM User
                      WHERE Name = 'Chris Schorn'];

        Contact attendee = new Contact(LastName='Test1', Advisor__c=owner.Id, Assistant__c=owner.Id);

        createNewTask.creatingNewTask(attendee, System.Date.today().addDays(1), False, System.Datetime.now().time().addHours(10), 'Test1', 'Test1', 'Test1', True, False);
        createNewTask.creatingNewTask(attendee, System.Date.today().addDays(1), True, System.Datetime.now().time().addHours(10), 'Test2', 'Test2', 'Test2', True, False);
        createNewTask.creatingNewTask(attendee, System.Date.today().addDays(1), False, System.Datetime.now().time().addHours(10), 'Test2', 'Test2', 'Test2', False, True);
        createNewTask.creatingNewTask(attendee, System.Date.today().addDays(1), True, System.Datetime.now().time().addHours(10), 'Test2', 'Test2', 'Test2', False, True);
    }

}
