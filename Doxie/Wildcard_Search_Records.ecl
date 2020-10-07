import ut, vehicle_wildcard, doxie;

vehicle_wildcard.MAC_Field_Declare();

// not a standard call to a macro reading input, so I have to reassign few fields
mod_access := MODULE(doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule()))
  EXPORT unsigned1 dppa := DPPA_Purpose;
  EXPORT string DataRestrictionMask := ^.DataRestrictionMask;
  EXPORT boolean ln_branded := ln_branded_value;
  EXPORT string ssn_mask := ssn_mask_value;
  EXPORT unsigned1 dl_mask := IF(dl_mask_value, 1, 0);
END;


sif :=
RECORD
  STRING Tag := ut.mod_WildSimplify.do(tag_value);
  STRING VIN := ut.mod_WildSimplify.do(vin_value);
  boolean containsSearch := containsSearch;
  SET OF STRING zip := zips;
  STRING city := city_val;
  STRING state := state_val;
  SET OF STRING make := _make;
  SET OF STRING MajorColor := _majorColor;
  SET OF STRING MinorColor := _minorColor;
  SET OF STRING Model := _model;
  SET OF STRING Body := _body;
  STRING Sex := _sex;
  STRING FilterLimit := _filterLimit;
  STRING ModelYearStart := _modelYearStart;
  STRING ModelYearEnd := _modelYearEnd;
  STRING AgeLow := _ageRangeStart;
  STRING AgeHigh := _ageRangeEnd;
  STRING FirstName := fname_val;
  STRING LastName := lname_val;
  STRING MiddleName := mname_val;
  STRING RegisterState := regState;
  INTEGER MaxResults := MaxResults_val;
  INTEGER MaxResultsThisTime := MaxResultsThisTime_val;
  INTEGER SkipRecords := SkipRecords_val;
  unsigned1 DPPAPurpose := DPPA_Purpose;
  boolean Raw := raw_records;
  boolean IsANeighbor := true;
  STRING SSNMask := ssn_mask_val;
  unsigned1 DLMask := dl_mask_val;
  unsigned1 RegistrationType := tline_use;
  unsigned1 RecordStatus := tline_use;
  string Zip5 := zip5_value;
  unsigned1 ZipRadius := zipradius_value;
  boolean IncludeDetailedRegistrationType := incDetailedReg;
END;

FN := vehicle_wildcard.functions;
zipCodes   := FN.getZips(zip5_value,zipradius_value,county_value,city_value,state_value,zips_in) : STORED('zip_use');
stateCodes := FN.getStates(zipradius_value,city_value,state_value,zipCodes) : STORED('state_use');
makeCodes  := FN.getMakes(_make)   : STORED('make_use');
modelCodes := FN.getModels(_model) : STORED('model_use');
bodyCodes  := FN.getBodys(_body)   : STORED('body_use');
majorColorCodes := FN.getColors(_majorColor): STORED('majorColor_use');

tmpMod := MODULE(Vehicle_Wildcard.IParam.wildcardParams)
  doxie.compliance.MAC_CopyModAccessValues(mod_access);
  EXPORT STRING            LicensePlateNum := ^.tag_value;
  EXPORT STRING            Vin_in := ^.vin_value;
  EXPORT STRING6           Zip := ^.zip5_value;
  EXPORT BOOLEAN           UseTagBlur := ^.UseTagBlur;
  EXPORT BOOLEAN           containsSearch := ^.containsSearch;
  EXPORT INTEGER           currentYear := ^.currentYear;
  EXPORT INTEGER           ageRangeStart := ^.ageRangeStart_use;
  EXPORT INTEGER           ageRangeEnd := ^.ageRangeEnd_use;
  EXPORT INTEGER           modelYearStart := ^.modelYearStart_use;
  EXPORT INTEGER           modelYearEnd := ^.modelYearEnd_use;
  EXPORT STRING1           gender := ^.sex_use;
  EXPORT STRING30          County := ^.county_value;
  EXPORT STRING2           State := ^.state_value;
  EXPORT SET OF UNSIGNED1  stateCodes := ^.stateCodes;
  EXPORT STRING2           regState := ^.regState;
  EXPORT UNSIGNED1         regStateCode := ^.regState_use;
  EXPORT SET OF STRING4    Makes := ^._make;
  EXPORT SET OF UNSIGNED2  makeCodes := ^.makeCodes;
  EXPORT SET OF UNSIGNED3  zipCodes := ^.zipCodes;
  EXPORT SET OF STRING36   Models := ^._model;
  EXPORT SET OF UNSIGNED2  modelCodes := ^.modelCodes;
  EXPORT SET OF STRING36   Bodys := ^._body;
  EXPORT SET OF UNSIGNED2  bodyCodes := ^.bodyCodes;
  EXPORT SET OF STRING3    majorColors := ^._majorColor;
  EXPORT SET OF UNSIGNED1  majorColorCodes := ^.majorColorCodes;
  EXPORT UNSIGNED8         MaxResultsVal := ^.MaxResults_val;
  EXPORT STRING30          FirstName := ^.fname_val;
  EXPORT STRING30          MiddleName := ^.mname_val;
  EXPORT STRING30          LastName := ^.lname_val;
  EXPORT UNSIGNED1         RegistrationType := ^.tline_use;
  EXPORT SET OF STRING1    RegistrationTypeAllow := ^.tline_allow;
  EXPORT BOOLEAN           IncludeCriminalIndicators := ^.IncludeCriminalIndicators;
  EXPORT BOOLEAN           IncludeNonRegulatedSources := ^.IncludeNonRegulatedVehicleSources;
END;

doxie.MAC_LocalRemoteCombo(sif, doxie.Wildcard_Search_Local(tmpMod,noFail),
            'doxie.wildcard_search', _neighbor_service_ip,
            doxie.Layout_VehicleSearch_wCrimInd, VID != '',
            'Wildcard_Errors', results_out)

export Wildcard_Search_Records := results_out;
