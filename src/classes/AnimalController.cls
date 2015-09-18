public with sharing class AnimalController {

     public String message {get;set;}
     public String SelectedAnimalType {get;set;}	// like cat, dog
     public String SelectedName {get;set;}
     public String opMessage {get;set;}				// the save msg
     public Animals__c dummya;

     public selectOption SelectedRecordType {get;set;} 	// selected value of herbivore, carnivore
     public List<selectOption> availableRecordTypes {get {return getRecordTypes();} set;}  // the full list of herbivore, carnivore
    
    // like joey,
    // Or Ziggi. Don't forget Ziggi!! 
    public String AnimalName 
    { get { if (AnimalName == null) AnimalName = ''; return AnimalName; }
      set ;
    }
 
    // like cats, dogs, etc.
    public List<SelectOption> AnimalTypeList 
    {
        get {
                List<SelectOption> options = new List<SelectOption> ();
                Schema.DescribeFieldResult fieldResult = Animals__c.typeOfAnimal__c.getDescribe();
                
                List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                
                for( Schema.PicklistEntry f : ple)
                {
                    options.add(new SelectOption(f.getLabel(), f.getValue()));
                }
                return options;
            }
        set;
    }

    public AnimalController() {
        system.debug('IN THE CONSTRUCTOR');

        SelectedRecordType = getRecordTypes().get(0);
        message ='first msg';
        system.debug('available record types in the constructor:' + availableRecordTypes);
    }

     public void Save() {
         opMessage = 'You added name = ' + SelectedName;
         opMessage = opMessage + '.... And you selected picklist value = ' + SelectedAnimalType;
     }
     

     public Animals__c getDummya ()
        {
            if(dummya==null)
                dummya = new Animals__c (recordTypeId=SelectedRecordType.getValue());
                //dummya = new Animals__c(recordTypeId=rectypeid);
            system.debug('getting dummya:' + dummya);
            return dummya;
        }
    
     public void setDummya (Id rectypeid) {
         //dummya = new Animals__c(recordTypeId=rectypeid);
         dummya.RecordTypeId = rectypeid;
         system.debug('updating the dummya to the new type: ' + dummya);
         
     }
    
    // record type methods (herbivore/carnivore)

	public List<selectOption> getRecordTypes()
	{
    List<selectOption> rTypes = new List<selectOption>();  
    List<RecordType> recordtypes = new List<RecordType>();
    recordtypes = [Select Name FROM RecordType where SobjectType = 'Animals__c'];
    
    for (RecordType  a : recordtypes)
            {
                rTypes.add(new selectOption(a.Id, a.Name ));
            }
    system.debug('getting record types' + rTypes);
    return rTypes; 
}
     

    public pageReference updateDummya ()
   {
       
       system.debug ('IN UPDATE DUMMAYA: selected record type:' + SelectedRecordType);
       Id i = SelectedRecordType.getValue();
       system.debug('recordtype id: ' + i );
       setdummya(i);
       system.debug('ssssssssssssssssssssssssssss');
       message = 'hi from here';

       return Null;
   }
}