// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT Text_Search, doxie, AutostandardI, WSInput;

EXPORT WatercraftSearchService := MACRO
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

  #CONSTANT('SearchGoodSSNOnly',TRUE)
  #CONSTANT('SearchIgnoresAddressOnly',TRUE)
  #CONSTANT('getBdidsbyExecutive',FALSE)

 WSInput.MAC_WatercraftSearchService();

  doxie.MAC_Header_Field_Declare ();
  gm := AutoStandardI.GlobalModule();

  params := MODULE(PROJECT(gm, WatercraftV2_Services.Interfaces.search_params, opt))
    STRING2 st_pass := '' : STORED('state');
    EXPORT STRING2 st := STD.STR.ToUpperCase(st_pass);
    EXPORT UNSIGNED2 pt := 10 : STORED('PenaltThreshold');
    EXPORT STRING30 wk := '' : STORED('WatercraftKey');
    STRING30 h_num := '' : STORED('HullNumber');
    EXPORT STRING30 hull_num := STD.STR.ToUpperCase (h_num);
    EXPORT STRING32 seqk := '' : STORED('sequenceKey');
    STRING50 v_name := '' : STORED('VesselName');
    EXPORT STRING50 vesl_nam := STD.STR.ToUpperCase(v_name);
    EXPORT UNSIGNED2 min_vesl_len := 0 : STORED('MinVesselLength');
    EXPORT UNSIGNED2 max_vesl_len := 0 : STORED('MaxVesselLength');
    EXPORT STRING6 ssn_mask := ssn_mask_val;
    EXPORT STRING14 DID := '' :STORED('DID');
    EXPORT STRING BDID := '' :STORED('BDID');
    EXPORT BOOLEAN include_non_regulated_sources := FALSE : STORED('IncludeNonRegulatedWatercraftSources');
  END;
  rsrt_stmts := WatercraftV2_services.WatercraftSearch(params);
  rsrt1 := rsrt_stmts.Records;
  Text_Search.MAC_Append_ExternalKey(rsrt1, rsrt2, l.watercraft_key + l.sequence_key + l.state_origin);
  doxie.MAC_Marshall_Results(rsrt2,rmar);
  OUTPUT(rmar, NAMED('Results'));

ENDMACRO;
