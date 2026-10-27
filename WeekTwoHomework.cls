public with sharing class WeekTwoHomework {

    // A method that includes a query for a list of Contacts and includes the Account Name and Industry as well. 
    // Use a loop to print the name of each contact's Account Name with System.debug  
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

    
    // A method that includes a query for a list of Accounts AND includes all their closed-won opportunities in a subquery.
    // Use a loop to print out the name of each Account's opportunity with System.debug
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
    
    // A method that queries for Opportunity records that returns results in a map format.
    public static Map<Id, Opportunity> returnOpportunityMap() {
        //returns all standard fields as fields were not specified, and fields(all) is limited to max 200 records
        return new Map<Id, Opportunity>([SELECT FIELDS(ALL) FROM Opportunity LIMIT 100]);
    }

    // An aggregate results query that returns an integer equal to the total number of open opportunities in your org.
    public static Integer returnCountOfOpportunities() {
        //query optimised to avoid nulls and 'not'
        return [SELECT COUNT() FROM Opportunity WHERE isClosed = false];
    }
}
