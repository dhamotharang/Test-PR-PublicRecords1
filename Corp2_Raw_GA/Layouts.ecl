EXPORT Layouts := MODULE

	EXPORT CorporationLayoutIn := RECORD,MAXLENGTH(1000)

		STRING ControlNumber;								
		STRING BizEntityId;								
		STRING BusinessName;		
		STRING BusinessTypeDesc;										
		STRING CommencementDate;						
		STRING EffectiveDate;								
		STRING IsPerpetual;									
		STRING EndDate;											
		STRING ForeignState;								
		STRING ForeignCountry;							
		STRING ForeignDateOfOrganization;		
		STRING EntityStatusDate;	
		STRING EntityStatus;								
		STRING RegisteredAgentId;						
		STRING GoodStanding;								
		STRING PrimaryPhone;								
		STRING EmailAddress;	

	END;

	EXPORT CorporationLayoutBase := RECORD, MAXLENGTH(1000)

		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		CorporationLayoutIn;

	END;

	EXPORT RAgentLayoutIn := RECORD,MAXLENGTH(1000)

		STRING RegisteredAgentId;					
		STRING Name;												
		STRING CommercialRa;								
		STRING Line1;												
		STRING Line2;												
		STRING Line3;											
		STRING Line4;												
		STRING City;												
		STRING State;												
		STRING Zip;													
		STRING PhoneNumber;									
		STRING Email;												
		STRING CountyName;									
		STRING Country;

	END;

	EXPORT RAgentLayoutBase := RECORD, MAXLENGTH(2048)

		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		RAgentLayoutIn;

	END;

	EXPORT OfficerLayoutIn := RECORD,MAXLENGTH(1000)

		STRING ControlNumber;
		STRING Description;
		STRING FirstName;									
		STRING MiddleName;								
		STRING LastName;										
		STRING CompanyName;									
		STRING Line1;												
		STRING Line2;												
		STRING City;												
		STRING State;												
		STRING Zip;													
		STRING FileNumber;
		STRING BizEntityId;			
	END;

	EXPORT OfficerLayoutBase := RECORD,MAXLENGTH(1000)
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		OfficerLayoutIn;
	END;

	EXPORT AddressLayoutIn := RECORD,MAXLENGTH(1000)
		STRING BizEntityId;									
		STRING ControlNumber;								
		STRING StreetAddr1;												
		STRING StreetAddr2;			
		STRING City;											
		STRING State;												
		STRING Zip;													
		STRING Country;										
	END;

	EXPORT AddressLayoutBase := RECORD,MAXLENGTH(1000)
		STRING1		 action_flag;
		UNSIGNED4	 dt_first_received;
		UNSIGNED4	 dt_last_received;			
		AddressLayoutIn;
	END;

	EXPORT StockLayoutIn := RECORD,MAXLENGTH(1000)
		STRING BizEntityId;									
		STRING StockType;									
		STRING Label;											
		STRING Quantity;									
		STRING ShareValue;								
		STRING FileNumber;
	END;

	EXPORT StockLayoutBase := RECORD,MAXLENGTH(1000)
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		StockLayoutIn;
	END;

	EXPORT filingLayoutIn := RECORD,MAXLENGTH(1000)
		STRING ControlNumber;								
		STRING FileNumber;	
		STRING BusinessTypeDesc;	
		STRING Description;			
		STRING FiledDate;										
		STRING BizEntityId;	
	END;

	EXPORT filingLayoutBase := RECORD,MAXLENGTH(1000)
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received; 
		filingLayoutIn;
	END;

	EXPORT TempCorpAddrLayoutIn:= RECORD
		CorporationLayoutIn;
		addressLayoutIn -BizEntityId -ControlNumber;
	END;

	EXPORT TempCorpAddrAgentLayoutIn:= RECORD
		TempCorpAddrLayoutIn;
		STRING Name;												
		STRING CommercialRa;								
		STRING ra_Line1;											
		STRING ra_Line2;												
		STRING ra_Line3;												
		STRING ra_Line4;												
		STRING ra_City;												
		STRING ra_State;												
		STRING ra_Zip;													
		STRING PhoneNumber;								
		STRING Email;												
		STRING CountyName;									
		STRING ra_Country;
	END;

	EXPORT TempCorpOfficerLayoutIn:= RECORD
		CorporationLayoutIn;
		OfficerLayoutIn -BizEntityId;
	END;

	EXPORT TempCorpOfficer_Titles := RECORD
		TempCorpOfficerLayoutIn;
		STRING Title1;
		STRING Title2;
		STRING Title3;
		STRING Title4;
		STRING Title5;
		STRING Title6;
		STRING Title7;
		STRING Title8;
		STRING Title9;
		STRING Title10;
	END;

	EXPORT TempCorpStockLayoutIn:= RECORD
		corporationLayoutIn;
		stockLayoutIn -BizEntityId ;
	END;

	EXPORT TempCorpFilingLayoutIn:= RECORD
		corporationLayoutIn;
		FilingLayoutIn -BizEntityId ;
	END;
	
END;