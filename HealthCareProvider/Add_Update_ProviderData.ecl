IMPORT ut, RoxieKeyBuild, lib_fileservices, SALT27, Health_Provider_Services;

EXPORT Add_Update_ProviderData (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Hdr, STRING fileDate = ut.GetDate) := FUNCTION 
	
	AMS_DS 			:= HealthCareProvider.ConvertAMStoHeader (HealthCareProvider.Files.AMS_DID_DS)	: persist ('~temp::hdr::ams',expire(1));
	
	NPPES_DS		:=	HealthCareProvider.ConvertNPPEStoHeader (HealthCareProvider.Files.NPPES_DID_DS)	: persist ('~temp::hdr::nppes',expire(1));
	
	DEA_DS			:=	HealthCareProvider.ConvertDEAtoHeader (HealthCareProvider.Files.DEA_DID_DS)	: persist ('~temp::hdr::dea',expire(1));
	
	Prof_LIC_DS	:=	HealthCareProvider.ConvertProfLICtoHeader (HealthCareProvider.Files.PROF_LIC_DS)	: persist ('~temp::hdr::proflic',expire(1));
	
	Enclarity_DS	:=	HealthCareProvider.ConvertEnclaritytoHeader (HealthCareProvider.Files.Enclarity_DS)	: persist ('~temp::hdr::enclarity',expire(1));

	Enclarity_ASSOC_DS	:=	HealthCareProvider.ConvertEnclarityAssoctoHeader (HealthCareProvider.Files.Enclarity_ASSOC_DS)	: persist ('~temp::hdr::enclarity::assoc',expire(1));
	
	Append_Header_DS 	:=	AMS_DS + NPPES_DS + DEA_DS + Prof_LIC_DS + Enclarity_DS + Enclarity_ASSOC_DS : persist ('~temp::hdr::append',expire(1));

	Assign_Derived_Gender	:=	HealthCareProvider.UpdateGender (Append_Header_DS);
	
	Clean_Suffix_DS	:=	HealthCareProvider.Clean_Suffix_Name (Assign_Derived_Gender);
	
	Append_CnsmrData_DS := HealthCareProvider.UpdateCnsmrData (Clean_Suffix_DS);
	
	Append_Entity_Type_DS := HealthCareProvider.UpdateEntityType (Append_CnsmrData_DS);
	
	FilesToIngest		:=	HealthCareProvider.Clean_Name (Append_Entity_Type_DS) : persist ('~temp::hdr::filetoingest',expire(1));

	RecordType 			:= 	ENUM(UNSIGNED1,Unknown,Unchanged,Updated,Old,New);
  RTToText(UNSIGNED1 c) := CHOOSE(c,'UNKNOWN','Unchanged','Updated','Old','New');	
	
	FileToIngest		:=	PROJECT	(FilesToIngest,TRANSFORM (HealthCareProvider.Layouts.Header_Flag, SELF.TYPE := RecordType.New; SELF := LEFT));

	HeaderSourceCounts	:= TABLE(Hdr,{SRC, Cnt := COUNT (GROUP)},SRC,FEW);
  InputSourceCounts 	:= TABLE(FilesToIngest,{SRC, Cnt := COUNT (GROUP)},SRC,FEW);
	
	BaseFile				:=	PROJECT (HDR,TRANSFORM (HealthCareProvider.Layouts.Header_Flag, SELF.TYPE := RecordType.OLD; SELF := LEFT));
	
	CombinedFile		:=	BaseFile + FiletoIngest : persist ('~temp::hdr::combinedfile',expire(1));
	
	D_CombinedFile	:=	DISTRIBUTE (CombinedFile,HASH32(did,src,dt_lic_begin,dt_lic_expiration,dt_dea_expiration,dt_npi_deact,dt_address_verified,dt_bus_incorporated,ssn,cnsmr_ssn,dob,cnsmr_dob
																										 ,phone,fax,lic_nbr,c_lic_nbr,lic_state,lic_type,lic_status,title,fname,mname,lname,sname
																										 ,sic_code,gender,derived_gender,address_classification,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig
																										 ,sec_range,v_city_name,st,zip,death_ind,dod,tax_id,billing_tax_id,fein,derived_fein,upin,npi_number,billing_npi_number,dea_bus_act_ind
																										 ,dea_number,clia_number,taxonomy,medicare_facility_number,medicaid_number,ncpdp_number,speciality_code,provider_status,vendor_id));
	
	Base_FiletoIngest	:=	GROUP (D_CombinedFile,did,src,dt_lic_begin,dt_lic_expiration,dt_dea_expiration,dt_npi_deact,dt_address_verified,dt_bus_incorporated,ssn,cnsmr_ssn,dob,cnsmr_dob
																										 ,phone,fax,lic_nbr,c_lic_nbr,lic_state,lic_type,lic_status,title,fname,mname,lname,sname
																										 ,sic_code,gender,derived_gender,address_classification,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig
																										 ,sec_range,v_city_name,st,zip,death_ind,dod,tax_id,billing_tax_id,fein,derived_fein,upin,npi_number,billing_npi_number,dea_bus_act_ind
																										 ,dea_number,clia_number,taxonomy,medicare_facility_number,medicaid_number,ncpdp_number,speciality_code,provider_status,vendor_id,ALL);

  HealthCareProvider.Layouts.Header_Flag MergeData	(HealthCareProvider.Layouts.Header_Flag L, HealthCareProvider.Layouts.Header_Flag R) := TRANSFORM
    SELF.dt_first_seen := MAP ( L.Type = 0 OR (unsigned)L.dt_first_seen = 0 => R.dt_first_seen,
																R.Type = 0 OR (unsigned)R.dt_first_seen = 0 => L.dt_first_seen,
																(unsigned)L.dt_first_seen < (unsigned)R.dt_first_seen => L.dt_first_seen,
																R.dt_first_seen);
    SELF.dt_last_seen := MAP ( L.Type = 0 => R.dt_last_seen,
																R.Type = 0 => L.dt_last_seen,
																(unsigned)L.dt_last_seen < (unsigned)R.dt_last_seen => R.dt_last_seen,
																L.dt_last_seen);
    SELF.dt_vendor_first_reported := MAP ( L.Type = 0 OR (unsigned)L.dt_vendor_first_reported = 0 => R.dt_vendor_first_reported,
																					 R.Type = 0 OR (unsigned)R.dt_vendor_first_reported = 0 => L.dt_vendor_first_reported,
																					 (unsigned)L.dt_vendor_first_reported < (unsigned)R.dt_vendor_first_reported => L.dt_vendor_first_reported, // Want the lowest non-zero value
																					 R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAP ( L.Type = 0 => R.dt_vendor_last_reported,
																					 R.Type = 0 => L.dt_vendor_last_reported,
																					 (unsigned)L.dt_vendor_last_reported < (unsigned)R.dt_vendor_last_reported => R.dt_vendor_last_reported, // Want the highest value
																					 L.dt_vendor_last_reported);
    SELF.Type := MAP ( L.Type = 0 => R.Type, L.Type = RecordType.Updated OR R.Type = 0 OR R.Type = L.Type => L.Type,SELF.dt_first_seen <> L.dt_first_seen OR SELF.dt_last_seen <> L.dt_last_seen OR SELF.dt_vendor_first_reported <> L.dt_vendor_first_reported OR SELF.dt_vendor_last_reported <> L.dt_vendor_last_reported => RecordType.Updated, RecordType.Unchanged);
    SELF := L;
  END;

  MergedData := UNGROUP(ROLLUP( SORT( Base_FiletoIngest,Type,RID),TRUE,MergeData(LEFT,RIGHT)))  : persist ('~temp::hdr::mergeddata');

	NewData	:=	MergedData (Type = RecordType.New) : persist ('~temp::hdr::newdata');

	// Assign_LNPID_NewData := PROJECT (NewData,TRANSFORM(HealthCareProvider.Layouts.Header_Flag, SELF.RID := COUNTER; SELF.LNPID := 0; SELF := LEFT;))  : persist ('~temp::hdr::extlink::input',expire(10));
	
	// Health_Provider_Services.mac_get_best_lnpid_custom (Assign_LNPID_NewData,lnpid,
												// FNAME,MNAME,LNAME,SNAME,
												// GENDER,
												// PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
												// SSN,DOB,PHONE,
												// LIC_STATE,LIC_NBR,
												// TAX_ID,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,UPIN,DID,BDID,,,NewResult,false,80);
		
	OldData	:=	MergedData (Type <> RecordType.New);

	Max_RID	:=	MAX (OldData, RID);
	
	Layouts.Header_Flag addNewRid (Layouts.Header_Flag L, Layouts.Header_Flag R) := TRANSFORM
		SELF.RID := IF (L.RID = 0, Max_RID + 1 + thorlib.node(), L.RID + thorlib.nodes ());
		SELF.LNPID := SELF.RID;
		SELF	:=	R;
	END;
	
	Assign_RID	:=	ITERATE (NewData,addNewRid(LEFT,RIGHT),LOCAL) : PERSIST ('~thor::assign::rid');
	
	RidFile	:=	OldData (~(src IN ['64','SJ'] and Type = RecordType.Old)) + Assign_RID;

  StatsRec := RECORD
    SALT27.StrType Type := RTToText(RidFile.TYPE);
    UNSIGNED Cnt := COUNT(GROUP);
    RidFile.SRC;
  END;

  UpdateStats := TABLE(RidFile,StatsRec,Type,SRC,FEW);

	NewInputFile := PROJECT (RidFile,TRANSFORM (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT)) : PERSIST ('~thor::hdr::newfile');

	SaltInputFile :=  NewInputFile;

	OUTPUT (HeaderSourceCounts,ALL,NAMED('CurrentHeaderStats'));
	OUTPUT (InputSourceCounts,ALL,NAMED('FileToIngestStats'));
	OUTPUT (SORT(UpdateStats,MAP(SRC = '64' => 1,SRC = 'SJ' => 2,SRC = 'NP' => 3,SRC = 'DA' => 4,SRC = 'PL' => 5,6),
													 MAP(TYPE = 'Old' => 1, TYPE = 'Unchanged' => 2, TYPE = 'Updated' => 3, TYPE = 'New' => 4, 5)),ALL,NAMED('IngestedFileStats'));

	RETURN SaltInputFile;
End;
