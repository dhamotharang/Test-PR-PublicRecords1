EXPORT Layouts := MODULE;
	 
	export CorpActionsLayoutIn	:= record 
		 string    ActionNumber{xpath('ActionNumber')};											  
		 string    AcctNumber{xpath('AcctNumber')};													  
		 string    FilingDateTime{xpath('FilingDateTime')}; 								
		 string    ExecutedDate{xpath('ExecutedDate')}; 										
		 string    EffectiveDate{xpath('EffectiveDate')};										
		 string    FilerClientName{xpath('FilerClientName')};								
		 string    DocumentNumber{xpath('DocumentNumber')};									
		 string    NumberOfPages{xpath('NumberOfPages')};										
		 string    AddedDate{xpath('AddedDate')};														
		 string    UpdatedDate{xpath('UpdatedDate')};												
		 string    FilingTypeId{xpath('FilingType/Id')};										
		 string    FilingTypeDescription{xpath('FilingType/Description')};	
		 string    BusTypeId{xpath('BusinessType/Id')};											
		 string    BusTypeDescription{xpath('BusinessType/Description')};		
		 string    TaxPayment{xpath('TaxPayment')};													
		 string		 TaxReportNumber{xpath('TaxReportNumber')};									
		 string		 TaxReceiptDate{xpath('TaxReceiptDate')};									
		 string    Fees{xpath('Fees')};																			
	end;

	export CorpOfficersLayoutIn	:= record
		 string    Id{xpath('Id')};																					
		 string    AcctNumber{xpath('AcctNumber')};													
		 string    DateTakingOffice{xpath('DateTakingOffice')};							
		 string    PositionHeld{xpath('PositionHeld')};											
		 string 	 FirstName{xpath('FirstName')};														
		 string 	 MiddleName{xpath('MiddleName')};													
		 string 	 LastName{xpath('LastName')};															
		 string 	 SoundexName{xpath('SoundexName')};												
		 string 	 OfcrStreetAddress1{xpath('Address/StreetAddress1')};			
		 string 	 OfcrStreetAddress2{xpath('Address/StreetAddress2')};			
		 string 	 OfcrCity{xpath('Address/City')};													
		 string 	 OfcrState{xpath('Address/State')};												
		 string 	 OfcrZipcode{xpath('Address/Zipcode')};										
		 string 	 OfcrCountyCode{xpath('Address/CountyCode')};								
		 string 	 OfcrCountryCode{xpath('Address/CountryCode')};						
		 string 	 FilingDateTime{xpath('FilingDateTime')};									
		 string 	 YearOutReported{xpath('YearOutReported')};								
	end;
	
	export CorpEntityLayoutIn	:= Record
		 string    AcctNumber{xpath('AcctNumber')};																							
		 string    FilingDateTime{xpath('FilingDateTime')};																			
		 string    CorpType{xpath('CorpType')};																							
		 string    CorpStateName{xpath('CorpStateName')};																		
		 string    ForgnCorpName{xpath('ForgnCorpName')};																		
		 string    Status{xpath('Status')};																									
		 string    Duration{xpath('Duration')};																							
		 string    ExpirationDate{xpath('ExpirationDate')};																	
		 string    StreetAddress1{xpath('Address/StreetAddress1')};													  
		 string    StreetAddress2{xpath('Address/StreetAddress2')};													  
		 string    City{xpath('Address/City')};																							 
		 string    State{xpath('Address/State')};																						  
		 string    Zipcode{xpath('Address/Zipcode')};																				  
		 string    CountyCode{xpath('Address/CountyCode')};																	 
		 string    CountryCode{xpath('Address/CountryCode')};																  
		 string    QualifyingState{xpath('QualifyingState')};																
		 string    DateIncorp{xpath('DateIncorp')};																					
		 string 	 NonProfitMembers{xpath('NonProfitMembers')};															  
		 string    NonProfitBenefit{xpath('NonProfitBenefit')};															  
		 string    RegAgentID{xpath('RegAgentID')};																					
		 string    DO_StreetAddress1{xpath('DesignatedOffice/StreetAddress1')};		               
		 string    DO_StreetAddress2{xpath('DesignatedOffice/StreetAddress2')};		               
		 string    DO_City{xpath('DesignatedOffice/City')};												              
		 string    DO_State{xpath('DesignatedOffice/State')};											               
		 string    DO_Zipcode{xpath('DesignatedOffice/Zipcode')};									               
		 string    DO_CountyCode{xpath('DesignatedOffice/CountyCode')};						               
		 string    DO_CountryCode{xpath('DesignatedOffice/CountryCode')};					               
		 string    AssociatedAcctNumber{xpath('AssociatedAcctNumber')};											
		 string    NatureOfBusiness{xpath('NatureOfBusiness')};															
		 string    LawPractice{xpath('LawPractice')};																				  
		 string    Name{xpath('Name')};																											
		 string    CorpModNameFlag{xpath('CorpModNameFlag')};																  
		 string    FarmExemptionCategory{xpath('FarmExemptionCategory')};										
		 string    TotalShareValue{xpath('TotalShareValue')};																  
		 string    TradeApplicantType{xpath('TradeApplicantType')};													  
		 string    OwnerName{xpath('OwnerName')};																						 
		 string    IsForeign{xpath('IsForeign')};																						  
	end;
		
	export RegisteredAgentLayoutIn	:= record
		 string    RegAgentName{xpath('RegAgentName')};					
		 string    FirstName{xpath('FirstName')};								  
		 string    LastName{xpath('LastName')};									  
		 string    IndivEntity{xpath('IndivEntity')};						  
		 string    RAStreetAddress1{xpath('Address/StreetAddress1')};	 
		 string    RAStreetAddress2{xpath('Address/StreetAddress2')};	 
		 string    RACity{xpath('Address/City')};									  
		 string    RAState{xpath('Address/State')}; 							  
		 string    RAZipcode{xpath('Address/Zipcode')}; 					  
		 string    RACountyCode{xpath('Address/CountyCode')};			  
		 string    RACountryCode{xpath('Address/CountryCode')}; 	  
		 string    AcctNumber{xpath('AcctNumber')};							
		 string    CorporationType{xpath('CorporationType')};		  
		 string		 AgentId{xpath('AgentId')}; 									  
		 string    EntityNumber{xpath('EntityNumber')};					 
		 string    BusinessName{xpath('BusinessName')};					  
	end;


// Vendor Lookup Table Files

	export CorpTypeLayoutIn := record
		string  	Id{xpath('Id')};
		string    Description{xpath('Description')};
	end;
	
	export CountryCodesLayoutIn := record
		string 		Code{xpath('Code')};
		string 		Description{xpath('Description')};
	end;

	export ListOfStatesLayoutIn := record
		string 		Id{xpath('Id')};
		string 		StateCodeID{xpath('StateCodeID')};
		string    StateCode{xpath('StateCode')};
		string    Description{xpath('Description')};
	end;
	
	// Vendor sends this file, but CorpActions already contains this info.
	// The Corp2.NE mapper doesn't use the FilingType file, but leaving this in place in case we need it later	
	// export FilingTypeLayoutIn := record
		// string  	Id{xpath('Id')};
		// string    Description{xpath('Description')};
	// end;

	// Vendor sends this file, but CorpOfficers already contains this info.
	// The Corp2.NE mapper doesn't use the PositionHeld file, but leaving this in place in case we need it later
	// export PositionHeldLayoutIn := record
		// string 		Id{xpath('Id')}; 
		// string    Description{xpath('Description')};
		// string    EntityTypeId{xpath('EntityTypeId')};
		// string    EntityType{xpath('EntityType')};
	// end;

	
// Temporary Layouts
		
	export	jsonInputLayout := record 	
	  string jsonData;  
  end;
	
	export Temp_OfficersWithEntity	:= record
			CorpOfficersLayoutIn;
			CorpEntityLayoutIn;
	end;
	
	export Temp_CorpEntityWithRA := record 
		CorpEntityLayoutIn;			
		RegisteredAgentLayoutIn;		
		string CorpTypeCode;
		string StDesc;
		string CntryDesc;
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
