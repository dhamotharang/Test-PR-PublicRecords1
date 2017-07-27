IMPORT AutoStandardI;

EXPORT IParams := MODULE

	EXPORT address_search := INTERFACE(AutoStandardI.DataRestrictionI.params, AutoStandardI.DataPermissionI.params)
		EXPORT UNSIGNED1 GLBPurpose          := 0;
		EXPORT UNSIGNED1 DPPAPurpose         := 0;
		EXPORT STRING32  ApplicationType     := '';
	END;
	
END;