// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- FAP StateWide Service.
IF Jurisdiction not specified,
Returns Results from all the available Jurisdiction.
*/
import AutoStandardI, FAP_StateWide, Doxie;

EXPORT FAP_SearchService := MACRO
#CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#onwarning(4207, ignore);

#OPTION ('optimizeProjects', FALSE);
#CONSTANT('UsingKeepSSNs',TRUE);
#STORED('PenaltThreshold', 10);

	unsigned8	MaxResults_val					:= 2000		: stored('MaxResults');
	unsigned8	MaxResultsThisTime_val	:= 2000		: stored('MaxResultsThisTime');
	unsigned8	SkipRecords_val					:= 0			: stored('SkipRecords');
	unsigned2  pt	:= AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));

out_set := MODULE(Statewide_Services.layout_FAB_FAP_out.output_set)END;

OP := FAP_StateWide.FAPSearchService_ids(out_set).search_result()(penalt<= pt or isDeepDive);
doxie.MAC_Marshall_Results(OP,result);
OUTPUT(result,NAMED('Results'));

ENDMACRO;
