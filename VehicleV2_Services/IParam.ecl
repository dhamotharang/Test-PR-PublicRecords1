IMPORT AutoStandardI, AutoHeaderI, AutoKeyI, iesp, VehicleV2_Services, BatchShare, doxie, STD;

EXPORT IParam := MODULE
  
  SHARED AutoKeyIdsParams := INTERFACE(AutoKeyI.AutoKeyStandardFetchBaseInterface)
    EXPORT BOOLEAN workHard := FALSE;
    EXPORT BOOLEAN noFail := FALSE;
    EXPORT BOOLEAN isdeepDive := FALSE;
  END;
  
  SHARED commonVehParams := INTERFACE
    EXPORT STRING30 vehicleKey := '';
    EXPORT STRING15 iterationKey := '';
    EXPORT STRING15 sequenceKey := '';
    EXPORT STRING vin_in := '';
    EXPORT STRING DataSource := VehicleV2_Services.Constant.LOCAL_VAL;
    EXPORT STRING14 didValue := '';// required for doxie.MAC_Header_Field_Declare
    EXPORT UNSIGNED6 bdidValue := 0;// required for doxie.MAC_Header_Field_Declare
    EXPORT STRING titleIssueDate := '' ;
    EXPORT STRING previousTitleIssueDate := '';
    EXPORT UNSIGNED2 penalty_threshold := VehicleV2_Services.Constant.VEHICLE_PENALT_THRESHOLD;// required for doxie.MAC_Header_Field_Declare
    EXPORT UNSIGNED4 lookupValue;
    EXPORT BOOLEAN getMinors := FALSE; //NB: not the same as "include minors"!
    EXPORT BOOLEAN displayMatchedParty := FALSE; // required for doxie.MAC_Header_Field_Declare
    EXPORT BOOLEAN IncludeNonRegulatedSources := FALSE;
  END;
  
  EXPORT reportParams := INTERFACE (doxie.IDataAccess,
                                    commonVehParams)
    EXPORT BOOLEAN excludeLessors := FALSE; // required for doxie.MAC_Header_Field_Declare
  END;

  SHARED baseSearchParams := INTERFACE(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
              AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,AutoKeyIdsParams)
    EXPORT STRING50 ReferenceCode;
    EXPORT STRING20 BillingCode;
    EXPORT STRING50 QueryId;
    EXPORT STRING SubCustomerID;
    EXPORT STRING name_suffix;
    EXPORT UNSIGNED8 maxresultsVal := 2000;// required for doxie.MAC_Header_Field_Declare
    EXPORT UNSIGNED8 maxresultsthistimeVal := 2000;// required for doxie.MAC_Header_Field_Declare
    EXPORT UNSIGNED8 skiprecordsVal := 0;// required for doxie.MAC_Header_Field_Declare
  END;
  
  EXPORT searchParams := INTERFACE(baseSearchParams,
                                    AutoStandardI.LIBIN.PenaltyI.base,
                                    commonVehParams,
                                    doxie.IDataAccess)
    EXPORT STRING DataPermissionMask := ''; //INTERFACES: different definitions in base modules
    EXPORT STRING RealTimePermissibleUse;
    EXPORT STRING ModelYear;
    EXPORT STRING Make;
    EXPORT STRING Model;
    EXPORT STRING LicensePlateNum;
    EXPORT BOOLEAN doCombinedSearch := FALSE;
    EXPORT STRING20 titleNumber;
    EXPORT STRING dlValue;// required for doxie.MAC_Header_Field_Declare
    EXPORT BOOLEAN insuranceUsage; // any special insurance code logic
    EXPORT BOOLEAN authenticationUsage; // set experian gateway process type as authentication
    EXPORT BOOLEAN includeDevelopedVehicles; // return developed vehicles experian AND/OR local
    EXPORT STRING clnAddr182;
    EXPORT BOOLEAN UseTagBlur;
    EXPORT BOOLEAN IncludeCriminalIndicators;
    EXPORT BOOLEAN multiFamilyDwelling;
    EXPORT INTEGER registrationType;
  END;
  
  
EXPORT polkParams := INTERFACE(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full, doxie.IDataAccess)
  EXPORT STRING DataPermissionMask := ''; //INTERFACES: different definitions in base modules
  EXPORT STRING50 ReferenceCode;
  EXPORT STRING20 BillingCode;
  EXPORT STRING50 QueryId;
  EXPORT STRING RealTimePermissibleUse;
  EXPORT STRING SubCustomerID;
  EXPORT STRING name_suffix;
  EXPORT STRING vin_in;
  EXPORT STRING ModelYear;
  EXPORT STRING Make;
  EXPORT STRING Model;
  EXPORT STRING LicensePlateNum;
  EXPORT STRING DataSource;
  EXPORT BOOLEAN noFail:=FALSE; // for batch services
  EXPORT BOOLEAN authenticationUsage := FALSE;
  EXPORT BOOLEAN includeDevelopedVehicles := FALSE;
  EXPORT STRING clnAddr182 := '';
END;
  
EXPORT SetInputSearchBy (iesp.motorvehicle.t_MotorVehicleSearch2By searchBy) := FUNCTION
    iesp.ECL2ESP.SetInputName (GLOBAL(searchBy).Name);
    iesp.ECL2ESP.SetInputAddress (GLOBAL(searchBy).Address);
    STRING11 ssn := TRIM(GLOBAL(searchBy).SSN);
    #STORED ('SSN', ssn);
    STRING VIN := TRIM(GLOBAL(searchBy).VIN);
    #STORED('VIN', VIN);
    INTEGER YearMake := GLOBAL(searchBy).YearMake;
    #STORED('Year', YearMake);
    STRING Make := TRIM(GLOBAL(searchBy).make);
    #STORED('Make', Make);
    STRING Model := TRIM(GLOBAL(searchBy).model);
    #STORED('Model', Model);
    STRING TagNumber := TRIM(GLOBAL(searchBy).TagNumber);
    #STORED('Tag', TagNumber);
    STRING DriverLicenseNumber := TRIM(GLOBAL(searchBy).DriverLicenseNumber);
    #STORED('DriversLicense', DriverLicenseNumber);
    STRING CompanyName := TRIM(GLOBAL(searchBy).CompanyName);
    #STORED('CompanyName', CompanyName);
    STRING TitleNumber := TRIM(GLOBAL(searchBy).TitleNumber);
    #STORED('TitleNumber', TitleNumber);
    STRING12 UniqueId := TRIM(GLOBAL(searchBy).UniqueId);
    #STORED('DID',UniqueId);
    STRING VehicleKey := TRIM(GLOBAL(searchBy).VehicleKey);
    #STORED('VehicleKey', VehicleKey);
    STRING IterationKey := TRIM(GLOBAL(searchBy).IterationKey);
    #STORED('IterationKey', IterationKey);
    STRING SequenceKey := TRIM(GLOBAL(searchBy).SequenceKey);
    #STORED('SequenceKey', SequenceKey);
    RETURN OUTPUT (DATASET ([],{INTEGER x}), NAMED('__internal__'), extend);
    END;
  
  EXPORT SetInputSearchByMVRRegistration (iesp.motorvehicleRegistration.t_MotorVehicleRegistrationSearchBy searchBy) := FUNCTION
    iesp.ECL2ESP.SetInputName (GLOBAL(searchBy).Name);
    iesp.ECL2ESP.SetInputAddress (GLOBAL(searchBy).Address);
    UNSIGNED STORED_radius := (GLOBAL(searchBy).Radius);
    #STORED ('Radius',STORED_radius);
    STRING11 ssn := TRIM(GLOBAL(searchBy).SSN);
    #STORED ('SSN', ssn);
    STRING1 genderTmp := TRIM(GLOBAL(searchBy).Gender);
    STRING1 gender := IF (gendertmp = 'A', '', genderTmp); // DEFULT IS ALL in ESP
    #STORED('Gender', gender);
    STRING VIN := TRIM(GLOBAL(searchBy).VIN);
    // this allows combined MVR search to bypass roxie error message
    // use VIN for input into regular MVR search and vinWIld for input into
    // wilcard portion of query within
    // the combined MVR search (VehicleV2_Services.VehicleRegSearchService)
    // Also do same for TagNumber below.
    #STORED('VIN', IF (LENGTH(STD.STR.Filter(VIN,'*?')) > 0,'',VIN));
    #STORED('VINWild', VIN);
    INTEGER YearMake := GLOBAL(searchBy).YearMake;
    #STORED('YearMake', YearMake);
    #STORED('Year', YearMake);
    INTEGER YearMakeMax := GLOBAL(searchBy).YearMakeMax;
    #STORED('YearMakeMax', YearMakeMax);
    INTEGER Age := GLOBAL(searchBy).Age;
    #STORED('Age', Age);
    INTEGER AgeMax := GLOBAL(searchBy).AgeMax;
    #STORED('AgeMax', AgeMax);
  
    SET of STRING xml_in_Makes := SET(searchBy.Makes, value);
    STRING Make := TRIM(GLOBAL(xml_in_makes[1]));
    STRING Make2 := TRIM(GLOBAL(xml_in_makes[2]));
    STRING Make3 := TRIM(GLOBAL(xml_in_makes[3]));
    STRING Make4 := TRIM(GLOBAL(xml_in_makes[4]));
    #STORED('Make', Make);
    #STORED('Make2', Make2);
    #STORED('Make3', Make3);
    #STORED('Make4', Make4);
    
    SET of STRING xml_in_Models := SET(searchBy.Models, value);
    STRING Model := TRIM(GLOBAL(xml_in_models[1]));
    STRING Model2 := TRIM(GLOBAL(xml_in_models[2]));
    STRING Model3 := TRIM(GLOBAL(xml_in_models[3]));
    STRING Model4 := TRIM(GLOBAL(xml_in_models[4]));
    #STORED('Model', Model);
    #STORED('Model2', Model2);
    #STORED('Model3', Model3);
    #STORED('Model4', Model4);
    
    SET of STRING30 xml_in_Colors := SET(searchBy.Colors, value);
    STRING Color := TRIM(GLOBAL(xml_in_Colors[1]));
    STRING Color2 := TRIM(GLOBAL(xml_in_Colors[2]));
    STRING Color3 := TRIM(GLOBAL(xml_in_Colors[3]));
    STRING Color4 := TRIM(GLOBAL(xml_in_Colors[4]));
    #STORED('Color', Color);
    #STORED('Color2', Color2);
    #STORED('Color3', Color3);
    #STORED('Color4', Color4);
    
    SET of STRING30 xml_in_MinorColors := SET(searchBy.MinorColors, value);
    STRING MinorColor := TRIM(GLOBAL(xml_in_MinorColors[1]));
    STRING MinorColor2 := TRIM(GLOBAL(xml_in_MinorColors[2]));
    STRING MinorColor3 := TRIM(GLOBAL(xml_in_MinorColors[3]));
    STRING MinorColor4 := TRIM(GLOBAL(xml_in_MinorColors[4]));
    #STORED('MinorColor', MinorColor);
    #STORED('MinorColor2', MinorColor2);
    #STORED('MinorColor3', MinorColor3);
    #STORED('MinorColor4', MinorColor4);
      
    STRING TagNumber := TRIM(GLOBAL(searchBy).TagNumber);
    // this allows combined MVR search to bypass roxie error message by setting 2nd
    // attr and using that in wildcard portion of query
    #STORED('Tag', IF (LENGTH(STD.STR.Filter(TagNumber,'*?')) > 0,'',
                       TagNumber));
    #STORED('TagWild', TagNumber);
    STRING DriverLicenseNumber := TRIM(GLOBAL(searchBy).DriverLicenseNumber);
    #STORED('DriversLicense', DriverLicenseNumber);
    STRING CompanyName := TRIM(GLOBAL(searchBy).CompanyName);
    #STORED('CompanyName', CompanyName);
    STRING TitleNumber := TRIM(GLOBAL(searchBy).TitleNumber);
    #STORED('TitleNumber', TitleNumber);
    STRING RegistrationStatus := TRIM(GLOBAL(searchBy).RegistrationStatus);
    #STORED('RegistrationStatus', RegistrationStatus);
    STRING12 UniqueId := TRIM(GLOBAL(searchBy).UniqueId);
    #STORED('DID',UniqueId);
    RETURN OUTPUT (DATASET ([],{INTEGER x}), NAMED('__internal__'), extend);
  END;
  
  EXPORT SetInputSearchOptions (iesp.motorvehicle.t_MotorVehicleSearch2Option options) := FUNCTION
    BOOLEAN UseNicknames := GLOBAL(options).UseNicknames; // must be provided: 'TRUE'
    #STORED ('allownicknames', UseNicknames);
    BOOLEAN IncludeAlsoFound := GLOBAL(options).IncludeAlsoFound; //def=FALSE
    #STORED ('nodeepdive', ~IncludeAlsoFound);
    BOOLEAN UsePhonetics := GLOBAL(options).UsePhonetics; //def=FALSE
    #STORED ('phoneticmatch', UsePhonetics);
    BOOLEAN UseTagBlur := GLOBAL(options).UseTagBlur; //def=FALSE
    #STORED ('UseTagBlur', UseTagBlur);
    BOOLEAN StrictMatch := GLOBAL(options).StrictMatch; //def=FALSE
    #STORED ('StrictMatch', StrictMatch);
    iesp.ECL2ESP.Marshall.Mac_Set(options);
    STRING DataSource := IF(GLOBAL(options).DataSource='',VehicleV2_Services.Constant.LOCAL_VAL,GLOBAL(options).DataSource);
    #STORED('DataSource', DataSource);
    STRING RealTimePermissibleUse := GLOBAL(options).RealTimePermissibleUse;
    #STORED('RealTimePermissibleUse', RealTimePermissibleUse);
    BOOLEAN doCombined := GLOBAL(options).doCombined;
    #STORED('doCombined', doCombined);

    BOOLEAN insuranceUsage := GLOBAL(options).insuranceUsage;
    #STORED('insuranceUsage', insuranceUsage);
    BOOLEAN authenticationUsage := GLOBAL(options).authenticationUsage;
    #STORED('authenticationUsage', authenticationUsage);
    BOOLEAN includeDevelopedVehicles := GLOBAL(options).includeDevelopedVehicles;
    #STORED('includeDevelopedVehicles', includeDevelopedVehicles);
    BOOLEAN includeCriminalIndicators := GLOBAL(options).includeCriminalIndicators;
    #STORED('includeCriminalIndicators', includeCriminalIndicators);
    
    BOOLEAN IncludeNonRegulatedVehicleSources := GLOBAL(options).IncludeNonRegulatedVehicleSources;
    #STORED('IncludeNonRegulatedVehicleSources', IncludeNonRegulatedVehicleSources);
    
    BOOLEAN multiFamilyDwelling := GLOBAL(options).MultiFamilyDwelling;
    #STORED('MultiFamilyDwelling', multiFamilyDwelling);
    INTEGER registrationType := GLOBAL(options).RegistrationType;
    #STORED('RegistrationType', registrationType);

    RETURN OUTPUT (DATASET ([],{INTEGER x}), NAMED('__internal__'), extend);
  END;
  
  
  EXPORT SetInputSearchOptionsMVRRegistration (iesp.motorvehicleRegistration.t_MotorVehicleRegistrationOption options) := FUNCTION
    BOOLEAN UseNicknames := GLOBAL(options).UseNicknames; // must be provided: 'TRUE'
    #STORED ('allownicknames', UseNicknames);
    BOOLEAN IncludeAlsoFound := GLOBAL(options).IncludeAlsoFound; //def=FALSE
    #STORED ('nodeepdive', ~IncludeAlsoFound);
    BOOLEAN UsePhonetics := GLOBAL(options).UsePhonetics; //def=FALSE
    #STORED ('phoneticmatch', UsePhonetics);
    BOOLEAN UseTagBlur := GLOBAL(options).UseTagBlur; //def=FALSE
    #STORED ('UseTagBlur', UseTagBlur);
    iesp.ECL2ESP.Marshall.Mac_Set(options);
    STRING DataSource := IF(GLOBAL(options).DataSource='',VehicleV2_Services.Constant.LOCAL_VAL,GLOBAL(options).DataSource);
    #STORED('DataSource', DataSource);
    STRING RealTimePermissibleUse := GLOBAL(options).RealTimePermissibleUse;
    #STORED('RealTimePermissibleUse', RealTimePermissibleUse);
    BOOLEAN doCombined := GLOBAL(options).DoCombined;
    #STORED('doCombined', doCombined);

    BOOLEAN insuranceUsage := GLOBAL(options).InsuranceUsage;
    #STORED('insuranceUsage', insuranceUsage);
    BOOLEAN includeCriminalIndicators := GLOBAL(options).IncludeCriminalIndicators;
    #STORED('includeCriminalIndicators', includeCriminalIndicators);
    
    BOOLEAN IncludeNonRegulatedVehicleSources := GLOBAL(options).IncludeNonRegulatedVehicleSources;
    #STORED('IncludeNonRegulatedVehicleSources', IncludeNonRegulatedVehicleSources);
    UNSIGNED maxresults := GLOBAL(options).MaxResults;
    #STORED('MaxResults', IF (MaxResults = 0, 1000, MaxResults));
    RETURN OUTPUT (DATASET ([],{INTEGER x}), NAMED('__internal__'), extend);
  END;
  
  EXPORT SetInputReportBy (iesp.motorvehicle.t_MotorVehicleReport2By reportBy) := FUNCTION
    STRING VIN := TRIM(GLOBAL(reportBy).VIN);
    #STORED('VIN', VIN);
    STRING12 UniqueId := TRIM(GLOBAL(reportBy).UniqueId);
    #STORED('DID',UniqueId);
    STRING BusinessId := TRIM(GLOBAL(reportBy).BusinessId);
    #STORED('BDID', BusinessId);
    STRING VehicleRecordId := TRIM(GLOBAL(reportBy).VehicleRecordId);
    STRING VehicleNumber := TRIM(GLOBAL(reportBy).VehicleNumber);
    STRING VehicleKey := IF(VehicleRecordId = '', VehicleNumber, VehicleRecordId);
    #STORED('VehicleKey', VehicleKey);
    STRING IterationKey := TRIM(GLOBAL(reportBy).IterationKey);
    #STORED('IterationKey', IterationKey);
    STRING SequenceKey := TRIM(GLOBAL(reportBy).SequenceKey);
    #STORED('SequenceKey', SequenceKey);
    STRING DataSource := IF(GLOBAL(reportBy).DataSource='',VehicleV2_Services.Constant.LOCAL_VAL,GLOBAL(reportBy).DataSource);
    #STORED('DataSource', DataSource);
    
    RETURN OUTPUT (DATASET ([],{INTEGER x}), NAMED('__internal__'), extend);
  END;
  
  
  EXPORT SetInputReportOptions (iesp.motorvehicle.t_MotorVehicleReport2Option options) := FUNCTION
    BOOLEAN IncludeNonRegulatedVehicleSources := GLOBAL(options).IncludeNonRegulatedVehicleSources;
    #STORED('IncludeNonRegulatedVehicleSources', IncludeNonRegulatedVehicleSources);
    
    RETURN OUTPUT (DATASET ([],{INTEGER x}), NAMED('__internal__'), extend);
  END;
  
  EXPORT getSearchModule(BOOLEAN MVRcombinedQuery=FALSE) := FUNCTION
    input_params := AutoStandardI.GlobalModule();
    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
    
    search_mod:= MODULE(PROJECT (input_params, searchParams, OPT)) //OPT: mostly, FetchI_Hdr_Biz.full fields
      doxie.compliance.MAC_CopyModAccessValues(mod_access);

      EXPORT STRING50 ReferenceCode := '' : STORED('ReferenceCode');
      EXPORT STRING20 BillingCode := '' : STORED('BillingCode');
      EXPORT STRING50 QueryId := '' : STORED('QueryId');
      EXPORT STRING RealTimePermissibleUse := '' : STORED('RealTimePermissibleUse');
      EXPORT STRING SubCustomerID:='' :STORED('SubCustomerID');
      STRING year := '' : STORED('YEAR');
      EXPORT STRING ModelYear:= IF (year = '0', '', year);
      STRING _make := '' : STORED('Make');
      EXPORT STRING Make := STD.STR.ToUpperCase(TRIM(_make, LEFT, RIGHT));
      STRING _model := '' : STORED('Model');
      EXPORT STRING Model := STD.STR.ToUpperCase(TRIM(_model, LEFT, RIGHT));
      EXPORT STRING LicensePlateNum := AutoStandardI.InterfaceTranslator.tag_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.tag_value.params));
      EXPORT STRING vin_in := AutoStandardI.InterfaceTranslator.vin_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.vin_value.params));
      EXPORT STRING name_suffix := input_params.namesuffix;
      EXPORT STRING DataSource := '' : STORED('DataSource');
      EXPORT BOOLEAN doCombinedSearch := FALSE : STORED('doCombined');
      EXPORT STRING30 vehicleKey := '' : STORED('VehicleKey');
      EXPORT STRING15 iterationKey := '' : STORED('IterationKey');
      EXPORT STRING15 sequenceKey := '' : STORED('SequenceKey');
      EXPORT STRING20 titleNumber := '' : STORED('TitleNumber');
      EXPORT STRING titleIssueDate := '' : STORED('TitleIssueDate');
      EXPORT STRING previousTitleIssueDate := '' : STORED('PreviousTitleIssueDate');
      EXPORT UNSIGNED2 penalty_threshold := VehicleV2_Services.Constant.VEHICLE_PENALT_THRESHOLD : STORED('PenaltThreshold');
      EXPORT BOOLEAN excludeLessors := AutoStandardI.InterfaceTranslator.Exclude_Lessors.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.Exclude_Lessors.params));
      EXPORT BOOLEAN displayMatchedParty := AutoStandardI.InterfaceTranslator.DisplayMatchedParty_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.DisplayMatchedParty_value.params));
      // translate 4 "standard" library fields here, since we will use them in places other than standard search
      EXPORT STRING2 state := AutoStandardI.InterfaceTranslator.state_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.state_value.params));
      EXPORT STRING30 county := AutoStandardI.InterfaceTranslator.county_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.county_value.params));
      EXPORT STRING30 firstname := AutoStandardI.InterfaceTranslator.fname_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.fname_value.params));
      EXPORT STRING30 lastname := AutoStandardI.InterfaceTranslator.lname_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.lname_value.params));
      EXPORT UNSIGNED8 maxresultsVal := AutoStandardI.InterfaceTranslator.MaxResults_val.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.MaxResults_val.params));
      EXPORT UNSIGNED8 maxresultsthistimeVal := AutoStandardI.InterfaceTranslator.MaxResultsThisTime_val.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.MaxResultsThisTime_val.params));
      EXPORT UNSIGNED8 skiprecordsVal := AutoStandardI.InterfaceTranslator.SkipRecords_val.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.SkipRecords_val.params));
      EXPORT STRING dlValue := AutoStandardI.InterfaceTranslator.dl_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.dl_value.params));
      EXPORT STRING14 didValue := AutoStandardI.InterfaceTranslator.did_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.did_value.params));
      EXPORT UNSIGNED6 bdidValue := AutoStandardI.InterfaceTranslator.bdid_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.bdid_value.params));
      EXPORT UNSIGNED4 lookupValue := AutoStandardI.InterfaceTranslator.lookup_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.lookup_value.params));
      EXPORT BOOLEAN isDeepDive := ~AutoStandardI.InterfaceTranslator.nodeepdive.val(PROJECT(input_params, AutoStandardI.InterfaceTranslator.nodeepdive.params));
      EXPORT STRING120 company := AutoStandardI.InterfaceTranslator.comp_name_value.val(PROJECT(input_params, AutoStandardI.InterfaceTranslator.comp_name_value.params));
      EXPORT STRING11 ssn := AutoStandardI.InterfaceTranslator.ssn_value.val(PROJECT(input_params, AutoStandardI.InterfaceTranslator.ssn_value.params));
      EXPORT STRING25 city := AutoStandardI.InterfaceTranslator.city_val.val(PROJECT(input_params, AutoStandardI.InterfaceTranslator.city_val.params));
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
      EXPORT STRING50 ReferenceCode := '' : STORED('ReferenceCode');
      EXPORT STRING20 BillingCode := '' : STORED('BillingCode');
      EXPORT STRING50 QueryId := '' : STORED('QueryId');
      EXPORT STRING RealTimePermissibleUse := '' : STORED('RealTimePermissibleUse');
      EXPORT STRING SubCustomerID:='' :STORED('SubCustomerID');
      STRING year := '' : STORED('YEAR');
      EXPORT STRING ModelYear:= IF (year = '0', '', year);
      EXPORT STRING Make:='' : STORED('Make');
      EXPORT STRING Model:='' : STORED('Model');
      EXPORT STRING LicensePlateNum := AutoStandardI.InterfaceTranslator.tag_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.tag_value.params));
      EXPORT STRING vin_in := AutoStandardI.InterfaceTranslator.vin_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.vin_value.params));
      EXPORT STRING name_suffix := input_params.namesuffix;
      EXPORT STRING DataSource := '' : STORED('DataSource');
      EXPORT BOOLEAN doCombinedSearch := FALSE : STORED('doCombined');
      EXPORT STRING30 vehicleKey := '' : STORED('VehicleKey');
      EXPORT STRING15 iterationKey := '' : STORED('IterationKey');
      EXPORT STRING15 sequenceKey := '' : STORED('SequenceKey');
      EXPORT STRING20 titleNumber := '' : STORED('TitleNumber');
      EXPORT STRING titleIssueDate := '' : STORED('TitleIssueDate');
      EXPORT STRING previousTitleIssueDate := '' : STORED('PreviousTitleIssueDate');
      EXPORT UNSIGNED2 penalty_threshold := VehicleV2_Services.Constant.VEHICLE_PENALT_THRESHOLD : STORED('PenaltThreshold');
      EXPORT BOOLEAN excludeLessors := AutoStandardI.InterfaceTranslator.Exclude_Lessors.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.Exclude_Lessors.params));
      EXPORT BOOLEAN displayMatchedParty := AutoStandardI.InterfaceTranslator.DisplayMatchedParty_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.DisplayMatchedParty_value.params));
      // translate 3 "standard" library fields here, since we will use them in places other than standard search
      EXPORT UNSIGNED8 maxresultsVal := AutoStandardI.InterfaceTranslator.MaxResults_val.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.MaxResults_val.params));
      EXPORT UNSIGNED8 maxresultsthistimeVal := AutoStandardI.InterfaceTranslator.MaxResultsThisTime_val.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.MaxResultsThisTime_val.params));
      EXPORT UNSIGNED8 skiprecordsVal := AutoStandardI.InterfaceTranslator.SkipRecords_val.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.SkipRecords_val.params));
      EXPORT STRING dlValue := AutoStandardI.InterfaceTranslator.dl_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.dl_value.params));
      EXPORT STRING14 didValue := AutoStandardI.InterfaceTranslator.did_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.did_value.params));
      EXPORT UNSIGNED6 bdidValue := AutoStandardI.InterfaceTranslator.bdid_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.bdid_value.params));
      EXPORT UNSIGNED4 lookupValue := AutoStandardI.InterfaceTranslator.lookup_value.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.lookup_value.params));
      EXPORT BOOLEAN isDeepDive := ~AutoStandardI.InterfaceTranslator.nodeepdive.val(PROJECT(input_params, AutoStandardI.InterfaceTranslator.nodeepdive.params));
      EXPORT STRING120 company := AutoStandardI.InterfaceTranslator.comp_name_value.val(PROJECT(input_params, AutoStandardI.InterfaceTranslator.comp_name_value.params));
    
      EXPORT BOOLEAN insuranceUsage := FALSE : STORED('insuranceUsage');
      EXPORT BOOLEAN authenticationUsage := FALSE : STORED('authenticationUsage');
      EXPORT BOOLEAN includeDevelopedVehicles := FALSE : STORED('includeDevelopedVehicles');
      EXPORT BOOLEAN includeCriminalIndicators := FALSE : STORED('includeCriminalIndicators');
      EXPORT firstname := input_params.entity2_firstname;
      EXPORT middlename := input_params.entity2_middlename;
      EXPORT lastname := input_params.entity2_lastname;
      EXPORT unparsedfullname := input_params.entity2_unparsedfullname;
      EXPORT allownicknames := input_params.entity2_allownicknames;
      EXPORT phoneticmatch := input_params.entity2_phoneticmatch;
      EXPORT companyname := input_params.entity2_companyname;
      EXPORT addr := input_params.entity2_addr;
      EXPORT city := input_params.entity2_city;
      EXPORT state := input_params.entity2_state;
      EXPORT zip := input_params.entity2_zip;
      EXPORT zipradius := input_params.entity2_zipradius;
      EXPORT phone := input_params.entity2_phone;
      EXPORT fein := input_params.entity2_fein;
      EXPORT bdid := input_params.entity2_bdid;
      EXPORT did := input_params.entity2_did;
      EXPORT ssn := input_params.entity2_ssn;
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
      EXPORT STRING vin_in := AutoStandardI.InterfaceTranslator.vin_value.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.vin_value.params));
      EXPORT STRING DataSource := '' : STORED('DataSource');
      EXPORT STRING30 vehicleKey := '' : STORED('VehicleKey');
      EXPORT STRING15 iterationKey := '' : STORED('IterationKey');
      EXPORT STRING15 sequenceKey := '' : STORED('SequenceKey');
      EXPORT STRING titleIssueDate := '' : STORED('TitleIssueDate');
      EXPORT STRING previousTitleIssueDate := '' : STORED('PreviousTitleIssueDate');
      EXPORT STRING14 didValue := AutoStandardI.InterfaceTranslator.did_value.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.did_value.params));
      EXPORT UNSIGNED6 bdidValue := AutoStandardI.InterfaceTranslator.bdid_value.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.bdid_value.params));
      EXPORT UNSIGNED4 lookupValue := AutoStandardI.InterfaceTranslator.lookup_value.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.lookup_value.params));
      EXPORT BOOLEAN IncludeNonRegulatedSources := FALSE : STORED('IncludeNonRegulatedVehicleSources');
      EXPORT BOOLEAN displayMatchedParty := gm.displayMatchedParty;
      EXPORT UNSIGNED2 penalty_threshold := gm.penalty_threshold;
      EXPORT BOOLEAN excludeLessors := gm.excludelessors;
    END;
      
    RETURN in_mod;
  END;

  EXPORT VehicleBatch_params := INTERFACE
    EXPORT BOOLEAN penalize_by_party := FALSE;
    EXPORT BOOLEAN Is_UseDate := FALSE;
    EXPORT BOOLEAN ReturnCurrent := FALSE;
    EXPORT BOOLEAN FullNameMatch := FALSE;
  END;
  
  // just a few compliance fields are needed, so not inheriting from IDataAccess
  EXPORT RTBatch_V2_params := INTERFACE(VehicleBatch_params)
    EXPORT UNSIGNED1 Operation := 0;
    EXPORT BOOLEAN use_date := FALSE;
    EXPORT BOOLEAN select_years := FALSE;
    EXPORT UNSIGNED years := 0;
    EXPORT BOOLEAN include_ssn := FALSE;
    EXPORT BOOLEAN include_dob := FALSE;
    EXPORT BOOLEAN include_addr := FALSE;
    EXPORT BOOLEAN include_phone := FALSE;
    EXPORT STRING120 append_l := '';
    EXPORT STRING120 verIFy_l := '';
    EXPORT STRING120 fuzzy_l := '';
    EXPORT BOOLEAN DEDUP_results_l := TRUE;
    EXPORT STRING3 thresh_val := '';
    EXPORT UNSIGNED1 glb := 8;
    EXPORT BOOLEAN patriotproc := FALSE;
    EXPORT BOOLEAN show_minors := FALSE;
    EXPORT BOOLEAN GatewayNameMatch := FALSE;
    EXPORT BOOLEAN AlwaysHitGateway := FALSE;
    EXPORT STRING32 application_type := '';
    EXPORT STRING5 industry_class := '';
    EXPORT STRING DataRestrictionMask := BatchShare.Constants.Defaults.DataRestrictionMask;
    EXPORT BOOLEAN IncludeRanking := FALSE;
    EXPORT UNSIGNED1 dppa := 0;
    EXPORT BOOLEAN GetSSNBest := FALSE;
    EXPORT STRING1 BIPFetchLevel := '';
  END;
  
  
END;
