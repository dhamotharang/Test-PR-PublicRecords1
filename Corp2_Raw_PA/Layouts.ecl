IMPORT corp2_Mapping;

EXPORT Layouts := module

 // Vendor Input and Base file Layouts

  export BlobRec := RECORD  string blob;  end;

	export CorpNameLayoutIn := RECORD 
			STRING CorporationNameID;
			STRING CorporationID;
			STRING Name;
			STRING NameTypeID;
			STRING Title;
			STRING Salutation;
			STRING Prefix;
			STRING LastName;
			STRING MiddleName;
			STRING FirstName;
			STRING Suffix;
  end;

	export CorpNameLayoutBase := RECORD
			STRING1		action_flag;
			UNSIGNED4	dt_first_received;
			UNSIGNED4	dt_last_received;
			CorpNameLayoutIn;
  end;

  export AddressLayoutIn := RECORD
			STRING  AddressID;
			STRING  CorporationID;
			STRING  AddressTypeID;
			STRING  Address1;
			STRING  Address2;
			STRING  Address3;
			STRING  City;
			STRING  State;
			STRING  Zip;
			STRING  County;
			STRING  Country;
  end;
	
  export AddressLayoutBase := RECORD
			STRING1		action_flag;
			UNSIGNED4	dt_first_received;
			UNSIGNED4	dt_last_received;
			AddressLayoutIn;
  end;

	export OfficerLayoutIn := RECORD
			STRING  OfficerID ;
			STRING  CorporationID;
			STRING  Title;
			STRING  Salutation;
			STRING  Name;
			STRING  Address1;
			STRING  Address2;
			STRING  Address3;
			STRING  City;
			STRING  State;
			STRING  Zip;
			STRING  CountryName;
			STRING  OwnerPercentage;
			STRING  TransferRealEstate;
			STRING  ForeignAddress;
  end;
	
	export OfficerLayoutBase := RECORD
			STRING1		action_flag;
			UNSIGNED4	dt_first_received;
			UNSIGNED4	dt_last_received;
			OfficerLayoutIn;
  end;

  export CorporationsLayoutIn := RECORD
			STRING  CorporationID ;
			STRING  EntityID;
			STRING  CorporationTypeID ;
			STRING  CorporationStatusID;
			STRING  CorporationNumber;
			STRING  Citizenship;
			STRING  DateFormed;
			STRING  DissolveDate;
			STRING  Duration;
			STRING  CountyOfIncorporation;
			STRING  StateOfIncorporation;
			STRING  CountryOfIncorporation;
			STRING  Purpose;
			STRING  Profession;
			STRING  RegisteredAgentName;
	end;
 
	export CorporationsLayoutBase := RECORD
			STRING1		action_flag;
			UNSIGNED4	dt_first_received;
			UNSIGNED4	dt_last_received;
			CorporationsLayoutIn;
	end;

  export FilingLayoutIn := RECORD
			STRING  FilingID;
			STRING  CorporationID;
			STRING  CorporationNbr;
			STRING  DocumentTypeID;
			STRING  FilingDate;
			STRING  EffectiveDate;
  end;
	
  export FilingLayoutBase := RECORD
			STRING1		action_flag;
			UNSIGNED4	dt_first_received;
			UNSIGNED4	dt_last_received;
			FilingLayoutIn;
	end;

  export MergerLayoutIn := RECORD
			STRING  MergerID;							 
			STRING  SurvivorCorporationID; 
			STRING  MergedCorporationID; 
			STRING  MergerDate; 
  end;
	
	export MergerLayoutBase := RECORD
			STRING1		action_flag;
			UNSIGNED4	dt_first_received;
			UNSIGNED4	dt_last_received;
			MergerLayoutIn;
	end;
	
  // Vendor sends empty Stock file and mapper checks to verify it's still empty  
	export StockLayoutIn := RECORD
			STRING  StockID;
			STRING  CorporationID;
			STRING  StockClassID;
			STRING  AuthorizedShares;
			STRING  IssuedShares;
			STRING  Series;
			STRING  NPVFlag;
			STRING  ParValue;
	end;
	
	
	// Lookup File Layouts 
	export LookupLay_CorpStatus 	:= RECORD	 STRING CorpStatus;  			  STRING CorpStatusDesc; 							  end;
	export LookupLay_CorpType 		:= RECORD	 STRING CorpTypeID;  			  STRING CorpTypeDesc;  								end;
	export LookupLay_NameType 		:= RECORD	 STRING NameTypeID;  			  STRING NameTypeDesc;  								end;
	export LookupLay_AddrType 		:= RECORD	 STRING AddressTypeID;			STRING AddressTypeDesc;							  end;
	export LookupLay_PartyType 	  := RECORD	 STRING PartyTypeID; 			  STRING PartyTypeDesc; 								end;
	export LookupLay_DocType 		  := RECORD	 STRING DocTypeID;  		    STRING DocTypeDesc;  							    end;
	export LookupLay_OfficerParty := RECORD	 STRING OfficerPartyTypeID; STRING OfficerID; STRING PartyTypeID; end;
  

	// Layout for Joins and Normalize of the Corporations file  
  export jCorporations_TempLay := RECORD
	  CorporationsLayoutIn;
	  AddressLayoutIn  - corporationid;
	  CorpNameLayoutIn - corporationid;
	  MergerLayoutIn;
	 	string  CorpStatusDesc	       := '';
		string  CorpTypeDesc		       := ''; 
		string  NameTypeDesc		       := '';  
		string  AddressTypeDesc	       := ''; 	 
	end;
	
  // Layout for Joining CorpName, Corporations, and Officer for building Contact recs
	export jOfficers_TempLay := RECORD
		OfficerLayoutIn;
		string  CorpName_Name                  := '';
		string  EntityID                       := '';
		string  PartyTypeID     							 := '';
		string  PartyTypeDesc  								 := '';
  end;
	
	// Layout for Normalize for Events		
 export normFiling_layout := record
		FilingLayoutIn;
		string 	Norm_event_filing_date;
		string 	Norm_nmtyp ;
	end;
	
// Layout for Joining normFiling and Corporations		
 export jFilCorp_TempLay := record
		normFiling_Layout;
		string EntityID;
	end;	
  
end;