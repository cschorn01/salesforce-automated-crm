@isTest
public class getPreferredPhoneNumberTest {

    @isTest static void startingGetPreferredPhoneNumberTest(){

        Contact test1 = new Contact(LastName='1', Home_Phone__c='4845612027', Preferred_Phone__c='Home');
        Contact test2 = new Contact(LastName='2', Portable_Phone__c='4845612027', Preferred_Phone__c='Portable');
        Contact test3 = new Contact(LastName='3', Business_Phone__c='4845612027', Preferred_Phone__c='Business');
        Contact test4 = new Contact(LastName='4', Home_Phone__c='4845612027');
        Contact test5 = new Contact(LastName='5', Portable_Phone__c='4845612027');
        Contact test6 = new Contact(LastName='6', Business_Phone__c='4845612027');
        Contact test7 = new Contact(LastName='7');

        getPreferredPhoneNumber.gettingPreferredPhoneNumber(test1);
        getPreferredPhoneNumber.gettingPreferredPhoneNumber(test2);
        getPreferredPhoneNumber.gettingPreferredPhoneNumber(test3);
        getPreferredPhoneNumber.gettingPreferredPhoneNumber(test4);
        getPreferredPhoneNumber.gettingPreferredPhoneNumber(test5);
        getPreferredPhoneNumber.gettingPreferredPhoneNumber(test6);
        getPreferredPhoneNumber.gettingPreferredPhoneNumber(test7);
    }

}
