// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
EXPORT BatchService() := MACRO
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#constant('StrictMatch', true)
	UNSIGNED2 MaxResultsPerAcct := 10 : STORED('MaxResultsPerAcct');
	BOOLEAN   EnableExtraAccidents := false : STORED('EnableExtraAccidents');

	data_in := DATASET([], NationalAccident_Services.Layouts.inBatchNationalAccident) : STORED('batch_in', FEW);

	res := NationalAccident_Services.BatchService_Records(data_in,MaxResultsPerAcct,EnableExtraAccidents);
	OUTPUT(res, NAMED('Results'), ALL);

ENDMACRO;
