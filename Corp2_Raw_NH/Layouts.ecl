EXPORT Layouts := module

  	export CorporationLayoutIn 							:= Record
			string 		Businessid;                             
			string 		BusinessName;                           
			string    HomeStateName;                         
			string    BusinessStatus;                         
			string    BusinessType;                           
			string    CreationDate;                           
			string 		DateInJurisdiction;                     
			string 		Duration;                               
			string    ManagementStyle;                        
			string 		FiscalYearDate;                         
			string    CitizenStateOfInc;                      
			string    LastBenefitRptYear;                     
			string    NextBenefitRptYear;                     
			string    LastAnnRptYear;                         
			string    NextAnnRptYear;                         
			string    BusinessEmail;                          
			string 		NotificationEmail;                      
			string 		PhoneNumber;                            
		//	string 		lf;
	end;
	
	export AddressLayoutIn 									:= Record
			string 		Businessid;                             
			string 		PrinOfficeAddress;                      
			string 		PrinOfficeAddress2;                     
			string 		PrinOfficeCity;                         
			string 		PrinOfficeState;                        
			string 		PrinOfficeZip;                          
			string 		PrinOfficeCounty;                       
			string 		PrinOfficeCountry;                      
			string 		MailingAddress;                         
			string 		MailingAddress2;                        
			string 		MailingCity;                            
			string 		MailingState;                           
			string 		MailingZip;                             
			string 		MailingCounty;                          
			string 		MailingCountry;                         
			string 		lf;
	end;
		
	export FilingLayoutIn 						  		:= Record
			string 		Businessid;                             
			string 		FilingDateTime;                         
			string 		EffectiveDateTime;                          
			string 		FilingType;                             
			string 		FilingNumber;                          
			string 		lf;
	end;
		
	export PrevNamesLayoutIn 			  		:= Record
			string 		Businessid;                             
			string 		PreviousName;                           
			string 		PreviousNameType;                       
			string 		lf;
	end;
	
	export PrincipalsLayoutIn 						 	:= Record
			string 		Businessid;                             
			string 		PrincipalName;                          
			string 		PrincipalTitle;                         
			string 		PrincipalAddress;                       
			string 		PrincipalAddress2;                      
			string 		PrincipalCity;                          
			string 		PrincipalState;                         
			string 		PrincipalZip;                           
			string 		PrincipalCounty;                        
			string 		PrincipalCountry;                       
			string 		lf;
	end;

	export PrinPurposeLayoutIn 			  		    := Record
			string 		Businessid;                             
			string 		NAICSCode;                              
			string 		NAICSSubCode;                           
			string    Profession;                             
			string 		lf;
	end;
	
	export RegAgentLayoutIn 			  	      := Record
			string 		BusinessID;                             
			string 		RegAgentName;                           
			string 		RegAgentType;                          
			string 		RAPrinOfficeAddress;                      
			string 		RAPrinOfficeAddress2;                     
			string 		RAPrinOfficeCity;                         
			string 		RAPrinOfficeState;                        
			string 		RAPrinOfficeZip;                          
			string 		RAPrinOfficeCounty;                       
			string 		RAPrinOfficeCountry;                      
			string 		RAMailingAddress;                         
			string 		RAMailingAddress2;                        
			string 		RAMailingCity;                            
			string 		RAMailingState;                           
			string 		RAMailingZip;                             
			string 		RAMailingCounty;                         
			string 		RAMailingCountry;                         
			string 		lf;
	end;
	
	export StockLayoutIn 						  		:= Record
			string 		Businessid;                             
			string 		ShareClass;                             
			string 		NumberOfShares;                         
			string 		ParValue;                               
			string 		Note;                                   
//			string 		lf;
	end;
	
	/////////////////////
	//TEMPORARY LAYOUTS
	/////////////////////
	export TempCorporationLayoutIn				:= Record
		CorporationLayoutIn;
		AddressLayoutIn 				- [Businessid, lf];
		PrincipalsLayoutIn 		  - [Businessid, lf];
    PrinPurposeLayoutIn 		- [Businessid, lf];
		//RegAgentLayoutIn        - [Businessid, lf];
    string    NormBusinessName;
		string    NormBusinessTypeCode;
		string    NormFilingCode;
		string    NormDateInJurisdiction;
		string    NormRAName;
		string    NormRAType;
    string    NormRAAddressType;		
		string 		NormRAAddress;                      
		string 		NormRAAddress2;                     
		string 		NormRACity;                         
		string 		NormRAState;                        
		string 		NormRAZip;                          
    string 		NormRACountry; 
		string 		NormRACounty; 
		string    NormRAPrinCounty;
		string    NormRAPrinCountry;
	end;

  export TempFilingWithCorpLayoutIn				:= Record
		CorporationLayoutIn;	
		FilingLayoutIn					- [Businessid, lf];
		string10 FilingDate;
	end;
  
		export TempRALayoutIn				:= Record
		string    Businessid;
		string    NormRAName;
		string    NormRAType;
    string    NormRAAddressType;		
		string 		NormRAAddress;                      
		string 		NormRAAddress2;                     
		string 		NormRACity;                         
		string 		NormRAState;                        
		string 		NormRAZip;                          
    string 		NormRACountry; 
		string 		NormRACounty; 
		string    NormRAPrinCounty;
		string    NormRAPrinCountry;
	end;
end;