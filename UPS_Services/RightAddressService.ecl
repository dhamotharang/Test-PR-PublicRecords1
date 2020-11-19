// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- This service searches the header file (Autonomy-style UPS search).*/

EXPORT RightAddressService := MACRO
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #STORED ('ScoreThreshold', UPS_Services.Constants.SCORE_THRESHOLD);
  #CONSTANT('AllowWildcard',TRUE);
  #CONSTANT('isCP_V2',TRUE);
  resp := UPS_Services.RightAddress().soap_response;

  OUTPUT (resp, NAMED(doxie.strResultsName));

ENDMACRO;
