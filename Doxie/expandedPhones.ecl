import AutoStandardI, Doxie_Raw, Gateway;
EXPORT expandedPhones := MODULE
	EXPORT searchParams := INTERFACE
		EXPORT UNSIGNED1 DPPAPurpose := 0;
		EXPORT UNSIGNED1 GLBPurpose := 0;
		EXPORT STRING32  ApplicationType := '';
		EXPORT STRING5   IndustryClass := '';
		EXPORT STRING14  DID := '';
		EXPORT STRING11  SSN := '';
		EXPORT STRING120 UnParsedFullName := '';
		EXPORT STRING30  FirstName := '';
		EXPORT STRING30  MiddleName := '';
		EXPORT STRING30  LastName := '';
		EXPORT STRING4   NameSuffix := '';
		EXPORT STRING200 Addr := '';
		EXPORT STRING10  PrimRange := '';
		EXPORT STRING2   PreDir := '';
		EXPORT STRING30  PrimName := '';
		EXPORT STRING4   Suffix := '';
		EXPORT STRING2   PostDir := '';
		EXPORT STRING10  SecRange := '';
		EXPORT STRING25  City := '';
		EXPORT STRING2   State := '';
		EXPORT STRING6   Zip := '';
		EXPORT string30  County := '';
		EXPORT STRING15  Phone := '';
		EXPORT BOOLEAN   IncludeLastResort := FALSE;
		EXPORT BOOLEAN   IncludeDeadContacts := FALSE;
	  EXPORT STRING  DataPermissionMask := AutoStandardI.Constants.DataPermissionMask_default; 
	  EXPORT DATASET (Gateway.Layouts.Config) Gateways_In := dataset([], Gateway.Layouts.Config);
		EXPORT STRING    _TransactionId := '';
	END;

	EXPORT soap_response_layout :=  RECORD
		Doxie_Raw.PhonesPlus_Layouts.preFinalLayout;
	END;	

	EXPORT in_layout := RECORD
		UNSIGNED1 DPPAPurpose := 0;
		UNSIGNED1 GLBPurpose := 0;
		STRING14  DID := '';
		STRING11  SSN := '';
		STRING120 UnParsedFullName := '';
		STRING30  FirstName := '';
		STRING30  MiddleName := '';
		STRING30  LastName := '';
		STRING4   NameSuffix := '';
		STRING200 Addr := '';
		STRING10  PrimRange := '';
		STRING2   PreDir := '';
		STRING30  PrimName := '';
		STRING4   Suffix := '';
		STRING2   PostDir := '';
		STRING10  SecRange := '';
		STRING25  City := '';
		STRING2   State := '';
		STRING6   Zip := '';
		string30	County := '';		
		STRING15  Phone := '';
		boolean 	IncludeLastResort := false;
		boolean 	IncludeDeadContacts := false;
	  STRING  DataPermissionMask := AutoStandardI.Constants.DataPermissionMask_default;
		DATASET (Gateway.Layouts.Config) Gateways := dataset([], Gateway.Layouts.Config);
		STRING 		_TransactionId := '';
		boolean		_Blind := false;
	END;
END;