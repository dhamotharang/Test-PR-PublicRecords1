/*--SOAP--
<message name="SearchService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="HealthCareConsolidatedSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/

import iesp, AutoStandardI,address,ut;

export SearchService := MACRO
	ds_in := DATASET ([], iesp.healthcareconsolidatedsearch.t_HealthCareConsolidatedSearchRequest) : STORED('HealthCareConsolidatedSearchRequest', FEW);
	
	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	iesp.ECL2ESP.SetInputUser(first_row.user);	  
	iesp.ECL2ESP.SetInputReportBy (ROW (first_row.searchBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])));
	hasFullNCPDP := first_row.Options.IncludeFullNCPDPInfo;
	string11 Taxid       := trim(first_row.searchBy.Taxid);
	#stored('Taxid', Taxid);
	string11 Fein       := trim(first_row.searchBy.FEIN);
	#stored('Fein', Fein);
  STRING CompanyName := trim(first_row.searchBy.CompanyName);
	#STORED('CompanyName', CompanyName);
	String FullName := stringlib.StringToUpperCase(trim(first_row.searchby.Name.Full,left,right));
	boolean	doClnName := FullName <> '';
	clnName:= Address.CleanNameFields(Address.CleanPerson73(FullName)).CleanNameRecord;

	ProviderID_Raw	:=		first_row.searchby.ProviderId;
	ProvidSRC_Raw		:=		stringlib.StringToUpperCase(first_row.searchby.ProviderSrc);

	unsigned2 PenaltThreshold := first_row.Options.penaltythreshold;
	unsigned2 UserThreshold := if (first_row.Options.ThresholdLimit > 0,first_row.Options.ThresholdLimit,10);
	CustID := first_row.user.CompanyId:stored('_CompanyId');	
	#stored ('PenaltThreshold', PenaltThreshold);	
	stateLicenseDS := dataset([{1,1,stringlib.StringToUpperCase(first_row.searchby.LicenseState),stringlib.StringToUpperCase(first_row.searchby.LicenseNumber),'',''},
														 {1,2,stringlib.StringToUpperCase(first_row.searchby.LicenseState2),stringlib.StringToUpperCase(first_row.searchby.LicenseNumber2),'',''},
														 {1,3,stringlib.StringToUpperCase(first_row.searchby.LicenseState3),stringlib.StringToUpperCase(first_row.searchby.LicenseNumber3),'',''},
														 {1,4,stringlib.StringToUpperCase(first_row.searchby.LicenseState4),stringlib.StringToUpperCase(first_row.searchby.LicenseNumber4),'',''},
														 {1,5,stringlib.StringToUpperCase(first_row.searchby.LicenseState5),stringlib.StringToUpperCase(first_row.searchby.LicenseNumber5),'',''},
														 {1,6,stringlib.StringToUpperCase(first_row.searchby.LicenseState6),stringlib.StringToUpperCase(first_row.searchby.LicenseNumber6),'',''},
														 {1,7,stringlib.StringToUpperCase(first_row.searchby.LicenseState7),stringlib.StringToUpperCase(first_row.searchby.LicenseNumber7),'',''},
														 {1,8,stringlib.StringToUpperCase(first_row.searchby.LicenseState8),stringlib.StringToUpperCase(first_row.searchby.LicenseNumber8),'',''},
														 {1,9,stringlib.StringToUpperCase(first_row.searchby.LicenseState9),stringlib.StringToUpperCase(first_row.searchby.LicenseNumber9),'',''},
														 {1,10,stringlib.StringToUpperCase(first_row.searchby.LicenseState10),stringlib.StringToUpperCase(first_row.searchby.LicenseNumber10),'',''}
															],Healthcare_Provider_Services.IParams.licenseinfo);
  	
	input_params := AutoStandardI.GlobalModule();

	tmpMod:= MODULE(PROJECT(input_params, Healthcare_Header_Services.IParams.searchParams,opt))		
		EXPORT STRING 		NPI := first_row.searchby.NPINumber;
		EXPORT STRING 		UPIN := first_row.searchby.UPIN;
		EXPORT string11 	Fein := AutoStandardI.InterfaceTranslator.fein_val.val(project(input_params, AutoStandardI.InterfaceTranslator.fein_val.params));  
		EXPORT STRING 		MedicalSchoolName := first_row.searchby.MedicalSchoolName;
		EXPORT integer 		GraduationYear := first_row.searchby.GraduationYear;
		EXPORT STRING30 	LastName := stringlib.StringToUpperCase(if(doClnName,clnName.lname,first_row.searchby.Name.Last));      			
		EXPORT STRING30 	FirstName := stringlib.StringToUpperCase(if(doClnName,clnName.fname,first_row.searchby.Name.FIRST));      			
		EXPORT STRING30 	MiddleName := stringlib.StringToUpperCase(if(doClnName,clnName.mname,first_row.searchby.Name.Middle));      			
		EXPORT string120 	CompanyName := stringlib.StringToUpperCase(first_row.searchby.CompanyName);
		EXPORT string10 	prim_range :=  stringlib.StringToUpperCase(first_row.searchby.Address.StreetNumber);
		EXPORT string2		predir :=  stringlib.StringToUpperCase(first_row.searchby.Address.StreetPreDirection);
		EXPORT string28		prim_name :=  stringlib.StringToUpperCase(first_row.searchby.Address.StreetName);
		EXPORT string4		suffix :=  stringlib.StringToUpperCase(first_row.searchby.Address.StreetSuffix);
		EXPORT string2		postdir :=  stringlib.StringToUpperCase(first_row.searchby.Address.StreetPostDirection);
		EXPORT string8		sec_range :=  stringlib.StringToUpperCase(first_row.searchby.Address.UnitNumber);
		export string25 	city := AutoStandardI.InterfaceTranslator.city_val.val(project(input_params, AutoStandardI.InterfaceTranslator.city_val.params));
		export string2 		state := AutoStandardI.InterfaceTranslator.state_val.val(project(input_params, AutoStandardI.InterfaceTranslator.state_val.params));
		export string6 		zip := AutoStandardI.InterfaceTranslator.zip_val0.val(project(input_params, AutoStandardI.InterfaceTranslator.zip_val0.params));
		Export dataset(Healthcare_Header_Services.IParams.licenseinfo) StateLicenses := stateLicenseDS;
		EXPORT STRING 		DEA := first_row.searchby.DEANumber;
		EXPORT STRING 		DEA2 := first_row.searchby.DEANumber2;
		EXPORT string15		CLIANumber := first_row.searchby.CLIANumber;
		Export String15 	NCPDPNumber := first_row.searchby.PharmacyProviderId;
		EXPORT string15		Taxonomy := first_row.searchby.Taxonomy;
		EXPORT string15		Taxonomy2 := first_row.searchby.Taxonomy2;
		EXPORT string15		Taxonomy3 := first_row.searchby.Taxonomy3;
		EXPORT string15		Taxonomy4 := first_row.searchby.Taxonomy4;
		EXPORT string15		Taxonomy5 := first_row.searchby.Taxonomy5;
		export unsigned6  ProviderId := IF(ProvidSRC_Raw = 'S' and (integer)ProviderID_Raw > 1000000, (integer)ProviderID_Raw [1..(length(trim((string)ProviderID_Raw,all))-3)],(integer)ProviderID_Raw);
		export string5  	ProviderSrc := IF (ProvidSRC_Raw = 'S' and (integer)ProviderID_Raw > 1000000,'H',ProvidSRC_Raw);
		EXPORT String50 	BoardCertifiedSpecialty :=	first_row.searchby.BoardCertifiedSpecialty1;
		EXPORT String50 	BoardCertifiedSpecialty2 := first_row.searchby.BoardCertifiedSpecialty2;
		EXPORT String50		BoardCertifiedSpecialty3 := first_row.searchby.BoardCertifiedSpecialty3;
		EXPORT String50 	BoardCertifiedSpecialty4 := first_row.searchby.BoardCertifiedSpecialty4;
		EXPORT String50 	BoardCertifiedSpecialty5 := first_row.searchby.BoardCertifiedSpecialty5;
		EXPORT String50 	BoardCertifiedSubSpecialty := first_row.searchby.BoardCertifiedSubSpecialty1;
		EXPORT String50 	BoardCertifiedSubSpecialty2 := first_row.searchby.BoardCertifiedSubSpecialty2;
		EXPORT String50 	BoardCertifiedSubSpecialty3 := first_row.searchby.BoardCertifiedSubSpecialty3;
		EXPORT String50 	BoardCertifiedSubSpecialty4 := first_row.searchby.BoardCertifiedSubSpecialty4;
		EXPORT String50 	BoardCertifiedSubSpecialty5 := first_row.searchby.BoardCertifiedSubSpecialty5;
		EXPORT boolean	 	IsIndividualSearch := first_row.options.IsIndividualSearch;
		EXPORT boolean 		IsBusinessSearch := first_row.options.IsBusinessSearch;
		EXPORT boolean 		IsUnknownSearchBoth := first_row.options.IsUnknownSearchBoth;
	END;
	string _DRM := '':Stored('DataRestrictionMask'); 
	string _DPM := '':Stored('DataPermissionMask'); 
	Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
		self.CustomerID := CustID;	
		self.OneStepRule := first_row.searchby.VerificationConfiguration;
		self.penalty_threshold := UserThreshold;
		self.MaxResults := first_row.options.MaxResults;
		self.DRM := _DRM; // '':Stored('DataRestrictionMask'); 
		self.DPM := _DPM; // '':Stored('DataPermissionMask'); 
		self.hasFullNCPDP := hasFullNCPDP;
		self.glb_ok := ut.glb_ok ((integer)first_row.user.GLBPurpose);
		self.dppa_ok := ut.dppa_ok((integer)first_row.user.DLPurpose);
		self.glb :=   (integer)first_row.user.GLBPurpose;
		self.dppa :=  (integer)first_row.user.DLPurpose;
		self.doDeepDive := if((integer)ProviderID_Raw>0 and ProvidSRC_Raw in ['H',''],false,first_row.options.IncludeAlsoFound);
		self.excludeSourceAMS := first_row.options.ExcludeSourceAMS;
		self.excludeSourceNPPES := first_row.options.ExcludeSourceNPPES;
		self.excludeSourceDEA := first_row.options.ExcludeSourceDEA;
		self.excludeSourceProfLic := first_row.options.ExcludeSourceProfLic;
		self.excludeSourceSelectFile := first_row.options.ExcludeSourceSelectFile;
		self.excludeSourceCLIA := first_row.options.ExcludeSourceCLIA;
		self.excludeSourceNCPDP := first_row.options.ExcludeSourceNCPDP or _DRM[21] = '1';
		self.excludeLegacySanctions := first_row.options.ExcludeLegacySanctions;
		self.IncludeAlsoFound := first_row.options.IncludeAlsoFound;
		self.includeCustomerData := true;
		self.IncludeProvidersOnly := first_row.options.IncludeProvidersOnly;
		self.IncludeSanctionsOnly := first_row.options.IncludeSanctionsOnly;
		self.IncludeGroupAffiliations := first_row.options.IncludeGroupAffiliations;
		self.IncludeHospitalAffiliations := first_row.options.IncludeHospitalAffiliations;
		self.IncludeSpecialties  := first_row.options.IncludeSpecialties;
		self.IncludeLicenses  := first_row.options.IncludeLicenses;
		// self.IncludeResidencies  := first_row.options.IncludeResidencies;
		self.IncludeABMSBoardCertifiedSpecialty := first_row.options.IncludeBoardCertifiedSpecialty;
		// self:=[];Do not uncomment otherwise the default values will not get set.
	end;
	cfgData:=dataset([buildConfig()]);
	
	convertedInput := Healthcare_Header_Services.Records.convertInputtoDataset(tmpMod);
	rawRec := Healthcare_Header_Services.Records.getSearchServiceRecords(convertedInput, cfgData);
	returnThresholdExceeded:=rawRec[1].ProcessingMessage = 203 and rawRec[1].lnpid=0;
	hasoptout:=exists(rawRec(hasoptout = true));
	recsFmt:= project(rawRec,Healthcare_Header_Services.Transforms.formatSearchServiceProviderOutput(left,convertedInput,cfgData));
  		//marshall the output...
	//marshall the output...
	returnCnt := if((integer)ReturnCount=0,10,ReturnCount);
	startRec := if((integer)StartingRecord=0,1,StartingRecord);
	marshallResults := choosen(recsFmt, returnCnt, startRec);
	// Format output to iesp
	iesp.healthcareconsolidatedsearch.t_HealthCareConsolidatedSearchResponse format() := transform
				string q_id := '' : stored ('_QueryId');
				string t_id := '' : stored ('_TransactionId');
				string msg	:= 'Too many subjects found.';
				optoutMessage := if(hasoptout,DATASET([{'700',Healthcare_Provider_Services.Constants.optoutmsg}], iesp.share.t_ResultDisclaimer),DATASET([], iesp.share.t_ResultDisclaimer));
				badheader := ROW ({203, msg, q_id, t_id, [],[]}, iesp.share.t_ResponseHeader);
				goodheader := ROW ({0, '', q_id, t_id, [],optoutMessage}, iesp.share.t_ResponseHeader);
				self._Header         := if(returnThresholdExceeded ,badheader,goodheader);
				self.SearchBy				 := first_row.searchby;
				self.Options				 := first_row.options;
				self.RecordCount 		 := count(recsFmt);
				self.HealthCareProviders := marshallResults;
	end;

	recs := dataset([format()]);

	output(recs, named('Results'));
	
ENDMACRO;
// Healthcare_Provider_Services.SearchService();
