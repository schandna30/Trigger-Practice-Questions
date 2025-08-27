public with sharing class WrapperClassSyntax {
    public Account acc{get; set;}
    public bollean isselected{get;set;}

    public WrapperClassSyntax(Account a) {
        this.acc=a;
        this.isselected=true;

    }
    public static void demoMethod(){
        List<AccountWrapper> wrapper = new List<AccountWrapper>();
        List<Account> accList= [select id , name from Account Limit 5];
        //add these accounts to wrapper list
        for(Account acc: accList){
            wrapper.add(new AccountWrapper(acc));
        }
        //now wrappper has 5 wrapper objects
        // we can use it to show fields from diffrent objects 
        //combine diffren data types as well.
    }
}