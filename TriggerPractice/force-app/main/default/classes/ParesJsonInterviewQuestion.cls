

public class AccountWrapper {
    public Class Account Data{
        public string accountId;
        public string accountId;
        public String accountName;
        public String accountType;
        public String industry;
        public Decimal annualRevenue;
        public Integer numberOfEmployees;
        public Boolean isActive;
        public String rating;
        public Datetime createdDate;
        public Datetime lastModifiedDate;
        public BillingAddressWrapper billingAddress;
        public String website;
        public String phone;
        public String description;

        public class BillingAddressWrapper {
            public String street;
            public String city;
            public String state;
            public String postalCode;
            public String country;
        }


    }
    String jsonString='{
  "accountData": {
    "accountId": "0013000001ABC123",
    "accountName": "Acme Corporation",
    "accountType": "Customer - Direct",
    "industry": "Technology",
    "annualRevenue": 5000000,
    "numberOfEmployees": 250,
    "isActive": true,
    "rating": "Hot",
    "createdDate": "2024-01-15T10:30:00.000Z",
    "lastModifiedDate": "2024-08-20T14:45:30.000Z",
    "billingAddress": {
      "street": "123 Main Street",
      "city": "San Francisco",
      "state": "CA",
      "postalCode": "94105",
      "country": "USA"
    },
    "website": "https://www.acme-corp.com",
    "phone": "+1-555-123-4567",
    "description": "Leading technology company specializing in enterprise solutions"
  }
}';
    Account parsedData= (AccountWrapper) JSON.deserialize(jsonString,AccountWrapper.class);
    system.debug(parsedData.accountData.accountName);
    system.debug(parsedData.accountData.billingAddress.city);
}

//Serialize Apex->JSON String

Account acc= new Account(NAme='Test',Industry='Technology',Phone='1234567890');
String jsonStrng= JSON.Serialize(acc);