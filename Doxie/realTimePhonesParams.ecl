IMPORT  AutoStandardI, Gateway;

EXPORT realTimePhonesParams := MODULE
	EXPORT searchParams := INTERFACE
		EXPORT UNSIGNED1 DPPAPurpose := 0;
		EXPORT UNSIGNED1 GLBPurpose := 0;
		EXPORT STRING32  ApplicationType := '';
		EXPORT STRING5   IndustryClass := '';
		EXPORT STRING6   SSNMask := '';
		EXPORT STRING6   DOBMasK := '';
		EXPORT STRING11  SSN := '';
		EXPORT STRING30  LastName := '';
		EXPORT STRING 	 DataPermissionMask := AutoStandardI.Constants.DataPermissionMask_default;
		EXPORT STRING  	 DataRestrictionMask := AutoStandardI.Constants.DataRestrictionMask_default; 
		EXPORT BOOLEAN   isFCRA_val := FALSE;
		EXPORT DATASET (Gateway.Layouts.Config) Gateways := DATASET([], Gateway.Layouts.Config);
	END;
END;

