Import Healthcare_Shared,STD,HealthCareProvider,doxie,HealthCareFacility;
EXPORT Transforms_Header  := MODULE
	//Build Individual Header Requests
	Export Healthcare_Shared.Layouts_Header.HeaderRequestLayoutPlus createHeaderRequest(Healthcare_Shared.Layouts.userInputCleanMatch input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := transform
		hasLicense := input.license_number <>'' or input.DEA <>'' or input.NPI <>'' or input.upin <>'' or  input.vendorsrcID <> '' or input.lnpid > 0 or input.lnfid > 0 or input.DID > 0 or input.BDID > 0; 
		hasName := input.name_first <>'' or input.name_last <>'';
		hasAddress := (input.prim_range <>'' and input.prim_name <>'') or (input.prim_name <>'' and input.st <>'') or (input.prim_name <>'' and input.z5 <>'') or (input.p_city_name <>'' and input.st <>'');
		isLicenseOnly := hasLicense or cfg[1].isReport;//Used for very specific keys
		isNameAddrOnly := (hasName and hasAddress) and not hasLicense;
		hasSomething2Search := hasLicense or hasName or hasAddress;
		isFullSearch := hasSomething2Search and (not isLicenseOnly and not isNameAddrOnly);
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		self.lnpid := map((input.ProviderSrc = '' or input.ProviderSrc = Healthcare_Shared.Constants.SRC_HEADER) and input.lnpid>0 => input.lnpid,
											(input.ProviderSrc = '' or input.ProviderSrc = Healthcare_Shared.Constants.SRC_HEADER) and input.lnfid>0=> input.lnfid,
											0);
		SELF.FNAME := STD.Str.ToUpperCase(input.name_first);
		SELF.MNAME := '';//STD.Str.ToUpperCase(input.name_middle);
		SELF.LNAME := STD.Str.ToUpperCase(input.name_last);
		SELF.SNAME := STD.Str.ToUpperCase(input.name_suffix);
		// SELF.GENDER := '';//Not currently supported;
		SELF.PRIM_RANGE := STD.Str.ToUpperCase(input.prim_range);
		SELF.PRIM_NAME := STD.Str.ToUpperCase(input.prim_name);
		SELF.SEC_RANGE := STD.Str.ToUpperCase(input.sec_range);
		SELF.V_CITY_NAME := STD.Str.ToUpperCase(input.p_city_name);
		SELF.ST := STD.Str.ToUpperCase(input.st);
		SELF.ZIP := STD.Str.ToUpperCase(input.z5);
		SELF.SSN := input.ssn;
		SELF.DOB := (integer)input.dob;
		self.PHONE := input.workphone;
		SELF.LIC_STATE :=	STD.Str.ToUpperCase(input.license_state);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(STD.Str.ToUpperCase(input.license_number));
		SELF.TAX_ID	:= if(input.fein <> '',input.fein,input.TaxID);
		SELF.DEA_NUMBER	:= STD.Str.ToUpperCase(input.DEA);
		SELF.VENDOR_ID := STD.Str.ToUpperCase(map(input.lnpid > 0 and input.ProviderSrc <> '' and input.ProviderSrc <> Healthcare_Shared.Constants.SRC_HEADER => (string)input.lnpid,
																							input.lnfid > 0 and input.ProviderSrc <> '' and input.ProviderSrc <> Healthcare_Shared.Constants.SRC_HEADER => (string)input.lnfid,
																											input.VendorSrcID <> '' => input.VendorSrcID,''));
		SELF.SRC := if(input.lnpid > 0 or input.lnfid > 0 or input.VendorSrcID <> '',STD.Str.ToUpperCase(input.ProviderSrc),'');
		SELF.NPI_NUMBER	:= STD.Str.ToUpperCase(input.NPI);
		SELF.UPIN := Healthcare_Shared.functions.cleanAlphaNumeric(input.upin);
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
	Export Healthcare_Shared.Layouts_Header.HeaderRequestLayoutPlus createHeaderRequestWithoutState(Healthcare_Shared.Layouts.userInputCleanMatch input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := transform
		hasLicense := input.license_number <>'' or input.DEA <>'' or input.NPI <>'' or input.upin <>'' or input.lnpid > 0 or input.lnfid > 0 or input.DID > 0 or input.BDID > 0; 
		hasName := input.name_first <>'' or input.name_last <>'';
		hasLimitedAddress := input.prim_range ='' and input.prim_name ='' and (input.p_city_name <>'' and input.st <>'');
		isLicenseOnly := hasLicense or cfg[1].isReport;//Used for very specific keys
		isNameLimitedAddrOnly := (hasName and hasLimitedAddress) and not hasLicense;
		SELF.rid := if(isNameLimitedAddrOnly,(integer)input.acctno,skip);
		self.lnpid := map((input.ProviderSrc = '' or input.ProviderSrc = Healthcare_Shared.Constants.SRC_HEADER) and input.lnpid>0 => input.lnpid,
											(input.ProviderSrc = '' or input.ProviderSrc = Healthcare_Shared.Constants.SRC_HEADER) and input.lnfid>0=> input.lnpid,
											0);
		SELF.FNAME := STD.Str.ToUpperCase(input.name_first);
		SELF.MNAME := STD.Str.ToUpperCase(input.name_middle);
		SELF.LNAME := STD.Str.ToUpperCase(input.name_last);
		SELF.SNAME := STD.Str.ToUpperCase(input.name_suffix);
		// SELF.GENDER := '';//Not currently supported;
		SELF.PRIM_RANGE := STD.Str.ToUpperCase(input.prim_range);
		SELF.PRIM_NAME := STD.Str.ToUpperCase(input.prim_name);
		SELF.SEC_RANGE := STD.Str.ToUpperCase(input.sec_range);
		SELF.V_CITY_NAME := STD.Str.ToUpperCase(input.p_city_name);
		SELF.ST := STD.Str.ToUpperCase(input.st);
		SELF.ZIP := STD.Str.ToUpperCase(input.z5);
		SELF.SSN := input.ssn;
		SELF.DOB := (integer)input.dob;
		self.PHONE := input.workphone;
		SELF.LIC_STATE :=	STD.Str.ToUpperCase(input.license_state);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(STD.Str.ToUpperCase(input.license_number));
		SELF.TAX_ID	:= if(input.fein <> '',input.fein,input.TaxID);
		SELF.DEA_NUMBER	:= STD.Str.ToUpperCase(input.DEA);
		SELF.VENDOR_ID := STD.Str.ToUpperCase(map(input.lnpid > 0 and input.ProviderSrc <> '' and input.ProviderSrc <> Healthcare_Shared.Constants.SRC_HEADER => (string)input.lnpid,
																							input.lnfid > 0 and input.ProviderSrc <> '' and input.ProviderSrc <> Healthcare_Shared.Constants.SRC_HEADER => (string)input.lnfid,
																											input.VendorSrcID <> '' => input.VendorSrcID,''));
		SELF.SRC := if(input.lnpid > 0 or input.lnfid>0 or input.VendorSrcID <> '',STD.Str.ToUpperCase(input.ProviderSrc),'');
		SELF.NPI_NUMBER	:= STD.Str.ToUpperCase(input.NPI);
		SELF.UPIN := STD.Str.ToUpperCase(input.upin);
		SELF.DID := input.DID;
		SELF.BDID := input.BDID;
		SELF.SOURCE_RID := 0;//Not currently supported as the user do not know the rids they only know the lnpids;
		self.hasLicense := hasLicense; 
		self.hasName := hasName;
		self.isLicenseOnly := isLicenseOnly;
		self.isNameAddrOnly := false;
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderRequestLayoutPlus createHeaderRequestBilling(Healthcare_Shared.Layouts.userInputCleanMatch input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := transform
		hasLicense := input.license_number <>'' or input.DEA <>'' or input.NPI <>'' or input.upin <>'' or  input.lnpid > 0 or input.lnfid > 0 or input.DID > 0 or input.BDID > 0; 
		hasName := input.name_first <>'' or input.name_last <>'';
		hasAddress := (input.bill_prim_range <>'' and input.bill_prim_name <>'') or (input.bill_prim_name <>'' and input.bill_st <>'') or (input.bill_prim_name <>'' and input.bill_z5 <>'') or (input.bill_p_city_name <>'' and input.bill_st <>'');
		isLicenseOnly := hasLicense or cfg[1].isReport;//Used for very specific keys
		isNameAddrOnly := (hasName and hasAddress) and not hasLicense;
		hasSomething2Search := hasLicense or hasName or hasAddress;
		isFullSearch := hasSomething2Search and (not isLicenseOnly and not isNameAddrOnly);
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		self.lnpid := map((input.ProviderSrc = '' or input.ProviderSrc = Healthcare_Shared.Constants.SRC_HEADER) and input.lnpid>0 => input.lnpid,
											(input.ProviderSrc = '' or input.ProviderSrc = Healthcare_Shared.Constants.SRC_HEADER) and input.lnfid>0=> input.lnpid,
											0);
		SELF.FNAME := STD.Str.ToUpperCase(input.name_first);
		SELF.MNAME := STD.Str.ToUpperCase(input.name_middle);
		SELF.LNAME := STD.Str.ToUpperCase(input.name_last);
		SELF.SNAME := STD.Str.ToUpperCase(input.name_suffix);
		// SELF.GENDER := '';//Not currently supported;
		SELF.PRIM_RANGE := STD.Str.ToUpperCase(input.bill_prim_range);
		SELF.PRIM_NAME := STD.Str.ToUpperCase(input.bill_prim_name);
		SELF.SEC_RANGE := STD.Str.ToUpperCase(input.bill_sec_range);
		SELF.V_CITY_NAME := STD.Str.ToUpperCase(input.bill_p_city_name);
		SELF.ST := STD.Str.ToUpperCase(input.bill_st);
		SELF.ZIP := STD.Str.ToUpperCase(input.bill_z5);
		SELF.SSN := input.ssn;
		SELF.DOB := (integer)input.dob;
		self.PHONE := input.bill_phone;
		SELF.LIC_STATE :=	STD.Str.ToUpperCase(input.license_state);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(STD.Str.ToUpperCase(input.license_number));
		SELF.TAX_ID	:= if(input.fein <> '',input.fein,input.TaxID);
		SELF.DEA_NUMBER	:= STD.Str.ToUpperCase(input.DEA);
		SELF.VENDOR_ID := '';
		SELF.SRC := '';
		SELF.NPI_NUMBER	:= STD.Str.ToUpperCase(input.NPI);
		SELF.UPIN := STD.Str.ToUpperCase(input.upin);
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
	Export Healthcare_Shared.Layouts.userInputCleanMatch createInputByDid(doxie.layout_references inputbyDID) := transform
			self.acctno := '1';
			self := inputbyDID;
			self := [];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderRequestLayoutPlus createHeaderRequestByDid(doxie.layout_references inputbyDID) := transform
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
	Export Healthcare_Shared.Layouts_Header.HeaderRequestLayoutPlus createHeaderRequestDEA2(Healthcare_Shared.Layouts.userInputCleanMatch input) := transform
		SELF.rid := (integer)input.acctno;
		SELF.DEA_NUMBER	:= STD.Str.ToUpperCase(input.DEA2);
		self.hasLicense := true; 
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderRequestLayoutPlus createHeaderRequestLicense(Healthcare_Shared.Layouts.userInputCleanMatch input, unsigned cnt) := transform
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
		SELF.LIC_STATE :=	if(licSt<>'',STD.Str.ToUpperCase(licSt),STD.Str.ToUpperCase(input.st));
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(STD.Str.ToUpperCase(lic));
		self.hasLicense := true; 
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderRequestLayoutPlus createHeaderRequestNPI(Healthcare_Shared.Layouts.userInputCleanMatch input) := transform
		SELF.rid := (integer)input.acctno;
		SELF.NPI_NUMBER	:= STD.Str.ToUpperCase(input.NPI);
		self.hasLicense := true; 
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderRequestLayoutPlus createHeaderRequestDEA(Healthcare_Shared.Layouts.userInputCleanMatch input) := transform
		SELF.rid := (integer)input.acctno;
		SELF.DEA_NUMBER	:= STD.Str.ToUpperCase(input.DEA);
		self.hasLicense := true; 
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderRequestLayoutPlus createHeaderRequestUPIN(Healthcare_Shared.Layouts.userInputCleanMatch input) := transform
		cln_upin := Healthcare_Shared.Functions.cleanAlphaNumeric(input.upin);
		fmtOk := length(Healthcare_Shared.Functions.cleanOnlyCharacters(STD.Str.ToUpperCase(cln_upin[1])))>0;
		lengthOk := length(cln_upin)=6;
		SELF.rid := (integer)input.acctno;
		SELF.UPIN := if(fmtOK and lengthOK,STD.Str.ToUpperCase(input.upin),skip);
		self.hasLicense := true; 
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts.searchKeyResults xformHdrLNPids (Healthcare_Shared.Layouts_Header.HeaderResponseLayout L) := transform
			self.vendorid:=l.vendor_id;
			self.did:=l.did;
			self.bdid:=l.bdid;
			self.acctno:=(string)l.uniqueid;
			self.src:=l.src;
			self.LNPID:=l.LNPID;
			self.isHeaderResult := true;
			self.returnThresholdExceeded := l.returnThresholdExceeded;
			self.srcIndividualHeader := l.srcIndividualHeader;
			self.srcBusinessHeader := l.srcBusinessHeader;
			self := l;
			self := [];
	end;
	//Build Business Header Requests
	Export Healthcare_Shared.Layouts_Header.HeaderBusRequestLayoutPlus createBusHeaderRequest(Healthcare_Shared.Layouts.userInputCleanMatch input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := transform
		hasLicense := input.license_number <>'' or input.DEA <>'' or input.NPI <>'' or input.CLIANumber <>'' or input.NCPDPNumber <>'' or input.lnpid > 0 or input.lnfid > 0 or input.BDID > 0; 
		hasCName := input.comp_name <>'';
		hasAddress := (input.prim_range <>'' and input.prim_name <>'') or (input.prim_name <>'' and input.st <>'') or (input.prim_name <>'' and input.z5 <>'') or (input.p_city_name <>'' and input.st <>'');
		isLicenseOnly := hasLicense;
		isCNameAddrOnly := (hasCName and hasAddress) and not hasLicense;
		hasSomething2Search := hasLicense or hasCName or hasAddress;
		isFullSearch := hasSomething2Search and (not isLicenseOnly and not isCNameAddrOnly);
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		self.lnpid := map((input.ProviderSrc = '' or input.ProviderSrc = Healthcare_Shared.Constants.SRC_HEADER) and input.lnpid>0 => input.lnpid,
											(input.ProviderSrc = '' or input.ProviderSrc = Healthcare_Shared.Constants.SRC_HEADER) and input.lnfid>0=> input.lnfid,
											0);
		SELF.comp_name := HealthCareFacility.clean_facility_name(STD.Str.ToUpperCase(input.comp_name));
		SELF.PRIM_RANGE := STD.Str.ToUpperCase(input.prim_range);
		SELF.PRIM_NAME := STD.Str.ToUpperCase(input.prim_name);
		SELF.SEC_RANGE := STD.Str.ToUpperCase(input.sec_range);
		SELF.V_CITY_NAME := STD.Str.ToUpperCase(input.p_city_name);
		SELF.ST := STD.Str.ToUpperCase(input.st);
		SELF.ZIP := STD.Str.ToUpperCase(input.z5);
		SELF.PHONE := input.workphone;
		SELF.LIC_STATE :=	STD.Str.ToUpperCase(input.license_state);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(STD.Str.ToUpperCase(input.license_number));
		self.Tax_ID := if(input.TaxID <> '',input.TaxID,input.fein);
		SELF.DEA_NUMBER := STD.Str.ToUpperCase(input.DEA);
		SELF.VENDOR_ID := STD.Str.ToUpperCase(map(input.ProviderSrc <> '' and input.ProviderSrc <> Healthcare_Shared.Constants.SRC_HEADER and input.lnpid > 0 => (string)input.lnpid,
																							input.ProviderSrc <> '' and input.ProviderSrc <> Healthcare_Shared.Constants.SRC_HEADER and input.lnfid > 0 => (string)input.lnfid,
																							''));
		SELF.NPI_NUMBER	:= STD.Str.ToUpperCase(input.NPI);
		SELF.NCPDPNumber	:= STD.Str.ToUpperCase(input.NCPDPNumber);
		SELF.CLIANumber := STD.Str.ToUpperCase(input.CLIANumber);
		SELF.MedicareNumber := STD.Str.ToUpperCase(Healthcare_Shared.Functions.cleanAlphaNumeric(input.MedicareNumber));
		SELF.MedicaidNumber := STD.Str.ToUpperCase(Healthcare_Shared.Functions.cleanAlphaNumeric(input.MedicaidNumber));
		SELF.BDID := input.BDID;
		self.Taxonomy := STD.Str.ToUpperCase(input.Taxonomy1Verification);
		SELF.SRC := '';//STD.Str.ToUpperCase(input.ProviderSrc);
		SELF.SOURCE_RID := 0;//Not currently supported as the user do not know the rids they only know the lnpids;
		self.hasLicense := hasLicense; 
		self.hasCName := hasCName;
		self.hasAddress := hasAddress;
		self.isLicenseOnly := isLicenseOnly;
		self.isCNameAddrOnly := isCNameAddrOnly;
		self.isFullSearch := isFullSearch;
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderBusRequestLayoutPlus createBusHeaderRequestBilling(Healthcare_Shared.Layouts.userInputCleanMatch input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := transform
		hasLicense := input.license_number <>'' or input.DEA <>'' or input.NPI <>'' or input.CLIANumber <>'' or input.NCPDPNumber <>'' or input.lnpid > 0 or input.lnfid > 0 or input.BDID > 0; 
		hasCName := input.comp_name <>'';
		hasAddress := (input.bill_prim_range <>'' and input.bill_prim_name <>'') or (input.bill_prim_name <>'' and input.bill_st <>'') or (input.bill_prim_name <>'' and input.bill_z5 <>'') or (input.bill_p_city_name <>'' and input.bill_st <>'');
		isLicenseOnly := hasLicense;
		isCNameAddrOnly := (hasCName and hasAddress) and not hasLicense;
		hasSomething2Search := hasLicense or hasCName or hasAddress;
		isFullSearch := hasSomething2Search and (not isLicenseOnly and not isCNameAddrOnly);
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		self.lnpid := map((input.ProviderSrc = '' or input.ProviderSrc = Healthcare_Shared.Constants.SRC_HEADER) and input.lnpid>0 => input.lnpid,
											(input.ProviderSrc = '' or input.ProviderSrc = Healthcare_Shared.Constants.SRC_HEADER) and input.lnfid>0=> input.lnpid,
											0);
		SELF.comp_name := HealthCareFacility.clean_facility_name(STD.Str.ToUpperCase(input.bill_company_name));
		SELF.PRIM_RANGE := STD.Str.ToUpperCase(input.bill_prim_range);
		SELF.PRIM_NAME := STD.Str.ToUpperCase(input.bill_prim_name);
		SELF.SEC_RANGE := STD.Str.ToUpperCase(input.bill_sec_range);
		SELF.V_CITY_NAME := STD.Str.ToUpperCase(input.bill_p_city_name);
		SELF.ST := STD.Str.ToUpperCase(input.bill_st);
		SELF.ZIP := STD.Str.ToUpperCase(input.bill_z5);
		SELF.PHONE := input.bill_phone;
		SELF.LIC_STATE :=	STD.Str.ToUpperCase(input.license_state);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(STD.Str.ToUpperCase(input.license_number));
		self.Tax_ID := if(input.TaxID <> '',input.TaxID,input.fein);
		SELF.DEA_NUMBER := STD.Str.ToUpperCase(input.DEA);
		SELF.VENDOR_ID := STD.Str.ToUpperCase(map(input.ProviderSrc <> '' and input.ProviderSrc <> Healthcare_Shared.Constants.SRC_HEADER and input.lnpid > 0 => (string)input.lnpid,
																							input.ProviderSrc <> '' and input.ProviderSrc <> Healthcare_Shared.Constants.SRC_HEADER and input.lnfid > 0 => (string)input.lnfid,
																							''));
		SELF.NPI_NUMBER	:= STD.Str.ToUpperCase(input.NPI);
		SELF.NCPDPNumber	:= STD.Str.ToUpperCase(input.NCPDPNumber);
		SELF.CLIANumber := STD.Str.ToUpperCase(input.CLIANumber);
		SELF.MedicareNumber := STD.Str.ToUpperCase(Healthcare_Shared.Functions.cleanAlphaNumeric(input.MedicareNumber));
		SELF.MedicaidNumber := STD.Str.ToUpperCase(Healthcare_Shared.Functions.cleanAlphaNumeric(input.MedicaidNumber));
		SELF.BDID := input.BDID;
		self.Taxonomy := STD.Str.ToUpperCase(input.Taxonomy1Verification);
		SELF.SRC := '';//STD.Str.ToUpperCase(input.ProviderSrc);
		SELF.SOURCE_RID := 0;//Not currently supported as the user do not know the rids they only know the lnpids;
		self.hasLicense := hasLicense; 
		self.hasCName := hasCName;
		self.hasAddress := hasAddress;
		self.isLicenseOnly := isLicenseOnly;
		self.isCNameAddrOnly := isCNameAddrOnly;
		self.isFullSearch := isFullSearch;
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts.userInputCleanMatch createBusInputByBDid(doxie.Layout_ref_bdid inputbyBDID) := transform
			self.acctno := '1';
			self := inputbyBDID;
			self := [];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderBusRequestLayoutPlus createBusHeaderRequestByBDid(doxie.Layout_ref_bdid inputbyBDID) := transform
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
	Export Healthcare_Shared.Layouts_Header.HeaderBusRequestLayoutPlus createBusHeaderRequestNCPDP(Healthcare_Shared.Layouts.userInputCleanMatch input) := transform
		hasLicense := input.NCPDPNumber <>''; 
		isLicenseOnly := hasLicense;
		hasSomething2Search := hasLicense;
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		SELF.NCPDPNumber	:= STD.Str.ToUpperCase(input.NCPDPNumber);
		self.hasLicense := hasLicense; 
		self.isLicenseOnly := isLicenseOnly;
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderBusRequestLayoutPlus createBusHeaderRequestCLIA(Healthcare_Shared.Layouts.userInputCleanMatch input) := transform
		hasLicense := input.CLIANumber <>''; 
		isLicenseOnly := hasLicense;
		hasSomething2Search := hasLicense;
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		SELF.CLIANumber := STD.Str.ToUpperCase(input.CLIANumber);
		self.hasLicense := hasLicense; 
		self.isLicenseOnly := isLicenseOnly;
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderBusRequestLayoutPlus createBusHeaderRequestNPI(Healthcare_Shared.Layouts.userInputCleanMatch input) := transform
		hasLicense := input.NPI <>''; 
		isLicenseOnly := hasLicense;
		hasSomething2Search := hasLicense;
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		SELF.NPI_NUMBER	:= STD.Str.ToUpperCase(input.NPI);
		self.hasLicense := hasLicense; 
		self.isLicenseOnly := isLicenseOnly;
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderBusRequestLayoutPlus createBusHeaderRequestDEA(Healthcare_Shared.Layouts.userInputCleanMatch input) := transform
		hasLicense := input.DEA <>''; 
		isLicenseOnly := hasLicense;
		hasSomething2Search := hasLicense;
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		SELF.DEA_NUMBER := STD.Str.ToUpperCase(input.DEA);
		self.hasLicense := hasLicense; 
		self.isLicenseOnly := isLicenseOnly;
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderBusRequestLayoutPlus createBusHeaderRequestLic(Healthcare_Shared.Layouts.userInputCleanMatch input) := transform
		hasLicense := input.license_number <>''; 
		isLicenseOnly := hasLicense;
		hasSomething2Search := hasLicense;
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		SELF.LIC_STATE :=	STD.Str.ToUpperCase(input.license_state);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(STD.Str.ToUpperCase(input.license_number));
		self.hasLicense := hasLicense; 
		self.isLicenseOnly := isLicenseOnly;
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderBusRequestLayoutPlus createBusHeaderRequestMedicareMedicaid(Healthcare_Shared.Layouts.userInputCleanMatch input) := transform
		hasLicense := input.MedicareNumber <>'' or input.MedicaidNumber <>''; 
		isLicenseOnly := hasLicense;
		hasSomething2Search := hasLicense;
		SELF.rid := if(hasSomething2Search,(integer)input.acctno,skip);
		SELF.MedicareNumber := STD.Str.ToUpperCase(Healthcare_Shared.Functions.cleanAlphaNumeric(input.MedicareNumber));
		SELF.MedicaidNumber := STD.Str.ToUpperCase(Healthcare_Shared.Functions.cleanAlphaNumeric(input.MedicaidNumber));
		self.hasLicense := hasLicense; 
		self.isLicenseOnly := isLicenseOnly;
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderBusRequestLayoutPlus createBusHeaderRequestDEA2(Healthcare_Shared.Layouts.userInputCleanMatch input) := transform
		SELF.rid := (integer)input.acctno;
		SELF.DEA_NUMBER	:= STD.Str.ToUpperCase(input.DEA2);
		self.hasLicense := true; 
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts_Header.HeaderBusRequestLayoutPlus createBusHeaderRequestLicense(Healthcare_Shared.Layouts.userInputCleanMatch input, unsigned cnt) := transform
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
		SELF.LIC_STATE :=	STD.Str.ToUpperCase(licSt);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(STD.Str.ToUpperCase(lic));
		self.hasLicense := true; 
		SELF :=	[];
	End;
	Export Healthcare_Shared.Layouts.searchKeyResults xformBusHdrLNPids (Healthcare_Shared.Layouts_Header.HeaderBusResponseLayout L) := transform
			self.lnfid:=l.LNPID;
			self.vendorid:=l.vendor_id;
			self.did:=l.did;
			self.bdid:=l.bdid;
			self.acctno:=(string)l.uniqueid;
			self.src:=l.src;
			self.isHeaderResult := true;
			self.srcIndividualHeader := l.srcIndividualHeader;
			self.srcBusinessHeader := l.srcBusinessHeader;
			self := l;
			self := [];
	end;
End;