IMPORT doxie, STD;

doxie.MAC_Header_Field_Declare()

EXPORT input := MODULE

  // DL Keys
  EXPORT UNSIGNED6 dl_seq := 0 : STORED('DLSeq');
  EXPORT UNSIGNED6 did := (UNSIGNED6)did_value;
  EXPORT QSTRING24 dl_num := (QSTRING24)dl_value;
  
  // DL Indicatives
  EXPORT BOOLEAN randomize := FALSE : STORED('Randomize');
  EXPORT UNSIGNED1 agelow := agelow_val;
  EXPORT UNSIGNED1 agehigh := agehigh_val;
  EXPORT STRING1 race := race_value;
  EXPORT STRING1 gender := STD.STR.ToUpperCase(gender_value);
  EXPORT UNSIGNED maxResults := maxResults_val;
  
  //XML Direct
  SHARED STRING1 needToUpperIncludeHistory := 'A' : STORED('IncludeHistory');
  EXPORT STRING1 IncludeHistory := STD.STR.ToUpperCase(needToUpperIncludeHistory);
  SHARED STRING needToUpperDLState := '' :STORED('DLState');
  EXPORT STRING DLState := STD.STR.ToUpperCase(needToUpperDLState);

  
  // DL Tuning
  EXPORT UNSIGNED2 pThresh := 10 : STORED('PenaltThreshold');
  EXPORT BOOLEAN incDeepDive := NOT noDeepDive;

  // Filtering
  EXPORT STRING state := state_value;
  EXPORT STRING county := county_value;
  
  // Privacy
  EXPORT STRING6 ssn_mask := ssn_mask_value;
  EXPORT BOOLEAN dl_mask := dl_mask_value;
  EXPORT UNSIGNED1 edobmask := dob_mask_value;
  EXPORT UNSIGNED1 dppa_purpose := GLOBAL(DPPA_Purpose);
  EXPORT UNSIGNED1 glb_purpose := GLOBAL(GLB_Purpose);
  
  // Breadth
  SHARED BOOLEAN iEverything := FALSE : STORED('IncludeEverything');
  SHARED BOOLEAN iAccidents := FALSE : STORED('IncludeAccidents');
  SHARED BOOLEAN iConvictions := FALSE : STORED('IncludeConvictions');
  SHARED BOOLEAN iDRInfo := FALSE : STORED('IncludeDRInfo');
  SHARED BOOLEAN iFRAInsurance := FALSE : STORED('IncludeFRAInsurance');
  SHARED BOOLEAN iSuspensions := FALSE : STORED('IncludeSuspensions');
  EXPORT BOOLEAN incAccidents := iEverything OR iAccidents;
  EXPORT BOOLEAN incConvictions := iEverything OR iConvictions;
  EXPORT BOOLEAN incDRInfo := iEverything OR iDRInfo;
  EXPORT BOOLEAN incFRAInsurance := iEverything OR iFRAInsurance;
  EXPORT BOOLEAN incSuspensions := iEverything OR iSuspensions;
  EXPORT BOOLEAN incNonDMV := FALSE : STORED('IncludeNonDMVSources');

END;
