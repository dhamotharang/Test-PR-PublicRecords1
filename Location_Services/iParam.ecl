IMPORT AutoStandardI;

EXPORT iParam :=
MODULE

	EXPORT PropHistHRI :=
	INTERFACE(AutoStandardI.DataRestrictionI.params,AutoStandardI.DataPermissionI.params)
		EXPORT BOOLEAN   AllowAll            := FALSE;
		EXPORT BOOLEAN   AllowGLB            := FALSE;
		EXPORT BOOLEAN   AllowDPPA           := FALSE;
		EXPORT UNSIGNED1 GLBPurpose          := 0;
		EXPORT UNSIGNED1 DPPAPurpose         := 0;
		EXPORT BOOLEAN   IncludeMinors       := FALSE;
		EXPORT STRING    DataRestrictionMask := '000000000000000';
		EXPORT STRING    DataPermissionMask  := AutoStandardI.Constants.DataPermissionMask_default;
		EXPORT BOOLEAN   IgnoreFares         := FALSE;
		EXPORT BOOLEAN   IgnoreFidelity      := FALSE;
		EXPORT STRING6   SSNMask             := '';
		EXPORT STRING6   DOBMask             := '';
		EXPORT BOOLEAN   LNBranded           := FALSE;
		EXPORT STRING32  ApplicationType     := '';
		EXPORT STRING5   IndustryClass       := '';
	END;

END;