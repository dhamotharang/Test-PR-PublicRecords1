// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- This service searches the header file (Autonomy-style fed-ex search).*/
export RightAddressService := MACRO

  #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #stored ('ScoreThreshold', UPS_Services.Constants.SCORE_THRESHOLD);
  #constant('AllowWildcard',true);
  #constant('isCP_V2',true);
  resp := UPS_Services.RightAddress().soap_response;
  output (resp, named(doxie.strResultsName));

ENDMACRO;
