/*--SOAP--
<message name="IngenixProviderReportRequest">
	<part name="DID" type="xsd:string"/>
  <part name="ProviderID" type="xsd:unsignedInt" required="1"/>
  <part name="ProviderSrc" type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte" />
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask"    type="xsd:string"/>
  <part name="IncludeSanctions" type="xsd:boolean"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
	<part name="HealthCareConsolidatedReportRequest" type="tns:XmlDataSet" cols="80" rows="40" />
 </message>
*/
/*--INFO-- This service pulls from the Ingenix provider files.*/
/*--HELP-- 

<pre>
   &lt;HealthCareConsolidatedReportRequest&gt;
    &lt;Row&gt;
     &lt;User&gt;
      &lt;ReferenceCode/&gt;
      &lt;BillingCode/&gt;
      &lt;QueryId/&gt;
      &lt;CompanyId/&gt;
      &lt;GLBPurpose/&gt;
      &lt;DLPurpose/&gt;
      &lt;LoginHistoryId/&gt;
      &lt;DebitUnits/&gt;
      &lt;IP/&gt;
      &lt;IndustryClass/&gt;
      &lt;ResultFormat/&gt;
      &lt;LogAsFunction/&gt;
      &lt;SSNMask/&gt;
      &lt;DOBMask/&gt;
      &lt;DLMask&gt;0&lt;/DLMask&gt;
      &lt;DataRestrictionMask/&gt;
      &lt;DataPermissionMask/&gt;
      &lt;ApplicationType/&gt;
      &lt;SSNMaskingOn&gt;0&lt;/SSNMaskingOn&gt;
      &lt;DLMaskingOn&gt;0&lt;/DLMaskingOn&gt;
      &lt;EndUser&gt;
       &lt;CompanyName/&gt;
       &lt;StreetAddress1/&gt;
       &lt;City/&gt;
       &lt;State/&gt;
       &lt;Zip5/&gt;
      &lt;/EndUser&gt;
      &lt;MaxWaitSeconds/&gt;
      &lt;RelatedTransactionId/&gt;
      &lt;AccountNumber/&gt;
      &lt;TestDataEnabled&gt;0&lt;/TestDataEnabled&gt;
      &lt;TestDataTableName/&gt;
     &lt;/User&gt;
     &lt;RemoteLocations/&gt;
     &lt;ServiceLocations/&gt;
     &lt;Options&gt;
      &lt;Blind&gt;0&lt;/Blind&gt;
      &lt;Encrypt&gt;0&lt;/Encrypt&gt;
      &lt;ReturnTokens&gt;0&lt;/ReturnTokens&gt;
      &lt;IncludeSanctions&gt;0&lt;/IncludeSanctions&gt;
      &lt;IncludeDegrees&gt;0&lt;/IncludeDegrees&gt;
      &lt;IncludeGroupAffiliations&gt;0&lt;/IncludeGroupAffiliations&gt;
      &lt;IncludeHospitalAffiliations&gt;0&lt;/IncludeHospitalAffiliations&gt;
      &lt;IncludeResidencies&gt;0&lt;/IncludeResidencies&gt;
      &lt;IncludeMedicalSchools&gt;0&lt;/IncludeMedicalSchools&gt;
      &lt;IncludeSpecialties&gt;0&lt;/IncludeSpecialties&gt;
      &lt;IncludeLicenses&gt;0&lt;/IncludeLicenses&gt;
      &lt;IncludeDEAInformation&gt;0&lt;/IncludeDEAInformation&gt;
      &lt;IncludeBusinessAddresses&gt;0&lt;/IncludeBusinessAddresses&gt;
      &lt;IncludeProfessionalLicenses&gt;0&lt;/IncludeProfessionalLicenses&gt;
      &lt;IncludeCurrentProfessionalLicensesOnly&gt;0&lt;/IncludeCurrentProfessionalLicensesOnly&gt;
      &lt;IncludeAssociates&gt;0&lt;/IncludeAssociates&gt;
      &lt;IncludeGSASanctions&gt;0&lt;/IncludeGSASanctions&gt;
      &lt;StrictMatchGSASanctions&gt;0&lt;/StrictMatchGSASanctions&gt;
      &lt;IncludeCorporateAffiliations&gt;0&lt;/IncludeCorporateAffiliations&gt;
      &lt;IncludeCriminalRecords&gt;0&lt;/IncludeCriminalRecords&gt;
      &lt;IncludeLiensJudgments&gt;0&lt;/IncludeLiensJudgments&gt;
      &lt;IncludeBankruptcies&gt;0&lt;/IncludeBankruptcies&gt;
      &lt;IncludeBlankDOD&gt;0&lt;/IncludeBlankDOD&gt;
      &lt;IncludeIndividualInstantID&gt;0&lt;/IncludeIndividualInstantID&gt;
      &lt;IncludeBusinessInstantID&gt;0&lt;/IncludeBusinessInstantID&gt;
      &lt;IncludeCLIA&gt;0&lt;/IncludeCLIA&gt;
      &lt;IncludeVerifications&gt;0&lt;/IncludeVerifications&gt;
      &lt;IncludeAlsoFound&gt;0&lt;/IncludeAlsoFound&gt;
      &lt;Relatives&gt;
       &lt;IncludeRelatives&gt;0&lt;/IncludeRelatives&gt;
       &lt;MaxRelatives/&gt;
       &lt;RelativeDepth/&gt;
       &lt;IncludeRelativeAddresses&gt;0&lt;/IncludeRelativeAddresses&gt;
       &lt;MaxRelativeAddresses/&gt;
      &lt;/Relatives&gt;
      &lt;Neighbors&gt;
       &lt;IncludeNeighbors&gt;0&lt;/IncludeNeighbors&gt;
       &lt;IncludeHistoricalNeighbors&gt;0&lt;/IncludeHistoricalNeighbors&gt;
       &lt;NeighborhoodCount/&gt;
       &lt;NeighborCount/&gt;
       &lt;HistoricalNeighborhoodCount/&gt;
       &lt;HistoricalNeighborCount/&gt;
      &lt;/Neighbors&gt;
      &lt;IncludeModels&gt;
       &lt;ProviderIntegrityScore&gt;&lt;/ProviderIntegrityScore&gt;
       &lt;IncludeAllRiskIndicators&gt;0&lt;/IncludeAllRiskIndicators&gt;
      &lt;/IncludeModels&gt;
     &lt;/Options&gt;
     &lt;ReportBy&gt;
      &lt;ProviderId/&gt;
      &lt;UniqueId/&gt;
     &lt;/ReportBy&gt;
     &lt;ReportBy2&gt;
      &lt;Name&gt;
       &lt;Full/&gt;
       &lt;First/&gt;
       &lt;Middle/&gt;
       &lt;Last/&gt;
       &lt;Suffix/&gt;
       &lt;Prefix/&gt;
      &lt;/Name&gt;
      &lt;CompanyName/&gt;
      &lt;Address&gt;
       &lt;StreetNumber/&gt;
       &lt;StreetPreDirection/&gt;
       &lt;StreetName/&gt;
       &lt;StreetSuffix/&gt;
       &lt;StreetPostDirection/&gt;
       &lt;UnitDesignation/&gt;
       &lt;UnitNumber/&gt;
       &lt;StreetAddress1/&gt;
       &lt;StreetAddress2/&gt;
       &lt;City/&gt;
       &lt;State/&gt;
       &lt;Zip5/&gt;
       &lt;Zip4/&gt;
       &lt;County/&gt;
       &lt;PostalCode/&gt;
       &lt;StateCityZip/&gt;
      &lt;/Address&gt;
      &lt;Phone10/&gt;
      &lt;DOB&gt;
       &lt;Year/&gt;
       &lt;Month/&gt;
       &lt;Day/&gt;
      &lt;/DOB&gt;
      &lt;ProviderId/&gt;
      &lt;UniqueId/&gt;
      &lt;BusinessId/&gt;
      &lt;UPINNumber/&gt;
      &lt;NPINumber/&gt;
      &lt;TaxId/&gt;
      &lt;FEIN/&gt;
      &lt;SSN/&gt;
      &lt;LicenseNumber/&gt;
      &lt;LicenseState/&gt;
     &lt;/ReportBy2&gt;
    &lt;/Row&gt;
   &lt;/HealthCareConsolidatedReportRequest&gt;
</pre>
*/

import AutoStandardI,ingenix_natlprof,Prof_licensev2_services,doxie_files,doxie,iesp,PersonReports, address,Healthcare_Header_Services,ut;

export Report_Service := macro
 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 #onwarning(4207, ignore);
	myConst := Healthcare_Header_Services.Constants;
	// get XML input 
	rec_in := iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportRequest;
	ds_in := DATASET([],rec_in) : STORED('HealthCareConsolidatedReportRequest',FEW);
	request := ds_in[1] : INDEPENDENT;

	// set compliance from iesp XML input
	User := GLOBAL(request.User);
	iesp.ECL2ESP.SetInputUser(User);

	ReportBy := GLOBAL(request.ReportBy);
	ReportBy2 := GLOBAL(request.ReportBy2);
	Options  := GLOBAL(request.Options);

  Healthcare_Header_Services.IParams.SetInputSearch(request);
	hasFullNCPDP := Options.IncludeFullNCPDPInfo;
	
	STRING25 Model_Request_Raw		  := TRIM(Options.IncludeModels.ProviderIntegrityScore);
	UNSIGNED1 NumWarningCodes			  := IF(Options.IncludeModels.IncludeAllRiskIndicators = TRUE, 8, 4);
	Model_Request_Upper := StringLib.StringToUpperCase(Model_Request_Raw);
	#STORED('NumberOfWarningCodes', NumWarningCodes);
	#STORED('Model_Request', Model_Request_Upper);

	#STORED('StrictMatch',true);
	//Defaults requested by Kathy B. for use in the Individual and Business Identifier searches
	#STORED('OFACOnly',True);
	#STORED('OFACVersion',1);
	#STORED('GlobalWatchListThreshold',.84);
	#STORED('RedFlag_Version',1);
	#STORED('DOBRadius',2);
	testCompany := request.ReportBy2.CompanyName <> '';
	testSSN := if(testCompany,'123456789',request.ReportBy2.SSN);
	#STORED('SSN',testSSN);
	//Figure out where the Did value might be coming from due to crazy backward compatibility and then store the value
	did_val := trim(request.ReportBy.UniqueId,all);
	did_val2 := trim(request.ReportBy2.UniqueId,all);
	did_final := map(length(did_val)>0 => did_val,
									 length(did_val2)>0 => did_val2,
									 '');
	bdid_val := trim(global(ReportBy2).BusinessId) : stored('BusinessId');
	//Figure out where the providerid value might be coming from due to crazy backward compatibility and then store the value
	string20 CustID := User.CompanyId;	
	boolean IncAlsoFound := Options.IncludeAlsoFound : stored('IncludeAlsoFound');
	providsrc_val :=	trim(global(ReportBy).ProviderSrc,all)	 : stored('ProviderSrc');
	providsrc_val2 :=	trim(global(ReportBy2).ProviderSrc,all);
	providsrc_raw := if(trim(providsrc_val,all)<>'',providsrc_val,providsrc_val2);
	provid_val :=	trim(global(ReportBy).ProviderID,all)	 : stored('ProviderID');
	provid_val2 :=	trim(global(ReportBy2).ProviderID,all);
	provid_raw := if(length(provid_val)>0,provid_val,provid_val2);
	provid_final := if(providsrc_raw='S' and (integer)provid_raw>1000000,provid_raw[1..(length(trim((string)provid_raw,all))-3)],provid_raw);
	providsrc_final := if(providsrc_raw='S' and (integer)provid_raw>1000000,'H',providsrc_raw);
	in_maxRel := Options.Relatives.MaxRelatives;
	maxRel := if(in_maxRel=0,iesp.Constants.HPR.MAX_Relatives,min(in_maxRel,iesp.Constants.BR.MaxRelatives));
	in_RelDepth := Options.Relatives.RelativeDepth;
	maxRelDepth := if(in_RelDepth>0,in_RelDepth,iesp.Constants.HPR.MAX_RelativeDepth);
	in_MaxRelAddr := Options.Relatives.MaxRelativeAddresses;
	maxRelAddr := if(in_MaxRelAddr>0,in_MaxRelAddr,iesp.Constants.HPR.MAX_RelativeAddresses);
	in_NbrhoodCnt := Options.Neighbors.NeighborhoodCount;
	maxNbrhoodCnt := if(in_NbrhoodCnt>0,in_NbrhoodCnt,iesp.Constants.HPR.MAX_NeighborhoodCount);
	in_NbrCnt := Options.Neighbors.NeighborCount;
	maxNbrCnt := if(in_NbrCnt>0,in_NbrCnt,iesp.Constants.HPR.MAX_NeighborCount);
	in_HNbrhoodCnt := Options.Neighbors.HistoricalNeighborhoodCount;
	maxHNbrhoodCnt := if(in_HNbrhoodCnt>0,in_HNbrhoodCnt,iesp.Constants.HPR.MAX_HistoricalNeighborhoodCount);
	in_HNbrCnt := Options.Neighbors.HistoricalNeighborCount;
	maxHNbrCnt := if(in_HNbrCnt>0,in_HNbrCnt,iesp.Constants.HPR.MAX_HistoricalNeighborCount);
	unsigned2 	user_penalty_threshold := 10 :stored('PenaltyThreshold');

	//Need to handle request.ReportBy2.name.full do name clean
	cleanName := request.ReportBy2.name.full <> '';
	clnName := Address.CleanPerson73(request.ReportBy2.name.full);
	string clnFirst := TRIM(clnName[6..25]);
	string clnMiddle := TRIM(clnName[26..45]);
	string clnLast := TRIM(clnName[46..70]);
	
	//Need to handle request.ReportBy2.address.StreetAddress1
	cleanAddr := request.ReportBy2.address.StreetAddress1 <> '';
	clnAddr := Address.CleanFields(Address.GetCleanAddress(request.ReportBy2.address.StreetAddress1,request.ReportBy2.Address.City+' '+request.ReportBy2.Address.State+' '+request.ReportBy2.Address.Zip5,address.Components.Country.US).str_addr);

	//Get the raw records and set DID
	layout  := Healthcare_Header_Services.Layouts.autokeyInput;
	layout setinput():=transform
	self.acctno := '1';
	self.name_first := if(cleanName,clnFirst,request.ReportBy2.Name.First);
	self.name_middle := if(cleanName,clnMiddle,request.ReportBy2.Name.Middle);
	self.name_last := if(cleanName,clnLast,request.ReportBy2.Name.Last);
	self.name_suffix := request.ReportBy2.Name.Suffix;
	self.comp_name := request.ReportBy2.CompanyName;
	self.predir := if(cleanAddr,clnAddr.predir,request.ReportBy2.Address.StreetPreDirection);
	self.prim_range := if(cleanAddr,clnAddr.prim_range,request.ReportBy2.Address.StreetNumber);
	self.prim_name := if(cleanAddr,clnAddr.prim_name,request.ReportBy2.Address.StreetName);
	self.addr_suffix := if(cleanAddr,clnAddr.addr_suffix,request.ReportBy2.Address.StreetSuffix);
	self.postdir := if(cleanAddr,clnAddr.postdir,request.ReportBy2.Address.StreetPostDirection);
	self.sec_range := if(cleanAddr,clnAddr.sec_range,request.ReportBy2.Address.UnitNumber);
	self.p_city_name := request.ReportBy2.Address.City;
	self.st := request.ReportBy2.Address.State;
	self.z5 := request.ReportBy2.Address.Zip5;
	self.zip4 := request.ReportBy2.Address.Zip4;
	self.ssn := request.ReportBy2.SSN;
	self.dob := iesp.ECL2ESP.t_DateToString8(request.ReportBy2.DOB);
	self.homephone:=request.ReportBy2.Phone10;
	self.taxid := request.ReportBy2.taxid;
	self.FEIN := request.ReportBy2.fein;
	self.license_number := request.ReportBy2.licensenumber;
	self.license_state := request.ReportBy2.licensestate;
	Self.StateLicense1Verification := request.ReportBy2.licensenumber;
	Self.StateLicense1StateVerification := request.ReportBy2.licensestate;
	self.UPIN := request.ReportBy2.upinnumber;
	self.NPI := request.ReportBy2.npinumber;
	self.cliaNumber := request.ReportBy2.CLIANumber;
	self.did:=map(request.ReportBy.UniqueId <> '' => (integer)request.ReportBy.UniqueId,
								(integer)request.ReportBy2.UniqueId);
	self.bdid:=(integer)request.ReportBy2.businessid;
	self.providerid:=(integer)provid_final;
	self.providerSRC:=stringlib.StringToUpperCase(providsrc_final);
	self:=[]
	end;
	searchByCriteria := dataset([setinput()]);
	string _DRM := '':Stored('DataRestrictionMask'); 
	Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
		self.CustomerID := CustID;	
		self.penalty_threshold := user_penalty_threshold;
		self.MaxResults := 1;
		self.DRM := _DRM; // '':Stored('DataRestrictionMask'); 
		self.hasFullNCPDP := hasFullNCPDP;
		self.glb_ok := ut.glb_ok ((integer)user.GLBPurpose);
		self.dppa_ok := ut.dppa_ok((integer)user.DLPurpose);
		self.isReport := True;
		self.doDeepDive := IncAlsoFound;
		self.IncludeSanctions := request.Options.IncludeSanctions;
		self.IncludeGroupAffiliations := request.options.IncludeGroupAffiliations;
		self.IncludeHospitalAffiliations := request.options.IncludeHospitalAffiliations;
		self.IncludeSpecialties  := request.options.IncludeSpecialties;
		self.IncludeLicenses  := request.options.IncludeLicenses;
		self.IncludeResidencies  := request.options.IncludeResidencies;
		self.IncludeABMSBoardCertifiedSpecialty := request.options.IncludeBoardCertifiedSpecialty;
		self.IncludeABMSCareer := request.options.IncludeCareer;
		self.IncludeABMSEducation := request.options.IncludeEducation;
		self.IncludeABMSProfessionalAssociations := request.options.IncludeProfessionalAssociations;
		// self:=[];Do not uncomment otherwise the default values will not get set.
	end;
	cfg:=dataset([buildConfig()]);
	prov := sort(Healthcare_Header_Services.Records.getReportServiceDidValues(searchByCriteria,cfg)(record_penalty<=user_penalty_threshold),-record_penalty,map(Src=myConst.SRC_ING=>1,Src=myConst.SRC_AMS=>2,Src=myConst.SRC_HEADER=>1,3));

	dsDids := project(prov.dids,doxie.layout_references);
	dsBDids := project(prov.bdids,doxie.layout_ref_bdid);

	#STORED('DID',dsDids[1].did);
	#STORED('BDID',dsBDids[1].bdid);

	doxie.MAC_Header_Field_Declare();

	input_params := AutoStandardI.GlobalModule();
	params := module(project(input_params,Healthcare_Header_Services.IParams.reportParams,opt))
		export set of unsigned6  sanc_id_set := [] : stored('SanctionID');
		export unsigned6  ProviderId := (integer)provid_final;
		export string5  	ProviderSrc := stringlib.StringToUpperCase(providsrc_final);
		export string14	  DID := if(exists(dsDids),(string)dsDids[1].did,did_final);
		export string		  BDID := if(exists(dsBDids),(String)dsBDids[1].bdid,bdid_val);
		export unsigned6  prolic_seq_num := 0  		 : stored('SequenceID');
		shared string20	  L_Number := stringlib.StringToUpperCase(request.ReportBy2.LicenseNumber) :stored('LicenseNumber');
		EXPORT STRING 		NPI := stringlib.StringToUpperCase(request.ReportBy2.NPINumber)  : stored('NPINumber');
		EXPORT STRING 		UPIN := stringlib.StringToUpperCase(request.ReportBy2.UPINNumber)  : stored('UPINNumber');
		Export String2 		LicenseState := stringlib.StringToUpperCase(request.ReportBy2.LicenseState)  :stored('LicenseState');
		Export String			LicenseNumber := stringlib.StringToUpperCase(L_Number);
		export string20   License_Number 	:= stringlib.stringtouppercase(l_number);
		export string15   CLIANumber 	:= stringlib.stringtouppercase(request.ReportBy2.CLIANumber)  :stored('CLIANumber');
		EXPORT string11 	TaxID := stringlib.StringToUpperCase(request.ReportBy2.TaxID):stored('TaxId');  
		EXPORT STRING120 	CompanyName := stringlib.StringToUpperCase(request.ReportBy2.CompanyName):stored('CompanyName');      			
		EXPORT STRING30 	LastName := stringlib.StringToUpperCase(if(cleanName,clnLast,request.ReportBy2.Name.Last)):stored('Last');      			
		EXPORT STRING30 	FirstName := stringlib.StringToUpperCase(if(cleanName,clnFirst,request.ReportBy2.Name.First)):stored('First');      			
		EXPORT STRING30 	MiddleName := stringlib.StringToUpperCase(if(cleanName,clnMiddle,request.ReportBy2.Name.Middle)):stored('Middle');      			
		Export string10 	StreetNumber :=	stringlib.StringToUpperCase(trim(request.ReportBy2.Address.StreetNumber,all)):stored('StreetNumber');
		Export string2 		StreetPreDirection :=	stringlib.StringToUpperCase(trim(request.ReportBy2.Address.StreetPreDirection,all)):stored('StreetPreDirection');
		Export string50 	StreetName :=	stringlib.StringToUpperCase(trim(request.ReportBy2.Address.StreetName,all)):stored('StreetName');
		Export string4 		StreetSuffix :=	stringlib.StringToUpperCase(trim(request.ReportBy2.Address.StreetSuffix,all)):stored('StreetSuffix');
		Export string2 		StreetPostDirection :=	stringlib.StringToUpperCase(trim(request.ReportBy2.Address.StreetPostDirection,all)):stored('StreetPostDirection');
		Export string8 		UnitNumber :=	stringlib.StringToUpperCase(trim(request.ReportBy2.Address.UnitNumber,all)):stored('UnitNumber');
		Export string200 	StreetAddress1 :=	stringlib.StringToUpperCase(trim(request.ReportBy2.Address.StreetAddress1,all)):stored('StreetAddress1');
		Export string25		City :=	stringlib.StringToUpperCase(trim(request.ReportBy2.Address.City,all)):stored('City');
		Export string2 		State :=	stringlib.StringToUpperCase(trim(request.ReportBy2.Address.State,all)):stored('State');
		Export string6		Zip :=	trim(request.ReportBy2.Address.Zip5,all);
		EXPORT boolean 		IncludeDegrees := request.options.IncludeDegrees : stored('IncludeDegrees');//Set to true for backward compatibility done by ESP
		EXPORT boolean 		IncludeMedicalSchools := request.options.IncludeMedicalSchools : stored('IncludeMedicalSchools');//Set to true for backward compatibility done by ESP
		EXPORT boolean 		IncludeDEAInformation := request.options.IncludeDEAInformation : stored('IncludeDEAInformation');//Set to true for backward compatibility done by ESP
		EXPORT boolean 		IncludeBusinessAddresses := request.options.IncludeBusinessAddresses : stored('IncludeBusinessAddresses');//Set to true for backward compatibility done by ESP
		EXPORT boolean 		IncludeProfessionalLicenses := request.options.IncludeProfessionalLicenses : stored('IncludeProfessionalLicenses');
		EXPORT boolean 		IncludeCurrentProfessionalLicensesOnly := request.options.IncludeCurrentProfessionalLicensesOnly : stored('IncludeCurrentProfessionalLicensesOnly');
		EXPORT boolean 		IncludeAssoc := request.options.IncludeAssociates : stored('IncludeAssociates');
		EXPORT boolean 		IncludeGSASanctions := request.options.IncludeGSASanctions : stored('IncludeGSASanctions');
		EXPORT boolean 		StrictMatchGSASanctions := request.options.StrictMatchGSASanctions : stored('StrictMatchGSASanctions');
		EXPORT boolean 		IncludeCLIA := request.options.IncludeCLIA : stored('IncludeCLIA');
		EXPORT boolean 		IncludeCorporateAffiliations := request.options.IncludeCorporateAffiliations : stored('IncludeCorporateAffiliations');
		EXPORT boolean 		IncludeCorporateAffiliationsOnlyWhenSanctions := request.options.IncludeCorporateAffiliationsOnlyWhenSanctions : stored('IncludeCorporateAffiliationsOnlyWhenSanctions');
		EXPORT boolean 		IncludeCriminalRecords := request.options.IncludeCriminalRecords : stored('IncludeCriminalRecords');
		EXPORT boolean 		IncludeSexOffenders := request.options.IncludeSexOffenders : stored('IncludeSexOffenders');
		EXPORT boolean 		IncludeLiensJudgments := request.options.IncludeLiensJudgments : stored('IncludeLiensJudgments');
		EXPORT boolean 		IncludeBankruptcies := request.options.IncludeBankruptcies : stored('IncludeBankruptcies');
		EXPORT boolean 		IncludeBlankDOD := request.options.IncludeBlankDOD : stored('IncludeBlankDOD');
		EXPORT boolean 		IncludeIndividualInstantID := request.options.IncludeIndividualInstantID : stored('IncludeIndividualInstantID');
		EXPORT boolean 		IncludeBusinessInstantID := request.options.IncludeBusinessInstantID : stored('IncludeBusinessInstantID');
		EXPORT boolean 		IncludeVerifications := request.options.IncludeVerifications : stored('IncludeVerifications');
		EXPORT boolean 		IncludeRels := request.options.Relatives.IncludeRelatives : stored('IncludeRelatives');
		EXPORT boolean 		IncludeRelativesOnlyWhenDeadOrWithSanctions := request.options.IncludeRelativesOnlyWhenDeadOrWithSanctions : stored('IncludeRelativesOnlyWhenDeadOrWithSanctions');
		EXPORT unsigned3	MaxRelatives := if(request.options.Relatives.IncludeRelatives,maxRel,0);
		EXPORT unsigned1	RelativeDepth := if(request.options.Relatives.IncludeRelatives,maxRelDepth,0);
		EXPORT boolean 		IncludeRelativeAddresses := request.options.Relatives.IncludeRelativeAddresses : stored('IncludeRelativeAddresses');
		EXPORT unsigned1	MaxRelativeAddresses := if(request.options.Relatives.IncludeRelativeAddresses,maxRelAddr,0);
		EXPORT boolean 		IncludeNeighs := request.options.Neighbors.IncludeNeighbors : stored('IncludeNeighbors');
		EXPORT boolean 		IncludeHistoricalNeighbors := request.options.Neighbors.IncludeHistoricalNeighbors  : stored('IncludeHistoricalNeighbors');
		EXPORT unsigned1	NeighborhoodCount := if(request.options.Neighbors.IncludeNeighbors,maxNbrhoodCnt,0);
		EXPORT unsigned1 	NeighborCount := if(request.options.Neighbors.IncludeNeighbors,maxNbrCnt,0);
		EXPORT unsigned1 	HistoricalNeighborhoodCount := if(request.options.Neighbors.IncludeHistoricalNeighbors,maxHNbrhoodCnt,0);
		EXPORT unsigned1 	HistoricalNeighborCount := if(request.options.Neighbors.IncludeHistoricalNeighbors,maxHNbrCnt,0);
		Export boolean		derivedLexID := request.ReportBy.UniqueId = ''and request.ReportBy2.UniqueId = '';
		EXPORT String50 	BoardCertifiedSpecialty :=	request.ReportBy2.BoardCertifiedSpecialty;
	end;

	recs := Healthcare_Provider_Services.ReportService_Records (params, ReportBy2,true,cfg);
	output(recs, named('Results'));
endmacro;
// Report_Service();