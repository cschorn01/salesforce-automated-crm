public class getPreferredPhoneNumber {

    public static String gettingPreferredPhoneNumber(Contact preferredPhoneType){
        if(preferredPhoneType.Preferred_Phone__c == 'Home'){
            return preferredPhoneType.Home_Phone__c;
        }
        else if(preferredPhoneType.Preferred_Phone__c == 'Business'){
            return preferredPhoneType.Business_Phone__c;
        }
        else if(preferredPhoneType.Preferred_Phone__c == 'Portable'){
            return preferredPhoneType.Portable_Phone__c;
        }
        else{
            if(preferredPhoneType.Home_Phone__c != Null){
                return preferredPhoneType.Home_Phone__c;
            }
            else if(preferredPhoneType.Business_Phone__c != Null){
                return preferredPhoneType.Business_Phone__c;
            }
            else if(preferredPhoneType.Portable_Phone__c != Null){
                return preferredPhoneType.Portable_Phone__c;
            }
            else{
                return 'Contact does not have a number in our system';
            }
        }
    }

}
