IMPORT BIPV2_Company_Names, HealthCareProvider, ut;
EXPORT StandardizeFacilityName (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Fac_DS) := FUNCTION
	
	Split_Fac_Name	:=	HealthCareFacility.SplitCName (Fac_DS);
	
	Assign_ID	:=	PROJECT (Split_Fac_Name,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF.LNPID := COUNTER; SELF.RID := COUNTER; SELF := LEFT;));
	
	CleanFacName := PROJECT (Assign_ID(CNAME <> ''),TRANSFORM(BIPV2_Company_Names.layouts.layout_names, SELF.cnp_nameid := LEFT.RID; SELF.CNP_NAME := HealthCareFacility.Clean_Facility_Name(LEFT.CNAME);));

	CleanData := BIPV2_Company_Names.functions.go(CleanFacName,FALSE,FALSE);

	ApplyCleanData := JOIN (DISTRIBUTE(PROJECT(Assign_ID,TRANSFORM(RECORDOF(Split_Fac_Name), SELF.CNP_NAME := HealthCareFacility.Clean_Facility_Name(LEFT.CNAME); SELF := LEFT;)),HASH32(RID)),DISTRIBUTE(CleanData,HASH32(cnp_nameid)),LEFT.rid = RIGHT.cnp_nameid,
													TRANSFORM (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,
																		 SELF.CNP_nameid				:= RIGHT.CNP_nameid;
																		 SELF.CNP_name					:= if (ut.Word(LEFT.CNP_NAME,1) = 'A', LEFT.CNP_NAME,RIGHT.CNP_NAME);
																		 SELF.CNP_number				:= RIGHT.CNP_number;
																		 SELF.CNP_store_number	:= RIGHT.CNP_store_number;
																		 SELF.CNP_btype					:= RIGHT.CNP_btype;
																		 SELF.CNP_lowv					:= RIGHT.CNP_lowv;
																		 SELF.CNP_translated		:= RIGHT.CNP_translated;
																		 SELF.CNP_classid				:= RIGHT.CNP_classid;
																		 SELF := LEFT;),LEFT OUTER,LOCAL);

	RETURN ApplyCleanData;
END;
