EXPORT Layouts := MODULE;
	
 
	export CorpActionLayoutIn	:= record 
	
		string ActionNumber;
		string AcctNumber;           
		string DateTimeFiled;           
		string DateTimeEntered;      
		string DateTimeEffective;     
		string FilerClientName;
		string ServiceTypeCode;       
		string DocNumber;
		string NumPages;
		string TaxPayment;
		string TaxReceiptDate;           
		string TaxReportNumber;       
		string InternalField;
		
	end;
	
	export CorpActionLayoutBase	:= Record
		
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		CorpActionLayoutIn;
		
	end;

	export CorpOfficersLayoutIn	:= record
	
		string RecID;
		string AcctNumber;              
		string YearInReported;        
		string YearOutReported;
		string PositionTitle;            
		string FirstName;            
		string MiddleInitial;         
		string LastName;          
		string LastNameSdx;			
		string OfcrAddress1;
		string OfcrAddress2;                   
		string OfcrCity;          
		string OfcrState;         
		string cntryCode;              
		string OfcrZipCode;          		    
		string FilingDateTime;           
		string Internal;
		
	end;
	
	export CorpOfficersLayoutBase	:= Record
		
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		CorpOfficersLayoutIn;
		
	end;

	export CorpEntityLayoutIn	:= Record

		string AcctNumber;               
		string AssociatedAcctNumber;      
		string ForgnCorpName;
		string ForgnModifiedName;
		string ForgnModifiedNameSdx;
		string CorpStateName;            
		string CorpModifiedName;
		string CorpModifiedNameSdx;
		string CorpModifiedNameFlag;				 
		string RegAgentID;
		string RegAgentContact;
		string CorpType;	
		string Status;     
		string UpdateNeeded;
		string Classification;       
		string FarmExemptionCategory;    
		string DateIncorp;      
		string QualifyingState;
		string Duration;
		string ExpirationDate;         
		string Name;     
		string Contact;    
		string Address1;     
		string Address2;    
		string City;
		string State;                    
		string ZipCode;
		string CountyCode;
		string CntryCode;
		string PhoneNumber;
		string FaxNumber;
		string EmailAddr;
		string NatureOfBusiness;        
		string Field33;
		string UserField2;
		string FilingDateTime;          
		string Internal;			

	end;
	
	export CorpEntityLayoutBase	:= Record
		
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		CorpEntityLayoutIn;
		
	end;
	
	export RegisterAgentLayoutIn	:= record
	
		string RegAgentID;
		string AcctNumber;
		string CorporationRepresented;
		string PickListFlag;
		string RegAgentName;            
		string RegAgentNameSdx;
		string RegAgentAddr1;     
		string RegAgentAddr2;    
		string RegAgentCity;
		string RegAgentState; 
		string RegAgentZip;
		string RegAgentCnty;
		string RegAgentPhone;
		string RegAgentFax;
		string RegAgentEmail;
		string RegAgentContact;
		string RegAgtLastUpdatedBy;
		string RegAgtDateTimeStamp;
		string RegAgtInternal;
		
	end;
	
	export RegisterAgentLayoutBase	:= Record
		
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		RegisterAgentLayoutIn;
		
	end;
		
	export Temp_CorpActionDesc := record
	
		CorpActionLayoutIn;
		string Description;
			
	end;
		
	export Temp_OfficerWithTitles	:= record
		
		CorpOfficersLayoutIn;
		string Title1;
		string Title2;
		string Title3;
		string Title4;
		string Title5;
		string Title6;
		string Title7;
		string Title8;
		string Title9;
		string Title10;
	
	end;
	
	export Temp_EntityWithOfficerTitles	:= record
	
			CorpEntityLayoutIn;
			Temp_OfficerWithTitles;
		
	end;
			
	export Temp_CorpEntityWithRA := record 
	
		CorpEntityLayoutIn;			
		RegisterAgentLayoutIn;		
		string CorpTypeDesc;
		string StDesc;
		string CntryDesc;
			
	end;
	
	export Lookup_FilingCode := record	
		
		string filingCode;
		string filingDesc;						
		string filingDesc2;	
			
	end;
	
	export Lookup_CorpCode := record
	
		string corpCode;
		string corpDesc;
		string corpDesc2;
		string corpDesc3;
		
	end;
	
	export Lookup_TitleCode := record	
	
		string titleCode;  
		string titleDesc;			
	
	end;	
	
	export StateTypeCodeLayout := record
	
		string stateCode;
		string stateDesc;	
		
	end;		
		  
	export CntryTypeCodeLayout := record	
	
		string cntryDesc;
		string cntryCode1;
		string cntryCode2;
		
	end;
	
end;
