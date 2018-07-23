import Healthcare_Header_Services, Healthcare_Lookups,Healthcare_Shared,doxie,iesp,DidVille,Business_Header_SS,Healthcare_Provider_Services,Healthcare_Services,BatchServices,AutoStandardI,ut,HealthCareFacility,HealthCareProvider,Enclarity_Facility_Sanctions,std;

EXPORT Transforms := MODULE
	shared legacyLayout := doxie.ingenix_provider_module;
	Shared LegacySearch := legacyLayout.layout_ingenix_provider_search_plus;
	shared LegacyReport := legacyLayout.layout_ingenix_provider_report;
	shared LegacyReportWithVerification := Layouts.LegacyReportWithVerifications;

	Export Layouts.layout_SrcRec AddSequence (Layouts.layout_SrcRec l,INTEGER c) := transform
		SELF.Seq := c;
		SELF := l;
	end;

	//Build Individual Header Requests
	Export Layouts.HeaderRequestLayoutPlus createHeaderRequest(Layouts.autokeyInput input,dataset(Layouts.common_runtime_config) cfg) := transform
		hasLicense := input.license_number <>'' or input.DEA <>'' or input.NPI <>'' or input.upin <>''or  input.ProviderID > 0 or input.DID > 0 or input.BDID > 0; 
		hasName := input.name_first <>'' or input.name_last <>'';
		hasAddress := (input.prim_range <>'' and input.prim_name <>'') or (input.prim_name <>'' and input.st <>'') or (input.prim_name <>'' and input.z5 <>'') or (input.p_city_name <>'' and input.st <>'');
		isLicenseOnly := hasLicense or cfg[1].isReport;//Used for very specific keys
		isNameAddrOnly := (hasName and hasAddress) and not hasLicense;
		hasSomething2Search := hasLicense or hasName or hasAddress;
		isFullSearch := hasSomething2Search and (not isLicenseOnly and not isNameAddrOnly);
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		self.lnpid := if(input.ProviderSrc = '' or input.ProviderSrc = Constants.SRC_HEADER,input.ProviderID,0);
		SELF.FNAME := stringlib.StringToUpperCase(input.name_first);
		SELF.MNAME := stringlib.StringToUpperCase(input.name_middle);
		SELF.LNAME := stringlib.StringToUpperCase(input.name_last);
		SELF.SNAME := stringlib.StringToUpperCase(input.name_suffix);
		// SELF.GENDER := '';//Not currently supported;
		SELF.PRIM_RANGE := stringlib.StringToUpperCase(input.prim_range);
		SELF.PRIM_NAME := stringlib.StringToUpperCase(input.prim_name);
		SELF.SEC_RANGE := stringlib.StringToUpperCase(input.sec_range);
		SELF.V_CITY_NAME := stringlib.StringToUpperCase(input.p_city_name);
		SELF.ST := stringlib.StringToUpperCase(input.st);
		SELF.ZIP := stringlib.StringToUpperCase(input.z5);
		SELF.SSN := input.ssn;
		SELF.DOB := (integer)input.dob;
		self.PHONE := input.workphone;
		SELF.LIC_STATE :=	stringlib.StringToUpperCase(input.license_state);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(stringlib.StringToUpperCase(input.license_number));
		SELF.TAX_ID	:= if(input.fein <> '',input.fein,input.TaxID);
		SELF.DEA_NUMBER	:= stringlib.StringToUpperCase(input.DEA);
		SELF.VENDOR_ID := stringlib.StringToUpperCase(if(input.ProviderSrc <> '' and input.ProviderSrc <> Constants.SRC_HEADER,(string)input.ProviderID,''));
		SELF.SRC := stringlib.StringToUpperCase(input.ProviderSrc);
		SELF.NPI_NUMBER	:= stringlib.StringToUpperCase(input.NPI);
		SELF.UPIN := stringlib.StringToUpperCase(input.upin);
		SELF.DID := input.DID;
		SELF.BDID := input.BDID;
		SELF.SOURCE_RID := 0;//Not currently supported as the user do not know the rids they only know the lnpids;
		self.hasLicense := hasLicense; 
		self.hasName := hasName;
		self.hasAddress := hasAddress;
		self.isLicenseOnly := isLicenseOnly;
		self.isNameAddrOnly := isNameAddrOnly;
		self.isFullSearch := isFullSearch;
		SELF :=	[];
	End;
	Export Layouts.HeaderRequestLayoutPlus createHeaderRequestWithoutState(Layouts.autokeyInput input,dataset(Layouts.common_runtime_config) cfg) := transform
		hasLicense := input.license_number <>'' or input.DEA <>'' or input.NPI <>'' or input.upin <>''or  input.ProviderID > 0 or input.DID > 0 or input.BDID > 0; 
		hasName := input.name_first <>'' or input.name_last <>'';
		hasLimitedAddress := input.prim_range ='' and input.prim_name ='' and (input.p_city_name <>'' and input.st <>'');
		isLicenseOnly := hasLicense or cfg[1].isReport;//Used for very specific keys
		isNameLimitedAddrOnly := (hasName and hasLimitedAddress) and not hasLicense;
		SELF.rid := if(isNameLimitedAddrOnly,(integer)input.acctno,skip);
		self.lnpid := if(input.ProviderSrc = '' or input.ProviderSrc = Constants.SRC_HEADER,input.ProviderID,0);
		SELF.FNAME := stringlib.StringToUpperCase(input.name_first);
		SELF.MNAME := stringlib.StringToUpperCase(input.name_middle);
		SELF.LNAME := stringlib.StringToUpperCase(input.name_last);
		SELF.SNAME := stringlib.StringToUpperCase(input.name_suffix);
		// SELF.GENDER := '';//Not currently supported;
		SELF.PRIM_RANGE := stringlib.StringToUpperCase(input.prim_range);
		SELF.PRIM_NAME := stringlib.StringToUpperCase(input.prim_name);
		SELF.SEC_RANGE := stringlib.StringToUpperCase(input.sec_range);
		SELF.V_CITY_NAME := stringlib.StringToUpperCase(input.p_city_name);
		SELF.ST := '';//stringlib.StringToUpperCase(input.st); map this out due to Header query failure problems
		SELF.ZIP := stringlib.StringToUpperCase(input.z5);
		SELF.SSN := input.ssn;
		SELF.DOB := (integer)input.dob;
		self.PHONE := input.workphone;
		SELF.LIC_STATE :=	stringlib.StringToUpperCase(input.license_state);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(stringlib.StringToUpperCase(input.license_number));
		SELF.TAX_ID	:= if(input.fein <> '',input.fein,input.TaxID);
		SELF.DEA_NUMBER	:= stringlib.StringToUpperCase(input.DEA);
		SELF.VENDOR_ID := stringlib.StringToUpperCase(if(input.ProviderSrc <> '' and input.ProviderSrc <> Constants.SRC_HEADER,(string)input.ProviderID,''));
		SELF.SRC := stringlib.StringToUpperCase(input.ProviderSrc);
		SELF.NPI_NUMBER	:= stringlib.StringToUpperCase(input.NPI);
		SELF.UPIN := stringlib.StringToUpperCase(input.upin);
		SELF.DID := input.DID;
		SELF.BDID := input.BDID;
		SELF.SOURCE_RID := 0;//Not currently supported as the user do not know the rids they only know the lnpids;
		self.hasLicense := hasLicense; 
		self.hasName := hasName;
		self.isLicenseOnly := isLicenseOnly;
		self.isNameAddrOnly := false;
		SELF :=	[];
	End;
	Export Layouts.autokeyInput createInputByDid(doxie.layout_references inputbyDID) := transform
			self.acctno := '1';
			self := inputbyDID;
			self := [];
	End;
	Export Layouts.HeaderRequestLayoutPlus createHeaderRequestByDid(doxie.layout_references inputbyDID) := transform
		SELF.rid := 1;
		self.lnpid := 0;
		SELF.FNAME := '';
		SELF.MNAME := '';
		SELF.LNAME := '';
		SELF.SNAME := '';
		// SELF.GENDER := '';//Not currently supported;
		SELF.PRIM_RANGE := '';
		SELF.PRIM_NAME := '';
		SELF.SEC_RANGE := '';
		SELF.V_CITY_NAME := '';
		SELF.ST := '';
		SELF.ZIP := '';
		SELF.SSN := '';//input.ssn;//Not currently populated;
		SELF.DOB := 0;
		self.PHONE := '';
		SELF.LIC_STATE :=	'';
		SELF.LIC_NBR :=	'';
		SELF.TAX_ID	:= '';
		SELF.DEA_NUMBER	:= '';
		SELF.VENDOR_ID := '';
		SELF.SRC := '';
		SELF.NPI_NUMBER	:= '';
		SELF.UPIN := '';
		SELF.DID := if(inputbyDID.DID>0,inputbyDID.DID,skip);
		SELF.BDID := 0;
		SELF.SOURCE_RID := 0;//Not currently supported as the user do not know the rids they only know the lnpids;
		self.hasLicense := false; 
		self.hasName := false;
		self.hasAddress := false;
		self.isLicenseOnly := true;
		self.isNameAddrOnly := false;
		self.isFullSearch := false;
		SELF :=	[];
	End;
	Export Layouts.HeaderRequestLayoutPlus createHeaderRequestDEA2(Layouts.autokeyInput input) := transform
		SELF.rid := (integer)input.acctno;
		SELF.DEA_NUMBER	:= stringlib.StringToUpperCase(input.DEA2);
		self.hasLicense := true; 
		SELF :=	[];
	End;
	Export Layouts.HeaderRequestLayoutPlus createHeaderRequestLicense(Layouts.autokeyInput input, unsigned cnt) := transform
		lic := map(cnt = 1 => input.StateLicense1Verification,
							 cnt = 2 => input.StateLicense2Verification,
							 cnt = 3 => input.StateLicense3Verification,
							 cnt = 4 => input.StateLicense4Verification,
							 cnt = 5 => input.StateLicense5Verification,
							 cnt = 6 => input.StateLicense6Verification,
							 cnt = 7 => input.StateLicense7Verification,
							 cnt = 8 => input.StateLicense8Verification,
							 cnt = 9 => input.StateLicense9Verification,
							 cnt = 10 => input.StateLicense10Verification,
							 '');
		licSt := map(cnt = 1 => input.StateLicense1StateVerification,
								 cnt = 2 => input.StateLicense2StateVerification,
								 cnt = 3 => input.StateLicense3StateVerification,
								 cnt = 4 => input.StateLicense4StateVerification,
								 cnt = 5 => input.StateLicense5StateVerification,
								 cnt = 6 => input.StateLicense6StateVerification,
								 cnt = 7 => input.StateLicense7StateVerification,
								 cnt = 8 => input.StateLicense8StateVerification,
								 cnt = 9 => input.StateLicense9StateVerification,
								 cnt = 10 => input.StateLicense10StateVerification,
								 '');
		SELF.rid := (integer)input.acctno;
		SELF.LNAME := stringlib.StringToUpperCase(input.name_last);
		SELF.LIC_STATE :=	if(licSt='',stringlib.StringToUpperCase(input.st),stringlib.StringToUpperCase(licSt));
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(stringlib.StringToUpperCase(lic));
		self.hasLicense := true; 
		SELF :=	[];
	End;
	Export Layouts.searchKeyResults xformHdrLNPids (Layouts.HeaderResponseLayout L) := transform
			self.prov_id:=l.LNPID;
			self.vendorid:=l.vendor_id;
			self.did:=l.did;
			self.bdid:=l.bdid;
			self.acctno:=(string)l.uniqueid;
			self.src:=l.src;
			self.LNPID:=l.LNPID;
			self.isHeaderResult := true;
			self.isSearchFailed := l.keysfailed>0;
			self.keysfailed_decode := l.keysfailed_decode;
			self.returnThresholdExceeded := l.returnThresholdExceeded;
			self.srcIndividualHeader := l.srcIndividualHeader;
			self.srcBusinessHeader := l.srcBusinessHeader;
	end;
	//Build Business Header Requests
	Export Layouts.HeaderBusRequestLayoutPlus createBusHeaderRequest(Layouts.autokeyInput input,dataset(Layouts.common_runtime_config) cfg) := transform
		hasLicense := input.license_number <>'' or input.DEA <>'' or input.NPI <>'' or input.CLIANumber <>'' or input.NCPDPNumber <>'' or input.ProviderID > 0 or input.BDID > 0; 
		hasCName := input.comp_name <>'';
		hasAddress := (input.prim_range <>'' and input.prim_name <>'') or (input.prim_name <>'' and input.st <>'') or (input.prim_name <>'' and input.z5 <>'') or (input.p_city_name <>'' and input.st <>'');
		isLicenseOnly := hasLicense;
		isCNameAddrOnly := (hasCName and hasAddress) and not hasLicense;
		hasSomething2Search := hasLicense or hasCName or hasAddress;
		isFullSearch := hasSomething2Search and (not isLicenseOnly and not isCNameAddrOnly);
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		self.lnpid := if(input.ProviderSrc = '' or input.ProviderSrc = Constants.SRC_HEADER,input.ProviderID,0);
		SELF.comp_name := HealthCareFacility.clean_facility_name(stringlib.StringToUpperCase(input.comp_name));
		SELF.PRIM_RANGE := stringlib.StringToUpperCase(input.prim_range);
		SELF.PRIM_NAME := stringlib.StringToUpperCase(input.prim_name);
		SELF.SEC_RANGE := stringlib.StringToUpperCase(input.sec_range);
		SELF.V_CITY_NAME := stringlib.StringToUpperCase(input.p_city_name);
		SELF.ST := stringlib.StringToUpperCase(input.st);
		SELF.ZIP := stringlib.StringToUpperCase(input.z5);
		SELF.PHONE := input.workphone;
		SELF.LIC_STATE :=	stringlib.StringToUpperCase(input.license_state);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(stringlib.StringToUpperCase(input.license_number));
		self.Tax_ID := if(input.TaxID <> '',input.TaxID,input.fein);
		SELF.DEA_NUMBER := stringlib.StringToUpperCase(input.DEA);
		SELF.VENDOR_ID := stringlib.StringToUpperCase(if(input.ProviderSrc <> '' and input.ProviderSrc <> Constants.SRC_HEADER,(string)input.ProviderID,''));
		SELF.NPI_NUMBER	:= stringlib.StringToUpperCase(input.NPI);
		SELF.NCPDPNumber	:= stringlib.StringToUpperCase(input.NCPDPNumber);
		SELF.CLIANumber := stringlib.StringToUpperCase(input.CLIANumber);
		SELF.MedicareNumber := stringlib.StringToUpperCase(input.MedicareNumber);
		SELF.BDID := input.BDID;
		self.Taxonomy := stringlib.StringToUpperCase(input.Taxonomy1Verification);
		SELF.SRC := '';//stringlib.StringToUpperCase(input.ProviderSrc);
		SELF.SOURCE_RID := 0;//Not currently supported as the user do not know the rids they only know the lnpids;
		self.hasLicense := hasLicense; 
		self.hasCName := hasCName;
		self.hasAddress := hasAddress;
		self.isLicenseOnly := isLicenseOnly;
		self.isCNameAddrOnly := isCNameAddrOnly;
		self.isFullSearch := isFullSearch;
		SELF :=	[];
	End;
	Export Layouts.autokeyInput createBusInputByBDid(doxie.Layout_ref_bdid inputbyBDID) := transform
			self.acctno := '1';
			self := inputbyBDID;
			self := [];
	End;
	Export Layouts.HeaderBusRequestLayoutPlus createBusHeaderRequestByBDid(doxie.Layout_ref_bdid inputbyBDID) := transform
		SELF.rid := 1;
		self.lnpid := 0;
		SELF.comp_name := '';
		SELF.PRIM_RANGE := '';
		SELF.PRIM_NAME := '';
		SELF.SEC_RANGE := '';
		SELF.V_CITY_NAME := '';
		SELF.ST := '';
		SELF.ZIP := '';
		self.PHONE := '';
		SELF.LIC_STATE :=	'';
		SELF.LIC_NBR :=	'';
		SELF.TAX_ID	:= '';
		SELF.DEA_NUMBER	:= '';
		SELF.VENDOR_ID := '';
		SELF.SRC := '';
		SELF.NPI_NUMBER	:= '';
		SELF.CLIANumber := '';
		SELF.MedicareNumber := '';
		SELF.BDID := if(inputbyBDID.BDID>0,inputbyBDID.BDID,skip);
		SELF.SOURCE_RID := 0;//Not currently supported as the user do not know the rids they only know the lnpids;
		self.hasLicense := false; 
		self.hasCName := false;
		self.hasAddress := false;
		self.isLicenseOnly := true;
		self.isCNameAddrOnly := false;
		self.isFullSearch := false;
		SELF :=	[];
	End;
	Export Layouts.HeaderBusRequestLayoutPlus createBusHeaderRequestNCPDP(Layouts.autokeyInput input) := transform
		hasLicense := input.NCPDPNumber <>''; 
		isLicenseOnly := hasLicense;
		hasSomething2Search := hasLicense;
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		SELF.NCPDPNumber	:= stringlib.StringToUpperCase(input.NCPDPNumber);
		self.hasLicense := hasLicense; 
		self.isLicenseOnly := isLicenseOnly;
		SELF :=	[];
	End;
	Export Layouts.HeaderBusRequestLayoutPlus createBusHeaderRequestCLIA(Layouts.autokeyInput input) := transform
		hasLicense := input.CLIANumber <>''; 
		isLicenseOnly := hasLicense;
		hasSomething2Search := hasLicense;
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		SELF.CLIANumber := stringlib.StringToUpperCase(input.CLIANumber);
		self.hasLicense := hasLicense; 
		self.isLicenseOnly := isLicenseOnly;
		SELF :=	[];
	End;
	Export Layouts.HeaderBusRequestLayoutPlus createBusHeaderRequestNPI(Layouts.autokeyInput input) := transform
		hasLicense := input.NPI <>''; 
		isLicenseOnly := hasLicense;
		hasSomething2Search := hasLicense;
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		SELF.NPI_NUMBER	:= stringlib.StringToUpperCase(input.NPI);
		self.hasLicense := hasLicense; 
		self.isLicenseOnly := isLicenseOnly;
		SELF :=	[];
	End;
	Export Layouts.HeaderBusRequestLayoutPlus createBusHeaderRequestDEA(Layouts.autokeyInput input) := transform
		hasLicense := input.DEA <>''; 
		isLicenseOnly := hasLicense;
		hasSomething2Search := hasLicense;
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		SELF.DEA_NUMBER := stringlib.StringToUpperCase(input.DEA);
		self.hasLicense := hasLicense; 
		self.isLicenseOnly := isLicenseOnly;
		SELF :=	[];
	End;
	Export Layouts.HeaderBusRequestLayoutPlus createBusHeaderRequestLic(Layouts.autokeyInput input) := transform
		hasLicense := input.license_number <>''; 
		isLicenseOnly := hasLicense;
		hasSomething2Search := hasLicense;
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		SELF.LIC_STATE :=	stringlib.StringToUpperCase(input.license_state);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(stringlib.StringToUpperCase(input.license_number));
		self.hasLicense := hasLicense; 
		self.isLicenseOnly := isLicenseOnly;
		SELF :=	[];
	End;
	Export Layouts.HeaderBusRequestLayoutPlus createBusHeaderRequestDEA2(Layouts.autokeyInput input) := transform
		SELF.rid := (integer)input.acctno;
		SELF.DEA_NUMBER	:= stringlib.StringToUpperCase(input.DEA2);
		self.hasLicense := true; 
		SELF :=	[];
	End;
	Export Layouts.HeaderBusRequestLayoutPlus createBusHeaderRequestLicense(Layouts.autokeyInput input, unsigned cnt) := transform
		lic := map(cnt = 1 => input.StateLicense1Verification,
							 cnt = 2 => input.StateLicense2Verification,
							 cnt = 3 => input.StateLicense3Verification,
							 cnt = 4 => input.StateLicense4Verification,
							 cnt = 5 => input.StateLicense5Verification,
							 cnt = 6 => input.StateLicense6Verification,
							 cnt = 7 => input.StateLicense7Verification,
							 cnt = 8 => input.StateLicense8Verification,
							 cnt = 9 => input.StateLicense9Verification,
							 cnt = 10 => input.StateLicense10Verification,
							 '');
		licSt := map(cnt = 1 => input.StateLicense1StateVerification,
								 cnt = 2 => input.StateLicense2StateVerification,
								 cnt = 3 => input.StateLicense3StateVerification,
								 cnt = 4 => input.StateLicense4StateVerification,
								 cnt = 5 => input.StateLicense5StateVerification,
								 cnt = 6 => input.StateLicense6StateVerification,
								 cnt = 7 => input.StateLicense7StateVerification,
								 cnt = 8 => input.StateLicense8StateVerification,
								 cnt = 9 => input.StateLicense9StateVerification,
								 cnt = 10 => input.StateLicense10StateVerification,
								 '');
		SELF.rid := (integer)input.acctno;
		SELF.LIC_STATE :=	stringlib.StringToUpperCase(licSt);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(stringlib.StringToUpperCase(lic));
		self.hasLicense := true; 
		SELF :=	[];
	End;
	Export Layouts.searchKeyResults xformBusHdrLNPids (Layouts.HeaderBusResponseLayout L) := transform
			self.prov_id:=l.LNPID;
			self.vendorid:=l.vendor_id;
			self.did:=l.did;
			self.bdid:=l.bdid;
			self.acctno:=(string)l.uniqueid;
			self.src:=l.src;
			self.LNPID:=l.LNPID;
			self.isHeaderResult := true;
			self := l;
	end;

	//AMS Base transforms
	Export Layouts.CombinedHeaderResults build_ams_base (Layouts.ams_base_with_input l) := transform
		self.acctno := l.acctno;
		self.sources := dataset([{l.ams_id,Constants.SRC_AMS}],Layouts.layout_SrcID);
		self.LNPID := l.lnpid;
		self.VendorID := l.ams_id;
		self.srcID := (integer)l.ams_id;
		self.src := Constants.SRC_AMS;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.names := project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 2;
																			self.namePenalty := 0;
																			self.FullName := left.rawdemographicsfields.acct_name;
																			self.FirstName := left.clean_name.fname;
																			self.MiddleName := left.clean_name.mname;
																			self.LastName := left.clean_name.lname;
																			self.Suffix := left.clean_name.name_suffix;
																			self.Title := left.clean_name.title;
																			self.Gender := left.rawdemographicsfields.gen_cd;
																			self.CompanyName := '';));
		tmp_phones := l.clean_phones;
		tmp_phones_off := project(tmp_phones,transform(Layouts.layout_phone, self.phone:=left.phone;self.phonetype:='OFFICE PHONE'));
		tmp_phones_fax := project(tmp_phones,transform(Layouts.layout_phone, self.phone:=left.fax;self.phonetype:='OFFICE FAX'));
		self.Addresses := project(l,transform(Layouts.layout_addressinfo,
																		self.addrSeq := Constants.ADDR_SEQ_AMS;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := left.rawaddressfields.gold_record_flag;
																		self.addrConfidenceValue := left.rawaddressfields.bob_value;
																		self.addrType := '';
																		self.addrTypeCode := left.rawaddressfields.addr_type;
																		self.addrVerificationStatusFlag := left.rawaddressfields.addr_status;
																		self.addrVerificationDate := left.rawaddressfields.update_date;
																		self.addrPenalty := 0;
																		self.address1 := left.rawaddressfields.ams_street;
																		self.address2 := '';
																		self.prim_range := left.clean_company_address.prim_range;
																		self.predir := left.clean_company_address.predir;
																		self.prim_name := left.clean_company_address.prim_name;
																		self.addr_suffix := left.clean_company_address.addr_suffix;
																		self.postdir := left.clean_company_address.postdir;
																		self.unit_desig := left.clean_company_address.unit_desig;
																		self.sec_range := left.clean_company_address.sec_range;
																		self.p_city_name := left.clean_company_address.p_city_name;
																		self.v_city_name := left.clean_company_address.v_city_name;
																		self.st := left.clean_company_address.st;
																		self.z5 := left.clean_company_address.zip;
																		self.zip4 := left.clean_company_address.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.clean_company_address.geo_lat;
																		self.geo_long := left.clean_company_address.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.clean_phones.phone;
																		self.FaxNumber := left.clean_phones.fax;
																		self.Phones := dataset([{left.clean_phones.phone,left.clean_phones.fax}],Layouts.layout_addressphone);));
		self.dobs := dataset([{l.rawdemographicsfields.dob_date}],Layouts.layout_dob)(dob<>'');
		self.phones := project(tmp_phones_off+tmp_phones_fax,transform(Layouts.layout_phone, skip(left.phone=''), self:=left));
		self.dids := if(l.did_score>Constants.DID_SCORE_THRESHOLD and l.did>0,dataset([{(integer)l.did}],Layouts.layout_did));
		self.optouts := dataset([{'',
															'',
															'',
															'',
															l.opt_out_flag_desc,
															'',
															if(l.status_desc='Dead','Y','N'),
															''}],Layouts.layout_optout)(length(trim(optout_sitedesc,all))>1);
		self.taxids := dataset([{l.rawdemographicsfields.tax_id}],Layouts.layout_taxid)(taxid<>'');
		Self.SrcRecRaw :=  project(l,transform(Layouts.layout_SrcRec,
																		self.Src := constants.SRC_AMS;
																		self.nameSeq := 2;
																		self.namePenalty := 0;
																		self.FullName := left.rawdemographicsfields.acct_name;
																		self.FirstName := left.clean_name.fname;
																		self.MiddleName := left.clean_name.mname;
																		self.LastName := left.clean_name.lname;
																		self.Suffix := left.clean_name.name_suffix;
																		self.Title := left.clean_name.title;
																		self.Gender := left.rawdemographicsfields.gen_cd;
																		self.CompanyName := '';
																		self.addrSeq := Constants.ADDR_SEQ_AMS;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := left.rawaddressfields.gold_record_flag;
																		self.addrConfidenceValue := left.rawaddressfields.bob_value;
																		self.addrType := '';
																		self.addrTypeCode := left.rawaddressfields.addr_type;
																		self.addrVerificationStatusFlag := left.rawaddressfields.addr_status;
																		self.addrVerificationDate := left.rawaddressfields.update_date;
																		self.addrPenalty := 0;
																		self.address1 := left.rawaddressfields.ams_street;
																		self.address2 := '';
																		self.prim_range := left.clean_company_address.prim_range;
																		self.predir := left.clean_company_address.predir;
																		self.prim_name := left.clean_company_address.prim_name;
																		self.addr_suffix := left.clean_company_address.addr_suffix;
																		self.postdir := left.clean_company_address.postdir;
																		self.unit_desig := left.clean_company_address.unit_desig;
																		self.sec_range := left.clean_company_address.sec_range;
																		self.p_city_name := left.clean_company_address.p_city_name;
																		self.v_city_name := left.clean_company_address.v_city_name;
																		self.st := left.clean_company_address.st;
																		self.z5 := left.clean_company_address.zip;
																		self.zip4 := left.clean_company_address.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.clean_company_address.geo_lat;
																		self.geo_long := left.clean_company_address.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.clean_phones.phone;
																		self.FaxNumber := left.clean_phones.fax;
																		self.Phones := dataset([{left.clean_phones.phone,left.clean_phones.fax}],Layouts.layout_addressphone);
																		self.ssn := '';
																		self.dob := left.rawdemographicsfields.dob_date;
																		self.did := left.did;
																		self.bdid := if(left.bdid_score>Constants.DID_SCORE_THRESHOLD and left.bdid>0,left.bdid,0);
																		self.fein := left.rawdemographicsfields.tax_id;
																		self := left;
																		self:=[];));
		self:=l; 
		self:=[];
	end;
	//AMS Rollup
	export Layouts.layout_addressinfo doAMSBaseRecordAddrRollup(Layouts.layout_addressinfo l,
																										DATASET(Layouts.layout_addressinfo) allRows) := TRANSFORM
			tmpPhones := project(allRows, TRANSFORM( Layouts.layout_addressphone, SELF := left));
			tmpPhonesOnly := dedup(tmpPhones(faxnumber=''),all);
			tmpFaxOnly := dedup(tmpPhones(phonenumber=''),all);
			tmpPhoneFaxBoth := dedup(tmpPhones(phonenumber<>'' and faxnumber<>''),all);
			uniquePhones:=join(tmpPhoneFaxBoth,tmpPhonesOnly,left.phonenumber=right.phonenumber,right only);
			uniqueFaxes:=join(tmpPhoneFaxBoth,tmpFaxOnly,left.faxnumber=right.faxnumber,right only);
			self.phones:= (tmpPhoneFaxBoth+uniquePhones+uniqueFaxes)(trim(phonenumber,all)<>'' or trim(faxnumber,all)<>'');
			self.phonenumber := '';//Blanked out as data s now in collection
			self.faxnumber := '';//Blanked out as data s now in collection
			self.last_seen := max(allRows,last_seen);
			self.addrSeq := min(allRows,addrSeq);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self.v_last_seen := max(allRows,v_last_seen);
			self.v_first_seen := if(min(allRows,v_first_seen) <> '', min(allRows,v_first_seen),min(allRows,v_last_seen));
			self := l;
			self := [];
	end;
	export Layouts.CombinedHeaderResults doAMSBaseRecordSrcIdRollup(Layouts.CombinedHeaderResults l, 
																									DATASET(Layouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.LNPID := if(l.LNPID <> 0, l.LNPID,l.SrcId);
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.isHeaderResult := l.isHeaderResult;
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := l.ProcessingMessage;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( Layouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5,-addrConfidenceValue),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doAMSBaseRecordAddrRollup(left,rows(left))),addrseq,-addrConfidenceValue);
		self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( Layouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL );
		self.dobs          := DEDUP( NORMALIZE( allRows, LEFT.dobs, TRANSFORM( Layouts.layout_dob, SELF := RIGHT	)	), dob, ALL );
		self.phones        := DEDUP( NORMALIZE( allRows, LEFT.phones, TRANSFORM( Layouts.layout_phone, SELF := RIGHT	)	), RECORD, ALL );
		self.dids          := Functions.processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( Layouts.layout_did, SELF := RIGHT	)	) );
		self.bdids         := Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	) );
		self.feins         := DEDUP( NORMALIZE( allRows, LEFT.feins, TRANSFORM( Layouts.layout_fein, SELF := RIGHT	)	), fein, ALL );
		self.taxids        := DEDUP( NORMALIZE( allRows, LEFT.taxids, TRANSFORM( Layouts.layout_taxid, SELF := RIGHT	)	), taxid, ALL );
		self.optouts       := DEDUP( NORMALIZE( allRows, LEFT.optouts, TRANSFORM( Layouts.layout_optout, SELF := RIGHT	)	), RECORD, ALL );
		self.SrcRecRaw		 := sort(dedup( project(sort(allRows.SrcRecRaw,
																			Src,namePenalty,-(integer)addrConfidenceValue,-addrVerificationDate,seq,nameSeq,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																			ssn,dob,did,bdid,fein,dotid,empid,powid,proxid,orgid,ultid,
																			addrSeq,addrSeqGrp,addrGoldFlag,addrType,addrTypeCode,addrVerificationStatusFlag,
																			address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																			sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),AddSequence(left,counter)),
																Src,nameSeq,namePenalty,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																ssn,dob,did,bdid,fein,dotid,empid,powid,proxid,orgid,ultid,
																addrSeq,addrSeqGrp,addrGoldFlag,addrConfidenceValue,addrType,addrTypeCode,addrVerificationStatusFlag,
																addrVerificationDate,address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),
													src,seq);
		self := l;
	end;

	//Enclarity Base transforms
	Export Layouts.CombinedHeaderResults build_selectfile_Provider_base (Layouts.selectfile_providers_base_with_input l) := transform
		//Does the DID link and DOB and SSN make sense when compared with Enclarity year of birth or lic_begin_date.
		hasYear := l.birth_year <> '' and (integer)l.birth_year > 0;
		hasBestYear := l.best_dob > 0;
		hasLicYear := l.lic_begin_date <> '' and (integer)l.lic_begin_date > 0;
		compareYr := ((string)l.best_dob)[1..4];
		goodYear := hasYear and hasBestYear and (integer)compareYr = (integer)l.birth_year;
		logicalYear := hasYear and hasBestYear and
									 ((integer)compareYr > (integer)l.birth_year and (integer)compareYr - (integer)l.birth_year <= 13) or
		               ((integer)l.birth_year > (integer)compareYr and (integer)l.birth_year - (integer)compareYr <= 13);
		beginDte := l.lic_begin_date[1..4];
		logicalLicYear := hasLicYear and hasBestYear and
										((integer)beginDte > (integer)compareYr and (integer)beginDte - (integer)compareYr >= 20);
		goodDidLink := goodyear or logicalYear or logicalLicYear or ~hasYear;
		self.acctno := l.acctno;
		self.sources := dataset([{l.group_key,Constants.SRC_SELECTFILE}],Layouts.layout_SrcID);
		self.LNPID := l.lnpid;
		self.srcID := l.lnpid;
		self.vendorid := l.group_key;
		self.src := Constants.SRC_SELECTFILE;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.hasStateRestrict := l.state_restrict_flag='Y';
		self.hasOIG := l.oig_flag='Y';
		self.hasOPM := l.opm_flag='Y';
		self.status := l.provider_status;
		self.names := project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 1;
																			self.namePenalty := 0;
																			self.FullName := Healthcare_Header_Services.Functions.getCleanHealthCareName(left.orig_fullname);
																			self.FirstName := Healthcare_Header_Services.Functions.getCleanHealthCareName(left.first_name);
																			self.MiddleName :=Healthcare_Header_Services.Functions.getCleanHealthCareName( left.middle_name);
																			self.LastName := Healthcare_Header_Services.Functions.getCleanHealthCareName(left.last_name);
																			self.Suffix := Healthcare_Header_Services.Functions.getCleanHealthCareName(left.suffix_name);
																			self.Title := Healthcare_Header_Services.Functions.getCleanHealthCareName(left.title);
																			self.Gender := left.gender;
																			self.CompanyName := left.clean_company_name;));
		self.Addresses := project(l,transform(Layouts.layout_addressinfo,
																		self.addrSeq := Constants.ADDR_SEQ_ENCLARITY;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := (string)left.addr_conf_score;
																		self.addrType := left.addr_rectype;
																		self.addrTypeCode := left.normed_addr_rec_type;
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := (string)left.clean_last_verify_date;
																		self.addrPenalty := 0;
																		self.address1 := Functions.buildAddress(left.clean_prim_range,left.clean_predir,left.clean_prim_name,left.clean_addr_suffix,left.clean_postdir,left.clean_unit_desig,left.clean_sec_range);
																		self.address2 := '';
																		self.prim_range := left.clean_prim_range;
																		self.predir := left.clean_predir;
																		self.prim_name := left.clean_prim_name;
																		self.addr_suffix := left.clean_addr_suffix;
																		self.postdir := left.clean_postdir;
																		self.unit_desig := left.clean_unit_desig;
																		self.sec_range := left.clean_sec_range;
																		self.p_city_name := left.clean_p_city_name;
																		self.v_city_name := left.v_city_name;
																		self.st := left.clean_st;
																		self.z5 := left.clean_z5;
																		self.zip4 := left.zip4;
																		self.primaryLocation := left.primary_location;
																		self.practiceAddress := left.prac_addr_ind;
																		self.BillingAddress := left.bill_addr_ind;
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.geo_lat;
																		self.geo_long := left.geo_long;
																		self.fips_state := left.fips_st;
																		self.fips_county := left.fips_county;
																		self.PhoneNumber := left.phone1;
																		self.FaxNumber := left.fax1;
																		self.Phones := dataset([{left.phone1,left.fax1}],Layouts.layout_addressphone);));
		self.dobs := dataset([{if(goodDidLink,(string)l.best_dob,if((integer)l.birth_year>0,l.birth_year+'0101',''))}],Layouts.layout_dob)(dob<>'');
		phoneData:= dataset([{l.phone1,map(l.prac1_phone_ind='Y' => 'OFFICE PHONE',l.bill1_phone_ind='Y' => 'BILLING PHONE','OFFICE PHONE')}],Layouts.layout_phone)(phone<>'');
		faxData:= dataset([{l.fax1,map(l.prac1_fax_ind='Y' => 'OFFICE FAX',l.bill1_fax_ind='Y' => 'BILLING FAX','OFFICE FAX')}],Layouts.layout_phone)(phone<>'');
		self.phones := phoneData+faxData;
		self.dids := if(goodDidLink and l.did_score>Constants.DID_SCORE_THRESHOLD and l.did>0,dataset([{l.did}],Layouts.layout_did));
		self.bdids := if(l.bdid_score>Constants.DID_SCORE_THRESHOLD and l.bdid>0,dataset([{l.bdid}],Layouts.layout_bdid));
		self.bipkeys := project(l,transform(Layouts.layout_bipkeys, self := left));
		self.ssns := dataset([{if(goodDidLink and l.best_ssn<>'',l.best_ssn,'')}],Layouts.layout_ssn)(ssn<>'');
		self.optouts := dataset([{'','','','','','',
															if(l.date_of_death<>'','Y',''),
															l.date_of_death}],Layouts.layout_optout);
		self.upins := dataset([{l.acctno,l.lnpid,l.upin}],Layouts.layout_upin)(upin<>'');
		self.npis := dataset([{l.acctno,l.lnpid,l.npi_num,l.npi_num=l.usernpi,2,l.npi_deact_date,'',l.npi_enum_date,l.type1}],Layouts.layout_npi)(npi<>'');
		self.deas := project(l,transform(Layouts.layout_dea,
									self.acctno := left.acctno;
									self.ProviderID:=left.lnpid;
									self.dea:=if((string)left.dea_num <>'',(string)left.dea_num,skip);
									self.expiration_date := left.dea_num_exp;
									self.dea_bus_act_ind := left.dea_bus_act_ind;
									self.bestsource := 2;
									self.dea_num := left.dea_num;
									self.dea_num_exp := left.dea_num_exp;
									self.dea_num_bus_act_ind := left.dea_bus_act_ind;
									self.dea_num_bus_type := map ( 
																					Left.dea_bus_act_ind = 'A' =>     	'Pharmacy',                                                                                                                                                                                                                                                                                                                                 
																					Left.dea_bus_act_ind = 'B' =>     	'Hospital/Clinic',
																					Left.dea_bus_act_ind = 'C' =>     	'Practitioner',
																					Left.dea_bus_act_ind = 'D' =>     	'Teaching Institution',
																					Left.dea_bus_act_ind = 'E' =>     	'Manufacturer',
																					Left.dea_bus_act_ind = 'F' =>     	'Distributor',
																					Left.dea_bus_act_ind = 'G' =>     	'Researcher',
																					Left.dea_bus_act_ind = 'H' =>     	'Analytical Lab',
																					Left.dea_bus_act_ind = 'J' =>     	'Importer',
																					Left.dea_bus_act_ind = 'K' =>     	'Exporter',
																					Left.dea_bus_act_ind = 'M' =>     	'Mid Level Practitioner',
																					Left.dea_bus_act_ind = 'N' =>     	'Narcotic Treatment Program',
																					Left.dea_bus_act_ind = 'P' =>     	'Narcotic Treatment Program',
																					Left.dea_bus_act_ind = 'R' =>     	'Narcotic Treatment Program',
																					Left.dea_bus_act_ind = 'S' =>     	'Narcotic Treatment Program',
																					Left.dea_bus_act_ind = 'T' =>     	'Narcotic Treatment Program',
																					Left.dea_bus_act_ind = 'U' =>     	'Narcotic Treatment Program',
																					'');
									self.dea_AddressLine1 := Functions.buildAddress(left.clean_prim_range,left.clean_predir,left.clean_prim_name,left.clean_addr_suffix,left.clean_postdir,left.clean_unit_desig,left.clean_sec_range);
									self.dea_AddressLine2 := '';
									self.dea_prim_range := left.clean_prim_range;
									self.dea_predir := left.clean_predir;
									self.dea_prim_name := left.clean_prim_name;
									self.dea_addr_suffix := left.clean_addr_suffix;
									self.dea_postdir := left.clean_postdir;
									self.dea_unit_desig := left.clean_unit_desig;
									self.dea_sec_range := left.clean_sec_range;
									self.dea_p_city_name := left.clean_p_city_name;
									self.dea_st := left.clean_st;
									self.dea_z5 := left.clean_z5;
									self.dea_zip4 := left.zip4;
									self.dea_geo_lat := left.geo_lat;
									self.dea_geo_long := left.geo_long;));
		self.Degrees := dataset([{l.acctno,l.lnpid,l.suffix_other,0}],Layouts.layout_degree)(Degree<>'');
		self.StateLicenses := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.lic_state,l.lic_num,'',l.lic_type,l.lic_status,l.lic_begin_date,l.lic_end_date,''}],Layouts.layout_licenseinfo)(LicenseNumber<>'');
		Self.SrcRecRaw :=  project(l,transform(Layouts.layout_SrcRec,
																		self.Src := constants.SRC_SELECTFILE;
																		self.nameSeq := 1;
																		self.namePenalty := 0;
																		self.FullName := left.orig_fullname;
																		self.FirstName := left.first_name;
																		self.MiddleName := left.middle_name;
																		self.LastName := left.last_name;
																		self.Suffix := left.suffix_name;
																		self.Title := left.title;
																		self.Gender := left.gender;
																		self.CompanyName := left.clean_company_name;
																		self.addrSeq := Constants.ADDR_SEQ_ENCLARITY;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := (string)left.addr_conf_score;
																		self.addrType := left.addr_rectype;
																		self.addrTypeCode := left.normed_addr_rec_type;
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := (string)left.clean_last_verify_date;
																		self.addrPenalty := 0;
																		self.address1 := Functions.buildAddress(left.clean_prim_range,left.clean_predir,left.clean_prim_name,left.clean_addr_suffix,left.clean_postdir,left.clean_unit_desig,left.clean_sec_range);
																		self.address2 := '';
																		self.prim_range := left.clean_prim_range;
																		self.predir := left.clean_predir;
																		self.prim_name := left.clean_prim_name;
																		self.addr_suffix := left.clean_addr_suffix;
																		self.postdir := left.clean_postdir;
																		self.unit_desig := left.clean_unit_desig;
																		self.sec_range := left.clean_sec_range;
																		self.p_city_name := left.clean_p_city_name;
																		self.v_city_name := left.v_city_name;
																		self.st := left.clean_st;
																		self.z5 := left.clean_z5;
																		self.zip4 := left.zip4;
																		self.primaryLocation := left.primary_location;
																		self.practiceAddress := left.prac_addr_ind;
																		self.BillingAddress := left.bill_addr_ind;
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.geo_lat;
																		self.geo_long := left.geo_long;
																		self.fips_state := left.fips_st;
																		self.fips_county := left.fips_county;
																		self.PhoneNumber := left.phone1;
																		self.FaxNumber := left.fax1;
																		self.Phones := dataset([{left.phone1,left.fax1}],Layouts.layout_addressphone);
																		self.ssn := if(goodDidLink and left.best_ssn<>'',left.best_ssn,'');
																		self.dob := if(goodDidLink,(string)left.best_dob,if((integer)left.birth_year>0,left.birth_year+'0101',''));
																		self.did := if(goodDidLink and left.did_score>Constants.DID_SCORE_THRESHOLD and left.did>0,left.did,0);
																		self.bdid := if(left.bdid_score>Constants.DID_SCORE_THRESHOLD and left.bdid>0,left.bdid,0);
																		self := left;
																		self:=[];));
		self:=[]; 
	end;

	//Enclarity Business Base transforms
	Export Layouts.CombinedHeaderResults build_selectfile_Facility_base (Layouts.selectfile_facilities_base_with_input l) := transform
		self.acctno := l.acctno;
		self.sources := dataset([{l.group_key,Constants.SRC_SELECTFILE}],Layouts.layout_SrcID);
		self.LNPID := l.lnpid;
		self.srcID := l.prov_id;
		self.vendorid := l.group_key;
		self.src := Constants.SRC_SELECTFILE;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.hasStateRestrict := false;//Does not appear that we have Business Sanctions
		self.hasOIG := l.oig_flag='Y';
		self.hasOPM := false;//Does not appear that we have Business Sanctions
		self.medicare_fac_num := l.medicare_fac_num;
		self.status := '';//No rules yet on status for businesses;
		self.names := project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 1;
																			self.namePenalty := ut.CompanySimilar100(left.prac_company_name,left.comp_name);
																			self.FullName := '';
																			self.FirstName := '';
																			self.MiddleName := '';
																			self.LastName := '';
																			self.Suffix := '';
																			self.Title := '';
																			self.Gender := '';
																			self.CompanyName := left.prac_company_name;));
		self.Addresses := project(l,transform(Layouts.layout_addressinfo,
																		self.addrSeq := Constants.ADDR_SEQ_ENCLARITY;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := (string)left.addr_conf_score;
																		self.addrType := '';
																		self.addrTypeCode := left.normed_addr_rec_type;
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := (string)left.clean_last_verify_date;
																		self.addrPenalty := 0;
																		self.address1 := Functions.buildAddress(left.clean_prim_range,left.clean_predir,left.clean_prim_name,left.clean_addr_suffix,left.clean_postdir,left.clean_unit_desig,left.clean_sec_range);
																		self.address2 := '';
																		self.prim_range := left.clean_prim_range;
																		self.predir := left.clean_predir;
																		self.prim_name := left.clean_prim_name;
																		self.addr_suffix := left.clean_addr_suffix;
																		self.postdir := left.clean_postdir;
																		self.unit_desig := left.clean_unit_desig;
																		self.sec_range := left.clean_sec_range;
																		self.p_city_name := left.clean_p_city_name;
																		self.v_city_name := left.v_city_name;
																		self.st := left.clean_st;
																		self.z5 := left.clean_z5;
																		self.zip4 := left.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.geo_lat;
																		self.geo_long := left.geo_long;
																		self.fips_state := left.fips_st;
																		self.fips_county := left.fips_county;
																		self.PhoneNumber := left.phone1;
																		self.FaxNumber := left.fax1;
																		self.Phones := dataset([{left.phone1,left.fax1}],Layouts.layout_addressphone);));
		phoneData:= dataset([{l.phone1,'FACILITY PHONE'}],Layouts.layout_phone)(phone<>'');
		faxData:= dataset([{l.fax1,'FACILITY FAX'}],Layouts.layout_phone)(phone<>'');
		self.phones := phoneData+faxData;
		self.bdids := if(l.bdid_score>Constants.DID_SCORE_THRESHOLD and l.bdid>0,dataset([{l.bdid}],Layouts.layout_bdid));
		self.bipkeys := project(l,transform(Layouts.layout_bipkeys, self := left));
		self.npis := dataset([{l.acctno,l.lnpid,l.npi_num,l.npi_num=l.usernpi,2,'','','',l.type1}],Layouts.layout_npi)(npi<>'');
		self.deas := project(l,transform(Layouts.layout_dea,
									self.acctno := left.acctno;
									self.ProviderID:=left.lnpid;
									self.dea:=(string)left.dea_num;
									self.expiration_date := left.dea_num_exp;
									self.dea_bus_act_ind := left.dea_bus_act_ind;
									self.bestsource := 2;
									self.dea_num := left.dea_num;
									self.dea_num_exp := left.dea_num_exp;
									self.dea_num_bus_act_ind := left.dea_bus_act_ind;
									self.dea_num_bus_type := map ( 
																					Left.dea_bus_act_ind = 'A' =>     	'Pharmacy',                                                                                                                                                                                                                                                                                                                                 
																					Left.dea_bus_act_ind = 'B' =>     	'Hospital/Clinic',
																					Left.dea_bus_act_ind = 'C' =>     	'Practitioner',
																					Left.dea_bus_act_ind = 'D' =>     	'Teaching Institution',
																					Left.dea_bus_act_ind = 'E' =>     	'Manufacturer',
																					Left.dea_bus_act_ind = 'F' =>     	'Distributor',
																					Left.dea_bus_act_ind = 'G' =>     	'Researcher',
																					Left.dea_bus_act_ind = 'H' =>     	'Analytical Lab',
																					Left.dea_bus_act_ind = 'J' =>     	'Importer',
																					Left.dea_bus_act_ind = 'K' =>     	'Exporter',
																					Left.dea_bus_act_ind = 'M' =>     	'Mid Level Practitioner',
																					Left.dea_bus_act_ind = 'N' =>     	'Narcotic Treatment Program',
																					Left.dea_bus_act_ind = 'P' =>     	'Narcotic Treatment Program',
																					Left.dea_bus_act_ind = 'R' =>     	'Narcotic Treatment Program',
																					Left.dea_bus_act_ind = 'S' =>     	'Narcotic Treatment Program',
																					Left.dea_bus_act_ind = 'T' =>     	'Narcotic Treatment Program',
																					Left.dea_bus_act_ind = 'U' =>     	'Narcotic Treatment Program',
																					'');
									self.dea_AddressLine1 := Functions.buildAddress(left.clean_prim_range,left.clean_predir,left.clean_prim_name,left.clean_addr_suffix,left.clean_postdir,left.clean_unit_desig,left.clean_sec_range);
									self.dea_AddressLine2 := '';
									self.dea_prim_range := left.clean_prim_range;
									self.dea_predir := left.clean_predir;
									self.dea_prim_name := left.clean_prim_name;
									self.dea_addr_suffix := left.clean_addr_suffix;
									self.dea_postdir := left.clean_postdir;
									self.dea_unit_desig := left.clean_unit_desig;
									self.dea_sec_range := left.clean_sec_range;
									self.dea_p_city_name := left.clean_p_city_name;
									self.dea_st := left.clean_st;
									self.dea_z5 := left.clean_z5;
									self.dea_zip4 := left.zip4;
									self.dea_geo_lat := left.geo_lat;
									self.dea_geo_long := left.geo_long;));
		self.StateLicenses := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.lic_state,l.lic_num,'',l.lic_type,l.lic_status,l.lic_begin_date,l.lic_end_date,''}],Layouts.layout_licenseinfo)(LicenseNumber<>'');
		self.Taxonomy := dataset([{l.acctno,l.group_key,l.lnpid,l.taxonomy,'',l.type1,l.classification}],Layouts.layout_taxonomy);
		self.sanctions := project(l,transform(Layouts.layout_sanctions, self.acctno:=if(l.sanc1_date <> '',l.acctno,skip);self.ProviderID:=l.lnpid;self.group_key:=l.group_key;
																							self.sanc1_date:=l.sanc1_date;self.sanc1_code:=l.sanc1_code;self.sanc1_state:=l.lic_state;
																							self.sanc1_lic_num:=l.lic_num;self.lnpid:=l.lnpid;self.clean_sanc1_date:=(string)l.clean_sanc1_date;self:=[];));
		Self.SrcRecRaw :=  project(l,transform(Layouts.layout_SrcRec,
																		self.Src := constants.SRC_SELECTFILE;
																		self.nameSeq := 1;
																		self.namePenalty := ut.CompanySimilar100(left.prac_company_name,left.comp_name);
																		self.FullName := '';
																		self.FirstName := '';
																		self.MiddleName := '';
																		self.LastName := '';
																		self.Suffix := '';
																		self.Title := '';
																		self.Gender := '';
																		self.CompanyName := left.prac_company_name;
																		self.addrSeq := Constants.ADDR_SEQ_ENCLARITY;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := left.normed_addr_rec_type;
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := (string)left.clean_last_verify_date;
																		self.addrPenalty := 0;
																		self.address1 := Functions.buildAddress(left.clean_prim_range,left.clean_predir,left.clean_prim_name,left.clean_addr_suffix,left.clean_postdir,left.clean_unit_desig,left.clean_sec_range);
																		self.address2 := '';
																		self.prim_range := left.clean_prim_range;
																		self.predir := left.clean_predir;
																		self.prim_name := left.clean_prim_name;
																		self.addr_suffix := left.clean_addr_suffix;
																		self.postdir := left.clean_postdir;
																		self.unit_desig := left.clean_unit_desig;
																		self.sec_range := left.clean_sec_range;
																		self.p_city_name := left.clean_p_city_name;
																		self.v_city_name := left.v_city_name;
																		self.st := left.clean_st;
																		self.z5 := left.clean_z5;
																		self.zip4 := left.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.geo_lat;
																		self.geo_long := left.geo_long;
																		self.fips_state := left.fips_st;
																		self.fips_county := left.fips_county;
																		self.PhoneNumber := left.phone1;
																		self.FaxNumber := left.fax1;
																		self.Phones := dataset([{left.phone1,left.fax1}],Layouts.layout_addressphone);
																		self.dob := '';
																		self.did := 0;
																		self.bdid := if(left.bdid_score>Constants.DID_SCORE_THRESHOLD and left.bdid>0,left.bdid,0);
																		self.dotid:=left.dotid;
																		self.empid:=left.empid;
																		self.powid:=left.powid;
																		self.seleid:=left.seleid;
																		self.proxid:=left.proxid;
																		self.orgid:=left.orgid;
																		self.ultid:=left.ultid;
																		self := left;
																		self:=[];));
		self:=l;
		self:=[]; 
	end;

	//Enclarity Business Base transforms
	Export Layouts.CombinedHeaderResults build_selectfile_Facility_sanctions (Layouts.searchKeyResults_plus_input l, recordof(Enclarity_facility_sanctions.Keys(,true).facility_sanctions_lnfid.qa) r) := transform
		self.acctno := l.acctno;
		self.sources := dataset([{r.group_key,Constants.SRC_SELECTFILE}],Layouts.layout_SrcID);
		self.LNPID := r.lnfid;
		self.srcID := r.lnfid;
		self.vendorid := r.group_key;
		self.src := Constants.SRC_SELECTFILE;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.hasStateRestrict := true;//Does not appear that we have Business Sanctions
		self.hasOIG := false;
		self.hasOPM := false;//Does not appear that we have Business Sanctions
		self.medicare_fac_num := r.medicaid_fac_num;
		self.status := '';//No rules yet on status for businesses;
		getNames :=  project(r,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 1;
																			self.namePenalty := ut.CompanySimilar100(left.prac_company1_name,l.comp_name);
																			self.CompanyName := stringlib.StringToUpperCase(left.prac_company1_name)))+
									project(r,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 2;
																			self.namePenalty := ut.CompanySimilar100(left.dba_name,l.comp_name);
																			self.CompanyName := stringlib.StringToUpperCase(left.dba_name)))+
									project(r,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 3;
																			self.namePenalty := ut.CompanySimilar100(left.bill_company1_name,l.comp_name);
																			self.CompanyName := stringlib.StringToUpperCase(left.bill_company1_name)));
		self.names := getNames(CompanyName <>'');
		getAddresses := project(r,transform(Layouts.layout_addressinfo,
																		self.addrSeq := Constants.ADDR_SEQ_ENCLARITY;
																		self.addrTypeCode := 'P';
																		self.addrVerificationDate := (string)left.Date_vendor_last_reported;
																		self.address1 := Functions.buildAddress(left.clean_prac1_prim_range,left.clean_prac1_predir,left.clean_prac1_prim_name,left.clean_prac1_addr_suffix,left.clean_prac1_postdir,left.clean_prac1_unit_desig,left.clean_prac1_sec_range);
																		self.prim_range := left.clean_prac1_prim_range;
																		self.predir := left.clean_prac1_predir;
																		self.prim_name := left.clean_prac1_prim_name;
																		self.addr_suffix := left.clean_prac1_addr_suffix;
																		self.postdir := left.clean_prac1_postdir;
																		self.unit_desig := left.clean_prac1_unit_desig;
																		self.sec_range := left.clean_prac1_sec_range;
																		self.p_city_name := left.clean_prac1_p_city_name;
																		self.v_city_name := left.clean_prac1_v_city_name;
																		self.st := left.clean_prac1_st;
																		self.z5 := left.clean_prac1_zip;
																		self.zip4 := left.clean_prac1_zip4;
																		self.last_seen := (string)left.date_last_seen;
																		self.first_seen := (string)left.date_first_seen;
																		self.v_last_seen := (string)left.Date_vendor_last_reported;
																		self.v_first_seen := (string)left.Date_vendor_first_reported;
																		self.geo_lat := left.clean_prac1_geo_lat;
																		self.geo_long := left.clean_prac1_geo_long;
																		self.fips_state := left.clean_prac1_fips_st;
																		self.fips_county := left.clean_prac1_fips_county;
																		self.PhoneNumber := left.prac_phone1;
																		self.FaxNumber := left.prac_fax1;
																		self.Phones := dataset([{left.prac_phone1,left.prac_fax1}],Layouts.layout_addressphone);))+
										project(r,transform(Layouts.layout_addressinfo,
																		self.addrSeq := Constants.ADDR_SEQ_ENCLARITY;
																		self.addrTypeCode := 'P';
																		self.addrVerificationDate := (string)left.Date_vendor_last_reported;
																		self.address1 := Functions.buildAddress(left.clean_prac2_prim_range,left.clean_prac2_predir,left.clean_prac2_prim_name,left.clean_prac2_addr_suffix,left.clean_prac2_postdir,left.clean_prac2_unit_desig,left.clean_prac2_sec_range);
																		self.prim_range := left.clean_prac2_prim_range;
																		self.predir := left.clean_prac2_predir;
																		self.prim_name := left.clean_prac2_prim_name;
																		self.addr_suffix := left.clean_prac2_addr_suffix;
																		self.postdir := left.clean_prac2_postdir;
																		self.unit_desig := left.clean_prac2_unit_desig;
																		self.sec_range := left.clean_prac2_sec_range;
																		self.p_city_name := left.clean_prac2_p_city_name;
																		self.v_city_name := left.clean_prac2_v_city_name;
																		self.st := left.clean_prac2_st;
																		self.z5 := left.clean_prac2_zip;
																		self.zip4 := left.clean_prac2_zip4;
																		self.last_seen := (string)left.date_last_seen;
																		self.first_seen := (string)left.date_first_seen;
																		self.v_last_seen := (string)left.Date_vendor_last_reported;
																		self.v_first_seen := (string)left.Date_vendor_first_reported;
																		self.geo_lat := left.clean_prac2_geo_lat;
																		self.geo_long := left.clean_prac2_geo_long;
																		self.fips_state := left.clean_prac2_fips_st;
																		self.fips_county := left.clean_prac2_fips_county;
																		self.PhoneNumber := left.prac_phone1;
																		self.FaxNumber := left.prac_fax1;
																		self.Phones := dataset([{left.prac_phone1,left.prac_fax1}],Layouts.layout_addressphone);))+
											project(r,transform(Layouts.layout_addressinfo,
																		self.addrSeq := Constants.ADDR_SEQ_ENCLARITY;
																		self.addrTypeCode := 'B';
																		self.addrVerificationDate := (string)left.Date_vendor_last_reported;
																		self.address1 := Functions.buildAddress(left.clean_bill1_prim_range,left.clean_bill1_predir,left.clean_bill1_prim_name,left.clean_bill1_addr_suffix,left.clean_bill1_postdir,left.clean_bill1_unit_desig,left.clean_bill1_sec_range);
																		self.prim_range := left.clean_bill1_prim_range;
																		self.predir := left.clean_bill1_predir;
																		self.prim_name := left.clean_bill1_prim_name;
																		self.addr_suffix := left.clean_bill1_addr_suffix;
																		self.postdir := left.clean_bill1_postdir;
																		self.unit_desig := left.clean_bill1_unit_desig;
																		self.sec_range := left.clean_bill1_sec_range;
																		self.p_city_name := left.clean_bill1_p_city_name;
																		self.v_city_name := left.clean_bill1_v_city_name;
																		self.st := left.clean_bill1_st;
																		self.z5 := left.clean_bill1_zip;
																		self.zip4 := left.clean_bill1_zip4;
																		self.last_seen := (string)left.date_last_seen;
																		self.first_seen := (string)left.date_first_seen;
																		self.v_last_seen := (string)left.Date_vendor_last_reported;
																		self.v_first_seen := (string)left.Date_vendor_first_reported;
																		self.geo_lat := left.clean_bill1_geo_lat;
																		self.geo_long := left.clean_bill1_geo_long;
																		self.fips_state := left.clean_bill1_fips_st;
																		self.fips_county := left.clean_bill1_fips_county;
																		self.PhoneNumber := left.bill_phone1;
																		self.FaxNumber := left.bill_fax1;
																		self.Phones := dataset([{left.bill_phone1,left.bill_fax1}],Layouts.layout_addressphone);));
		self.Addresses := getAddresses(prim_range<>'');
		phoneData:= dataset([{r.prac_phone1,'FACILITY PHONE'}],Layouts.layout_phone)(phone<>'');
		faxData:= dataset([{r.prac_fax1,'FACILITY FAX'}],Layouts.layout_phone)(phone<>'');
		self.phones := phoneData+faxData;
		self.bdids := if(r.bdid_score>Constants.DID_SCORE_THRESHOLD and r.bdid>0,dataset([{r.bdid}],Layouts.layout_bdid));
		self.bipkeys := project(r,transform(Layouts.layout_bipkeys, self := left));
		self.npis := dataset([{l.acctno,r.lnfid,r.npi_num,r.npi_num=l.usernpi,2,r.npi_deact_date,'','','2'}],Layouts.layout_npi)(npi<>'');
		self.StateLicenses := dataset([{l.acctno,r.lnfid,r.lnfid,0,r.lic1_state,r.lic1_num,'',r.lic1_type,r.lic1_status,Healthcare_Header_Services.Functions.cleanOnlyNumbers(r.lic1_begin_date),Healthcare_Header_Services.Functions.cleanOnlyNumbers(r.lic1_end_date),''}],Layouts.layout_licenseinfo)(LicenseNumber<>'' and LicenseNumber<>'0');
		self.Taxonomy := dataset([{l.acctno,r.group_key,r.lnfid,r.taxonomy,r.taxonomy_primary_ind,'',''}],Layouts.layout_taxonomy);
		self.sanctions := project(r,transform(Layouts.layout_sanctions, 
															self.acctno:=l.acctno;self.ProviderID:=left.lnfid;self.group_key:=left.group_key;
															self.sanc1_date :=Healthcare_Header_Services.Functions.cleanOnlyNumbers(left.sanc1_date);self.sanc1_state := left.sanc1_state;
															self.sanc1_lic_num := left.lic1_num; self.sanc1_prof_type := left.facility_type;
															self.sanc1_rein_date :=Healthcare_Header_Services.Functions.cleanOnlyNumbers(left.sanc1_rein_date);// self.pid left.pid;
															self.SancLegacyType := left.sanc1_complaint;
															self.src := left.src;	self.dt_vendor_first_reported := left.Date_vendor_first_reported;
															self.dt_vendor_last_reported := left.Date_vendor_last_reported; self.dt_first_seen	:= (integer)left.date_first_seen;
															self.dt_last_seen	:= (integer)left.date_last_seen; self.record_type := left.record_type;
															self.source_rid := left.source_rid; self.lnpid:=left.lnfid;	self.clean_sanc1_date:=(string)left.clean_sanc1_date;
															self.clean_sanc1_rein_date := left.clean_sanc1_rein_date; self.LN_derived_rein_date := left.LN_derived_rein_date;
															self.LN_derived_rein_flag	:= left.LN_derived_rein_date <> '';	self.Level	:= 'STATE';	
															self.Enc_derived_rein_date := Healthcare_Header_Services.Functions.cleanOnlyNumbers(left.sanc1_rein_date); self.Enc_derived_rein_flag := if((integer)Healthcare_Header_Services.Functions.cleanOnlyNumbers(left.sanc1_rein_date) > 0,'TRUE','FALSE');
															self.prov_type_desc := left.facility_type;
															self.FullDesc := left.sanc1_description_ef; 
															self.SancCategory :=left.sanc1_complaint;
															self.SancLevel :='STATE';
															self.StateOrFederal := 'STATE';
															self.RegulatingBoard := left.sanc1_board_name;
															self.SpecialNotes := trim(left.sanc1_case_num_ef,right)+' '+trim(left.sanc1_terms_ef,right)+' '+trim(left.sanc1_fine_ef,right)+' '+trim(left.sanc1_condition_ef,right);
															self.LicenseStatus :=left.provider_status_ef;
															self.isReinstatement := left.LN_derived_rein_flag or (integer)Healthcare_Header_Services.Functions.cleanOnlyNumbers(left.sanc1_rein_date) > 0;
															self:=[];));
		self:=r;
		self:=l;
		self:=[]; 
	end;

	//Enclarity rollups
	export Layouts.layout_addressinfo doSelectFileProvidersBaseRecordAddrRollup(Layouts.layout_addressinfo l,
																										DATASET(Layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self.addrConfidenceValue := max(allRows,addrConfidenceValue);
			self.addrVerificationDate := max(allRows,addrVerificationDate);
			self := l;
			self := [];
	end;
	export Layouts.CombinedHeaderResults doSelectFileProvidersBaseRecordSrcIdRollup(Layouts.CombinedHeaderResults l, 
																									DATASET(Layouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.LNPID := l.LNPID;
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := l.ProcessingMessage;
		self.vendorid := l.vendorid;
		self.hasStateRestrict := exists(allRows(hasStateRestrict=true));
		self.hasOIG := exists(allRows(hasOIG=true));
		self.hasOPM := exists(allRows(hasOPM=true));
		//Handle Status
		statusDeceased := exists(allRows(status='D'));
		statusReportedHighDeceased := exists(allRows(status='U'));
		statusReportedDeceased := exists(allRows(status='U1'));
		statusHighRetired := exists(allRows(status='R1'));
		statusMediumRetired := exists(allRows(status='R2'));
		statusLowRetired := exists(allRows(status='R4'));
		statusActive := exists(allRows(status='N'));

		self.status := map(statusDeceased or statusReportedHighDeceased or statusReportedDeceased => 'D',
											 statusHighRetired or statusMediumRetired or statusLowRetired => 'R',
											 statusActive => 'A',
											 ' ');
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := sort(DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL ),namePenalty);
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses(prim_name<>'',p_city_name<>'',st<>'',z5<>''), 
																											TRANSFORM( Layouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5,-(integer)addrConfidenceValue,-addrVerificationDate),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doSelectFileProvidersBaseRecordAddrRollup(left,rows(left))),-(integer)addrConfidenceValue,-addrVerificationDate);
		self.dobs          := DEDUP( NORMALIZE( allRows, LEFT.dobs, TRANSFORM( Layouts.layout_dob, SELF := RIGHT	)	), dob, ALL );
		self.phones        := DEDUP( NORMALIZE( allRows, LEFT.phones, TRANSFORM( Layouts.layout_phone, SELF := RIGHT	)	), record, ALL );
		self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( Layouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL );
		self.dids          := Functions.processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( Layouts.layout_did, SELF := RIGHT	)	) );
		self.bdids         := Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	) );
		self.bipkeys       := Functions.processBIPKeys( NORMALIZE( allRows, LEFT.bipkeys, TRANSFORM( Layouts.layout_bipkeys, SELF := RIGHT	)	) );
		self.optouts       := dedup( NORMALIZE( allRows, LEFT.optouts, TRANSFORM( Layouts.layout_optout, SELF := RIGHT	)	), record, all );
		self.upins	       := dedup( NORMALIZE( allRows, LEFT.upins, TRANSFORM( Layouts.layout_upin, SELF := RIGHT	)	), record, all );
		self.npis	      	 := dedup( NORMALIZE( allRows, LEFT.npis, TRANSFORM( Layouts.layout_npi, SELF := RIGHT	)	), record, all );
		self.deas	      	 := sort(dedup( NORMALIZE( allRows, LEFT.deas, TRANSFORM( Layouts.layout_dea, SELF := RIGHT	)	), record, all ),-expiration_date);
		self.StateLicenses := sort(dedup( NORMALIZE( allRows, LEFT.StateLicenses, TRANSFORM( Layouts.layout_licenseinfo, SELF := RIGHT	)	), record, all ),LicenseState,-Termination_Date, LicenseNumber);
		self.SrcRecRaw		 := sort(dedup( project(sort(allRows.SrcRecRaw,
																			Src,namePenalty,-(integer)addrConfidenceValue,-addrVerificationDate,seq,nameSeq,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																			ssn,dob,did,bdid,fein,dotid,empid,powid,proxid,orgid,ultid,
																			addrSeq,addrSeqGrp,addrGoldFlag,addrType,addrTypeCode,addrVerificationStatusFlag,
																			address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																			sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),AddSequence(left,counter)),
																Src,nameSeq,namePenalty,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																ssn,dob,did,bdid,fein,dotid,empid,powid,proxid,orgid,ultid,
																addrSeq,addrSeqGrp,addrGoldFlag,addrConfidenceValue,addrType,addrTypeCode,addrVerificationStatusFlag,
																addrVerificationDate,address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),
													src,seq);
		self.Sanctions			:=  sort(dedup(sort(NORMALIZE( allRows, LEFT.Sanctions, TRANSFORM( Layouts.layout_sanctions, SELF := RIGHT	)	), acctno,ProviderID,group_key,GroupSortOrder,sanc1_state,sanc1_lic_num,sanc1_date), acctno,ProviderID,group_key,GroupSortOrder,sanc1_state,sanc1_lic_num,sanc1_date),GroupSortOrder);
		self.LegacySanctions:=  sort(dedup(sort(NORMALIZE( allRows, LEFT.LegacySanctions, TRANSFORM( Layouts.layout_LegacySanctions, SELF := RIGHT	)	), acctno,ProviderID,group_key,GroupSortOrder,SANC_SANCST,SANC_LICNBR,SANC_SANCDTE), acctno,ProviderID,group_key,GroupSortOrder,SANC_SANCST,SANC_LICNBR,SANC_SANCDTE),groupsortorder);
		self := l;
	end;
	export Layouts.CombinedHeaderResults doSelectFileFacilitiesBaseRecordSrcIdRollup(Layouts.CombinedHeaderResults l, 
																									DATASET(Layouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.LNPID := l.LNPID;
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := l.ProcessingMessage;
		self.vendorid := l.vendorid;
		self.hasStateRestrict := exists(allRows(hasStateRestrict=true));
		self.hasOIG := exists(allRows(hasOIG=true));
		self.hasOPM := exists(allRows(hasOPM=true));
		//Handle Status
		statusDeceased := exists(allRows(status='D'));
		statusReportedHighDeceased := exists(allRows(status='U'));
		statusReportedDeceased := exists(allRows(status='U1'));
		statusHighRetired := exists(allRows(status='R1'));
		statusMediumRetired := exists(allRows(status='R2'));
		statusLowRetired := exists(allRows(status='R4'));
		statusActive := exists(allRows(status='N'));
		self.status := map(statusDeceased or statusReportedHighDeceased or statusReportedDeceased => 'D',
											 statusHighRetired or statusMediumRetired or statusLowRetired => 'R',
											 statusActive => 'A',
											 ' ');
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := sort(DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL ),namePenalty);
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( Layouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doSelectFileProvidersBaseRecordAddrRollup(left,rows(left))),-(integer)addrConfidenceValue,-addrVerificationDate);
		self.phones        := DEDUP( NORMALIZE( allRows, LEFT.phones, TRANSFORM( Layouts.layout_phone, SELF := RIGHT	)	), record, ALL );
		self.bdids         := Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	) );
		self.bipkeys       := Functions.processBIPKeys( NORMALIZE( allRows, LEFT.bipkeys, TRANSFORM( Layouts.layout_bipkeys, SELF := RIGHT	)	) );
		self.npis	      	 := dedup( NORMALIZE( allRows, LEFT.npis, TRANSFORM( Layouts.layout_npi, SELF := RIGHT	)	), record, all );
		self.deas	      	 := sort(dedup( NORMALIZE( allRows, LEFT.deas, TRANSFORM( Layouts.layout_dea, SELF := RIGHT	)	), record, all ),-expiration_date);
		self.StateLicenses := sort(dedup( NORMALIZE( allRows, LEFT.StateLicenses, TRANSFORM( Layouts.layout_licenseinfo, SELF := RIGHT	)	), record, all ),LicenseState,-Termination_Date, LicenseNumber);
		self.Taxonomy 		 := sort(dedup( NORMALIZE( allRows, LEFT.Taxonomy, TRANSFORM( Layouts.layout_taxonomy, SELF := RIGHT	)	), record, all ),record);
		self.Sanctions 		 := sort(dedup( NORMALIZE( allRows, LEFT.Sanctions, TRANSFORM( Layouts.layout_sanctions, SELF := RIGHT	)	), record, all ),-clean_sanc1_date);
		self.LegacySanctions:= sort(dedup( NORMALIZE( allRows, LEFT.LegacySanctions, TRANSFORM( Layouts.layout_LegacySanctions, SELF := RIGHT	)	), record, all ),-SANC_SANCDTE);
		self.SrcRecRaw		 := sort(dedup( project(sort(allRows.SrcRecRaw,
																			Src,namePenalty,-(integer)addrConfidenceValue,-addrVerificationDate,-Ultid,-orgid,-seleid,-proxid,seq,nameSeq,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																			ssn,dob,did,bdid,fein,dotid,empid,powid,
																			addrSeq,addrSeqGrp,addrGoldFlag,addrType,addrTypeCode,addrVerificationStatusFlag,
																			address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																			sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),AddSequence(left,counter)),
																Src,nameSeq,namePenalty,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																ssn,dob,did,bdid,fein,dotid,empid,powid,proxid,seleid,orgid,ultid,
																addrSeq,addrSeqGrp,addrGoldFlag,addrConfidenceValue,addrType,addrTypeCode,addrVerificationStatusFlag,
																addrVerificationDate,address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),
													src,seq);
		self := l;
	end;

	//DEA Legacy transforms
	Export iesp.healthcare.t_DEAControlledSubstanceRecordEx build_DeaRaw (Layouts.dea_base_with_input l) := transform

		self.Number := l.rawData.dea_registration_number;
		self.RegistrationNumber := l.rawData.dea_registration_number;
		self.SSN := l.best_ssn;
		self.CompanyName := l.rawData.cname;

		SELF.Name := iesp.ECL2ESP.SetName (L.rawData.fname, L.rawData.mname, L.rawData.lname, L.rawData.name_suffix, L.rawData.title,'');
		SELF.Address := iesp.ECL2ESP.SetAddress(
			l.rawData.prim_name,l.rawData.prim_range,L.rawData.predir,L.rawData.postdir, L.rawData.addr_suffix,L.rawData.unit_desig,L.rawData.sec_range, 
			l.rawData.p_city_name,l.rawData.st,l.rawData.zip,l.rawData.zip4,'');
		SELF.BusinessType := map ( 
					L.rawData.Business_activity_code = 'A' =>     	'Pharmacy',                                                                                                                                                                                                                                                                                                                                 
					L.rawData.Business_activity_code = 'B' =>     	'Hospital/Clinic',
					L.rawData.Business_activity_code = 'C' =>     	'Practitioner',
					L.rawData.Business_activity_code = 'D' =>     	'Teaching Institution',
					L.rawData.Business_activity_code = 'E' =>     	'Manufacturer',
					L.rawData.Business_activity_code = 'F' =>     	'Distributor',
					L.rawData.Business_activity_code = 'G' =>     	'Researcher',
					L.rawData.Business_activity_code = 'H' =>     	'Analytical Lab',
					L.rawData.Business_activity_code = 'J' =>     	'Importer',
					L.rawData.Business_activity_code = 'K' =>     	'Exporter',
					L.rawData.Business_activity_code = 'M' =>     	'Mid Level Practitioner',
					L.rawData.Business_activity_code = 'N' =>     	'Narcotic Treatment Program',
					L.rawData.Business_activity_code = 'P' =>     	'Narcotic Treatment Program',
					L.rawData.Business_activity_code = 'R' =>     	'Narcotic Treatment Program',
					L.rawData.Business_activity_code = 'S' =>     	'Narcotic Treatment Program',
					L.rawData.Business_activity_code = 'T' =>     	'Narcotic Treatment Program',
					L.rawData.Business_activity_code = 'U' =>     	'Narcotic Treatment Program',
					'');		
		SELF.DrugSchedules := L.rawData.Drug_Schedules;
		SELF.ExpirationDate := iesp.ECL2ESP.toDate((INTEGER)L.rawData.Expiration_Date);
    SELF := [];
	end;

	//DEA Base transforms
	Export Layouts.CombinedHeaderResults build_Dea_base (Layouts.dea_base_with_input l) := transform
		self.acctno := l.acctno;
		self.sources := dataset([{l.rawdata.dea_registration_number,Constants.SRC_DEA}],Layouts.layout_SrcID);
		self.LNPID := l.lnpid;
		self.VendorID := l.rawdata.dea_registration_number;
		self.srcID := l.lnpid;
		self.src := Constants.SRC_DEA;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		isIndividual := L.rawData.Business_activity_code[1] in ['C','G','M'];
		hasName := l.rawdata.fname <> '' or l.rawdata.lname <> '';
		keeprec := if(isIndividual and not hasname,false,true);
		self.names := project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 5;
																			self.namePenalty := 0;
																			self.FullName := '';
																			self.FirstName := if(keeprec,left.rawdata.fname,skip);
																			self.MiddleName := left.rawdata.mname;
																			self.LastName := left.rawdata.lname;
																			self.Suffix := left.rawdata.name_suffix;
																			self.Title := left.rawdata.title;
																			self.Gender := '';
																			self.CompanyName := left.rawdata.cname));
		self.Addresses := project(l,transform(Layouts.layout_addressinfo,
																		self.addrSeq := Constants.ADDR_SEQ_DEA;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := '';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := Functions.buildAddress(left.rawdata.prim_range,left.rawdata.predir,left.rawdata.prim_name,left.rawdata.addr_suffix,left.rawdata.postdir,left.rawdata.unit_desig,left.rawdata.sec_range);
																		self.address2 := '';
																		self.prim_range := left.rawdata.prim_range;
																		self.predir := left.rawdata.predir;
																		self.prim_name := left.rawdata.prim_name;
																		self.addr_suffix := left.rawdata.addr_suffix;
																		self.postdir := left.rawdata.postdir;
																		self.unit_desig := left.rawdata.unit_desig;
																		self.sec_range := left.rawdata.sec_range;
																		self.p_city_name := left.rawdata.p_city_name;
																		self.v_city_name := left.rawdata.v_city_name;
																		self.st := left.rawdata.st;
																		self.z5 := left.rawdata.zip;
																		self.zip4 := left.rawdata.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := '';
																		self.first_seen := '';
																		self.v_last_seen := (string)left.rawdata.date_last_reported;
																		self.v_first_seen := (string)left.rawdata.date_first_reported;
																		self.geo_lat := left.rawdata.geo_lat;
																		self.geo_long := left.rawdata.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := '';
																		self.FaxNumber := '';
																		self.Phones := dataset([],Layouts.layout_addressphone);));
		self.dids := dataset([{(integer)l.did}],Layouts.layout_did)(did>0);
		self.bdids := dataset([{(integer)l.bdid}],Layouts.layout_bdid)(bdid>0);
		self.ssns := dataset([{l.best_ssn}],Layouts.layout_ssn)(ssn<>'');
		self.deas := project(l,transform(Layouts.layout_dea,
									self.acctno := left.acctno;
									self.ProviderID:=left.lnpid;
									self.dea:=(string)left.rawdata.dea_registration_number;
									self.expiration_date := left.rawdata.expiration_date;
									self.dea_bus_act_ind := left.rawdata.Business_activity_code;
									self.bestsource := 1;
									self.dea_num := left.rawdata.dea_registration_number;
									self.dea_num_exp := left.rawdata.Expiration_Date;
									self.dea_num_sch := left.rawdata.Drug_Schedules;
									self.dea_num_bus_act_ind := left.rawdata.Business_activity_code;
									self.dea_num_deact_date := '';//not in our dea file
									self.dea_stat := 0;
									self.dea_num_status := left.rawdata.Activity;
									self.dea_num_bus_act_sub_ind := left.rawdata.Bus_Activity_Sub_Code;
									self.dea_num_bus_type := map ( 
																					Left.rawData.Business_activity_code = 'A' =>     	'Pharmacy',                                                                                                                                                                                                                                                                                                                                 
																					Left.rawData.Business_activity_code = 'B' =>     	'Hospital/Clinic',
																					Left.rawData.Business_activity_code = 'C' =>     	'Practitioner',
																					Left.rawData.Business_activity_code = 'D' =>     	'Teaching Institution',
																					Left.rawData.Business_activity_code = 'E' =>     	'Manufacturer',
																					Left.rawData.Business_activity_code = 'F' =>     	'Distributor',
																					Left.rawData.Business_activity_code = 'G' =>     	'Researcher',
																					Left.rawData.Business_activity_code = 'H' =>     	'Analytical Lab',
																					Left.rawData.Business_activity_code = 'J' =>     	'Importer',
																					Left.rawData.Business_activity_code = 'K' =>     	'Exporter',
																					Left.rawData.Business_activity_code = 'M' =>     	'Mid Level Practitioner',
																					Left.rawData.Business_activity_code = 'N' =>     	'Narcotic Treatment Program',
																					Left.rawData.Business_activity_code = 'P' =>     	'Narcotic Treatment Program',
																					Left.rawData.Business_activity_code = 'R' =>     	'Narcotic Treatment Program',
																					Left.rawData.Business_activity_code = 'S' =>     	'Narcotic Treatment Program',
																					Left.rawData.Business_activity_code = 'T' =>     	'Narcotic Treatment Program',
																					Left.rawData.Business_activity_code = 'U' =>     	'Narcotic Treatment Program',
																					'');
									self.dea_AddressLine1 := Functions.buildAddress(left.rawdata.prim_range,left.rawdata.predir,left.rawdata.prim_name,left.rawdata.addr_suffix,left.rawdata.postdir,left.rawdata.unit_desig,left.rawdata.sec_range);
									self.dea_AddressLine2 := '';
									self.dea_prim_range := left.rawdata.prim_range;
									self.dea_predir := left.rawdata.predir;
									self.dea_prim_name := left.rawdata.prim_name;
									self.dea_addr_suffix := left.rawdata.addr_suffix;
									self.dea_postdir := left.rawdata.postdir;
									self.dea_unit_desig := left.rawdata.unit_desig;
									self.dea_sec_range := left.rawdata.sec_range;
									self.dea_p_city_name := left.rawdata.p_city_name;
									self.dea_st := left.rawdata.st;
									self.dea_z5 := left.rawdata.zip;
									self.dea_zip4 := left.rawdata.zip4;
									self.dea_geo_lat := left.rawdata.geo_lat;
									self.dea_geo_long := left.rawdata.geo_long;));
		self.DEARaw := project(l,build_DeaRaw(left));
		Self.SrcRecRaw :=  project(l,transform(Layouts.layout_SrcRec,
																		self.Src := constants.SRC_DEA;
																		self.nameSeq := 5;
																		self.namePenalty := 0;
																		self.FullName := '';
																		self.FirstName := left.rawdata.fname;
																		self.MiddleName := left.rawdata.mname;
																		self.LastName := left.rawdata.lname;
																		self.Suffix := left.rawdata.name_suffix;
																		self.Title := left.rawdata.title;
																		self.Gender := '';
																		self.CompanyName := left.rawdata.cname;
																		self.addrSeq := Constants.ADDR_SEQ_DEA;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := '';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := Functions.buildAddress(left.rawdata.prim_range,left.rawdata.predir,left.rawdata.prim_name,left.rawdata.addr_suffix,left.rawdata.postdir,left.rawdata.unit_desig,left.rawdata.sec_range);
																		self.address2 := '';
																		self.prim_range := left.rawdata.prim_range;
																		self.predir := left.rawdata.predir;
																		self.prim_name := left.rawdata.prim_name;
																		self.addr_suffix := left.rawdata.addr_suffix;
																		self.postdir := left.rawdata.postdir;
																		self.unit_desig := left.rawdata.unit_desig;
																		self.sec_range := left.rawdata.sec_range;
																		self.p_city_name := left.rawdata.p_city_name;
																		self.v_city_name := left.rawdata.v_city_name;
																		self.st := left.rawdata.st;
																		self.z5 := left.rawdata.zip;
																		self.zip4 := left.rawdata.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := '';
																		self.first_seen := '';
																		self.v_last_seen := (string)left.rawdata.date_last_reported;
																		self.v_first_seen := (string)left.rawdata.date_first_reported;
																		self.geo_lat := left.rawdata.geo_lat;
																		self.geo_long := left.rawdata.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := '';
																		self.FaxNumber := '';
																		self.Phones := dataset([],Layouts.layout_addressphone);
																		self.ssn := left.best_ssn;
																		self.did := (integer)left.did;
																		self.bdid := (integer)left.bdid;
																		self := left;
																		self:=[];));
		self:=l; 
		self:=[];
	END;

	//DEA Rollups
	export Layouts.layout_addressinfo doDEABaseRecordAddrRollup(Layouts.layout_addressinfo l,
																										DATASET(Layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self := l;
			self := [];
	end;
	export Layouts.CombinedHeaderResults doDEABaseRecordSrcIdRollup(Layouts.CombinedHeaderResults l, 
																									DATASET(Layouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.LNPID := l.LNPID;
		self.Vendorid := l.vendorid;
		self.SrcId := l.lnpid;
		self.Src := l.Src;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := l.ProcessingMessage;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( Layouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doDEABaseRecordAddrRollup(left,rows(left))),addrseq);
		self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( Layouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL );
		self.dids          := Functions.processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( Layouts.layout_did, SELF := RIGHT	)	) );
		self.bdids         := Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	) );
		self.deas	         := DEDUP(sort(NORMALIZE(allRows, LEFT.deas, TRANSFORM(Layouts.layout_dea, SELF := RIGHT)), dea,-expiration_date),dea,expiration_date);
		self.DEARaw        := sort(NORMALIZE(allRows, LEFT.DEARaw, TRANSFORM(iesp.healthcare.t_DEAControlledSubstanceRecordEx, SELF := RIGHT)),RegistrationNumber,-ExpirationDate);
		self.SrcRecRaw		 := sort(dedup( project(sort(allRows.SrcRecRaw,
																			Src,namePenalty,-(integer)addrConfidenceValue,-addrVerificationDate,-Ultid,-orgid,-seleid,-proxid,seq,nameSeq,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																			ssn,dob,did,bdid,fein,dotid,empid,powid,
																			addrSeq,addrSeqGrp,addrGoldFlag,addrType,addrTypeCode,addrVerificationStatusFlag,
																			address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																			sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),AddSequence(left,counter)),
																Src,nameSeq,namePenalty,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																ssn,dob,did,bdid,fein,dotid,empid,powid,proxid,seleid,orgid,ultid,
																addrSeq,addrSeqGrp,addrGoldFlag,addrConfidenceValue,addrType,addrTypeCode,addrVerificationStatusFlag,
																addrVerificationDate,address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),
													src,seq);
		self := l;
	end;

	//NPPES Base Transform
	Export Layouts.CombinedHeaderResults build_npi_base (Layouts.npi_base_with_input l) := transform
		self.acctno := l.acctno;
		self.sources := dataset([{l.npi,Constants.SRC_NPPES}],Layouts.layout_SrcID);
		self.LNPID := l.lnpid;
		self.VendorID := l.npi;
		self.srcID := (integer)l.npi;
		self.src := Constants.SRC_NPPES;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		name1 := project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 5;
																			self.namePenalty := if(left.provider_organization_name <> '', 100-Healthcare_Header_Services.Functions.CompareBusinessNameConfidence(left.comp_name, left.provider_organization_name), 0);
																			self.FullName := '';
																			self.FirstName := left.clean_name_provider.fname;
																			self.MiddleName := left.clean_name_provider.mname;
																			self.LastName := left.clean_name_provider.lname;
																			self.Suffix := left.clean_name_provider.name_suffix;
																			self.Title := left.clean_name_provider.title;
																			self.Gender := '';
																			self.CompanyName := left.provider_organization_name;));
		nm2Exists := l.provider_other_organization_name<>'';
		name2 := if(nm2Exists,project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 5;
																			self.namePenalty := if(left.provider_other_organization_name <> '', 100-Healthcare_Header_Services.Functions.CompareBusinessNameConfidence(left.comp_name, left.provider_other_organization_name), 0);
																			self.FullName := '';
																			self.FirstName := left.clean_name_provider.fname;
																			self.MiddleName := left.clean_name_provider.mname;
																			self.LastName := left.clean_name_provider.lname;
																			self.Suffix := left.clean_name_provider.name_suffix;
																			self.Title := left.clean_name_provider.title;
																			self.Gender := '';
																			self.CompanyName := left.provider_other_organization_name;)));
		self.names := dedup(sort(name1+name2,record),record);
		Address1 := project(l,transform(Layouts.layout_addressinfo,
																		self.addrSeq := Constants.ADDR_SEQ_NPPES;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'P';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := left.location_prep_address1;
																		self.address2 := '';
																		self.prim_range := left.clean_location_address.prim_range;
																		self.predir := left.clean_location_address.predir;
																		self.prim_name := left.clean_location_address.prim_name;
																		self.addr_suffix := left.clean_location_address.addr_suffix;
																		self.postdir := left.clean_location_address.postdir;
																		self.unit_desig := left.clean_location_address.unit_desig;
																		self.sec_range := left.clean_location_address.sec_range;
																		self.p_city_name := left.clean_location_address.p_city_name;
																		self.v_city_name := left.clean_location_address.v_city_name;
																		self.st := left.clean_location_address.st;
																		self.z5 := left.clean_location_address.zip;
																		self.zip4 := left.clean_location_address.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.clean_location_address.geo_lat;
																		self.geo_long := left.clean_location_address.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.provider_business_practice_location_address_telephone_number;
																		self.FaxNumber := left.provider_business_practice_location_address_fax_number;
																		self.Phones := dataset([{left.provider_business_practice_location_address_telephone_number,left.provider_business_practice_location_address_fax_number}],Layouts.layout_addressphone);));
		Address2 := project(l,transform(Layouts.layout_addressinfo,
																		self.addrSeq := Constants.ADDR_SEQ_NPPES+1;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'B';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := left.mailing_prep_address1;
																		self.address2 := '';
																		self.prim_range := left.clean_mailing_address.prim_range;
																		self.predir := left.clean_mailing_address.predir;
																		self.prim_name := left.clean_mailing_address.prim_name;
																		self.addr_suffix := left.clean_mailing_address.addr_suffix;
																		self.postdir := left.clean_mailing_address.postdir;
																		self.unit_desig := left.clean_mailing_address.unit_desig;
																		self.sec_range := left.clean_mailing_address.sec_range;
																		self.p_city_name := left.clean_mailing_address.p_city_name;
																		self.v_city_name := left.clean_mailing_address.v_city_name;
																		self.st := left.clean_mailing_address.st;
																		self.z5 := left.clean_mailing_address.zip;
																		self.zip4 := left.clean_mailing_address.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.clean_mailing_address.geo_lat;
																		self.geo_long := left.clean_mailing_address.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.provider_business_mailing_address_telephone_number;
																		self.FaxNumber := left.provider_business_mailing_address_fax_number;
																		self.Phones := dataset([{left.provider_business_mailing_address_telephone_number,left.provider_business_mailing_address_fax_number}],Layouts.layout_addressphone);));
		self.Addresses := address1+address2;
		self.dids := dataset([{(integer)l.did}],Layouts.layout_did)(did>0);
		self.bdids := dataset([{(integer)l.bdid}],Layouts.layout_bdid)(bdid>0);
		self.npis := dataset([{l.acctno,(string)l.lnpid,(string)l.npi,l.UserNPI=l.npi,1,l.NPI_Deactivation_Date,l.NPI_Reactivation_Date,l.Provider_Enumeration_Date,l.Entity_Type_Code}],Layouts.layout_npi)(npi<>'');
		self.NPPESVerified := map(l.userNPI = l.vendorid =>'YES',
															l.userNPI <> '' => 'CORRECTED',
															'');
		self.NPIRaw := dataset([Healthcare_Provider_Services.NPI_Transforms.formatRecords(project(l,transform(Layouts.NPPES_Layouts.nppes_penalty_recs,self:=left)))]);
		ds1 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_1,l.Provider_License_Number_1,'','','','','',''}],Layouts.layout_licenseinfo);
		ds2 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_2,l.Provider_License_Number_2,'','','','','',''}],Layouts.layout_licenseinfo);
		ds3 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_3,l.Provider_License_Number_3,'','','','','',''}],Layouts.layout_licenseinfo);
		ds4 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_4,l.Provider_License_Number_4,'','','','','',''}],Layouts.layout_licenseinfo);
		ds5 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_5,l.Provider_License_Number_5,'','','','','',''}],Layouts.layout_licenseinfo);
		ds6 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_6,l.Provider_License_Number_6,'','','','','',''}],Layouts.layout_licenseinfo);
		ds7 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_7,l.Provider_License_Number_7,'','','','','',''}],Layouts.layout_licenseinfo);
		ds8 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_8,l.Provider_License_Number_8,'','','','','',''}],Layouts.layout_licenseinfo);
		ds9 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_9,l.Provider_License_Number_9,'','','','','',''}],Layouts.layout_licenseinfo);
		ds10 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_10,l.Provider_License_Number_10,'','','','','',''}],Layouts.layout_licenseinfo);
		ds11 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_11,l.Provider_License_Number_11,'','','','','',''}],Layouts.layout_licenseinfo);
		ds12 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_12,l.Provider_License_Number_12,'','','','','',''}],Layouts.layout_licenseinfo);
		ds13 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_13,l.Provider_License_Number_13,'','','','','',''}],Layouts.layout_licenseinfo);
		ds14 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_14,l.Provider_License_Number_14,'','','','','',''}],Layouts.layout_licenseinfo);
		ds15 := dataset([{l.acctno,l.lnpid,l.lnpid,0,l.Provider_License_Number_State_Code_15,l.Provider_License_Number_15,'','','','','',''}],Layouts.layout_licenseinfo);
		combinedLic := ds1+ds2+ds3+ds4+ds5+ds6+ds7+ds8+ds9+ds10+ds11+ds12+ds13+ds14+ds15;
		self.StateLicenses := combinedLic(LicenseNumber<>'');
		Self.SrcRecRaw :=  project(l,transform(Layouts.layout_SrcRec,
																		self.Src := constants.SRC_NPPES;
																		self.nameSeq := 5;
																		self.namePenalty := 0;
																		self.FullName := '';
																		self.FirstName := left.clean_name_provider.fname;
																		self.MiddleName := left.clean_name_provider.mname;
																		self.LastName := left.clean_name_provider.lname;
																		self.Suffix := left.clean_name_provider.name_suffix;
																		self.Title := left.clean_name_provider.title;
																		self.Gender := '';
																		self.CompanyName := left.provider_organization_name;
																		self.addrSeq := Constants.ADDR_SEQ_NPPES;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'P';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := left.location_prep_address1;
																		self.address2 := '';
																		self.prim_range := left.clean_location_address.prim_range;
																		self.predir := left.clean_location_address.predir;
																		self.prim_name := left.clean_location_address.prim_name;
																		self.addr_suffix := left.clean_location_address.addr_suffix;
																		self.postdir := left.clean_location_address.postdir;
																		self.unit_desig := left.clean_location_address.unit_desig;
																		self.sec_range := left.clean_location_address.sec_range;
																		self.p_city_name := left.clean_location_address.p_city_name;
																		self.v_city_name := left.clean_location_address.v_city_name;
																		self.st := left.clean_location_address.st;
																		self.z5 := left.clean_location_address.zip;
																		self.zip4 := left.clean_location_address.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.clean_location_address.geo_lat;
																		self.geo_long := left.clean_location_address.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.provider_business_practice_location_address_telephone_number;
																		self.FaxNumber := left.provider_business_practice_location_address_fax_number;
																		self.Phones := dataset([{left.provider_business_practice_location_address_telephone_number,left.provider_business_practice_location_address_fax_number}],Layouts.layout_addressphone);
																		self.did := (integer)left.did;
																		self.bdid := (integer)left.bdid;
																		self := left;
																		self:=[];));
		self:=l; 
		self:=[];
	END;
	//NPPES Rollups
	export Layouts.layout_addressinfo doNPIBaseRecordAddrRollup(Layouts.layout_addressinfo l,
																										DATASET(Layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self.v_last_seen := max(allRows,v_last_seen);
			self.v_first_seen := if(min(allRows,v_first_seen) <> '', min(allRows,v_first_seen),min(allRows,v_last_seen));
			self := l;
			self := [];
	end;
	export Layouts.CombinedHeaderResults doNPIBaseRecordSrcIdRollup(Layouts.CombinedHeaderResults l, 
																									DATASET(Layouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.LNPID := l.LNPID;
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := l.ProcessingMessage;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( Layouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doNPIBaseRecordAddrRollup(left,rows(left))),-last_seen,addrseq);
		self.dids          := Functions.processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( Layouts.layout_did, SELF := RIGHT	)	) );
		self.bdids         := Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	) );
		self.npis	         := DEDUP( NORMALIZE( allRows, LEFT.npis, TRANSFORM( Layouts.layout_npi, SELF := RIGHT	)	), npi, All);
		self.NPIRaw	       := DEDUP(sort( NORMALIZE( allRows, LEFT.NPIRaw, TRANSFORM(iesp.npireport.t_NPIReport, SELF := RIGHT	)	), NPIInformation.NPINumber,-npiinformation.LastUpdateDate), NPIInformation.NPINumber);
		self.NPPESVerified := map(exists(allRows(NPPESVerified='YES')) => 'YES',
															exists(allRows(NPPESVerified='CORRECTED')) => 'CORRECTED','');
		self.StateLicenses := sort(dedup( NORMALIZE( allRows, LEFT.StateLicenses, TRANSFORM( Layouts.layout_licenseinfo, SELF := RIGHT	)	), record, all ),LicenseState,-Termination_Date, LicenseNumber);
		self.SrcRecRaw		 := sort(dedup( project(sort(allRows.SrcRecRaw,
																			Src,namePenalty,-(integer)addrConfidenceValue,-addrVerificationDate,-Ultid,-orgid,-seleid,-proxid,seq,nameSeq,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																			ssn,dob,did,bdid,fein,dotid,empid,powid,
																			addrSeq,addrSeqGrp,addrGoldFlag,addrType,addrTypeCode,addrVerificationStatusFlag,
																			address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																			sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),AddSequence(left,counter)),
																Src,nameSeq,namePenalty,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																ssn,dob,did,bdid,fein,dotid,empid,powid,proxid,seleid,orgid,ultid,
																addrSeq,addrSeqGrp,addrGoldFlag,addrConfidenceValue,addrType,addrTypeCode,addrVerificationStatusFlag,
																addrVerificationDate,address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),
													src,seq);
		self := l;
	end;

	//Proflic Legacy transforms
	Export iesp.proflicense.t_PL2Action build_Action (Layouts.proflic_base_with_input src) := transform
		Self._Type := src.rawdata.action_record_type;
		Self.ViolationDescription := src.rawdata.action_complaint_violation_desc;
		Self.ViolationDate := iesp.ecl2esp.toDatestring8(src.rawdata.action_complaint_violation_dt);
		Self.EffectiveDate := iesp.ecl2esp.toDatestring8(src.rawdata.action_effective_dt);
		Self.Description :=  src.rawdata.action_complaint_violation_desc;
		Self.Status := src.rawdata.action_status;
		Self.PostingDate := iesp.ecl2esp.toDatestring8(src.rawdata.action_posting_status_dt);
		Self.CaseNumber := src.rawdata.action_case_number;
	end;

	Export iesp.proflicense.t_PL2Education build_Education (Layouts.proflic_base_with_input srcEdu, integer seq) := transform
		self.School := map(seq=1 => srcEdu.rawdata.education_1_school_attended,
											 seq=2 => srcEdu.rawdata.education_2_school_attended,
											 seq=3 => srcEdu.rawdata.education_3_school_attended,'');
		self.Degree := map(seq=1 => srcEdu.rawdata.education_1_degree,
											 seq=2 => srcEdu.rawdata.education_2_degree,
											 seq=3 => srcEdu.rawdata.education_3_degree,'');
		self.Curriculum := map(seq=1 => srcEdu.rawdata.education_1_curriculum,
													 seq=2 => srcEdu.rawdata.education_2_curriculum,
													 seq=3 => srcEdu.rawdata.education_3_curriculum,'');
		self.DatesAttended := map(seq=1 => srcEdu.rawdata.education_1_dates_attended,
															seq=2 => srcEdu.rawdata.education_2_dates_attended,
															seq=3 => srcEdu.rawdata.education_3_dates_attended,'');
	end;

	Export iesp.proflicense.t_ProfessionalLicenseRecord build_ProflicRaw (Layouts.proflic_base_with_input l) := transform
		self.prolicSeqId :=(String) l.rawdata.prolic_seq_id;
		self.IdValue := (STRING) l.rawdata.prolic_seq_id; 
		self.LicenseType := l.rawdata.license_type;
		self.LicenseNumber := l.rawdata.Orig_License_Number;
		self.ProviderNumber := l.LNPID;
		self.SanctionNumber := 0;
		self.SSN := l.rawdata.best_ssn;
		self.DateLastSeen := iesp.ecl2esp.toDatestring8(l.rawdata.date_last_seen);
		self.ProfessionOrBoard := l.rawdata.profession_or_board;
		self.Status := l.rawdata.Status;
		self.StatusEffectiveDate := iesp.ecl2esp.toDatestring8(l.rawdata.status_effective_dt);
		self.Name := iesp.ECL2ESP.SetName(l.rawdata.fname, l.rawdata.mname, l.rawdata.lname, l.rawdata.name_suffix, l.rawdata.title, '');
		self.OriginalName := iesp.ECL2ESP.SetName('', '', '', '', '', l.rawdata.Orig_name);
		self.AdditionalOrigName := iesp.ECL2ESP.SetName('', '', '', '', '', l.rawdata.Orig_Former_Name);
		self.CompanyName := l.rawdata.Company_name;
		self.Address := iesp.ecl2esp.SetAddress (l.rawdata.prim_name, l.rawdata.prim_range, l.rawdata.predir, l.rawdata.postdir,
					 l.rawdata.suffix, l.rawdata.unit_desig, l.rawdata.sec_range, l.rawdata.p_city_name,
					 l.rawdata.st, l.rawdata.zip, l.rawdata.zip4, '','', '', '', '');
		self.OriginalAddress := iesp.ecl2esp.SetAddress ('', '', '', '','', '', '', l.rawdata.Orig_City, l.rawdata.Orig_St, l.rawdata.Orig_Zip, '', '','', l.rawdata.Orig_Addr_1, l.rawdata.Orig_Addr_2, '');
		self.AdditionalOrigAddress := iesp.ecl2esp.SetAddress ('', '', '', '','', '', '', l.rawdata.additional_orig_city, l.rawdata.additional_orig_st, l.rawdata.additional_orig_zip, '', '','', l.rawdata.additional_orig_additional_1, l.rawdata.additional_orig_additional_2, '');
		self.Phone := l.rawdata.phone;
		self.TimeZone := '';
		self.AdditionalPhone := l.rawdata.additional_phone;
		self.Gender := l.rawdata.sex;
		self.DOB := iesp.ecl2esp.toDatestring8(l.rawdata.dob);
		self.IssuedDate := iesp.ecl2esp.toDatestring8(l.rawdata.issue_date);
		self.ExpirationDate := iesp.ecl2esp.toDatestring8(l.rawdata.expiration_date);
		self.LastRenewalDate := iesp.ecl2esp.toDatestring8(l.rawdata.last_renewal_date);
		self.LicenseObtainedBy := l.rawdata.license_obtained_by;
		self.BoardActionIndicator := if(length(trim(l.rawdata.Action_Status,all))>0,'Y','N'); 
		self.SourceState := l.rawdata.source_st;
		self.Occupation := l.rawdata.misc_occupation;
		self.PracticeHours := 0;
		self.PracticeType := l.rawdata.misc_practice_type;
		self.Email := l.rawdata.misc_email;
		self.Fax := l.rawdata.misc_fax;
		self.Action := row(build_Action(l));
		self.ContinueEducation := l.rawdata.education_continuing_education;
		self.Education1 := row(build_Education(l,1)); 
		self.Education2 := row(build_Education(l,2)); 
		self.Education3 := row(build_Education(l,3)); 
		self.AdditionalLicensingSpecs := l.rawdata.additional_licensing_specifics;
		self.PlaceOfBirth := l.rawdata.personal_pob_desc;
		self.Race := l.rawdata.personal_race_desc;
    SELF := [];
	end;

	//ProfLic Base transforms
	Export Layouts.CombinedHeaderResults build_ProfLic_base (Layouts.proflic_base_with_input l) := transform
		//Profession License is a bit odd that it might have the company name for the person record.  If the input was truely a company search filter out the individuals
		isCompany := l.comp_name <> '';
		hasIndividual := l.rawdata.lname <> '' ;
		self.acctno := if(isCompany and hasIndividual,skip,l.acctno);
		self.sources := dataset([{l.rawdata.prolic_key,Constants.SRC_PROFLIC}],Layouts.layout_SrcID);
		self.LNPID := l.lnpid;
		self.srcID := l.lnpid;
		self.VendorID := (string)l.rawdata.did;
		self.src := Constants.SRC_PROFLIC;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.names := project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 5;
																			self.namePenalty := 0;
																			self.FullName := '';
																			self.FirstName := left.rawdata.fname;
																			self.MiddleName := left.rawdata.mname;
																			self.LastName := left.rawdata.lname;
																			self.Suffix := left.rawdata.name_suffix;
																			self.Title := left.rawdata.title;
																			self.Gender := '';
																			self.CompanyName := left.rawdata.company_name;));
		self.Addresses := project(l,transform(Layouts.layout_addressinfo,
																		keepit := (left.rawdata.prim_name<>'' and left.rawdata.v_city_name<>'');
																		self.addrSeq := if(keepit,Constants.ADDR_SEQ_PROFLIC,skip);
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'P';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := if(left.rawdata.orig_addr_1<>'',left.rawdata.orig_addr_1,Functions.buildAddress(left.rawdata.prim_range,left.rawdata.predir,left.rawdata.prim_name,left.rawdata.suffix,left.rawdata.postdir,left.rawdata.unit_desig,left.rawdata.sec_range));
																		self.address2 := '';
																		self.prim_range := left.rawdata.prim_range;
																		self.predir := left.rawdata.predir;
																		self.prim_name := left.rawdata.prim_name;
																		self.addr_suffix := left.rawdata.suffix;
																		self.postdir := left.rawdata.postdir;
																		self.unit_desig := left.rawdata.unit_desig;
																		self.sec_range := left.rawdata.sec_range;
																		self.p_city_name := left.rawdata.p_city_name;
																		self.v_city_name := left.rawdata.v_city_name;
																		self.st := left.rawdata.st;
																		self.z5 := left.rawdata.zip;
																		self.zip4 := left.rawdata.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.rawdata.date_last_seen;
																		self.first_seen := (string)left.rawdata.date_first_seen;
																		self.v_last_seen := '';
																		self.v_first_seen := '';
																		self.geo_lat := left.rawdata.geo_lat;
																		self.geo_long := left.rawdata.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := '';
																		self.FaxNumber := '';
																		self.Phones := dataset([],Layouts.layout_addressphone);));
		self.dids := dataset([{(integer)l.rawdata.did}],Layouts.layout_did)(did>0);
		self.bdids := dataset([{(integer)l.rawdata.bdid}],Layouts.layout_bdid)(bdid>0);
		self.dobs := dataset([{l.rawdata.dob}],Layouts.layout_dob)(dob<>'');
		self.StateLicenses := dataset([{l.acctno,l.lnpid,0,l.rawdata.source_st,l.rawdata.license_number,'','',l.rawdata.issue_date,l.rawdata.expiration_date}],Layouts.layout_licenseinfo)(LicenseNumber<>'');
		self.ProfLicRaw := project(l,build_ProflicRaw(left));
		Self.SrcRecRaw :=  project(l,transform(Layouts.layout_SrcRec,
																		self.Src := constants.SRC_PROFLIC;
																		self.nameSeq := 5;
																		self.namePenalty := 0;
																		self.FullName := '';
																		self.FirstName := left.rawdata.fname;
																		self.MiddleName := left.rawdata.mname;
																		self.LastName := left.rawdata.lname;
																		self.Suffix := left.rawdata.name_suffix;
																		self.Title := left.rawdata.title;
																		self.Gender := '';
																		self.CompanyName := left.rawdata.company_name;
																		self.addrSeq := Constants.ADDR_SEQ_PROFLIC;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'P';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := if(left.rawdata.orig_addr_1<>'',left.rawdata.orig_addr_1,Functions.buildAddress(left.rawdata.prim_range,left.rawdata.predir,left.rawdata.prim_name,left.rawdata.suffix,left.rawdata.postdir,left.rawdata.unit_desig,left.rawdata.sec_range));
																		self.address2 := '';
																		self.prim_range := left.rawdata.prim_range;
																		self.predir := left.rawdata.predir;
																		self.prim_name := left.rawdata.prim_name;
																		self.addr_suffix := left.rawdata.suffix;
																		self.postdir := left.rawdata.postdir;
																		self.unit_desig := left.rawdata.unit_desig;
																		self.sec_range := left.rawdata.sec_range;
																		self.p_city_name := left.rawdata.p_city_name;
																		self.v_city_name := left.rawdata.v_city_name;
																		self.st := left.rawdata.st;
																		self.z5 := left.rawdata.zip;
																		self.zip4 := left.rawdata.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.rawdata.date_last_seen;
																		self.first_seen := (string)left.rawdata.date_first_seen;
																		self.v_last_seen := '';
																		self.v_first_seen := '';
																		self.geo_lat := left.rawdata.geo_lat;
																		self.geo_long := left.rawdata.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := '';
																		self.FaxNumber := '';
																		self.Phones := dataset([],Layouts.layout_addressphone);
																		self.dob := left.rawdata.dob;
																		self.did := (integer)left.did;
																		self.bdid := (integer)left.bdid;
																		self := left;
																		self:=[];));
		self:=l; 
		self:=[];
	END;

	//Proflic Rollups
	export Layouts.layout_addressinfo doProfLicBaseRecordAddrRollup(Layouts.layout_addressinfo l,
																										DATASET(Layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self := l;
			self := [];
	end;
	export Layouts.CombinedHeaderResults doProfLicBaseRecordSrcIdRollup(Layouts.CombinedHeaderResults l, 
																									DATASET(Layouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.LNPID := l.LNPID;
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := l.ProcessingMessage;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( Layouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doProfLicBaseRecordAddrRollup(left,rows(left))),-last_seen,addrseq);
		self.dids          := Functions.processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( Layouts.layout_did, SELF := RIGHT	)	) );
		self.bdids         := Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	) );
		self.dobs          := DEDUP( NORMALIZE( allRows, LEFT.dobs, TRANSFORM( Layouts.layout_dob, SELF := RIGHT	)	), dob, ALL );
		self.StateLicenses := sort(dedup( NORMALIZE( allRows, LEFT.StateLicenses, TRANSFORM( Layouts.layout_licenseinfo, SELF := RIGHT	)	), record, all ),LicenseState,-Termination_Date, LicenseNumber);
		self.ProfLicRaw    := sort(DEDUP(NORMALIZE(allRows, LEFT.ProfLicRaw, TRANSFORM( iesp.proflicense.t_ProfessionalLicenseRecord, SELF := RIGHT)), RECORD, ALL ),-ExpirationDate,prolicSeqId);
		self.SrcRecRaw		 := sort(dedup( project(sort(allRows.SrcRecRaw,
																			Src,namePenalty,-(integer)addrConfidenceValue,-addrVerificationDate,-Ultid,-orgid,-seleid,-proxid,seq,nameSeq,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																			ssn,dob,did,bdid,fein,dotid,empid,powid,
																			addrSeq,addrSeqGrp,addrGoldFlag,addrType,addrTypeCode,addrVerificationStatusFlag,
																			address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																			sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),AddSequence(left,counter)),
																Src,nameSeq,namePenalty,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																ssn,dob,did,bdid,fein,dotid,empid,powid,proxid,seleid,orgid,ultid,
																addrSeq,addrSeqGrp,addrGoldFlag,addrConfidenceValue,addrType,addrTypeCode,addrVerificationStatusFlag,
																addrVerificationDate,address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),
													src,seq);
		self := l;
	end;

	//CLIA Legacy transforms
	export iesp.cliasearch.t_CLIARecord CLIARawRecords(Layouts.clia_base_with_input recs):= TRANSFORM
		self.BusinessId := (string)recs.bdid;
		self.CLIANumber := recs.clia_number;
		self.LaboratoryType := recs.lab_type;
		self.CompanyName := recs.facility_name;
		self.CompanyName2 := recs.facility_name2;
		addr := recs.clean_company_address;
		self.CLIAProviderAddress := iesp.ECL2ESP.SetAddress(
																addr.prim_name, addr.prim_range, addr.predir, addr.postdir, addr.addr_suffix,
																addr.unit_desig, addr.sec_range, recs.city, recs.State, recs.zip, recs.zip4,
																'','', recs.address1, recs.address2, '');
		self.Phone10 := recs.facility_phone;
		self.RecordType := recs.record_type;
		self.DateFirstSeen := iesp.ECL2ESP.toDatestring8((string)recs.dt_vendor_first_reported);
		self.DateLastSeen := iesp.ECL2ESP.toDatestring8((string)recs.dt_vendor_last_reported);
		self.ExpirationDate := iesp.ECL2ESP.toDatestring8((string)recs.expiration_date);
		self.CertificateType := recs.certificate_type;
		self.TerminationCode := recs.lab_term_code;
		self.TerminationCodeDesc := recs.TermCodeDesc;
		self := recs;
		self := [];
	end;
	//CLIA Base transforms
	Export Layouts.CombinedHeaderResults build_CLIA_base (Layouts.clia_base_with_input l) := transform
		self.acctno := l.acctno;
		self.sources := dataset([{l.clia_number,Constants.SRC_CLIA}],Layouts.layout_SrcID);
		self.LNPID := l.lnpid;
		self.VendorID := l.clia_number;
		self.srcID := l.lnpid;
		self.src := Constants.SRC_CLIA;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		name1 := project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 3;//Cert is required to be renewed so name should be pretty accurate
																			self.namePenalty := ut.CompanySimilar100(left.facility_name,left.comp_name);//Add penalty
																			self.CompanyName := left.facility_name;
																			self:=[];));
		name2 := project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 3;//Cert is required to be renewed so name should be pretty accurate
																			self.namePenalty := ut.CompanySimilar100(left.facility_name2,left.comp_name);
																			self.CompanyName := left.facility_name2;
																			self:=[];));
		self.names := (name1+name2)(CompanyName <> '');
		self.Addresses := project(l,transform(Layouts.layout_addressinfo,
																		self.addrSeq := Constants.ADDR_SEQ_CLIA;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'P';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := if(left.address1<>'',left.address1,Functions.buildAddress(left.clean_company_address.prim_range,left.clean_company_address.predir,left.clean_company_address.prim_name,left.clean_company_address.addr_suffix,left.clean_company_address.postdir,left.clean_company_address.unit_desig,left.clean_company_address.sec_range));
																		self.address2 := '';
																		self.prim_range := left.clean_company_address.prim_range;
																		self.predir := left.clean_company_address.predir;
																		self.prim_name := left.clean_company_address.prim_name;
																		self.addr_suffix := left.clean_company_address.addr_suffix;
																		self.postdir := left.clean_company_address.postdir;
																		self.unit_desig := left.clean_company_address.unit_desig;
																		self.sec_range := left.clean_company_address.sec_range;
																		self.p_city_name := left.clean_company_address.p_city_name;
																		self.v_city_name := left.clean_company_address.v_city_name;
																		self.st := left.clean_company_address.st;
																		self.z5 := left.clean_company_address.zip;
																		self.zip4 := left.clean_company_address.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := '';
																		self.first_seen := '';
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.clean_company_address.geo_lat;
																		self.geo_long := left.clean_company_address.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.facility_phone;
																		self.FaxNumber := '';
																		self.Phones := dataset([{left.facility_phone,''}],Layouts.layout_addressphone);));
		self.bdids := dataset([{(integer)l.bdid}],Layouts.layout_bdid)(bdid>0);
		self.clianumbers := project(l,transform(Layouts.layout_clianumber,
																		self.clianumber:=if(left.clia_number<>'',left.clia_number,skip),
																		self.clia_cert_type_code:=left.certificate_type;
																		self.clia_end_date:=left.expiration_date;
																		self.clia_lab_type_description:=left.lab_type;
																		self.clia_lab_term_code:=left.lab_term_code;
																		self.clia_TermCodeDesc :=left.TermCodeDesc;
																		self :=[];));
		self.CLIARaw := project(l,CLIARawRecords(left));
		Self.SrcRecRaw :=  project(l,transform(Layouts.layout_SrcRec,
																		self.Src := constants.SRC_CLIA;
																		self.nameSeq := 3;//Cert is required to be renewed so name should be pretty accurate
																		self.namePenalty := ut.CompanySimilar100(if(left.facility_name<>'',left.facility_name,left.facility_name2),left.comp_name);
																		self.CompanyName := if(left.facility_name<>'',left.facility_name,left.facility_name2);
																		self.addrSeq := Constants.ADDR_SEQ_CLIA;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'P';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := if(left.address1<>'',left.address1,Functions.buildAddress(left.clean_company_address.prim_range,left.clean_company_address.predir,left.clean_company_address.prim_name,left.clean_company_address.addr_suffix,left.clean_company_address.postdir,left.clean_company_address.unit_desig,left.clean_company_address.sec_range));
																		self.address2 := '';
																		self.prim_range := left.clean_company_address.prim_range;
																		self.predir := left.clean_company_address.predir;
																		self.prim_name := left.clean_company_address.prim_name;
																		self.addr_suffix := left.clean_company_address.addr_suffix;
																		self.postdir := left.clean_company_address.postdir;
																		self.unit_desig := left.clean_company_address.unit_desig;
																		self.sec_range := left.clean_company_address.sec_range;
																		self.p_city_name := left.clean_company_address.p_city_name;
																		self.v_city_name := left.clean_company_address.v_city_name;
																		self.st := left.clean_company_address.st;
																		self.z5 := left.clean_company_address.zip;
																		self.zip4 := left.clean_company_address.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := '';
																		self.first_seen := '';
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.clean_company_address.geo_lat;
																		self.geo_long := left.clean_company_address.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.facility_phone;
																		self.FaxNumber := '';
																		self.Phones := dataset([{left.facility_phone,''}],Layouts.layout_addressphone);
																		self.bdid := (integer)left.bdid;
																		self := left;
																		self:=[];));
		self:=l; 
		self:=[];
	END;
	//CLIA Rollups
	export Layouts.layout_addressinfo doCLIABaseRecordAddrRollup(Layouts.layout_addressinfo l,
																										DATASET(Layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self := l;
			self := [];
	end;
	export Layouts.CombinedHeaderResults doCLIABaseRecordSrcIdRollup(Layouts.CombinedHeaderResults l, 
																									DATASET(Layouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.LNPID := l.LNPID;
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := l.ProcessingMessage;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( Layouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doCLIABaseRecordAddrRollup(left,rows(left))),-last_seen,addrseq);
		self.bdids         := Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	) );
		self.CLIARaw    := sort(DEDUP(NORMALIZE(allRows, LEFT.CLIARaw, TRANSFORM( iesp.cliasearch.t_CLIARecord, SELF := RIGHT)), RECORD, ALL ),CLIANumber,-ExpirationDate);
		self.SrcRecRaw		 := sort(dedup( project(sort(allRows.SrcRecRaw,
																			Src,namePenalty,-(integer)addrConfidenceValue,-addrVerificationDate,-Ultid,-orgid,-seleid,-proxid,seq,nameSeq,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																			ssn,dob,did,bdid,fein,dotid,empid,powid,
																			addrSeq,addrSeqGrp,addrGoldFlag,addrType,addrTypeCode,addrVerificationStatusFlag,
																			address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																			sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),AddSequence(left,counter)),
																Src,nameSeq,namePenalty,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																ssn,dob,did,bdid,fein,dotid,empid,powid,proxid,seleid,orgid,ultid,
																addrSeq,addrSeqGrp,addrGoldFlag,addrConfidenceValue,addrType,addrTypeCode,addrVerificationStatusFlag,
																addrVerificationDate,address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),
													src,seq);
		self := l;
	end;
	//NCPDP Base transforms
	Export Layouts.CombinedHeaderResults build_NCPDP_base (Layouts.ncpdp_base_with_input l, boolean hasFullNCPDP=false) := transform
		self.acctno := l.acctno;
		self.sources := dataset([{l.ncpdp_provider_id,Constants.SRC_NCPDP}],Layouts.layout_SrcID);
		self.LNPID := l.lnpid;
		self.VendorID := l.ncpdp_provider_id;
		self.srcID := l.lnpid;
		self.src := Constants.SRC_NCPDP;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.medicare_fac_num := l.medicare_provider_id;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		name1 := project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 4;
																			self.namePenalty := 0;
																			self.CompanyName := left.legal_business_name;
																			self:=[];));
		name2 := project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 4;
																			self.namePenalty := 0;
																			self.CompanyName := left.dba;
																			self:=[];));
		self.names := (name1+name2)(CompanyName <> '');
		Address1 := project(l,transform(Layouts.layout_addressinfo,
																		self.addrSeq := Constants.ADDR_SEQ_NCPDP;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'P';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := left.append_phyaddr1;
																		self.address2 := left.append_phyaddrlast;
																		self.prim_range := left.Phys_prim_range;
																		self.predir := left.Phys_predir;
																		self.prim_name := left.Phys_prim_name;
																		self.addr_suffix := left.Phys_addr_suffix;
																		self.postdir := left.Phys_postdir;
																		self.unit_desig := left.Phys_unit_desig;
																		self.sec_range := left.Phys_sec_range;
																		self.p_city_name := left.Phys_p_city_name;
																		self.v_city_name := '';
																		self.st := left.Phys_state;
																		self.z5 := left.Phys_zip5;
																		self.zip4 := left.Phys_zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_last_seen;
																		self.v_first_seen := (string)left.dt_first_seen;
																		self.geo_lat := left.Phys_geo_lat;
																		self.geo_long := left.Phys_geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.phys_loc_phone;
																		self.FaxNumber := left.phys_loc_fax_number;
																		self.Phones := dataset([{left.phys_loc_phone,left.phys_loc_fax_number}],Layouts.layout_addressphone);));
		Address2 := project(l,transform(Layouts.layout_addressinfo,
																		self.addrSeq := Constants.ADDR_SEQ_NCPDP;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'M';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := left.append_Mailaddr1;
																		self.address2 := left.append_Mailaddrlast;
																		self.prim_range := left.Mail_prim_range;
																		self.predir := left.Mail_predir;
																		self.prim_name := left.Mail_prim_name;
																		self.addr_suffix := left.Mail_addr_suffix;
																		self.postdir := left.Mail_postdir;
																		self.unit_desig := left.Mail_unit_desig;
																		self.sec_range := left.Mail_sec_range;
																		self.p_city_name := left.Mail_p_city_name;
																		self.v_city_name := '';
																		self.st := left.Mail_state;
																		self.z5 := left.Mail_zip5;
																		self.zip4 := left.Mail_zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_last_seen;
																		self.v_first_seen := (string)left.dt_first_seen;
																		self.geo_lat := left.Mail_geo_lat;
																		self.geo_long := left.Mail_geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := '';
																		self.FaxNumber := '';
																		self.Phones := dataset([],Layouts.layout_addressphone);));
		self.Addresses := (Address1+Address2)(st<>'');
		self.bdids := dataset([{(integer)l.bdid}],Layouts.layout_bdid)(bdid>0);
		self.feins := dataset([{l.federal_tax_id}],Layouts.layout_fein)(fein<>'');
		self.npis := if(hasFullNCPDP,dataset([{l.acctno,l.lnpid,l.national_provider_id,false}],Layouts.layout_npi),dataset([],Layouts.layout_npi))(npi<>'');
		self.deas := if(hasFullNCPDP,dataset([{l.acctno,l.lnpid,l.dea_registration_id,'',''}],Layouts.layout_dea),dataset([],Layouts.layout_dea))(dea<>'');
		self.StateLicenses := dataset([{l.acctno,l.lnpid,0,'',l.state_license_number,'','','',''}],Layouts.layout_licenseinfo)(LicenseNumber<>'');
		self.NCPDPRaw := project(project(l,transform(Healthcare_Services.NCPDP_Layouts.LayoutOutput,self.legal_business_name:=if(left.legal_business_name<>'',left.legal_business_name,left.dba);self:=left;self:=[];)),Healthcare_Services.NCPDP_Transforms.fmtReportResults(left,hasFullNCPDP));
		Self.SrcRecRaw :=  project(l,transform(Layouts.layout_SrcRec,
																		self.Src := constants.SRC_NCPDP;
																		self.nameSeq := 4;
																		self.namePenalty := 0;
																		self.CompanyName := if(left.legal_business_name<>'',left.legal_business_name,left.dba);
																		self.addrSeq := Constants.ADDR_SEQ_NCPDP;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'P';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := left.append_phyaddr1;
																		self.address2 := left.append_phyaddrlast;
																		self.prim_range := left.Phys_prim_range;
																		self.predir := left.Phys_predir;
																		self.prim_name := left.Phys_prim_name;
																		self.addr_suffix := left.Phys_addr_suffix;
																		self.postdir := left.Phys_postdir;
																		self.unit_desig := left.Phys_unit_desig;
																		self.sec_range := left.Phys_sec_range;
																		self.p_city_name := left.Phys_p_city_name;
																		self.v_city_name := '';
																		self.st := left.Phys_state;
																		self.z5 := left.Phys_zip5;
																		self.zip4 := left.Phys_zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_last_seen;
																		self.v_first_seen := (string)left.dt_first_seen;
																		self.geo_lat := left.Phys_geo_lat;
																		self.geo_long := left.Phys_geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.phys_loc_phone;
																		self.FaxNumber := left.phys_loc_fax_number;
																		self.Phones := dataset([{left.phys_loc_phone,left.phys_loc_fax_number}],Layouts.layout_addressphone);
																		self.bdid := (integer)left.bdid;
																		self.fein := left.federal_tax_id;
																		self := left;
																		self:=[];));
		self:=l; 
		self:=[];
	END;
	//NCPDP Rollups
	export Layouts.layout_addressinfo doNCPDPBaseRecordAddrRollup(Layouts.layout_addressinfo l,
																										DATASET(Layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self := l;
			self := [];
	end;
	export Layouts.CombinedHeaderResults doNCPDPBaseRecordSrcIdRollup(Layouts.CombinedHeaderResults l, 
																									DATASET(Layouts.CombinedHeaderResults) allRows) := TRANSFORM
			SELF.acctno := l.acctno;
			self.LNPID := l.LNPID;
			self.SrcId := l.SrcId;
			self.Src := l.Src;
			self.glb_ok	:= l.glb_ok;
			self.dppa_ok:= l.dppa_ok;
			self.srcIndividualHeader := l.srcIndividualHeader;
			self.srcBusinessHeader := l.srcBusinessHeader;
			self.ProcessingMessage := l.ProcessingMessage;
			self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
			self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
			self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( Layouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doNCPDPBaseRecordAddrRollup(left,rows(left))),-last_seen,addrseq);
			self.feins         := DEDUP( NORMALIZE( allRows, LEFT.feins, TRANSFORM( Layouts.layout_fein, SELF := RIGHT	)	), fein, ALL );
			self.bdids         := Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	) );
			self.npis          := DEDUP( NORMALIZE( allRows, LEFT.npis, TRANSFORM( Layouts.layout_npi, SELF.npi := TRIM(RIGHT.npi,ALL), SELF := RIGHT	)	), npi, ALL );
			self.deas          := DEDUP( SORT( NORMALIZE( allRows, LEFT.deas, TRANSFORM( Layouts.layout_dea, SELF.dea := TRIM(RIGHT.dea,ALL), SELF := RIGHT	)	), dea, -expiration_date), dea, expiration_date );
			self.StateLicenses := DEDUP( SORT( NORMALIZE( allRows, LEFT.StateLicenses, TRANSFORM( Layouts.layout_licenseinfo, SELF := RIGHT	)	), LicenseState,-Termination_Date, LicenseNumber), LicenseState, Termination_Date, LicenseNumber );
			self.NCPDPRaw    	 := sort(DEDUP(NORMALIZE(allRows, LEFT.NCPDPRaw, TRANSFORM(iesp.ncpdp.t_PharmacyReport, SELF := RIGHT)), RECORD, ALL ),EntityInformation.PharmacyProviderId);
			self.SrcRecRaw		 := sort(dedup( project(sort(allRows.SrcRecRaw,
																				Src,namePenalty,-(integer)addrConfidenceValue,-addrVerificationDate,-Ultid,-orgid,-seleid,-proxid,seq,nameSeq,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																				ssn,dob,did,bdid,fein,dotid,empid,powid,
																				addrSeq,addrSeqGrp,addrGoldFlag,addrType,addrTypeCode,addrVerificationStatusFlag,
																				address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																				sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),AddSequence(left,counter)),
																	Src,nameSeq,namePenalty,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																	ssn,dob,did,bdid,fein,dotid,empid,powid,proxid,seleid,orgid,ultid,
																	addrSeq,addrSeqGrp,addrGoldFlag,addrConfidenceValue,addrType,addrTypeCode,addrVerificationStatusFlag,
																	addrVerificationDate,address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																	sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),
														src,seq);
			self := l;
	end;
	
	/*Export iesp.healthcare_orgsearchandreport.t_OrganizationSearchOrganization build_hmsRaw (Layouts.dea_base_with_input l) := transform

		self.LNFID  := l.lnfid;
		//self.OrganizationName  := l.rawData.dea_registration_number;
		//self.SSN := l.rawData.best_ssn;
		self.OrganizationName := l.rawData.cname;

		//SELF.Name := iesp.ECL2ESP.SetName (L.rawData.fname, L.rawData.mname, L.rawData.lname, L.rawData.name_suffix, L.rawData.title,'');
		SELF.Address := iesp.ECL2ESP.SetAddress(
			l.rawData.prim_name,l.rawData.prim_range,L.rawData.predir,L.rawData.postdir, L.rawData.addr_suffix,L.rawData.unit_desig,L.rawData.sec_range, 
			l.rawData.p_city_name,l.rawData.st,l.rawData.zip,l.rawData.zip4,'');
		// SELF.BusinessType := map ( 
					// L.rawData.Business_activity_code = 'A' =>     	'Pharmacy',                                                                                                                                                                                                                                                                                                                                 
					// L.rawData.Business_activity_code = 'B' =>     	'Hospital/Clinic',
					// L.rawData.Business_activity_code = 'C' =>     	'Practitioner',
					// L.rawData.Business_activity_code = 'D' =>     	'Teaching Institution',
					// L.rawData.Business_activity_code = 'E' =>     	'Manufacturer',
					// L.rawData.Business_activity_code = 'F' =>     	'Distributor',
					// L.rawData.Business_activity_code = 'G' =>     	'Researcher',
					// L.rawData.Business_activity_code = 'H' =>     	'Analytical Lab',
					// L.rawData.Business_activity_code = 'J' =>     	'Importer',
					// L.rawData.Business_activity_code = 'K' =>     	'Exporter',
					// L.rawData.Business_activity_code = 'M' =>     	'Mid Level Practitioner',
					// L.rawData.Business_activity_code = 'N' =>     	'Narcotic Treatment Program',
					// L.rawData.Business_activity_code = 'P' =>     	'Narcotic Treatment Program',
					// L.rawData.Business_activity_code = 'R' =>     	'Narcotic Treatment Program',
					// L.rawData.Business_activity_code = 'S' =>     	'Narcotic Treatment Program',
					// L.rawData.Business_activity_code = 'T' =>     	'Narcotic Treatment Program',
					// L.rawData.Business_activity_code = 'U' =>     	'Narcotic Treatment Program',
					// '');		
		// SELF.DrugSchedules := L.rawData.Drug_Schedules;
		// SELF.ExpirationDate := iesp.ECL2ESP.toDate((INTEGER)L.rawData.Expiration_Date);
    SELF := [];
	end;
*/

	
	Export Layouts.CombinedHeaderResults build_hms_Indivbase (Layouts.hms_Indivbase_with_input l) := transform
							self.acctno := l.acctno;
							self.sources := dataset([],Layouts.layout_SrcID);

							self.LNPID := l.l_providerid;
							//self.VendorID := l.rawdata.dea_registration_number;
							self.srcID := (integer)l.rawdata.ln_key;
							//self.src := Constants.SRC_DEA;
							self.glb_ok	:= l.glb_ok;
							self.dppa_ok:= l.dppa_ok;
							//self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
							self.srcIndividualHeader := l.srcIndividualHeader;
							self.srcBusinessHeader := l.srcBusinessHeader;
							self.FacilityType:='';//l.rawdata.FACTYPE;
							self.OrganizationType:='';//;l.rawdata.ORGTYPE;
							self.names := project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 1;
																			self.namePenalty := 0;
																			self.FullName := Healthcare_Header_Services.Functions.getCleanHealthCareName(left.rawdata.name);
																			self.FirstName := Healthcare_Header_Services.Functions.getCleanHealthCareName(left.rawdata.first);
		                                  self.MiddleName := Healthcare_Header_Services.Functions.getCleanHealthCareName(left.rawdata.middle);
		                                  self.LastName := Healthcare_Header_Services.Functions.getCleanHealthCareName(left.rawdata.last);
																			self.Suffix := Healthcare_Header_Services.Functions.getCleanHealthCareName(left.rawdata.suffix);
																			self.Title := '';
																			self.Gender := left.rawdata.gender;
																			self.CompanyName := '';
																			self:=[];));
              self.Addresses := project(l,transform(Layouts.layout_addressinfo,
																						self.addrSeq := Constants.ADDR_SEQ_ENCLARITY;
																						self.addrSeqGrp := 0;
																						self.addrGoldFlag := '';
																						self.addrConfidenceValue := '';
																						self.addrType := '';
																						self.addrTypeCode := 'P';
																						self.addrVerificationStatusFlag := '';
																						self.addrVerificationDate := '';
																						self.addrPenalty := 0;
																						self.address1 := left.rawdata.street1;
																						self.address2 := left.rawdata.street2;
																						self.prim_range := left.rawdata.prim_range;
																						self.predir := left.rawdata.predir;
																						self.prim_name := left.rawdata.prim_name;
																						self.addr_suffix := left.rawdata.addr_suffix;
																						self.postdir := left.rawdata.postdir;
																						self.unit_desig := left.rawdata.unit_desig;
																						self.sec_range := left.rawdata.sec_range;
																						self.p_city_name := left.rawdata.p_city_name;
																						self.v_city_name := left.rawdata.v_city_name;
																						self.st := left.rawdata.address_state;
																						self.z5 := left.rawdata.zip;
																						self.zip4 := left.rawdata.zip4;
																						self.primaryLocation := '';
																						self.practiceAddress := '';
																						self.BillingAddress := '';
																						self.last_seen := (string)left.rawdata.dt_last_seen;
																						self.first_seen := (string)left.rawdata.dt_first_seen;
																						self.v_last_seen := (string)left.rawdata.dt_vendor_last_reported;
																						self.v_first_seen := (string)left.rawdata.dt_vendor_first_reported;
																						self.geo_lat := left.rawdata.geo_lat;
																						self.geo_long := left.rawdata.geo_long;
																						self.fips_state := '';
																						self.fips_county := '';
																						//phones:=left.
																						self.PhoneNumber := '';
																						self.FaxNumber := left.rawdata.fax1;
																						self.Phones := dataset([{left.rawdata.phone1,left.rawdata.fax1}],Layouts.layout_addressphone);));
							// self.npis := dataset([{l.acctno,l.lnpid,l.rawdata.npi,false}],Layouts.layout_npi)(npi<>'');
							// self.deas := dataset([{l.acctno,l.lnpid,l.rawdata.dea,'',''}],Layouts.layout_dea)(dea<>'');
             self.Specialties := project(l,transform(Layouts.layout_specialty,
						                                          spec:=Healthcare_Lookups.Functions_Taxonomy.getSpecialtyByCredentials(l.rawdata.cred);
						                                          self.acctno := '';
           	  	           														self.SpecialtyName:=spec.specialization;
           	  	           														//self.SpecialtyName:=spec.specialization;
														                          self:=l;
																		        					 self:=[];));			
           self.degrees := project(l,transform(Layouts.layout_degree,
																				 	self.acctno := '';
		                                      self.ProviderID:=0;
																					//self.Degree:='LPN';
																					self.Degree:=Healthcare_Lookups.Functions_Taxonomy.getDegreeByCredentials(l.rawdata.cred);;
																					self:=[];));				
																																	 
						self.dids := dataset([{(integer)l.rawdata.did}],Layouts.layout_did)(did>0);
						self.bdids := dataset([{(integer)l.rawdata.bdid}],Layouts.layout_bdid)(bdid>0);
						self.StateLicenses := project(l,transform(Layouts.layout_licenseinfo,
							                                 self.licenseAcctno :='1';
																							 self.group_key:='';
																						 	 self.ProviderID:=0;
																							 self.licenseSeq := 0;
																							 self.LicenseState := l.rawdata.license_state;
																							 self.LicenseNumber := l.rawdata.license_number;
																							 self.LicenseNumberFmt := '';
																							 self.LicenseType := l.rawdata.license_class_type;
																							 self.LicenseStatus := l.rawdata.status;
																							 self.Effective_Date :=l.rawdata.clean_issue_date;
																							 self.Termination_Date:=l.rawdata.clean_expiration_date;
																							 self.LicSortGroup:='';
																							 	self:=[];));
							self:=l; 
							self:=[];
	END;	
	export Layouts.CombinedHeaderResults doHmsIndivRecordSrcIdRollup(Layouts.CombinedHeaderResults l, 
																									DATASET(Layouts.CombinedHeaderResults) allRows) := TRANSFORM
							SELF.acctno := l.acctno;
							self.LNPID := l.LNPID;
							self.Vendorid := l.vendorid;
							self.SrcId := l.lnpid; 
							self.Src := l.Src;
							self.glb_ok	:= l.glb_ok;
							self.dppa_ok:= l.dppa_ok;
							self.srcIndividualHeader := l.srcIndividualHeader;
							self.srcBusinessHeader := l.srcBusinessHeader;
							self.ProcessingMessage := l.ProcessingMessage;
							self.facilitytype:=l.facilitytype;
							self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
							self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
              self.degrees       := DEDUP( NORMALIZE( allRows, LEFT.Degrees,transform(Layouts.layout_degree,SELF := RIGHT	)	), RECORD, ALL );
							self.Addresses     := sort(rollup(
							                                  group(
																								       sort(
																											       NORMALIZE(allRows, LEFT.Addresses,TRANSFORM( Layouts.layout_addressinfo, SELF := RIGHT	)),
																											          prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																								                prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																							                  group,doDEABaseRecordAddrRollup(left,rows(left))),addrseq)(prim_range<>'' and prim_range[1..10]<>'*** NOT AVAI');

							self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( Layouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL );
							self.dids          := Functions.processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( Layouts.layout_did, SELF := RIGHT	)	) );
							self.bdids         := Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	) );
							self.StateLicenses := DEDUP( NORMALIZE( allRows, LEFT.StateLicenses,transform(Layouts.layout_licenseinfo,SELF := RIGHT	)	), RECORD, ALL );
							self := l;
	end;
	


Export Layouts.CombinedHeaderResults build_hms_facility_base (Layouts.hms_base_with_input l) := transform
							self.acctno := l.acctno;
							self.sources := dataset([{l.rawdata.aha_id,l.rawdata.source},{l.rawdata.MEDICARE_PROVIDER_ID,l.rawdata.source}],Layouts.layout_SrcID);
							self.LNPID := l.l_providerid;
							//self.VendorID := l.rawdata.dea_registration_number;
							self.srcID := l.rawdata.lnfid;
							//self.src := Constants.SRC_DEA;
							self.glb_ok	:= l.glb_ok;
							self.dppa_ok:= l.dppa_ok;
							//self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
							self.srcIndividualHeader := l.srcIndividualHeader;
							self.srcBusinessHeader := l.srcBusinessHeader;
							self.FacilityType:=l.rawdata.FACTYPE;
							self.OrganizationType:=l.rawdata.ORGTYPE;
							self.names := project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 1;
																			self.namePenalty := 0;
																			self.CompanyName := STD.Str.ToUpperCase(left.comp_name);
																			self:=[];));
              self.Addresses := project(l,transform(Layouts.layout_addressinfo,
																						self.addrSeq := Constants.ADDR_SEQ_ENCLARITY;
																						self.addrSeqGrp := 0;
																						self.addrGoldFlag := '';
																						self.addrConfidenceValue := '';
																						self.addrType := '';
																						self.addrTypeCode := 'P';
																						self.addrVerificationStatusFlag := '';
																						self.addrVerificationDate := '';
																						self.addrPenalty := 0;
																						self.address1 := left.rawdata.address1;
																						self.address2 := left.rawdata.address2;
																						self.prim_range := left.rawdata.prim_range;
																						self.predir := left.rawdata.predir;
																						self.prim_name := left.rawdata.prim_name;
																						self.addr_suffix := left.rawdata.addr_suffix;
																						self.postdir := left.rawdata.postdir;
																						self.unit_desig := left.rawdata.unit_desig;
																						self.sec_range := left.rawdata.sec_range;
																						self.p_city_name := left.rawdata.p_city_name;
																						self.v_city_name := left.rawdata.v_city_name;
																						self.st := left.rawdata.state;
																						self.z5 := left.rawdata.zip;
																						self.zip4 := left.rawdata.zip4;
																						self.primaryLocation := '';
																						self.practiceAddress := '';
																						self.BillingAddress := '';
																						self.last_seen := (string)left.rawdata.date_last_seen;
																						self.first_seen := (string)left.rawdata.date_first_seen;
																						self.v_last_seen := (string)left.rawdata.date_last_seen;
																						self.v_first_seen := (string)left.rawdata.date_first_seen;
																						self.geo_lat := left.rawdata.geo_lat;
																						self.geo_long := left.rawdata.geo_long;
																						self.fips_state := '';
																						self.fips_county := '';
																						//phones:=left.
																						self.PhoneNumber := '';
																						self.FaxNumber := left.rawdata.fax;
																						self.Phones := dataset([{left.rawdata.phone1,left.rawdata.fax}],Layouts.layout_addressphone);));
							// self.npis := dataset([{l.acctno,l.lnpid,l.rawdata.npi,false}],Layouts.layout_npi)(npi<>'');
							// self.deas := dataset([{l.acctno,l.lnpid,l.rawdata.dea,'',''}],Layouts.layout_dea)(dea<>'');
							self.dids := dataset([{(integer)l.rawdata.did}],Layouts.layout_did)(did>0);
							self.bdids := dataset([{(integer)l.rawdata.bdid}],Layouts.layout_bdid)(bdid>0);
							self:=l; 
							self:=[];
	END;	
	
	
	export Layouts.CombinedHeaderResults doHmsRecordSrcIdRollup(healthcare_header_services.Layouts.CombinedHeaderResults l, 
																									DATASET(healthcare_header_services.Layouts.CombinedHeaderResults) allRows) := TRANSFORM
							SELF.acctno := l.acctno;
							self.LNPID := l.LNPID;
							self.Vendorid := l.vendorid;
							self.SrcId := l.lnpid;
							self.Src := l.Src;
							self.glb_ok	:= l.glb_ok;
							self.dppa_ok:= l.dppa_ok;
							self.srcIndividualHeader := l.srcIndividualHeader;
							self.srcBusinessHeader := l.srcBusinessHeader;
							self.ProcessingMessage := l.ProcessingMessage;
							self.facilitytype:=l.facilitytype;
							self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
							self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
							self.Addresses     := sort(rollup(
							                                  group(
																								        sort(
																								              NORMALIZE(allRows, LEFT.Addresses,TRANSFORM( Layouts.layout_addressinfo, SELF := RIGHT	)),
																											          prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																								                prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																							                  group,doDEABaseRecordAddrRollup(left,rows(left))),addrseq);
							self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( Layouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL );
							self.dids          := Functions.processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( Layouts.layout_did, SELF := RIGHT	)	) );
							self.bdids         := Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	) );
							self := l;
	end;
	
	//Boca Consumer header Base transforms
	Export Layouts.CombinedHeaderResults build_BocaHdr_base (Layouts.bocahdr_base_with_input l, integer cnt) := transform
		self.acctno := l.acctno;
		self.sources := dataset([{l.rawdata.did,Constants.SRC_BOCA_PERSON_HEADER}],Layouts.layout_SrcID);
		self.LNPID := l.rawdata.did;
		self.VendorID := (string)l.rawdata.did;
		self.srcID := l.rawdata.did;
		self.src := Constants.SRC_BOCA_PERSON_HEADER;
		self.subsrc := (string)cnt;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.names := project(l,transform(Layouts.layout_nameinfo,
																			self.nameSeq := 10;
																			self.namePenalty := 0;
																			self.FullName := '';
																			self.FirstName := left.rawdata.fname;
																			self.MiddleName := left.rawdata.mname;
																			self.LastName := left.rawdata.lname;
																			self.Suffix := left.rawdata.name_suffix;
																			self.Title := left.rawdata.title;
																			self.Gender := '';
																			self.CompanyName := '';));
		self.Addresses := project(l,transform(Layouts.layout_addressinfo,
																		self.addrSeq := Constants.ADDR_SEQ_DEEPDIVE;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := '';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := Functions.buildAddress(left.rawdata.prim_range,left.rawdata.predir,left.rawdata.prim_name,left.rawdata.suffix,left.rawdata.postdir,left.rawdata.unit_desig,left.rawdata.sec_range);
																		self.address2 := '';
																		self.prim_range := left.rawdata.prim_range;
																		self.predir := left.rawdata.predir;
																		self.prim_name := left.rawdata.prim_name;
																		self.addr_suffix := left.rawdata.suffix;
																		self.postdir := left.rawdata.postdir;
																		self.unit_desig := left.rawdata.unit_desig;
																		self.sec_range := left.rawdata.sec_range;
																		self.p_city_name := left.rawdata.city_name;
																		self.v_city_name := left.rawdata.city_name;
																		self.st := left.rawdata.st;
																		self.z5 := left.rawdata.zip;
																		self.zip4 := left.rawdata.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.rawdata.dt_last_seen;
																		self.first_seen := (string)left.rawdata.dt_first_seen;
																		self.v_last_seen := (string)left.rawdata.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.rawdata.dt_vendor_first_reported;
																		self.geo_lat := '';
																		self.geo_long := '';
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.rawdata.phone;
																		self.FaxNumber := '';
																		self.Phones := dataset([{left.rawdata.phone,''}],Layouts.layout_addressphone);));
		self.dids := dataset([{(integer)l.rawdata.did}],Layouts.layout_did)(did>0);
		self.ssns := if(l.rawdata.valid_ssn ='G',dataset([{l.rawdata.ssn}],Layouts.layout_ssn)(ssn<>''));
		string8 tmpDob := (string)l.rawdata.dob;
		self.dobs := if(tmpDob <> '0' and tmpDob[5..8]<>'0000',dataset([{tmpDob}],Layouts.layout_dob));
		Self.SrcRecRaw :=  project(l,transform(Layouts.layout_SrcRec,
																		self.Src := constants.SRC_BOCA_PERSON_HEADER;
																		self.nameSeq := 10;
																		self.namePenalty := 0;
																		self.FullName := '';
																		self.FirstName := left.rawdata.fname;
																		self.MiddleName := left.rawdata.mname;
																		self.LastName := left.rawdata.lname;
																		self.Suffix := left.rawdata.name_suffix;
																		self.Title := left.rawdata.title;
																		self.Gender := '';
																		self.CompanyName := '';
																		self.addrSeq := Constants.ADDR_SEQ_DEEPDIVE;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := '';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := Functions.buildAddress(left.rawdata.prim_range,left.rawdata.predir,left.rawdata.prim_name,left.rawdata.suffix,left.rawdata.postdir,left.rawdata.unit_desig,left.rawdata.sec_range);
																		self.address2 := '';
																		self.prim_range := left.rawdata.prim_range;
																		self.predir := left.rawdata.predir;
																		self.prim_name := left.rawdata.prim_name;
																		self.addr_suffix := left.rawdata.suffix;
																		self.postdir := left.rawdata.postdir;
																		self.unit_desig := left.rawdata.unit_desig;
																		self.sec_range := left.rawdata.sec_range;
																		self.p_city_name := left.rawdata.city_name;
																		self.v_city_name := left.rawdata.city_name;
																		self.st := left.rawdata.st;
																		self.z5 := left.rawdata.zip;
																		self.zip4 := left.rawdata.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.rawdata.dt_last_seen;
																		self.first_seen := (string)left.rawdata.dt_first_seen;
																		self.v_last_seen := (string)left.rawdata.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.rawdata.dt_vendor_first_reported;
																		self.geo_lat := '';
																		self.geo_long := '';
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.rawdata.phone;
																		self.FaxNumber := '';
																		self.Phones := dataset([{left.rawdata.phone,''}],Layouts.layout_addressphone);
																		self.dob := if(tmpDob <> '0' and tmpDob[5..8]<>'0000',tmpDob,'');
																		self.ssn := if(left.rawdata.valid_ssn ='G',left.rawdata.ssn,'');
																		self.did := (integer)left.rawdata.did;
																		self := left;
																		self:=[];));
		self:=l; 
		self:=[];
	END;

	//Boca Bus header Base transforms
	export DidVille.Layout_Did_OutBatch convertToDidvilleBatch(Layouts.autokeyInput inRec, boolean ssnonly=false):= TRANSFORM
		hasSSNorNameAddr := inRec.ssn <> '' or (inRec.name_last <> '' and inRec.prim_name <> '' and (inRec.st <> '' or inRec.z5 <> ''));
		self.seq := if(hasSSNorNameAddr,(integer)inRec.acctno,skip);
		self.ssn := inRec.ssn;
		self.dob := if(ssnonly,'',inRec.dob);
		self.phone10 := if(ssnonly,'',inRec.homephone);
		self.fname := if(ssnonly,'',inRec.name_first[1]);//Making this allow first initial only to pick up name variations
		self.mname := if(ssnonly,'',inRec.name_middle);
		self.lname := if(ssnonly,'',inRec.name_last);
		self.prim_range := if(ssnonly,'',inRec.prim_range);
		self.predir := if(ssnonly,'',inRec.predir);
		self.prim_name := if(ssnonly,'',inRec.prim_name);
		self.addr_suffix := if(ssnonly,'',inRec.addr_suffix);
		self.postdir := if(ssnonly,'',inRec.postdir);
		self.unit_desig := if(ssnonly,'',inRec.unit_desig);
		self.sec_range := if(ssnonly,'',inRec.sec_range);
		self.p_city_name := if(ssnonly,'',inRec.p_city_name);
		self.st := if(ssnonly,'',inRec.st);
		self.z5 := if(ssnonly,'',inRec.z5);
		self:=[];  
	end;
	export Layouts.CombinedHeaderResults doBocaHeaderBaseRecordSrcIdRollup(Layouts.CombinedHeaderResults l, 
																									DATASET(Layouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.LNPID := l.LNPID;
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.isAutokeysResult:= true;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := sort(DEDUP(sort(NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, self.nameSeq:= (integer)left.subsrc;SELF := RIGHT)),nameSeq), RECORD, ALL ),nameSeq);
		self.Addresses     := sort(rollup(group(dedup(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( Layouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,if(unit_desig<>'',1,9),if(sec_range<>'',1,9),p_city_name,v_city_name,st,z5),
																						prim_range,predir,prim_name,addr_suffix,postdir,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doDEABaseRecordAddrRollup(left,rows(left))),addrseq);
		self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( Layouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL );
		self.dids          := Functions.processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( Layouts.layout_did, SELF := RIGHT	)	) );
		self.dobs	         := DEDUP(sort(NORMALIZE( allRows, LEFT.dobs, TRANSFORM( Layouts.layout_dob, SELF := RIGHT	)	),-dob),dob);
		self.SrcRecRaw		 := sort(dedup( project(sort(allRows.SrcRecRaw,
																			Src,namePenalty,-(integer)addrConfidenceValue,-addrVerificationDate,-Ultid,-orgid,-seleid,-proxid,seq,nameSeq,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																			ssn,dob,did,bdid,fein,dotid,empid,powid,
																			addrSeq,addrSeqGrp,addrGoldFlag,addrType,addrTypeCode,addrVerificationStatusFlag,
																			address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																			sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),AddSequence(left,counter)),
																Src,nameSeq,namePenalty,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																ssn,dob,did,bdid,fein,dotid,empid,powid,proxid,seleid,orgid,ultid,
																addrSeq,addrSeqGrp,addrGoldFlag,addrConfidenceValue,addrType,addrTypeCode,addrVerificationStatusFlag,
																addrVerificationDate,address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),
													src,seq);
	end;

	export Layouts.CombinedHeaderResults doBocaBusHeaderBaseRecordSrcIdRollup(Layouts.CombinedHeaderResults l, 
																									DATASET(Layouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.LNPID := l.LNPID;
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.isBestBIPResult := l.isBestBIPResult;
		self.isAutokeysResult:= true;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := sort(DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL ),namePenalty);
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( Layouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doDEABaseRecordAddrRollup(left,rows(left))),addrseq);
		self.bdids         := Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	) );
		self.bipkeys       := DEDUP( NORMALIZE( allRows, LEFT.bipkeys, TRANSFORM( Layouts.layout_bipkeys, SELF := RIGHT	)	), record, all);
		self.feins         := DEDUP( NORMALIZE( allRows, LEFT.feins, TRANSFORM( Layouts.layout_fein, SELF := RIGHT	)	), fein, all);
		self.SrcRecRaw		 := sort(dedup( project(sort(allRows.SrcRecRaw,
																			Src,namePenalty,-(integer)addrConfidenceValue,-addrVerificationDate,-Ultid,-orgid,-seleid,-proxid,seq,nameSeq,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																			ssn,dob,did,bdid,fein,dotid,empid,powid,
																			addrSeq,addrSeqGrp,addrGoldFlag,addrType,addrTypeCode,addrVerificationStatusFlag,
																			address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																			sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),AddSequence(left,counter)),
																Src,nameSeq,namePenalty,FullName,FirstName,MiddleName,LastName,Suffix,Title,Gender,CompanyName,
																ssn,dob,did,bdid,fein,dotid,empid,powid,proxid,seleid,orgid,ultid,
																addrSeq,addrSeqGrp,addrGoldFlag,addrConfidenceValue,addrType,addrTypeCode,addrVerificationStatusFlag,
																addrVerificationDate,address1,address2,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
																sec_range,p_city_name,v_city_name,st,z5,zip4,primaryLocation,practiceAddress,BillingAddress,PhoneNumber,FaxNumber),
													src,seq);
	end;

	export Business_Header_SS.Layout_BDID_InBatch convertToBusinessLookup(Layouts.autokeyInput inRecs):= TRANSFORM
				self.seq := (integer)inRecs.acctno;
				self.company_name:= inRecs.comp_name;
				self.prim_range:= inRecs.prim_range;
				self.predir:= inRecs.predir;
				self.prim_name:= inRecs.prim_name;
				self.addr_suffix:= inRecs.addr_suffix;
				self.postdir:= inRecs.postdir;
				self.unit_desig:= inRecs.unit_desig;
				self.sec_range:= inRecs.sec_range;
				self.p_city_name:= inRecs.p_city_name;
				self.st:= inRecs.st;
				self.z5:= inRecs.z5;
				self.zip4:= inRecs.zip4;
				self.phone10:= if(inRecs.homephone <> '',inRecs.homephone,inRecs.workphone);
				self.fein:= inRecs.FEIN;
				self := [];
	end;

	export BatchServices.RollupBusiness_BatchService_Layouts.Input convertToBusinessRollup(Layouts.autokeyInput inRecs):= TRANSFORM
				self.acctno := inRecs.acctno;
				self.comp_name:= inRecs.comp_name;
				self.prim_range:= inRecs.prim_range;
				self.predir:= inRecs.predir;
				self.prim_name:= inRecs.prim_name;
				self.addr_suffix:= inRecs.addr_suffix;
				self.postdir:= inRecs.postdir;
				self.unit_desig:= inRecs.unit_desig;
				self.sec_range:= inRecs.sec_range;
				self.p_city_name:= inRecs.p_city_name;
				self.st:= inRecs.st;
				self.z5:= inRecs.z5;
				self.zip4:= '';//Not currently supported
				self.mileradius:= '';//Not currently supported
				self.workphone:= '';//Not currently supported
				self.fein:= '';//Not currently supported
				self.bdid:= (qstring)inRecs.bdid;
				self.max_results:= (qstring)Constants.MAX_BUSINESSROLLUP_RECS;
				self := [];
	end;
	//Final Rollups
	Export layouts.layout_licenseinfo addLicSeq(Layouts.layout_licenseinfo l, integer c) := TRANSFORM
					self.licenseSeq := c;
					self := l;
	END;

	Export Layouts.layout_licenseinfo doStateLicenseRollup(Layouts.layout_licenseinfo l, dataset(Layouts.layout_licenseinfo) allRows) := transform 
		self.LicSortGroup := max(allRows,Termination_Date)+l.LicSortGroup;
		self.Effective_Date := min(allRows(Effective_Date<>''),Effective_Date);
		self.Termination_Date := max(allRows,Termination_Date);
		self.LicenseNumberFmt := allrows(LicenseNumberFmt<>'')[1].LicenseNumberFmt;
		self.LicenseType := allrows(LicenseType<>'')[1].LicenseType;
		self.LicenseStatus := allrows(LicenseStatus<>'')[1].LicenseStatus;
		self := l;
	END;

	export layouts.layout_addressinfo doFinalBaseRecordAddrRollup(layouts.layout_addressinfo l,
																										DATASET(layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.addrSeq := min(allRows,addrSeq);
			self.first_seen := if(min(allRows(first_seen<>'0'),first_seen) <> '', min(allRows(first_seen<>'0'),first_seen),min(allRows(first_seen<>'0'),last_seen));
			self.v_last_seen := max(allRows,v_last_seen);
			self.v_first_seen := if(min(allRows(first_seen<>'0'),v_first_seen) <> '', min(allRows(first_seen<>'0'),v_first_seen),min(allRows(first_seen<>'0'),v_last_seen));
			self := l;
			self := [];
	end;
	Export  Layouts.layout_nameinfo xformRollNames( Layouts.layout_nameinfo l, 
																							DATASET( Layouts.layout_nameinfo) allRows) := TRANSFORM
									self.nameSeq := l.nameSeq;
									self.namePenalty := min(allRows,namePenalty);
									self.FullName := if(l.FullName<>'',l.FullName,allRows(FullName<>'')[1].FullName);
									self.FirstName := if(l.FirstName<>'',l.FirstName,allRows(FirstName<>'')[1].FirstName);
									self.MiddleName := if(l.MiddleName<>'',l.MiddleName,allRows(MiddleName<>'')[1].MiddleName);
									self.LastName := if(l.LastName<>'',l.LastName,allRows(LastName<>'')[1].LastName);
									self.Suffix := if(l.Suffix<>'',l.Suffix,allRows(Suffix<>'')[1].Suffix);
									self.Title := if(l.Title<>'',l.Title,allRows(Title<>'')[1].Title);
									self.Gender := if(l.Gender<>'',l.Gender,allRows(Gender<>'')[1].Gender);
									self:=l;
	end;
	Export  Layouts.layout_nameinfo xformRollCompany( Layouts.layout_nameinfo l, 
																							DATASET( Layouts.layout_nameinfo) allRows) := TRANSFORM
									self.nameSeq := l.nameSeq;
									self.namePenalty := min(allRows,namePenalty);
									self.CompanyName := if(l.CompanyName<>'',l.CompanyName,allRows(CompanyName<>'')[1].CompanyName);
									self:=l;
	end;
	Export layouts.CombinedHeaderResults doFinalRollup(layouts.CombinedHeaderResults l, 
																							DATASET(layouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.LNPID   := l.LNPID;
		self.SrcId  := l.SrcId;
		self.Src    := if(l.isAutokeysResult or l.Src in [Constants.SRC_SANC,Constants.SRC_BOCA_BUS_HEADER,Constants.SRC_BOCA_PERSON_HEADER,Constants.SRC_GSA_SANC],l.Src,Constants.SRC_HEADER);//For business re-entry we need to keep this until header 2
		self.VendorID := ''; //vendor id should be blank as thee are multiple vendors within a given result
		self.isAutokeysResult := l.isAutokeysResult;
		self.isHeaderResult := if(l.isAutokeysResult,false,true);
		self.isBestBIPResult := l.isBestBIPResult;
		self.isSearchFailed := l.isSearchFailed;
		self.keysfailed_decode := l.keysfailed_decode;
		self.glb_ok	:= if(exists(allRows(glb_ok=true)),true,false);
		self.dppa_ok:= if(exists(allRows(dppa_ok=true)),true,false);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := l.ProcessingMessage;
		self.hasStateRestrict := if(exists(allRows(hasStateRestrict=true)),true,false);
		self.hasOIG := if(exists(allRows(hasOIG=true)),true,false);
		self.hasOPM := if(exists(allRows(hasOPM=true)),true,false);
		self.medicare_fac_num := allRows(medicare_fac_num<>'')[1].medicare_fac_num;
		self.facilitytype := allRows(facilitytype<>'')[1].facilitytype;
		self.organizationtype := allRows(organizationtype<>'')[1].organizationtype;
		//Handle Status
		currentDate := (string)ut.GetDate;
		statusDeceased := exists(allRows(status='D'));
		statusRetired := exists(allRows(status='R'));
		statusActive := exists(allRows(status='A')); 
		self.status := map(statusDeceased => 'D',
											 statusRetired => 'R',
											 statusActive => 'A',
											 ' ');
		self.NPPESVerified := map(exists(allRows(NPPESVerified='YES')) => 'YES',
															exists(allRows(NPPESVerified='CORRECTED')) => 'CORRECTED',
															' ');
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
				//normalize the set for any name that has a first or last or full name building a full name it it does not exist
				nNames := NORMALIZE( allRows, LEFT.Names( (FirstName<>'' or LastName<>'' or FullName<>'' )), 
																																TRANSFORM( Layouts.layout_nameinfo, 
																																									SELF.fullname:=if(right.fullname <>'',right.fullname ,STD.Str.ToUpperCase(std.str.CleanSpaces(right.firstname+' '+right.middlename+' '+right.lastname+' '+right.suffix))),
																																									self.nameseq:=right.nameseq,
																																									self.namepenalty:=right.namepenalty, 
																																									self:=right)	);
				//group and rollup the names based on the newly built full name
				gNames := group(sort(nNames,fullname,nameSeq),fullname);
				Names := rollup(gNames,group,xformRollNames(left,rows(left)));
				//Do the same for Company names
				nCompany := NORMALIZE( allRows, LEFT.Names( CompanyName<>''), 
																																TRANSFORM( Layouts.layout_nameinfo, 
																																									SELF.CompanyName:=if(right.CompanyName <>'',right.CompanyName,right.CompanyName),
																																									self.nameseq:=right.nameseq,
																																									self.namepenalty:=right.namepenalty, 
																																									self:=right)	);
				gCompany := group(sort(nCompany,CompanyName,nameSeq),CompanyName);
				companyNames := rollup(gCompany,group,xformRollCompany(left,rows(left)));
    	 	 sort_names:=dedup(sort(ungroup(names)+ungroup(companynames),fullname,firstname,lastname,suffix,title,companyname),fullname,firstname,lastname,suffix,title,companyname);
		 finalnames:=sort(sort_names,nameSeq,namePenalty,fullname,companyname);	
		 self.Names:=finalnames(nameseq>0);
		
	 	
		/*Add logic to sort based on requirements
			normalize the addresses
			sort them so similar address are together and get priority fields in first position
			dedupe out duplicates that are the exact same address, but to not have the priority fields set
			resort the address using the priority sorting below.
			**** Primary Sorting Sequence ****
			The individual dataset build routines are going to have different addrseq values
			Finally, put a decending on the seen dates to put think in oder after that 
		*/
		self.Addresses     := Choosen(sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																										TRANSFORM( layouts.layout_addressinfo, SELF := RIGHT	)),
																					prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5,addrSeq,-(integer)addrConfidenceValue),
																		 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doFinalBaseRecordAddrRollup(left,rows(left))),addrseq,-(integer)addrConfidenceValue,-addrVerificationDate),100);
		self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( Layouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL )(ssn<>'');
		self.dobs          := sort(DEDUP( NORMALIZE( allRows, LEFT.dobs, TRANSFORM( Layouts.layout_dob, SELF := RIGHT	)	), dob, ALL ),-dob);
		self.phones        := DEDUP( NORMALIZE( allRows, LEFT.phones, TRANSFORM( Layouts.layout_phone, SELF := RIGHT	)	), RECORD, ALL );
		self.dids          := sort(DEDUP( sort(NORMALIZE( allRows, LEFT.dids, TRANSFORM( Layouts.layout_did, SELF := RIGHT	)	),did,-freq), did, ALL ),-freq,did);
		self.bdids         := sort(DEDUP( sort(NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	),bdid,-freq), bdid, ALL ),-freq, bdid);
		self.bipkeys       := sort(DEDUP( sort(NORMALIZE( allRows, LEFT.bipkeys, TRANSFORM( Layouts.layout_bipkeys, SELF := RIGHT	)	),UltID,OrgID,SELEID,-freq), UltID,OrgID,SELEID,ProxID, ALL ),-freq, UltID,OrgID,SELEID);
		self.feins         := DEDUP( NORMALIZE( allRows, LEFT.feins, TRANSFORM( Layouts.layout_fein, SELF := RIGHT	)	), fein, ALL );
		self.taxids        := DEDUP( NORMALIZE( allRows, LEFT.taxids, TRANSFORM( Layouts.layout_taxid, SELF := RIGHT	)	), taxid, ALL );
		self.upins         := DEDUP( NORMALIZE( allRows, LEFT.upins, TRANSFORM( Layouts.layout_upin, SELF := RIGHT	)	), upin, ALL );
		self.npis          := DEDUP( sort( NORMALIZE( allRows, LEFT.npis, TRANSFORM( Layouts.layout_npi, SELF.npi := TRIM(RIGHT.npi,ALL), SELF := RIGHT	)	), npi,bestsource), npi);
		self.deas          := DEDUP( SORT( NORMALIZE( allRows, LEFT.deas, TRANSFORM( Layouts.layout_dea, SELF.dea := TRIM(RIGHT.dea,ALL), SELF := RIGHT	)	), dea, -expiration_date,bestsource), dea, expiration_date );
		self.clianumbers   := DEDUP( NORMALIZE( allRows, LEFT.clianumbers, TRANSFORM( Layouts.layout_clianumber, SELF := RIGHT	)	), clianumber, ALL );
		self.optouts       := DEDUP( NORMALIZE( allRows, LEFT.optouts, TRANSFORM( Layouts.layout_optout, SELF := RIGHT	)	), RECORD, ALL );
		//Adding code to do rollup within each license to get most recent and first expire date to provide range
   //	Adding	condition to check if the license termination date is  less than current date then Mark it as Inactive.
		self.StateLicenses := project(sort(rollup(group(SORT(NORMALIZE( allRows, LEFT.StateLicenses, 
																																		TRANSFORM( Layouts.layout_licenseinfo, 
		                                                                self.LicSortGroup := trim(right.LicenseState,left,right)+(string)(integer)Functions.cleanOnlyNumbers(right.LicenseNumber); 
																																		self.LicenseStatus:=if(right.Termination_Date<currentDate,'I',right.LicenseStatus);
																																		SELF := RIGHT)), LicSortGroup,-Termination_Date),LicSortGroup),group,doStateLicenseRollup(left, rows(left))),-LicSortGroup,map(LicenseStatus='A'=>1,LicenseStatus='S'=>2,LicenseStatus='I'=>3,4)),addLicSeq(left,counter));
		self.affiliates    := DEDUP( NORMALIZE( allRows, LEFT.affiliates, TRANSFORM( Layouts.layout_affiliateHospital, SELF := RIGHT	)	), name, ALL );
		self.hospitals     := DEDUP( NORMALIZE( allRows, LEFT.hospitals, TRANSFORM( Layouts.layout_affiliateHospital, SELF := RIGHT	)	), name, ALL, HASH );
		self.Languages     := DEDUP( NORMALIZE( allRows, LEFT.Languages, TRANSFORM( Layouts.layout_language, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.Degrees     	 := DEDUP( NORMALIZE( allRows, LEFT.Degrees, TRANSFORM( Layouts.layout_degree, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.Specialties   := DEDUP( NORMALIZE( allRows, LEFT.Specialties, TRANSFORM( Layouts.layout_specialty, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.Residencies   := DEDUP( NORMALIZE( allRows, LEFT.Residencies, TRANSFORM( Layouts.layout_residency, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.MedSchools    := sort(DEDUP( NORMALIZE( allRows, LEFT.MedSchools, TRANSFORM( Layouts.layout_medschool, SELF := RIGHT	)	), RECORD, ALL, HASH ),-GraduationYear);
		self.Taxonomy      := DEDUP( NORMALIZE( allRows, LEFT.Taxonomy, TRANSFORM( Layouts.layout_taxonomy, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.Sanctions     := allRows(exists(Sanctions)).Sanctions;
		self.LegacySanctions := sort(DEDUP(allRows(exists(LegacySanctions)).LegacySanctions,record, all, hash),groupsortorder);
		self.SrcRecRaw		 := sort(allRows.SrcRecRaw,src,seq);
		self.NPIRaw        := allRows(exists(NPIRaw)).NPIRaw;
		self.DEARaw        := allRows(exists(DEARaw)).DEARaw;
		self.ProfLicRaw    := allRows(exists(ProfLicRaw)).ProfLicRaw;
		self.CLIARaw    	 := allRows(exists(CLIARaw)).CLIARaw;
		self.NCPDPRaw    := sort(DEDUP( NORMALIZE( allRows, LEFT.NCPDPRaw, TRANSFORM( iesp.ncpdp.t_PharmacyReport, SELF := RIGHT	)	), RECORD, ALL, HASH ),-EntityInformation.ClosureDate);
		self :=[];
	END;
	//Legacy Transforms
	shared legacyLayout.ingenix_npi_rec processNpi(iesp.npireport.t_NPIReport rec, integer c, string Verified) := transform
			self.NPI := rec.NPIInformation.NPINumber;
			self.NPITierTypeID:=0;
			self.NPPESVerified:=if(c=1,Verified,'NO');
	end;
	shared legacyLayout.ingenix_npi_rec processNpiSource(Layouts.layout_npi rec) := transform
			self.NPI := rec.NPI;
			self.NPITierTypeID:=0;
			self.NPPESVerified:='NO';
	end;
	export iesp.healthcare.t_HealthCareBusinessAddress processAddressSearchService(Layouts.layout_addressinfo inAddr):= TRANSFORM
		tmp_off_phone:=dataset([{inAddr.PhoneNumber,'OFFICE PHONE'}],iesp.healthcare.t_HealthCarePhones);
		tmp_off_fax:=dataset([{inAddr.FaxNumber,'OFFICE FAX'}],iesp.healthcare.t_HealthCarePhones);
		self.address := iesp.ECL2ESP.SetAddress(inAddr.prim_name, inAddr.prim_range, inAddr.predir, inAddr.postdir,
           inAddr.addr_suffix, inAddr.unit_desig, inAddr.sec_range, inAddr.p_city_name,
           inAddr.st, inAddr.z5, inAddr.zip4, '');
		self.phones := choosen(tmp_off_phone(Phone10<>'')+tmp_off_fax(Phone10<>''),iesp.constants.HPR.MAX_ADDRESSES_PHONES);
		self.Location.Latitude := inAddr.geo_lat;
		self.Location.Longitude := inAddr.geo_long;
		self.datefirstseen := iesp.ECL2ESP.toDatestring8(if(length(trim(inAddr.first_seen,all))=8,inAddr.first_seen,inAddr.v_first_seen));
		self.datelastseen := iesp.ECL2ESP.toDatestring8(if(length(trim(inAddr.last_seen,all))=8,inAddr.last_seen,inAddr.v_last_seen));
		self := [];
	end;
	export iesp.share.t_GeoAddress processSanctionAddressRaw(Layouts.layout_LegacySanctions inAddr):= TRANSFORM
		self.address := iesp.ECL2ESP.SetAddress(inAddr.ProvCo_Address_Clean_prim_name, inAddr.ProvCo_Address_clean_prim_range, inAddr.ProvCo_Address_clean_predir, inAddr.ProvCo_Address_Clean_postdir,
           inAddr.ProvCo_Address_clean_addr_suffix, inAddr.ProvCo_Address_clean_unit_desig, inAddr.ProvCo_Address_clean_sec_range, inAddr.ProvCo_Address_clean_p_city_name,
           inAddr.ProvCo_Address_clean_st, inAddr.ProvCo_Address_clean_zip, '', '');
		self.Location.Latitude := inAddr.ProvCo_Address_clean_geo_lat;
		self.Location.Longitude := inAddr.ProvCo_Address_clean_geo_long;
	end;
	export iesp.healthcare.t_HealthCareSanctionConsolidatedReport processSanctions(Layouts.layout_LegacySanctions inSanction):= TRANSFORM
		self.SanctionId := (string)inSanction.sanc_id;
		self.UniqueId := inSanction.did;
		self.Name := iesp.ECL2ESP.SetName(inSanction.prov_clean_fname, inSanction.prov_clean_mname, inSanction.prov_clean_lname, inSanction.Prov_Clean_name_suffix, inSanction.Prov_Clean_title, inSanction.SANC_BUSNME);
		self.GeoAddress := project(inSanction, processSanctionAddressRaw(left));
		self.DOB := iesp.ECL2ESP.toDatestring8(inSanction.sanc_dob);
		self.TaxId := inSanction.sanc_tin;
		self.UPIN := inSanction.sanc_upin;
		self.Source := inSanction.sanc_src_desc;
		self.SanctionTerm := inSanction.sanc_terms;
		self.SanctionType := inSanction.sanc_type;
		self.BoardType := inSanction.sanc_brdtype;
		self.ProviderType := inSanction.sanc_provtype;
		self.Fines := inSanction.sanc_fines;
		self.SanctionReason := inSanction.sanc_reas;
		self.Conditions := inSanction.sanc_cond;
		self.LicenseNumber := inSanction.sanc_licnbr;
		self.SanctionState := inSanction.sanc_sancst;
		self.SanctionDate := iesp.ECL2ESP.toDatestring8(inSanction.sanc_sancdte_form);
		self.DateLastReported := iesp.ECL2ESP.toDatestring8(inSanction.date_last_reported);
		self.DateFirstSeen := iesp.ECL2ESP.toDatestring8(inSanction.date_first_seen);
		self.DateLastSeen := iesp.ECL2ESP.toDatestring8(inSanction.date_last_seen);
		self.LicenseReinstatedDate := iesp.ECL2ESP.toDatestring8(inSanction.sanc_reindte_form);
		self.FraudAbuseFlag := if(inSanction.sanc_fab='TRUE',TRUE,FALSE);
		self.LostOfLicenseIndicator := if(inSanction.sanc_unamb_ind='TRUE',TRUE,FALSE);
		self.DateFirstReported := iesp.ECL2ESP.toDatestring8(inSanction.date_first_reported);
		self.ProcessDate := iesp.ECL2ESP.toDatestring8(inSanction.process_date);
		self.SanctionGroupType := inSanction.sanc_grouptype;
		self.SanctionSubGroupType := inSanction.sanc_subgrouptype;
		self.NationalProviderId := '';//Not in the Sanction file
		self.nppesVerified := inSanction.nppesVerified;
		self.DerivedReinstateDateIndicator := inSanction.LNDerivedReinstateDate;
		self.SanctionTypePriority := (string)inSanction.sanc_priority;
		self := inSanction;
		self := [];
	end;
	Export LegacySearch fmtLegacySearch (Layouts.CombinedHeaderResults resultRec) := transform
		self.ProviderID:= if(resultRec.issearchfailed,skip,(string)resultRec.LNPID);
		self.ProviderSrc:= resultRec.Src;
		self.did:=(string)resultRec.dids[1].did;
		self.name:= dedup(project(choosen(resultRec.Names,Constants.MAX_SEARCH_RECS), 
																	transform(legacyLayout.ingenix_name_rec,
																						skipit := left.FirstName = '' and left.MiddleName = '' and left.LastName ='';
																						self.Prov_Clean_fname := if(skipit,skip,left.FirstName);
																						self.Prov_Clean_mname := left.MiddleName;
																						self.Prov_Clean_lname := if(left.LastName <>'',left.LastName,left.CompanyName);
																						self.Prov_Clean_name_suffix := left.Suffix;
																						self := [];)),Prov_Clean_fname,Prov_Clean_mname,Prov_Clean_lname,all);
		self.taxid := project(choosen(resultRec.taxids,Constants.MAX_SEARCH_RECS), 
																		transform(legacyLayout.ingenix_taxid_rec, self.TaxID:=left.taxid;self := [];));
		self.dob := project(choosen(resultRec.dobs,Constants.MAX_SEARCH_RECS), 
																		transform(legacyLayout.ingenix_dob_rec, self.BirthDate:=left.dob;self := [];));
		self.license := dedup(sort(project(choosen(resultRec.StateLicenses,Constants.MAX_SEARCH_RECS), 
																		transform(legacyLayout.ingenix_license_rec,self := left;self := [])),record),record);
		self.address := project(choosen(resultRec.Addresses,Constants.MAX_SEARCH_RECS), 
																		transform(legacyLayout.ingenix_addr_rec_online,
																							tmp_off_phone:=project(left.Phones(phonenumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.phonenumber,self.PhoneType:='OFFICE PHONE';self := []));
																							tmp_off_fax:=project(left.Phones(faxnumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.faxnumber,self.PhoneType:='OFFICE FAX';self := []));
																							self.Prov_Clean_prim_range:=left.prim_range;
																							self.Prov_Clean_predir:=left.predir;
																							self.Prov_Clean_prim_name:=left.prim_name;
																							self.Prov_Clean_addr_suffix:=left.addr_suffix;
																							self.Prov_Clean_postdir:=left.postdir;
																							self.Prov_Clean_unit_desig:=left.unit_desig;
																							self.Prov_Clean_sec_range:=left.sec_range;
																							self.Prov_Clean_p_city_name:=left.p_city_name;
																							self.Prov_Clean_v_city_name:=left.v_city_name;
																							self.Prov_Clean_st:=left.st;
																							self.Prov_Clean_zip:=left.z5;
																							self.Prov_Clean_zip4:=left.zip4;
																							self.first_seen := left.first_seen;
																							self.last_seen := left.last_seen;
																							SELF.PHONE := tmp_off_phone(PhoneNumber<>'')+tmp_off_fax(PhoneNumber<>''); 
																							self := []));
	end;
	Export LegacyReport fmtLegacyRpt(layouts.CombinedHeaderResultsDoxieLayout resultRec, dataset(Layouts.common_runtime_config) cfg) := transform
		searchCriteria := cfg[1];
		myGender := resultRec.Names(Gender<>'')[1].Gender;
		self.ProviderID:= if(resultRec.issearchfailed,skip,(string)resultRec.LNPID);
		self.ProviderSrc:= resultRec.Src;
		self.Gender := myGender;
		self.Gender_Name := map(myGender='M' => 'MALE',
														myGender='F' => 'FEMALE',
														myGender);
		self.sanc_flag := if(count(resultRec.LegacySanctions) >0,true,false);
		self.sanction_id := [];//Do not exist anymore;
		self.providerdid := project(resultRec.dids, transform(legacyLayout.ingenix_did_rec,self.did:=(string)left.did));
		self.name:= project(resultRec.Names, transform(legacyLayout.ingenix_name_rec,
																						skipit := left.FirstName = '' and left.MiddleName = '' and left.LastName ='';
																						self.Prov_Clean_fname := if(skipit,skip,left.FirstName);
																						self.Prov_Clean_mname := left.MiddleName;
																						self.Prov_Clean_lname := if(left.LastName <>'',left.LastName,left.CompanyName);
																						self.Prov_Clean_name_suffix := left.Suffix;
																						self := [];));
		self.taxid := project(resultRec.taxids, transform(legacyLayout.ingenix_taxid_rec, self.TaxID:=left.taxid;self := [];));
		self.dob := project(resultRec.dobs, transform(legacyLayout.ingenix_dob_rec, self.BirthDate:=left.dob;self := [];));
		//Add rules about DOD
		dodTmp := dataset([{(string)resultRec.DeathLookup,resultRec.DateofDeath}],legacyLayout.ingenix_dod_rec);
		dodFull := dedup(sort(project(resultRec.optouts(death_ind<>''), transform(legacyLayout.ingenix_dod_rec, self.DeceasedIndicator := left.death_ind; self.DeceasedDate:=left.death_dt))+dodTmp,-DeceasedDate),record)(DeceasedDate<>'');
		self.dod := if(searchCriteria.IsShowAllDoDs,dodFull,choosen(dodFull,1));
		self.language := project(resultRec.Languages,legacyLayout.ingenix_language_rec);
		self.upin := project(resultRec.upins,transform(legacyLayout.ingenix_upin_rec,self.UPIN:=left.upin;self := []));
		npi_recs := project(resultRec.NPIRaw,processNpi(Left,counter,resultRec.NPPESVerified));
		npi_recs_orig := project(resultRec.npis,processNpiSource(left));
		npi_recs_filter := join(npi_recs,npi_recs_orig,left.npi=right.npi,right only);//Only keep those that are not dupes
		npi_recs_final := dedup(sort(npi_recs+npi_recs_filter,if(nppesverified = 'YES', 1, 2),npi),npi);
		self.npi := npi_recs_final;
		self.license := project(resultRec.StateLicenses, transform(legacyLayout.ingenix_license_rpt_rec,
																											self.LicenseState := left.LicenseState;
																											self.LicenseNumber := left.LicenseNumber;
																											self.Effective_Date := left.Effective_Date;
																											self.Termination_Date := left.Termination_Date;
																											self := []));
		self.dea := dedup(sort(project(resultRec.deas,transform(legacyLayout.ingenix_dea_rec,
																											self.DEANumber:=left.dea;
																											self.expiration_date := left.expiration_date;
																											self := []))(expiration_date<>''),deanumber,-expiration_date),deanumber,expiration_date);

		self.degree := project(resultRec.Degrees,legacyLayout.ingenix_degree_rec);
		self.specialty := project(resultRec.Specialties,legacyLayout.ingenix_specialty_rec);
		self.business_address := project(resultRec.Addresses, transform(legacyLayout.ingenix_addr_rpt_rec,
																		tmp_off_phone:=project(left.Phones(phonenumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.phonenumber,self.PhoneType:='OFFICE PHONE';self := []));
																		tmp_off_fax:=project(left.Phones(faxnumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.faxnumber,self.PhoneType:='OFFICE FAX';self := []));
																							self.Prov_Clean_prim_range:=left.prim_range;
																							self.Prov_Clean_predir:=left.predir;
																							self.Prov_Clean_prim_name:=left.prim_name;
																							self.Prov_Clean_addr_suffix:=left.addr_suffix;
																							self.Prov_Clean_postdir:=left.postdir;
																							self.Prov_Clean_unit_desig:=left.unit_desig;
																							self.Prov_Clean_sec_range:=left.sec_range;
																							self.Prov_Clean_p_city_name:=left.p_city_name;
																							self.Prov_Clean_v_city_name:=left.v_city_name;
																							self.Prov_Clean_st:=left.st;
																							self.Prov_Clean_zip:=left.z5;
																							self.Prov_Clean_zip4:=left.zip4;
																							self.prov_Clean_geo_lat:=left.geo_lat;
																							SELF.prov_Clean_geo_long:=left.geo_long;
																							SELF.PHONE := tmp_off_phone(PhoneNumber<>'')+tmp_off_fax(PhoneNumber<>'');
																							self.first_seen := left.first_seen;
																							self.last_seen := left.last_seen;
																							self := []));
		self.group_affiliation := project(resultRec.affiliates, transform(legacyLayout.ingenix_group_rec,
																							self.BDID := (string)left.bdid;
																							self.GroupName := left.name;
																							self.Address := left.address1;
																							self.City := left.p_city_name;
																							self.State := left.st;
																							self.Zip := left.z5;
																							self := []));
		self.hospital_affiliation := project(resultRec.hospitals, transform(legacyLayout.ingenix_hospital_rec,
																							self.BDID := (string)left.bdid;
																							self.HospitalName := left.name;
																							self.Address := left.address1;
																							self.City := left.p_city_name;
																							self.State := left.st;
																							self.Zip := left.z5;
																							self := []));
		self.residency := project(resultRec.Residencies,legacyLayout.ingenix_residency_rec);
		self.medschool := project(resultRec.MedSchools,legacyLayout.ingenix_medschool_rec);
		self.taxonomy := project(resultRec.Taxonomy,legacyLayout.ingenix_taxonomy_rec);
		self.sanction_data := project(resultRec.LegacySanctions,legacyLayout.ingenix_sanc_child_rec_full);
		self.SSN := dedup(sort(project(resultRec.SSNLookups,legacyLayout.ingenix_ssn_rec)+project(resultRec.ssns,legacyLayout.ingenix_ssn_rec),record),record);
		self.medicareoptout := project(resultRec.optouts, transform(legacyLayout.ingenix_medicare_optout_rec,
																				self.OptOutSiteDescription:=left.optout_sitedesc;
																				self.AffidavitReceivedDate:=left.optout_rec_dt;
																				self.OptOutEffectiveDate:=left.optout_eff_dt;
																				self.OptOutTerminationDate:=left.optout_term_dt;
																				self.OptOutStatus:=left.optout_status;
																				self.LastUpdate:=left.optout_last_update;
																				self := []))(OptOutSiteDescription<>'' or OptOutTerminationDate<>'');
		self.Deceased := resultRec.DeathLookup or exists(resultRec.optouts(death_ind='Y'));
		self := resultRec;
		self := [];
	end;
	Export LegacyReportWithVerification fmtLegacyRptWithVerifications(layouts.CombinedHeaderResultsDoxieLayout resultRec, dataset(Layouts.common_runtime_config) cfg) := transform
		searchCriteria := cfg[1];
		myGender := resultRec.Names(Gender<>'')[1].Gender;
		self.ProviderID:= (string)resultRec.LNPID;
		self.ProviderSrc:= resultRec.Src;
		self.Gender := myGender;
		self.Gender_Name := map(myGender='M' => 'MALE',
														myGender='F' => 'FEMALE',
														myGender);
		self.sanc_flag := if(count(resultRec.Sanctions) >0,true,false);
		self.sanction_id := [];//no longer valid;
		self.providerdid := project(resultRec.dids, transform(legacyLayout.ingenix_did_rec,self.did:=(string)left.did));
		self.name:= project(resultRec.Names, transform(legacyLayout.ingenix_name_rec,
																						self.Prov_Clean_fname := left.FirstName;
																						self.Prov_Clean_mname := left.MiddleName;
																						self.Prov_Clean_lname := if(left.LastName <>'',left.LastName,left.CompanyName);
																						self.Prov_Clean_name_suffix := left.Suffix;
																						self := [];));
		self.taxid := project(resultRec.taxids, transform(legacyLayout.ingenix_taxid_rec, self.TaxID:=left.taxid;self := [];));
		self.dob := project(resultRec.dobs, transform(legacyLayout.ingenix_dob_rec, self.BirthDate:=left.dob;self := [];));
		//Add rules about DOD
		dodTmp := dataset([{(string)resultRec.DeathLookup,resultRec.DateofDeath}],legacyLayout.ingenix_dod_rec);
		dodFull := dedup(sort(project(resultRec.optouts(death_ind<>''), transform(legacyLayout.ingenix_dod_rec, self.DeceasedIndicator := left.death_ind; self.DeceasedDate:=left.death_dt))+dodTmp,-DeceasedDate),record)(DeceasedDate<>'');
		self.dod := if(searchCriteria.IsShowAllDoDs,dodFull,choosen(dodFull,1));
		self.language := project(resultRec.Languages,legacyLayout.ingenix_language_rec);
		self.upin := project(resultRec.upins,transform(legacyLayout.ingenix_upin_rec,self.UPIN:=left.upin;self := []));
		npi_recs := project(resultRec.NPIRaw,processNpi(Left,counter,resultRec.NPPESVerified));
		npi_recs_orig := project(resultRec.npis,processNpiSource(left));
		npi_recs_filter := join(npi_recs,npi_recs_orig,left.npi=right.npi,right only);//Only keep those that are not dupes
		npi_recs_final := dedup(sort(npi_recs+npi_recs_filter,if(nppesverified = 'YES', 1, 2),npi),npi);
		self.npi := npi_recs_final;
		self.license := project(resultRec.StateLicenses, transform(legacyLayout.ingenix_license_rpt_rec,
																											self.LicenseState := left.LicenseState;
																											self.LicenseNumber := left.LicenseNumber;
																											self.Effective_Date := left.Effective_Date;
																											self.Termination_Date := left.Termination_Date;
																											self := []));
		self.dea := dedup(sort(project(resultRec.deas,transform(legacyLayout.ingenix_dea_rec,
																											self.DEANumber:=left.dea;
																											self.expiration_date := left.expiration_date;
																											self := []))(expiration_date<>''),deanumber,-expiration_date),deanumber,expiration_date);

		self.degree := project(resultRec.Degrees,legacyLayout.ingenix_degree_rec);
		self.specialty := project(resultRec.Specialties,legacyLayout.ingenix_specialty_rec);
		self.business_address := project(resultRec.Addresses, transform(legacyLayout.ingenix_addr_rpt_rec,
																		tmp_off_phone:=project(left.Phones(phonenumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.phonenumber,self.PhoneType:='OFFICE PHONE';self := []));
																		tmp_off_fax:=project(left.Phones(faxnumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.faxnumber,self.PhoneType:='OFFICE FAX';self := []));
																							self.Prov_Clean_prim_range:=left.prim_range;
																							self.Prov_Clean_predir:=left.predir;
																							self.Prov_Clean_prim_name:=left.prim_name;
																							self.Prov_Clean_addr_suffix:=left.addr_suffix;
																							self.Prov_Clean_postdir:=left.postdir;
																							self.Prov_Clean_unit_desig:=left.unit_desig;
																							self.Prov_Clean_sec_range:=left.sec_range;
																							self.Prov_Clean_p_city_name:=left.p_city_name;
																							self.Prov_Clean_v_city_name:=left.v_city_name;
																							self.Prov_Clean_st:=left.st;
																							self.Prov_Clean_zip:=left.z5;
																							self.Prov_Clean_zip4:=left.zip4;
																							self.prov_Clean_geo_lat:=left.geo_lat;
																							SELF.prov_Clean_geo_long:=left.geo_long;
																							SELF.PHONE := tmp_off_phone(PhoneNumber<>'')+tmp_off_fax(PhoneNumber<>'');
																							self.first_seen := left.first_seen;
																							self.last_seen := left.last_seen;
																							self := []));
		self.group_affiliation := project(resultRec.affiliates, transform(legacyLayout.ingenix_group_rec,
																							self.BDID := (string)left.bdid;
																							self.GroupName := left.name;
																							self.Address := left.address1;
																							self.City := left.p_city_name;
																							self.State := left.st;
																							self.Zip := left.z5;
																							self := []));
		self.hospital_affiliation := project(resultRec.hospitals, transform(legacyLayout.ingenix_hospital_rec,
																							self.BDID := (string)left.bdid;
																							self.HospitalName := left.name;
																							self.Address := left.address1;
																							self.City := left.p_city_name;
																							self.State := left.st;
																							self.Zip := left.z5;
																							self := []));
		self.residency := project(resultRec.Residencies,legacyLayout.ingenix_residency_rec);
		self.medschool := project(resultRec.MedSchools,legacyLayout.ingenix_medschool_rec);
		self.taxonomy := project(resultRec.Taxonomy,legacyLayout.ingenix_taxonomy_rec);
		self.sanction_data := project(resultRec.LegacySanctions,legacyLayout.ingenix_sanc_child_rec_full);
		self.SSN := dedup(sort(project(resultRec.SSNLookups,legacyLayout.ingenix_ssn_rec)+project(resultRec.ssns,legacyLayout.ingenix_ssn_rec),record),record);
		self.medicareoptout := project(resultRec.optouts, transform(legacyLayout.ingenix_medicare_optout_rec,
																				self.OptOutSiteDescription:=left.optout_sitedesc;
																				self.AffidavitReceivedDate:=left.optout_rec_dt;
																				self.OptOutEffectiveDate:=left.optout_eff_dt;
																				self.OptOutTerminationDate:=left.optout_term_dt;
																				self.OptOutStatus:=left.optout_status;
																				self.LastUpdate:=left.optout_last_update;
																				self := []))(OptOutSiteDescription<>'' or OptOutTerminationDate<>'');
		self.Deceased := resultRec.DeathLookup or exists(resultRec.optouts(death_ind='Y'));
		self := resultRec;
		self := [];
	end;
	export iesp.healthcareconsolidatedsearch.t_HealthCareConsolidatedSearchProvider formatSearchServiceProviderOutput(Layouts.CombinedHeaderResultsDoxieLayout resultRec, dataset(Layouts.autokeyInput) aInputData, dataset(Layouts.common_runtime_config) cfg)  := TRANSFORM 
		searchCriteria := cfg[1];
		self.ProviderId :=if(resultRec.issearchfailed,error(203,doxie.ErrorCodes(203)),(string)resultRec.lnpid);
		self.ProviderSrc := resultRec.Src;
		self.sex := resultRec.Names[1].Gender;
		self.UniqueIds := choosen(project(resultRec.dids, transform (iesp.share.t_StringArrayItem, Self.value := (string)Left.did)),iesp.Constants.HPR.MAX_UNIQUEIDS);
		self.BusinessIds := choosen(project(resultRec.bdids, transform (iesp.share.t_StringArrayItem, Self.value := (string)Left.bdid)),iesp.Constants.HPR.MAX_BDIDS);
		self.BusinessLinkIds := choosen(project(resultRec.bipkeys, transform (iesp.share.t_BusinessIdentity, self := left)),iesp.Constants.HPR.MAX_UNIQUEIDS);
		self.Names := choosen(dedup(sort(project(sort(dedup(sort(resultRec.names(nameSeq>0),FirstName,MiddleName,LastName,companyname,nameSeq),FirstName,MiddleName,LastName,companyname),nameSeq), transform(iesp.share.t_Name, self := iesp.ECL2ESP.SetName(left.FirstName, left.MiddleName, left.LastName, left.Suffix,'',map(left.LastName = '' and left.CompanyName <>''=>left.CompanyName,left.FullName)))),record),record)  ,iesp.Constants.HPR.MAX_NAMES);
		self.Languages := choosen(project(dedup(sort(resultRec.Languages,language),language), transform (iesp.share.t_StringArrayItem, Self.value := Left.language)),iesp.Constants.HPR.MAX_LANGUAGES);
		self.DOBs := choosen(project(dedup(sort(resultRec.dobs,-dob),dob), transform (iesp.share.t_Date, Self := if(resultRec.glb_ok,iesp.ECL2ESP.toDatestring8(Left.dob),iesp.ECL2ESP.ApplyDateMask(iesp.ECL2ESP.toDatestring8(Left.dob),5)))),iesp.Constants.HPR.MAX_DOBS);
		tmp_feins := project(dedup(sort(resultRec.feins,fein),fein), transform (iesp.share.t_StringArrayItem, Self.value := Left.fein));
		self.TaxIds := choosen(project(dedup(sort(resultRec.taxids,taxid),taxid), transform (iesp.share.t_StringArrayItem, Self.value := Left.taxid))+tmp_feins,iesp.Constants.HPR.MAX_TAXIDS);
		self.UPINs := choosen(project(dedup(sort(resultRec.upins,upin),upin), transform (iesp.share.t_StringArrayItem, Self.value := Left.upin)),iesp.Constants.HPR.MAX_UPINS);
		self.Degrees := choosen(project(dedup(sort(resultRec.degrees,degree),degree), transform (iesp.share.t_StringArrayItem, Self.value := Left.degree)),iesp.Constants.HPR.MAX_DEGREES);
		npi_recs := project(resultRec.NPIRaw,transform(iesp.share.t_StringArrayItem, Self.value := Left.NPIInformation.NPINumber));
		npi_recs_orig := project(resultRec.npis,transform (iesp.share.t_StringArrayItem, Self.value := Left.npi));
		npi_recs_filter := join(npi_recs,npi_recs_orig,left.value=right.value,right only);//Only keep those that are not dupes
		npi_recs_final := dedup(npi_recs+npi_recs_filter,record,all);
		self.NationalProviderIds := choosen(npi_recs_final,iesp.Constants.HPR.MAX_NPIS);
		self.NPPESVerified := resultRec.NPPESVerified;
		self.DEAInformation := choosen(project(dedup(sort(resultRec.deas,dea,-expiration_date),dea,expiration_date), transform (iesp.healthcare.t_DEAControlledSubstanceRecordEx, self.Number := left.dea, self.registrationNumber := left.dea, self.ExpirationDate := iesp.ECL2ESP.toDatestring8(Left.expiration_date), self := [])),iesp.Constants.HPR.MAX_DEAS);
		self.GroupAffiliations := choosen(project(dedup(sort(resultRec.affiliates,stringlib.StringToLowerCase(name)),stringlib.StringToLowerCase(name)), transform (iesp.healthcare.t_ProviderRelatedEntity, self.BusinessId:= if(~searchCriteria.IncludeGroupAffiliations,skip,(string)left.bdid), self.fein:= left.tin; self.Name:=left.name)),iesp.Constants.HPR.MAX_GROUPAFFILIATIONS);
		// self.GroupAffiliations := choosen(project(dedup(sort(resultRec.affiliates,stringlib.StringToLowerCase(name)),stringlib.StringToLowerCase(name)), transform (iesp.healthcare.t_ProviderRelatedEntity, self.BusinessId:= if(~searchCriteria.IncludeGroupAffiliations,skip,(string)left.bdid), self.Name:=left.name)),iesp.Constants.HPR.MAX_GROUPAFFILIATIONS);
		self.HospitalAffiliations := choosen(project(dedup(sort(resultRec.hospitals,stringlib.StringToLowerCase(name)),stringlib.StringToLowerCase(name)),  transform (iesp.healthcare.t_ProviderRelatedEntity,  self.BusinessId:=if(~searchCriteria.IncludeHospitalAffiliations,skip,(string)left.bdid), self.fein:= left.tin; self.Name:=left.name)),iesp.Constants.HPR.MAX_HOSPITALAFFILIATIONS);
		// self.HospitalAffiliations := choosen(project(dedup(sort(resultRec.hospitals,stringlib.StringToLowerCase(name)),stringlib.StringToLowerCase(name)),  transform (iesp.healthcare.t_ProviderRelatedEntity,  self.BusinessId:=if(~searchCriteria.IncludeHospitalAffiliations,skip,(string)left.bdid), self.Name:=left.name)),iesp.Constants.HPR.MAX_HOSPITALAFFILIATIONS);
		self.Residencies := choosen(project(dedup(sort(resultRec.Residencies,residency),residency), transform(iesp.healthcare.t_ProviderRelatedEntity, self.BusinessId:= if(~searchCriteria.IncludeResidencies,skip,left.bdid), self.Name:=left.residency, self:=[];)),iesp.Constants.HPR.MAX_RESIDENCIES);
		self.MedicalSchools := choosen(project(dedup(sort(resultRec.MedSchools,medschoolname,-graduationyear),medschoolname,graduationyear), transform(iesp.healthcare.t_MedicalSchool, self.BusinessId:=left.bdid, self.Name:=left.medschoolname, self.GraduationYear:=(Integer)left.graduationyear, self:=[];)),iesp.Constants.HPR.MAX_MEDICALSCHOOLS);
		self.Specialties := choosen(project(dedup(sort(resultRec.Specialties(specialtyname<>''),specialtyname,specialtygroupname),stringlib.StringToLowerCase(specialtyname),stringlib.StringToLowerCase(specialtygroupname)), transform(iesp.healthcare.t_Specialty, self.SpecialtyId:=if(~searchCriteria.IncludeSpecialties,skip,(String)left.specialtyid), self.SpecialtyName:=left.specialtyname, self.GroupId:=(String)left.specialtygroupid, self.GroupName:=left.specialtygroupname)),iesp.Constants.HPR.MAX_SPECIALTIES);
		self.BusinessAddresses := choosen(project(resultRec.Addresses(prim_name<>'' and st<>''), processAddressSearchService(left)),iesp.Constants.HPR.MAX_BUSINESSADDRESSES);
		self.Licenses := choosen(project(resultRec.StateLicenses, transform(iesp.healthcare.t_ProviderLicenseInfo, self.LicenseState:=if(~searchCriteria.IncludeLicenses,skip,left.licensestate), self.LicenseNumber :=left.licensenumber, self.EffectiveDate:=iesp.ECL2ESP.toDatestring8(Left.effective_date), self.ExpirationDate:=iesp.ECL2ESP.toDatestring8(Left.termination_date), self.LicenseSeqID := left.licenseSeq; self.LicenseType:=left.LicenseType;self.LicenseNumberOrig:= if(left.LicenseNumberFmt <> '',left.LicenseNumberFmt,'');self := left)),iesp.Constants.HPR.MAX_LICENSES);
		// self.Licenses := choosen(project(resultRec.StateLicenses, transform(iesp.healthcare.t_ProviderLicenseInfo, self.LicenseState:=if(~searchCriteria.IncludeLicenses,skip,left.licensestate), self.LicenseNumber :=left.licensenumber, self.EffectiveDate:=iesp.ECL2ESP.toDatestring8(Left.effective_date), self.ExpirationDate:=iesp.ECL2ESP.toDatestring8(Left.termination_date), self.LicenseSeqID := left.licenseSeq; self := left)),iesp.Constants.HPR.MAX_LICENSES);
		self.HasSanctions := exists(resultRec.LegacySanctions);
		self.HasLEIESanctions:= exists(resultRec.LegacySanctions(sanc_grouptype='FEDERAL',sanc_subgrouptype='OIG'));
		self.HasEPLSSanctions:= exists(resultRec.LegacySanctions(sanc_grouptype='FEDERAL',sanc_subgrouptype='OPM'));
		self.HasDisciplinarySanctions:=exists(resultRec.LegacySanctions(sanc_grouptype='FEDERAL',sanc_subgrouptype='')) or exists(resultRec.LegacySanctions(sanc_grouptype='STATE'));
		self.SanctionIds := choosen(project(resultRec.LegacySanctions, transform (iesp.share.t_StringArrayItem, Self.value := (string)Left.sanc_id)),iesp.Constants.HPR.MAX_SANCTIONIDS);
		self.Sanctions := choosen(Project(resultRec.LegacySanctions,processSanctions(left)),iesp.Constants.HPR.MAX_SANCTIONS);
		self.Deceased := resultRec.DeathLookup or resultRec.DateofDeath <> '' or exists(resultRec.optouts(death_ind='Y')) or exists(resultRec.customerDeath);
		self.IsFederalDeceased := resultRec.DeathLookup or resultRec.DateofDeath <> '' or exists(resultRec.optouts(death_ind='Y'));
		self.IsStateDeceased := exists(resultRec.customerDeath);
		self.SSNs := choosen(dedup(sort(project(resultRec.ssns, transform (iesp.share.t_StringArrayItem, Self.value := Left.ssn))+project(resultRec.ssnlookups, transform (iesp.share.t_StringArrayItem, Self.value := Left.ssn)),value),value),iesp.Constants.HPR.MAX_SSNS);
		self.MedicareOptOuts := project(resultRec.optouts, transform(iesp.healthcare.t_MedicareOptOut,
																						self.OptOutSiteDescription:=left.optout_sitedesc;
																						self.AffidavitReceivedDate:=iesp.ECL2ESP.toDatestring8(Left.optout_rec_dt);
																						self.OptOutEffectiveDate:=iesp.ECL2ESP.toDatestring8(left.optout_eff_dt);
																						self.OptOutTerminationDate:=iesp.ECL2ESP.toDatestring8(left.optout_term_dt);
																						self.OptOutStatus:=left.optout_status;
																						self := []))[1];
		//Add rules about DOD
		dodTmp := if(length(trim(resultRec.DateofDeath,all))>0,iesp.ECL2ESP.toDatestring8(resultRec.DateofDeath));
		dodFull := dedup(sort(project(resultRec.optouts(death_ind<>''), transform(iesp.share.t_Date, self:=iesp.ECL2ESP.toDatestring8(left.death_dt)))+dodTmp,-year,-month,-day),year,month,day)(year>0);
		self.DODs := if(searchCriteria.IsShowAllDoDs,dodFull,choosen(dodFull,1));
		self.CLIARecords := resultRec.CLIARaw;
		self.NPIReports := choosen(resultRec.NPIRaw,10);
		self.Taxonomies := choosen(project(resultRec.Taxonomy,transform(iesp.proflicense.t_Taxonomy,self:=left)),iesp.Constants.PROFLIC.MAX_TAXONOMY);
		self.PharmacyRecords := choosen(project(resultRec.NCPDPRaw,transform(iesp.ncpdp.t_PharmacyReportConsolidatedSearch, self:=left;self:=[];)),iesp.Constants.HPR.Max_NCPDP_Report);
		self.StateLicenseRecords := choosen(resultRec.customerLicense,iesp.Constants.PROFLIC.MAX_TAXONOMY);
		self.StateVitalRecords := choosen(resultRec.customerDeath,iesp.Constants.PROFLIC.MAX_TAXONOMY);
		self.Certifications := resultRec.abmsRaw[1].Certifications;//Let's hope for the best in matching.
		self.Verifications.VerificationConfiguration := resultRec.VerificationInfo[1].VerificationConfiguration;
		self.Verifications.VerificationConfigurationStatus := resultRec.VerificationInfo[1].VerificationConfigurationStatus;
		self.Verifications.VerificationConfigurationOutcome := resultRec.VerificationInfo[1].VerificationConfigurationOutcome;
		self.Verifications.NameVerified := resultRec.VerificationInfo[1].NameVerified;
		self.Verifications.CompanyNameVerified := resultRec.VerificationInfo[1].CompanyNameVerified;
		self.Verifications.AddressVerified := resultRec.VerificationInfo[1].AddressVerified;
		self.Verifications.PhoneVerified := resultRec.VerificationInfo[1].PhoneVerified;
		self.Verifications.UPINVerified := resultRec.VerificationInfo[1].UPINVerified;
		self.Verifications.NPIVerified := resultRec.VerificationInfo[1].NPIVerified;
		self.Verifications.FEINVerified := resultRec.VerificationInfo[1].FEINVerified;
		self.Verifications.FEINSuppliedExists := resultRec.VerificationInfo[1].FEINSuppliedExists;
		self.Verifications.SSNVerified := resultRec.VerificationInfo[1].SSNVerified;
		self.Verifications.LicenseVerified := resultRec.VerificationInfo[1].LicenseVerified;
		self.Verifications.CLIAVerified := resultRec.VerificationInfo[1].CLIAVerified;
		self.Verifications.MedicalSchoolNameVerified := resultRec.VerificationInfo[1].MedicalSchoolNameVerified;
		self.Verifications.GraduationYearVerified := resultRec.VerificationInfo[1].GraduationYearVerified;
		self.Verifications.NPIValid := resultRec.VerificationInfo[1].NPIValid;
		self.Verifications.NPISuppliedExists := resultRec.VerificationInfo[1].NPISuppliedExists;
		self.Verifications.LicenseValid := resultRec.VerificationInfo[1].LicenseValid;
		self.Verifications.CLIAValid := resultRec.VerificationInfo[1].CLIAValid;
		self.Verifications.DEAVerified := resultRec.VerificationInfo[1].DEAVerified;
		self.Verifications.DEA2Verified := resultRec.VerificationInfo[1].DEA2Verified;
		self.Verifications.DEAValid := resultRec.VerificationInfo[1].DEAValid;
		self.Verifications.DEA2Valid := resultRec.VerificationInfo[1].DEA2Valid;
		self.Verifications.PharmacyProviderIdVerified := resultRec.VerificationInfo[1].NCPDPNumberVerified;
		self.Verifications.TaxonomyVerified := resultRec.VerificationInfo[1].TaxonomyVerified;
		self.Verifications.Taxonomy1Verified := resultRec.VerificationInfo[1].Taxonomy1Verified;
		self.Verifications.Taxonomy2Verified := resultRec.VerificationInfo[1].Taxonomy2Verified;
		self.Verifications.Taxonomy3Verified := resultRec.VerificationInfo[1].Taxonomy3Verified;
		self.Verifications.Taxonomy4Verified := resultRec.VerificationInfo[1].Taxonomy4Verified;
		self.Verifications.Taxonomy5Verified := resultRec.VerificationInfo[1].Taxonomy5Verified;
		self.Verifications.License1Verified := resultRec.VerificationInfo[1].License1Verified;
		self.Verifications.License1Valid := resultRec.VerificationInfo[1].License1Valid;
		self.Verifications.License1ResultMatch := resultRec.VerificationInfo[1].License1ResultMatch;
		self.Verifications.License2Verified := resultRec.VerificationInfo[1].License2Verified;
		self.Verifications.License2Valid := resultRec.VerificationInfo[1].License2Valid;
		self.Verifications.License2ResultMatch := resultRec.VerificationInfo[1].License2ResultMatch;
		self.Verifications.License3Verified := resultRec.VerificationInfo[1].License3Verified;
		self.Verifications.License3Valid := resultRec.VerificationInfo[1].License3Valid;
		self.Verifications.License3ResultMatch := resultRec.VerificationInfo[1].License3ResultMatch;
		self.Verifications.License4Verified := resultRec.VerificationInfo[1].License4Verified;
		self.Verifications.License4Valid := resultRec.VerificationInfo[1].License4Valid;
		self.Verifications.License4ResultMatch := resultRec.VerificationInfo[1].License4ResultMatch;
		self.Verifications.License5Verified := resultRec.VerificationInfo[1].License5Verified;
		self.Verifications.License5Valid := resultRec.VerificationInfo[1].License5Valid;
		self.Verifications.License5ResultMatch := resultRec.VerificationInfo[1].License5ResultMatch;
		self.Verifications.License6Verified := resultRec.VerificationInfo[1].License6Verified;
		self.Verifications.License6Valid := resultRec.VerificationInfo[1].License6Valid;
		self.Verifications.License6ResultMatch := resultRec.VerificationInfo[1].License6ResultMatch;
		self.Verifications.License7Verified := resultRec.VerificationInfo[1].License7Verified;
		self.Verifications.License7Valid := resultRec.VerificationInfo[1].License7Valid;
		self.Verifications.License7ResultMatch := resultRec.VerificationInfo[1].License7ResultMatch;
		self.Verifications.License8Verified := resultRec.VerificationInfo[1].License8Verified;
		self.Verifications.License8Valid := resultRec.VerificationInfo[1].License8Valid;
		self.Verifications.License8ResultMatch := resultRec.VerificationInfo[1].License8ResultMatch;
		self.Verifications.License9Verified := resultRec.VerificationInfo[1].License9Verified;
		self.Verifications.License9Valid := resultRec.VerificationInfo[1].License9Valid;
		self.Verifications.License9ResultMatch := resultRec.VerificationInfo[1].License9ResultMatch;
		self.Verifications.License10Verified := resultRec.VerificationInfo[1].License10Verified;
		self.Verifications.License10Valid := resultRec.VerificationInfo[1].License10Valid;
		self.Verifications.License10ResultMatch := resultRec.VerificationInfo[1].License10ResultMatch;
		self.Verifications.BoardCertifiedSpecialtyVerified := resultRec.VerificationInfo[1].BoardCertifiedSpecialtyVerified;
		self.Verifications.BoardCertifiedSubSpecialtyVerified := resultRec.VerificationInfo[1].BoardCertifiedSubSpecialtyVerified;
		self.Verifications.BoardCertifiedSpecialty1Verified := resultRec.VerificationInfo[1].BoardCertifiedSpecialty1Verified;
		self.Verifications.BoardCertifiedSpecialty2Verified := resultRec.VerificationInfo[1].BoardCertifiedSpecialty2Verified;
		self.Verifications.BoardCertifiedSpecialty3Verified := resultRec.VerificationInfo[1].BoardCertifiedSpecialty3Verified;
		self.Verifications.BoardCertifiedSpecialty4Verified := resultRec.VerificationInfo[1].BoardCertifiedSpecialty4Verified;
		self.Verifications.BoardCertifiedSpecialty5Verified := resultRec.VerificationInfo[1].BoardCertifiedSpecialty5Verified;
		self.Verifications.BoardCertifiedSubSpecialty1Verified := resultRec.VerificationInfo[1].BoardCertifiedSubSpecialty1Verified;
		self.Verifications.BoardCertifiedSubSpecialty2Verified := resultRec.VerificationInfo[1].BoardCertifiedSubSpecialty2Verified;
		self.Verifications.BoardCertifiedSubSpecialty3Verified := resultRec.VerificationInfo[1].BoardCertifiedSubSpecialty3Verified;
		self.Verifications.BoardCertifiedSubSpecialty4Verified := resultRec.VerificationInfo[1].BoardCertifiedSubSpecialty4Verified;
		self.Verifications.BoardCertifiedSubSpecialty5Verified := resultRec.VerificationInfo[1].BoardCertifiedSubSpecialty5Verified;
		self.Verifications.BoardCertifiedSpecialtyValid := resultRec.VerificationInfo[1].BoardCertifiedSpecialtyValid;
		self.Verifications.BoardCertifiedSubSpecialtyValid := resultRec.VerificationInfo[1].BoardCertifiedSubSpecialtyValid;
		self.Verifications.BoardCertifiedSpecialty1Valid := resultRec.VerificationInfo[1].BoardCertifiedSpecialty1Valid;
		self.Verifications.BoardCertifiedSpecialty2Valid := resultRec.VerificationInfo[1].BoardCertifiedSpecialty2Valid;
		self.Verifications.BoardCertifiedSpecialty3Valid := resultRec.VerificationInfo[1].BoardCertifiedSpecialty3Valid;
		self.Verifications.BoardCertifiedSpecialty4Valid := resultRec.VerificationInfo[1].BoardCertifiedSpecialty4Valid;
		self.Verifications.BoardCertifiedSpecialty5Valid := resultRec.VerificationInfo[1].BoardCertifiedSpecialty5Valid;
		self.Verifications.BoardCertifiedSubSpecialty1Valid := resultRec.VerificationInfo[1].BoardCertifiedSubSpecialty1Valid;
		self.Verifications.BoardCertifiedSubSpecialty2Valid := resultRec.VerificationInfo[1].BoardCertifiedSubSpecialty2Valid;
		self.Verifications.BoardCertifiedSubSpecialty3Valid := resultRec.VerificationInfo[1].BoardCertifiedSubSpecialty3Valid;
		self.Verifications.BoardCertifiedSubSpecialty4Valid := resultRec.VerificationInfo[1].BoardCertifiedSubSpecialty4Valid;
		self.Verifications.BoardCertifiedSubSpecialty5Valid := resultRec.VerificationInfo[1].BoardCertifiedSubSpecialty5Valid;
		self := [];
	end;
end;