IMPORT Corp2_Mapping;
EXPORT Layouts := MODULE

  EXPORT AssumedNamedLayoutIn := RECORD
		STRING9   EntityID;
		STRING175 AssumedName;
		STRING8   FiledOn;
		STRING8   ExpiresOn;
		STRING8   RenewedOn;
		STRING1   Active;
		//STRING1   UpdateType;  //Only exists in an Update
	END;
  	
	EXPORT CorporationLayoutIn				:= RECORD
		STRING9   EntityID;
		STRING6   LegacyID;
		STRING175 EntityName;
		STRING4   EntityType;
		STRING8   IncDate;
		STRING1   Perpetual;
		STRING8   DateDissolved;
		STRING15  Act1;
		STRING15  Act2;
		STRING15  Act3;
		STRING175 AgentName;
		STRING55  AgentAddr1;
		STRING55  AgentAddr2;
		STRING30  AgentCity;
		STRING2   AgentState;
		STRING3   AgentCountry;
		STRING15  AgentPostalCode;
		STRING55  MailingAddr1;
		STRING55  MailingAddr2;
		STRING30  MailingCity;
		STRING2   MailingState;
		STRING3   MailingCountry;
		STRING15  MailingPostalCode;
		STRING4   LastAnnRptYear;
		STRING50  Purpose;
		STRING3   AssumedNamesCnt;
		STRING2   IncorporatedInState;
		STRING3   IncorporatedInCountry;
		STRING8   InactiveDate;
		STRING1   Active;
		STRING4   InactiveType;
		STRING15  TotalShares;
		//STRING1   UpdateType;  //Only exists in an Update
	END;
	
	EXPORT HistoryLayoutIn := RECORD
		STRING9   EntityID;
		STRING2   HistoryCode;
		STRING255 ChangeDesc;
		STRING8   FiledOn;
		//STRING1   UpdateType;  //Only exists in an Update
	END;
	
	EXPORT GeneralPartnerLayoutIn := RECORD
		STRING9   EntityID;
		STRING175 Name;
		STRING55  Addr1;
		STRING55  Addr2;
		STRING30  City;
		STRING2   State;
		STRING3   Country;
		STRING15  PostalCode;
		//STRING1   UpdateType;  //Only exists in an Update
	END;
	
	EXPORT LLCLayoutIn := RECORD
		STRING9   EntityID;
		STRING6   LegacyID;
		STRING175 EntityName;
		STRING4   EntityType;
		STRING8   FormationDate;
		STRING1   Perpetual;
		STRING8   TermExpiration;
		STRING15  Act1;
		STRING15  Act2;
		STRING15  Act3;
		STRING175 AgentName;
		STRING55  AgentAddr1;
		STRING55  AgentAddr2;
		STRING30  AgentCity;
		STRING2   AgentState;
		STRING3   AgentCountry;
		STRING15  AgentPostalCode;
		STRING55  MailingAddr1;
		STRING55  MailingAddr2;
		STRING30  MailingCity;
		STRING2   MailingState;
		STRING3   MailingCountry;
		STRING15  MailingPostalCode;
		STRING50  Purpose;
		STRING3   AssumedNamesCnt;
		STRING2   OrganizedInState;
		STRING3   OrganizedInCountry;
		STRING8   InactiveDate;
		STRING1   Active;
		STRING4   InactiveType;
		STRING1   ManagedBy;
		//STRING1   UpdateType;  //Only exists in an Update
	END;
  
  EXPORT LPLayoutIn := RECORD
		STRING9   EntityID;
		STRING6   LegacyID;
		STRING175 EntityName;
		STRING4   EntityType;
		STRING8   FormedOn;
		STRING1   Perpetual;
		STRING8   TermExpiration;
		STRING175 AgentName;
		STRING55  AgentAddr1;
		STRING55  AgentAddr2;
		STRING30  AgentCity;
		STRING2   AgentState;
		STRING3   AgentCountry;
		STRING15  AgentPostalCode;
		STRING55  OfficeAddr1;
		STRING55  OfficeAddr2;
		STRING30  OfficeCity;
		STRING2   OfficeState;
		STRING3   OfficeCountry;
		STRING15  OfficePostalCode;
		STRING3   AssumedNamesCnt;
		STRING2   FormedInState;
		STRING3   FormedInCountry;
		STRING8   InactiveDate;
		STRING1   Active;
		STRING4   InactiveType;
		STRING2   County1;
		STRING2   County2;
		STRING2   County3;
		//STRING1   UpdateType;  //Only exists in an Update
	END;
	
	EXPORT NameRegLayoutIn := RECORD
		STRING9   EntityID;
		STRING6   LegacyID;
		STRING175 Name;
		STRING55  Addr1;
		STRING55  Addr2;
		STRING30  City;
		STRING2   State;
		STRING3   Country;
		STRING15  PostalCode;
		STRING2   IncorporatedInState;
		STRING3   IncorporatedInCountry;
		STRING8   IncDate;
		STRING8   FiledOn;
		STRING8   RenewedOn;
		STRING8   ExpiresOn;
		STRING1   Active;
		//STRING1   UpdateType;  //Only exists in an Update
	END;
	
	//***********************
	//TEMPORARY LAYOUTS
	//***********************
	export Temp_CorpARHistory           := record
	  HistoryLayoutIn;
		string4 ar_year;
	end;
	
	export Temp_CorpStkHistory          := record
	  HistoryLayoutIn;
		string totalshares;
	end;
	
	export Temp_CorpGeneralPartner			:= record
		GeneralPartnerLayoutIn;
		Corp2_Mapping.LayoutsCommon.Main.Corp_legal_name;
	end;
	

end;
			