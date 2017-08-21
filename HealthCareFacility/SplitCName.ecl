IMPORT HealthCareProvider;
EXPORT SplitCName (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Infile) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header splitName (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header L, INTEGER C) := TRANSFORM
		SELF.CNAME	:=	ExtractString (L.CNAME,C,'DBA');
		SELF				:=	L;
	END;

	Split_CName	:=	NORMALIZE (Infile,STRINGLIB.STRINGFINDCOUNT(LEFT.CName,'DBA') + 1,splitName(LEFT,COUNTER));
	
	RETURN Split_CName (CNAME <> '');
END;