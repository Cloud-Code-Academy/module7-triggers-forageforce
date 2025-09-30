trigger AccountTrigger on Account (Before insert, After insert) {
    List<Contact> newRelatedContacts = new List<Contact> ();
    String lastName ='DefaultContact';
    String contactEmail = 'default@email.com';

    for(Account acc : Trigger.new) {
        if (trigger.isBefore) {
            if (acc.Type == Null) {
                acc.Type = 'Prospect';
            }
            if(!String.isEmpty(acc.ShippingStreet) && !String.isEmpty(acc.ShippingCity)) {
            acc.BillingStreet = acc.ShippingStreet;
            acc.BillingCity = acc.ShippingCity;
            acc.BillingState = acc.ShippingState;
            acc.BillingPostalCode = acc.ShippingPostalCode;
            acc.BillingCountry = acc.ShippingCountry;
            }
            if(acc.Phone != Null && !String.isEmpty(acc.Website) && acc.Fax != Null) {
                acc.rating = 'Hot';
            }
        }
        if (trigger.isAfter) {
            Contact rCon = new Contact();
            rCon.LastName = lastName;
            rCon.Email = contactEmail;
            rCon.AccountId = acc.Id;
            newRelatedContacts.add(rCon);
        }
    }
    insert newRelatedContacts;
}

/*
    * Question 4
    * Account Trigger
    * When an account is inserted create a contact related to the account with the following default values:
    * LastName = 'DefaultContact'
    * Email = 'default@email.com'
    * Trigger should only fire on insert.
    */