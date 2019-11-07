IMPORT AutoStandardI, AutoHeaderI, AutoKeyI, iesp, VehicleV2_Services, BatchShare, doxie;

EXPORT IParam := MODULE
	
	SHARED AutoKeyIdsParams := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		EXPORT BOOLEAN workHard := FALSE;
		EXPORT BOOLEAN noFail := FALSE;
		EXPORT BOOLEAN isdeepDive := FALSE;
	END;
	
	SHARED commonVehParams := INTERFACE
		EXPORT STRING30   vehicleKey := '';
		EXPORT STRING15		iterationKey := '';
		EXPORT STRING15 	sequenceKey := '';
		EXPORT STRING 		vin_in := '';
		EXPORT STRING  		DataSource := VehicleV2_Services.Constant.LOCAL_VAL;	
		EXPORT STRING14 	didValue := '';// required for doxie.MAC_Header_Field_Declare
		EXPORT UNSIGNED6 	bdidValue := 0;// required for doxie.MAC_Header_Field_Declare
		EXPORT STRING 		titleIssueDate := '' ;
		EXPORT STRING 		previousTitleIssueDate := '';					
		EXPORT UNSIGNED2 	penalty_threshold := VehicleV2_Services.Constant.VEHICLE_PENALT_THRESHOLD;// required for doxie.MAC_Header_Field_Declare
		EXPORT UNSIGNED4 	lookupValue;	
		EXPORT BOOLEAN 		getMinors := false; //NB: not the same as "include minors"!
		EXPORT BOOLEAN 		displayMatchedParty := false; // required for doxie.MAC_Header_Field_Declare
		EXPORT BOOLEAN	  IncludeNonRegulatedSources := false;		
	END;
	
	EXPORT reportParams := INTERFACE (doxie.IDataAccess,
																		commonVehParams)
			EXPORT BOOLEAN  	excludeLessors := false; // required for doxie.MAC_Header_Field_Declare
	END;

	SHARED baseSearchParams :=  interface(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
							AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,AutoKeyIdsParams)					
		EXPORT STRING50	ReferenceCode;
		EXPORT STRING20	BillingCode;
		EXPORT STRING50	QueryId;
		EXPORT STRING 	SubCustomerID;
		EXPORT STRING		name_suffix;				
		EXPORT UNSIGNED8 	maxresultsVal := 2000;// required for doxie.MAC_Header_Field_Declare
		EXPORT UNSIGNED8 	maxresultsthistimeVal := 2000;// required for doxie.MAC_Header_Field_Declare
		EXPORT UNSIGNED8 	skiprecordsVal := 0;// required for doxie.MAC_Header_Field_Declare
	END;
	
	EXPORT searchParams := interface(baseSearchParams, 
																		AutoStandardI.LIBIN.PenaltyI.base, 
																		commonVehParams,
                                    doxie.IDataAccess)		
		EXPORT string DataPermissionMask := ''; //INTERFACES: different definitions in base modules
		EXPORT STRING 	RealTimePermissibleUse;		
		EXPORT STRING 	ModelYear; 
		EXPORT STRING 	Make; 
		EXPORT STRING 	Model; 
		EXPORT STRING 	LicensePlateNum;		
		EXPORT BOOLEAN 	doCombinedSearch := false;		
		EXPORT STRING20	titleNumber;				
		EXPORT STRING 	dlValue;// required for doxie.MAC_Header_Field_Declare
		EXPORT BOOLEAN 	insuranceUsage; // any special insurance code logic
		EXPORT BOOLEAN 	authenticationUsage; // set experian gateway process type as authentication
		EXPORT BOOLEAN 	includeDevelopedVehicles; // return developed vehicles experian and/or local
		EXPORT STRING 	clnAddr182;
		EXPORT BOOLEAN	UseTagBlur;
		EXPORT BOOLEAN	IncludeCriminalIndicators;	 
		EXPORT BOOLEAN  multiFamilyDwelling;
		EXPORT INTEGER  registrationType;
	END;
	
	
	EXPORT polkParams := interface(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full, doxie.IDataAccess)
		EXPORT string DataPermissionMask := ''; //INTERFACES: different definitions in base modules
	 EXPORT string50	ReferenceCode;
	 EXPORT string20	BillingCode;
	 EXPORT string50	QueryId;
	 EXPORT string 		RealTimePermissibleUse;
	 EXPORT string 		SubCustomerID;
	 EXPORT string		name_suffix;
	 EXPORT string 		vin_in;
	 EXPORT string 		ModelYear; 
	 EXPORT string 		Make; 
	 EXPORT string 		Model; 
	 EXPORT string 		LicensePlateNum;
	 EXPORT string  	DataSource;
	 EXPORT boolean 	noFail:=false; // for batch services
		EXPORT BOOLEAN 	authenticationUsage := FALSE;
		EXPORT BOOLEAN 	includeDevelopedVehicles := FALSE;
		EXPORT STRING clnAddr182 := '';
	END;
	
EXPORT SetInputSearchBy (iesp.motorvehicle.t_MotorVehicleSearch2By searchBy) := FUNCTION
		iesp.ECL2ESP.SetInputName (global(searchBy).Name);
    iesp.ECL2ESP.SetInputAddress (global(searchBy).Address);
		STRING11 ssn := trim(global(searchBy).SSN);
		#STORED ('SSN', ssn);
		STRING VIN  := trim(global(searchBy).VIN);
		#STORED('VIN', VIN);
		INTEGER YearMake := global(searchBy).YearMake;
		#STORED('Year', YearMake); 
		STRING Make := trim(global(searchBy).make);
		#STORED('Make', Make); 
		STRING Model := trim(global(searchBy).model);
		#STORED('Model', Model); 			
		STRING TagNumber := trim(global(searchBy).TagNumber);
		#STORED('Tag', TagNumber);	
		STRING DriverLicenseNumber := trim(global(searchBy).DriverLicenseNumber);
		#STORED('DriversLicense', DriverLicenseNumber);		
		STRING CompanyName := trim(global(searchBy).CompanyName);
		#STORED('CompanyName', CompanyName);
		STRING TitleNumber := trim(global(searchBy).TitleNumber);
		#STORED('TitleNumber', TitleNumber);
		STRING12 UniqueId := trim(global(searchBy).UniqueId);
		#stored('DID',UniqueId);
		STRING VehicleKey := trim(global(searchBy).VehicleKey);
		#STORED('VehicleKey', VehicleKey);		
		STRING IterationKey := trim(global(searchBy).IterationKey);
		#STORED('IterationKey', IterationKey);
		STRING SequenceKey := trim(global(searchBy).SequenceKey);
		#STORED('SequenceKey', SequenceKey);				
		RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
		END;
	
	EXPORT SetInputSearchByMVRRegistration (iesp.motorvehicleRegistration.t_MotorVehicleRegistrationSearchBy searchBy) := FUNCTION
		iesp.ECL2ESP.SetInputName (global(searchBy).Name);
    iesp.ECL2ESP.SetInputAddress (global(searchBy).Address);
		unsigned stored_radius := (global(searchBy).Radius);
		#STORED ('Radius',stored_radius);
		STRING11 ssn := trim(global(searchBy).SSN);
		#STORED ('SSN', ssn);
		STRING1 genderTmp := trim(global(searchBy).Gender);
		STRING1 gender := if (gendertmp = 'A', '', genderTmp); // DEFULT IS ALL in ESP
		#STORED('Gender', gender);
		STRING VIN  := trim(global(searchBy).VIN);		
		// this allows combined MVR search to bypass roxie error message
		// use VIN for input into regular MVR search and vinWIld for input into
		// wilcard portion of query within 
		// the combined MVR search (VehicleV2_Services.VehicleRegSearchService)
    // Also do same for TagNumber below.
		#STORED('VIN', if (length(stringlib.stringfilter(VIN,'*?')) > 0,'',VIN));
		#STORED('VINWild', VIN);
		INTEGER YearMake := global(searchBy).YearMake;
		#STORED('YearMake', YearMake); 
		#STORED('Year', YearMake);
		INTEGER YearMakeMax := global(searchBy).YearMakeMax;
		#STORED('YearMakeMax', YearMakeMax); 
		INTEGER Age := global(searchBy).Age;
		#STORED('Age', Age); 
		INTEGER AgeMax := global(searchBy).AgeMax;
		#STORED('AgeMax', AgeMax); 
	
		set of string xml_in_Makes := set(searchBy.Makes, value);
		STRING Make := trim(global(xml_in_makes[1]));
		STRING Make2 := trim(global(xml_in_makes[2]));
	  STRING Make3 := trim(global(xml_in_makes[3]));
		STRING Make4 := trim(global(xml_in_makes[4]));
		#STORED('Make', Make); 
		#STORED('Make2', Make2);
		#STORED('Make3', Make3);
		#STORED('Make4', Make4);		
		
		set of string xml_in_Models := set(searchBy.Models, value);
		STRING Model := trim(global(xml_in_models[1]));
		STRING Model2 := trim(global(xml_in_models[2]));
		STRING Model3 := trim(global(xml_in_models[3]));
		STRING Model4 := trim(global(xml_in_models[4]));		
		#STORED('Model', Model); 		
	  #STORED('Model2', Model2);
		#STORED('Model3', Model3);
		#STORED('Model4', Model4);
		
		set of string30 xml_in_Colors := set(searchBy.Colors, value);
		STRING Color := trim(global(xml_in_Colors[1]));
		STRING Color2 := trim(global(xml_in_Colors[2]));
	  STRING Color3 := trim(global(xml_in_Colors[3]));
		STRING Color4 := trim(global(xml_in_Colors[4]));
		#STORED('Color', Color); 
		#STORED('Color2', Color2);
		#STORED('Color3', Color3);
		#STORED('Color4', Color4);		
		
		set of string30 xml_in_MinorColors := set(searchBy.MinorColors, value);
		STRING MinorColor := trim(global(xml_in_MinorColors[1]));
		STRING MinorColor2 := trim(global(xml_in_MinorColors[2]));
	  STRING MinorColor3 := trim(global(xml_in_MinorColors[3]));
		STRING MinorColor4 := trim(global(xml_in_MinorColors[4]));
		#STORED('MinorColor', MinorColor); 
		#STORED('MinorColor2', MinorColor2);
		#STORED('MinorColor3', MinorColor3);
		#STORED('MinorColor4', MinorColor4);				
      
		STRING TagNumber := trim(global(searchBy).TagNumber);
		// this allows combined MVR search to bypass roxie error message by setting 2nd 
		// attr and using that in wildcard portion of query
		#STORED('Tag', if (length(stringlib.stringfilter(TagNumber,'*?')) > 0,'',
		                   TagNumber));
		#STORED('TagWild', TagNumber);
		STRING DriverLicenseNumber := trim(global(searchBy).DriverLicenseNumber);
		#STORED('DriversLicense', DriverLicenseNumber);		
		STRING CompanyName := trim(global(searchBy).CompanyName);
		#STORED('CompanyName', CompanyName);
		STRING TitleNumber := trim(global(searchBy).TitleNumber);
		#STORED('TitleNumber', TitleNumber);
	  STRING RegistrationStatus := trim(global(searchBy).RegistrationStatus);
		#STORED('RegistrationStatus', RegistrationStatus);		
		STRING12 UniqueId := trim(global(searchBy).UniqueId);
		#stored('DID',UniqueId);		
		RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;
	
	EXPORT SetInputSearchOptions (iesp.motorvehicle.t_MotorVehicleSearch2Option options) := FUNCTION
	  BOOLEAN UseNicknames := global(options).UseNicknames; // must be provided: 'true'
    #STORED ('allownicknames', UseNicknames);
    BOOLEAN IncludeAlsoFound := global(options).IncludeAlsoFound; //def=FALSE
    #STORED ('nodeepdive', ~IncludeAlsoFound);
    BOOLEAN UsePhonetics := global(options).UsePhonetics;  //def=FALSE
    #STORED ('phoneticmatch', UsePhonetics);
    BOOLEAN UseTagBlur := global(options).UseTagBlur;  //def=FALSE
    #STORED ('UseTagBlur', UseTagBlur);
    BOOLEAN StrictMatch := global(options).StrictMatch;  //def=FALSE
    #STORED ('StrictMatch', StrictMatch);		
		iesp.ECL2ESP.Marshall.Mac_Set(options);
		STRING DataSource := IF(global(options).DataSource='',VehicleV2_Services.Constant.LOCAL_VAL,global(options).DataSource);
		#STORED('DataSource', DataSource);
		STRING RealTimePermissibleUse := global(options).RealTimePermissibleUse;
		#STORED('RealTimePermissibleUse', RealTimePermissibleUse);
		BOOLEAN doCombined := global(options).doCombined;		
		#STORED('doCombined', doCombined);

		BOOLEAN insuranceUsage := global(options).insuranceUsage;		
		#STORED('insuranceUsage', insuranceUsage);
		BOOLEAN authenticationUsage := global(options).authenticationUsage;		
		#STORED('authenticationUsage', authenticationUsage);
		BOOLEAN includeDevelopedVehicles := global(options).includeDevelopedVehicles;		
		#STORED('includeDevelopedVehicles', includeDevelopedVehicles);
		BOOLEAN includeCriminalIndicators := global(options).includeCriminalIndicators;		
		#STORED('includeCriminalIndicators', includeCriminalIndicators);
		
		BOOLEAN IncludeNonRegulatedVehicleSources := global(options).IncludeNonRegulatedVehicleSources;
		#STORED('IncludeNonRegulatedVehicleSources', IncludeNonRegulatedVehicleSources);
		
		BOOLEAN multiFamilyDwelling := global(options).MultiFamilyDwelling;
		#STORED('MultiFamilyDwelling', multiFamilyDwelling);
	  INTEGER registrationType := global(options).RegistrationType;
		#STORED('RegistrationType', registrationType);

		return OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;
  
	
	EXPORT SetInputSearchOptionsMVRRegistration (iesp.motorvehicleRegistration.t_MotorVehicleRegistrationOption options) := FUNCTION
	  BOOLEAN UseNicknames := global(options).UseNicknames; // must be provided: 'true'
    #STORED ('allownicknames', UseNicknames);
    BOOLEAN IncludeAlsoFound := global(options).IncludeAlsoFound; //def=FALSE
    #STORED ('nodeepdive', ~IncludeAlsoFound);
    BOOLEAN UsePhonetics := global(options).UsePhonetics;  //def=FALSE
    #STORED ('phoneticmatch', UsePhonetics);
    BOOLEAN UseTagBlur := global(options).UseTagBlur;  //def=FALSE
    #STORED ('UseTagBlur', UseTagBlur);   
		iesp.ECL2ESP.Marshall.Mac_Set(options);
		STRING DataSource := IF(global(options).DataSource='',VehicleV2_Services.Constant.LOCAL_VAL,global(options).DataSource);
		#STORED('DataSource', DataSource);
		STRING RealTimePermissibleUse := global(options).RealTimePermissibleUse;
		#STORED('RealTimePermissibleUse', RealTimePermissibleUse);
		BOOLEAN doCombined := global(options).DoCombined;		
		#STORED('doCombined', doCombined);

		BOOLEAN insuranceUsage := global(options).InsuranceUsage;		
		#STORED('insuranceUsage', insuranceUsage);
		BOOLEAN includeCriminalIndicators := global(options).IncludeCriminalIndicators;		
		#STORED('includeCriminalIndicators', includeCriminalIndicators);
		
		BOOLEAN IncludeNonRegulatedVehicleSources := global(options).IncludeNonRegulatedVehicleSources;
		#STORED('IncludeNonRegulatedVehicleSources', IncludeNonRegulatedVehicleSources);		
		UNSIGNED maxresults := global(options).MaxResults;		
		#STORED('MaxResults', if (MaxResults = 0, 1000, MaxResults));
		return OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;
	
	EXPORT SetInputReportBy (iesp.motorvehicle.t_MotorVehicleReport2By reportBy) := FUNCTION
		STRING VIN  := trim(global(reportBy).VIN);
		#STORED('VIN', VIN);				
		STRING12 UniqueId := trim(global(reportBy).UniqueId);
		#STORED('DID',UniqueId);
		STRING BusinessId := trim(global(reportBy).BusinessId);
		#STORED('BDID', BusinessId);
		STRING VehicleRecordId := trim(global(reportBy).VehicleRecordId);
		STRING VehicleNumber := trim(global(reportBy).VehicleNumber);
		STRING VehicleKey := IF(VehicleRecordId = '', VehicleNumber, VehicleRecordId);
		#STORED('VehicleKey', VehicleKey);		
		STRING IterationKey := trim(global(reportBy).IterationKey);
		#STORED('IterationKey', IterationKey);
		STRING SequenceKey := trim(global(reportBy).SequenceKey);
		#STORED('SequenceKey', SequenceKey);
		STRING DataSource := IF(global(reportBy).DataSource='',VehicleV2_Services.Constant.LOCAL_VAL,global(reportBy).DataSource);
		#STORED('DataSource', DataSource);		
		
		RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;
  
	
	EXPORT SetInputReportOptions (iesp.motorvehicle.t_MotorVehicleReport2Option options) := FUNCTION
		BOOLEAN IncludeNonRegulatedVehicleSources := global(options).IncludeNonRegulatedVehicleSources;
		#STORED('IncludeNonRegulatedVehicleSources', IncludeNonRegulatedVehicleSources);
    
		RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;
	
	EXPORT getSearchModule(Boolean MVRcombinedQuery=FALSE) := FUNCTION
		input_params := AutoStandardI.GlobalModule();
		mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
		
		search_mod:= MODULE(PROJECT (input_params, searchParams, OPT)) //OPT: mostly, FetchI_Hdr_Biz.full fields
      doxie.compliance.MAC_CopyModAccessValues(mod_access);

			EXPORT string50		ReferenceCode := '' : STORED('ReferenceCode');
			EXPORT string20		BillingCode := '' : STORED('BillingCode');
			EXPORT string50		QueryId := '' : STORED('QueryId');
			EXPORT string 		RealTimePermissibleUse := '' : STORED('RealTimePermissibleUse');
			EXPORT string 		SubCustomerID:='' :STORED('SubCustomerID');
			string year := '' : STORED('YEAR');
			EXPORT string 		ModelYear:= IF (year = '0', '', year);
			string _make := '' : STORED('Make'); 
			EXPORT string 		Make := stringlib.stringtouppercase(trim(_make, left, right));			
			string _model := '' : STORED('Model');			
			EXPORT string 		Model := stringlib.stringtouppercase(trim(_model, left, right));
			EXPORT string 		LicensePlateNum := AutoStandardI.InterfaceTranslator.tag_value.val(project(input_params,AutoStandardI.InterfaceTranslator.tag_value.params)); 
			EXPORT string 		vin_in := AutoStandardI.InterfaceTranslator.vin_value.val(project(input_params,AutoStandardI.InterfaceTranslator.vin_value.params)); 
			EXPORT string 		name_suffix := input_params.namesuffix;
			EXPORT string 		DataSource := '' : STORED('DataSource');	
			EXPORT BOOLEAN 		doCombinedSearch := FALSE : STORED('doCombined');
			EXPORT STRING30 	vehicleKey	 := '' : STORED('VehicleKey');
			EXPORT STRING15  	iterationKey := ''     : STORED('IterationKey');
			EXPORT STRING15 	sequenceKey  	:= '' 		: STORED('SequenceKey');
			EXPORT STRING20  	titleNumber := '' : STORED('TitleNumber');
			EXPORT STRING 		titleIssueDate := '' : stored('TitleIssueDate');
			EXPORT STRING 		previousTitleIssueDate := '' : stored('PreviousTitleIssueDate');		
			EXPORT unsigned2 	penalty_threshold := VehicleV2_Services.Constant.VEHICLE_PENALT_THRESHOLD : stored('PenaltThreshold');		
			EXPORT BOOLEAN 		excludeLessors := AutoStandardI.InterfaceTranslator.Exclude_Lessors.val(project(input_params,AutoStandardI.InterfaceTranslator.Exclude_Lessors.params));
			EXPORT BOOLEAN 		displayMatchedParty := AutoStandardI.InterfaceTranslator.DisplayMatchedParty_value.val(project(input_params,AutoStandardI.InterfaceTranslator.DisplayMatchedParty_value.params));
      // translate 4 "standard" library fields here, since we will use them in places other than standard search
			EXPORT STRING2 		state := AutoStandardI.InterfaceTranslator.state_value.val(project(input_params,AutoStandardI.InterfaceTranslator.state_value.params)); 
			EXPORT STRING30 	county := AutoStandardI.InterfaceTranslator.county_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.county_value.params));
			EXPORT STRING30 		firstname := AutoStandardI.InterfaceTranslator.fname_value.val(project(input_params,AutoStandardI.InterfaceTranslator.fname_value.params)); 
			EXPORT STRING30			lastname := AutoStandardI.InterfaceTranslator.lname_value.val(project(input_params,AutoStandardI.InterfaceTranslator.lname_value.params)); 
			EXPORT unsigned8 	maxresultsVal := AutoStandardI.InterfaceTranslator.MaxResults_val.val(project(input_params,AutoStandardI.InterfaceTranslator.MaxResults_val.params));
			EXPORT unsigned8 	maxresultsthistimeVal := AutoStandardI.InterfaceTranslator.MaxResultsThisTime_val.val(project(input_params,AutoStandardI.InterfaceTranslator.MaxResultsThisTime_val.params));
			EXPORT unsigned8 	skiprecordsVal := AutoStandardI.InterfaceTranslator.SkipRecords_val.val(project(input_params,AutoStandardI.InterfaceTranslator.SkipRecords_val.params));
			EXPORT STRING 	 	dlValue := AutoStandardI.InterfaceTranslator.dl_value.val(project(input_params,AutoStandardI.InterfaceTranslator.dl_value.params));
			EXPORT STRING14 	didValue := AutoStandardI.InterfaceTranslator.did_value.val(project(input_params,AutoStandardI.InterfaceTranslator.did_value.params));
			EXPORT unsigned6 	bdidValue := AutoStandardI.InterfaceTranslator.bdid_value.val(project(input_params,AutoStandardI.InterfaceTranslator.bdid_value.params));
			EXPORT UNSIGNED4  lookupValue := AutoStandardI.InterfaceTranslator.lookup_value.val(project(input_params,AutoStandardI.InterfaceTranslator.lookup_value.params)); 
			EXPORT BOOLEAN 		isDeepDive := ~AutoStandardI.InterfaceTranslator.nodeepdive.val(project(input_params, AutoStandardI.InterfaceTranslator.nodeepdive.params));
			EXPORT string120 company := AutoStandardI.InterfaceTranslator.comp_name_value.val(project(input_params, AutoStandardI.InterfaceTranslator.comp_name_value.params));
      export string11 ssn  := AutoStandardI.InterfaceTranslator.ssn_value.val(project(input_params, AutoStandardI.InterfaceTranslator.ssn_value.params));
      Export string25 city := AutoStandardI.InterfaceTranslator.city_val.val(project(input_params, AutoStandardI.InterfaceTranslator.city_val.params));
			EXPORT BOOLEAN insuranceUsage := FALSE : STORED('insuranceUsage');
			EXPORT BOOLEAN authenticationUsage := FALSE : STORED('authenticationUsage');
			EXPORT BOOLEAN includeDevelopedVehicles := FALSE : STORED('includeDevelopedVehicles');
			EXPORT BOOLEAN includeCriminalIndicators := FALSE : STORED('includeCriminalIndicators');
			EXPORT BOOLEAN IncludeNonRegulatedSources := FALSE : STORED('IncludeNonRegulatedVehicleSources');
			EXPORT STRING clnAddr182 := '';			
			EXPORT BOOLEAN NoFail := mvrCombinedQuery; // set to true in top level service;
			EXPORT BOOLEAN multiFamilyDwelling := FALSE : STORED('MultiFamilyDwelling');
			EXPORT INTEGER registrationType := 0 : STORED('RegistrationType');		
		END;
		RETURN search_mod; 
	END;
	
	EXPORT getSearchModule_entity2() := FUNCTION
		input_params := AutoStandardI.GlobalModule();
		mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
		
		in_mod:= MODULE(PROJECT(input_params, searchParams, opt))		
      doxie.compliance.MAC_CopyModAccessValues(mod_access);
			EXPORT string50		ReferenceCode := '' : STORED('ReferenceCode');
			EXPORT string20		BillingCode := '' : STORED('BillingCode');
			EXPORT string50		QueryId := '' : STORED('QueryId');
			EXPORT string 		RealTimePermissibleUse := '' : STORED('RealTimePermissibleUse');
			EXPORT string 		SubCustomerID:='' :STORED('SubCustomerID');
			string year := '' : STORED('YEAR');
			EXPORT string 		ModelYear:= IF (year = '0', '', year); 
			EXPORT string 		Make:='' : STORED('Make'); 
			EXPORT string 		Model:='' : STORED('Model'); 
			EXPORT string 		LicensePlateNum := AutoStandardI.InterfaceTranslator.tag_value.val(project(input_params,AutoStandardI.InterfaceTranslator.tag_value.params)); 
			EXPORT string 		vin_in := AutoStandardI.InterfaceTranslator.vin_value.val(project(input_params,AutoStandardI.InterfaceTranslator.vin_value.params)); 
			EXPORT string 		name_suffix := input_params.namesuffix;
			EXPORT string 		DataSource := '' : STORED('DataSource');	
			EXPORT BOOLEAN 		doCombinedSearch := FALSE : STORED('doCombined');
			EXPORT STRING30 	vehicleKey	 := '' : STORED('VehicleKey');
			EXPORT STRING15  	iterationKey := ''     : STORED('IterationKey');
			EXPORT STRING15 	sequenceKey  	:= '' 		: STORED('SequenceKey');
			EXPORT STRING20  	titleNumber := '' : STORED('TitleNumber');
			EXPORT STRING 		titleIssueDate := '' : stored('TitleIssueDate');
			EXPORT STRING 		previousTitleIssueDate := '' : stored('PreviousTitleIssueDate');		
			EXPORT unsigned2 	penalty_threshold := VehicleV2_Services.Constant.VEHICLE_PENALT_THRESHOLD : stored('PenaltThreshold');		
			EXPORT BOOLEAN 		excludeLessors := AutoStandardI.InterfaceTranslator.Exclude_Lessors.val(project(input_params,AutoStandardI.InterfaceTranslator.Exclude_Lessors.params));
			EXPORT BOOLEAN 		displayMatchedParty := AutoStandardI.InterfaceTranslator.DisplayMatchedParty_value.val(project(input_params,AutoStandardI.InterfaceTranslator.DisplayMatchedParty_value.params));
      // translate 3 "standard" library fields here, since we will use them in places other than standard search
			EXPORT unsigned8 	maxresultsVal := AutoStandardI.InterfaceTranslator.MaxResults_val.val(project(input_params,AutoStandardI.InterfaceTranslator.MaxResults_val.params));
			EXPORT unsigned8 	maxresultsthistimeVal := AutoStandardI.InterfaceTranslator.MaxResultsThisTime_val.val(project(input_params,AutoStandardI.InterfaceTranslator.MaxResultsThisTime_val.params));
			EXPORT unsigned8 	skiprecordsVal := AutoStandardI.InterfaceTranslator.SkipRecords_val.val(project(input_params,AutoStandardI.InterfaceTranslator.SkipRecords_val.params));
			EXPORT STRING 	 	dlValue := AutoStandardI.InterfaceTranslator.dl_value.val(project(input_params,AutoStandardI.InterfaceTranslator.dl_value.params));
			EXPORT STRING14 	didValue := AutoStandardI.InterfaceTranslator.did_value.val(project(input_params,AutoStandardI.InterfaceTranslator.did_value.params));
			EXPORT unsigned6 	bdidValue := AutoStandardI.InterfaceTranslator.bdid_value.val(project(input_params,AutoStandardI.InterfaceTranslator.bdid_value.params));
			EXPORT UNSIGNED4  lookupValue := AutoStandardI.InterfaceTranslator.lookup_value.val(project(input_params,AutoStandardI.InterfaceTranslator.lookup_value.params)); 
			EXPORT BOOLEAN 		isDeepDive := ~AutoStandardI.InterfaceTranslator.nodeepdive.val(project(input_params, AutoStandardI.InterfaceTranslator.nodeepdive.params));
			EXPORT string120 company := AutoStandardI.InterfaceTranslator.comp_name_value.val(project(input_params, AutoStandardI.InterfaceTranslator.comp_name_value.params));
    
			EXPORT BOOLEAN insuranceUsage := FALSE : STORED('insuranceUsage');
			EXPORT BOOLEAN authenticationUsage := FALSE : STORED('authenticationUsage');
			EXPORT BOOLEAN includeDevelopedVehicles := FALSE : STORED('includeDevelopedVehicles');
			EXPORT BOOLEAN includeCriminalIndicators := FALSE : STORED('includeCriminalIndicators');
			export firstname := input_params.entity2_firstname;
			export middlename := input_params.entity2_middlename;
			export lastname := input_params.entity2_lastname;
			export unparsedfullname := input_params.entity2_unparsedfullname;
			export allownicknames := input_params.entity2_allownicknames;
			export phoneticmatch := input_params.entity2_phoneticmatch;
			export companyname := input_params.entity2_companyname;
			export addr := input_params.entity2_addr;
			export city := input_params.entity2_city;
			export state := input_params.entity2_state;
			export zip := input_params.entity2_zip;
			export zipradius := input_params.entity2_zipradius;
			export phone := input_params.entity2_phone;
			export fein := input_params.entity2_fein;
			export bdid := input_params.entity2_bdid;
			export did := input_params.entity2_did;
			export ssn := input_params.entity2_ssn;
			EXPORT STRING clnAddr182 := '';
			EXPORT BOOLEAN IncludeNonRegulatedSources := FALSE : STORED('IncludeNonRegulatedVehicleSources');
			EXPORT BOOLEAN multiFamilyDwelling := FALSE : STORED('MultiFamilyDwelling');
			EXPORT INTEGER registrationType := 0 : STORED('RegistrationType');		
		END;
		RETURN in_mod;
	END;
	
	EXPORT getReportModule() := FUNCTION
		gm := AutoStandardI.GlobalModule();
    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(gm);
		
		in_mod := MODULE(PROJECT (mod_access, reportParams, OPT))
			EXPORT STRING 		vin_in := AutoStandardI.InterfaceTranslator.vin_value.val(project(gm,AutoStandardI.InterfaceTranslator.vin_value.params)); 
			EXPORT STRING   	DataSource := '' : STORED('DataSource');	
			EXPORT STRING30 	vehicleKey	 := '' : STORED('VehicleKey');
			EXPORT STRING15  	iterationKey := ''     : STORED('IterationKey');
			EXPORT STRING15 	sequenceKey  	:= '' 		: STORED('SequenceKey');
			EXPORT STRING 		titleIssueDate := '' : stored('TitleIssueDate');
			EXPORT STRING 		previousTitleIssueDate := '' : stored('PreviousTitleIssueDate');		
			EXPORT STRING14 	didValue := AutoStandardI.InterfaceTranslator.did_value.val(project(gm,AutoStandardI.InterfaceTranslator.did_value.params));
			EXPORT UNSIGNED6 	bdidValue := AutoStandardI.InterfaceTranslator.bdid_value.val(project(gm,AutoStandardI.InterfaceTranslator.bdid_value.params));
			EXPORT UNSIGNED4  lookupValue := AutoStandardI.InterfaceTranslator.lookup_value.val(project(gm,AutoStandardI.InterfaceTranslator.lookup_value.params)); 
			EXPORT BOOLEAN    IncludeNonRegulatedSources := FALSE : STORED('IncludeNonRegulatedVehicleSources');
  		EXPORT BOOLEAN 		displayMatchedParty := gm.displayMatchedParty;
      EXPORT UNSIGNED2 	penalty_threshold := gm.penalty_threshold;
      EXPORT BOOLEAN    excludeLessors := gm.excludelessors;
		END;
			
		RETURN in_mod;
	END;

	export VehicleBatch_params := interface
		export boolean penalize_by_party := false;
		export BOOLEAN Is_UseDate := false;
		export boolean ReturnCurrent	:= false;
		export boolean FullNameMatch := false;
	end;
	
  // just a few compliance fields are needed, so not inheriting from IDataAccess
	export RTBatch_V2_params := interface(VehicleBatch_params)
		export unsigned1 Operation           := 0;
		export boolean   use_date            := false;
		export boolean   select_years        := false;
		export unsigned  years               := 0;
		export boolean   include_ssn         := false;
		export boolean   include_dob         := false;
		export boolean   include_addr        := false;
		export boolean   include_phone       := false;
		export string120 append_l            := '';
		export string120 verify_l            := '';
		export string120 fuzzy_l             := '';
		export boolean   dedup_results_l     := true;
		export string3   thresh_val          := '';
		export unsigned1 glb                 := 8;
		export boolean   patriotproc         := false;
		export boolean   show_minors         := false;
		export boolean   GatewayNameMatch    := false;
		export boolean   AlwaysHitGateway    := false;
		export string32  application_type	   := '';
		export string5   industry_class	     := '';
		export string    DataRestrictionMask := BatchShare.Constants.Defaults.DataRestrictionMask;
		export boolean   IncludeRanking	     := false;
		export unsigned1 dppa  := 0;
		export boolean   GetSSNBest      	   := false;
		export string1   BIPFetchLevel			 := '';
	end;
	
	
END;
