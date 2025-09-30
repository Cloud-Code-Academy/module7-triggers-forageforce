trigger AccountTrigger on Account (Before insert) {
    for(Account acc : Trigger.new)
        if (acc.Type == Null) {
        acc.Type = 'Prospect';
            if(!String.isEmpty(acc.ShippingStreet) && !String.isEmpty(acc.ShippingCity)) {
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingCity = acc.ShippingCity;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingCountry = acc.ShippingCountry;
            }
        }

}