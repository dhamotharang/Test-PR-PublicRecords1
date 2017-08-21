IMPORT HealthCareFacilityHeader_Best, HealthCareProvider;

EXPORT Build_Best_Flag (STRING iter = thorlib.wuid()) := FUNCTION 
	#WORKUNIT ('NAME','Health Care Facility - Best Flag');
	#OPTION('multiplePersistInstances',FALSE);

	Initialize_Flags	:= PROJECT ( HealthCareFacility.Files.facility_Salt_Input_DS,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,  SELF.DID_FLAG := '';
																																																																															SELF.SSN_FLAG := '';	
																																																																															SELF.CNSMR_SSN_FLAG := '';
																																																																															SELF.DOB_FLAG := '';		
																																																																															SELF.CNSMR_DOB_FLAG := '';
																																																																															SELF.C_LIC_NBR_FLAG := '';
																																																																															SELF.LIC_NBR_FLAG := '';
																																																																															SELF.FNAME_FLAG := '';		
																																																																															SELF.MNAME_FLAG := '';		
																																																																															SELF.LNAME_FLAG := '';				
																																																																															SELF.CNAME_FLAG := '';	
																																																																															SELF.CNP_NAME_FLAG := '';
																																																																															SELF.TAX_ID_FLAG := '';	
																																																																															SELF.BILLING_TAX_ID_FLAG := '';
																																																																															SELF.FEIN_FLAG := '';			
																																																																															SELF.UPIN_FLAG := '';			
																																																																															SELF.NPI_NUMBER_FLAG := '';			
																																																																															SELF.BILLING_NPI_NUMBER_FLAG := '';
																																																																															SELF.DEA_NUMBER_FLAG := '';							
																																																																															SELF.CLIA_NUMBER_FLAG := '';
																																																																															SELF.TAXONOMY_FLAG := ''; 
																																																																															SELF.MEDICARE_FACILITY_NUMBER_FLAG := '';
																																																																															SELF.MEDICAID_NUMBER_FLAG := '';
																																																																															SELF.NCPDP_NUMBER_FLAG := '';
																																																																															SELF.IS_STATE_SANCTION := FALSE; 																																																																															
																																																																															SELF.IS_OIG_SANCTION := FALSE; 																																																																															
																																																																															SELF.IS_OPM_SANCTION := FALSE; 																																																																															
																																																																															SELF := LEFT));
	
	Salt_Iteration := HealthCareFacilityHeader_Best.Proc_Iterate (iter, Initialize_Flags).DoAll;
	
	Salt_Output	:=	Dataset (HealthCareFacility.Files.Facility_Salt_Output+iter,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,thor);
	
	Assign_Sanction_Flag	:=	HealthCareFacility.UpdateSanctionFlag (Salt_Output);
	
	HealthCareProvider.Mac_SF_BuildProcess(Assign_Sanction_Flag,
																					HealthCareFacility.Files.HealthCare_Prefix, 
																					HealthCareFacility.Files.Facility_out_Suffix, 
																					iter, SaltOut, 3, ,true, false);

	HealthCareProvider.Mac_SF_BuildProcess(Assign_Sanction_Flag,
																					HealthCareFacility.Files.HealthCare_Prefix, 
																					HealthCareFacility.Files.Facility_in_Suffix, 
																					iter, SaltIn, 3, ,true, true);

	RETURN SEQUENTIAL (Salt_Iteration,SaltOut,SaltIn);	
End;


