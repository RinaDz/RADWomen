public with sharing class WeekTwoHomework {
    public static void queryForListOfContacts() {
        List<Contact> contactList = [
            SELECT ID, Name, Account.Name, Account.Industry
            FROM Contact
        ];

        for (Contact c : contactList) {
            System.debug(
                'Contact Name: ' +
                c.Name +
                ' | Account Name: ' +
                c.Account.Name +
                ' | Industry: ' +
                c.Account.Industry
            );
        }   
    }

    public static void accountsWithClosedWonOpportunities() {
        //Query uses child relationship name (Note: Opportunities not Opportunity) . Returns all accounts, so if it had no close won opportunities number will be zero
        List<Account> accountList = [  
        SELECT ID, Name, (SELECT ID, Name FROM Opportunities WHERE StageName = 'Closed Won')
            FROM Account
        ];

        for (Account a : accountList) {
            System.debug('Account Name: ' + a.Name + ' | Opportunities: ' + a.Opportunities);
        }

    }
    
    public static Map<Id, Opportunity> returnOpportunityMap() {
        //returns all standard fields as fields were not specified, and fields(all) is limited to max 200 records
        return new Map<Id, Opportunity>([SELECT FIELDS(STANDARD) FROM Opportunity]);
    }

    public static Integer returnCountOfOpportunities() {
        //query optimised to avoid nulls and 'not'
        return [SELECT COUNT() FROM Opportunity WHERE StageName NOT IN ('Closed Won', 'Closed Lost')];
    }
}
