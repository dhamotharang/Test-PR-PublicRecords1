/*--SOAP--
<message name="TextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
	<part name="ApplicationType" type="xsd:string"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt */
/*--INFO-- SANCTN Text Search. */

EXPORT TextSearchService := MACRO

import Text_Search, ut, doxie, SANCTN;

// boolean-specific parameters
string srchString := '' : STORED('Search');

// general-use parameters
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

// boolean search
STRING stem		:= SANCTN_Services.Constants.stem;
STRING srcType:= SANCTN_Services.Constants.srcType;
STRING qual		:= SANCTN_Services.Constants.qual;
info := Text_Search.FileName_Info_Instance (stem, srcType, qual);

s := Text_Search.Text_Search_Module (info, srchString,false,,, MaxResults_val);

ans := s.answers;
errCode := s.error_code;
errMsg := s.error_msg;

boolean Err := errCode != 0;
IF (Err, ut.outputMessage (errCode, errMsg));

ids := JOIN (ans, SANCTN.Key_SANCTN_Map,
             keyed (Left.docref.doc = Right.doc),
             transform (SANCTN_services.layouts.id, SELF := Right),
             LIMIT (ut.limits.default, SKIP));

// fetch search records
rpen := SANCTN_services.raw.search_view.by_id (ids,'',appType);

rpen_sorted := SORT (rpen, -incident_date_clean);

doxie.MAC_Marshall_Results_NoCount (rpen_sorted, paged_results, , outputCount);

if(~Err, outputCount);
IF(~Err, OUTPUT(paged_results, NAMED('Results')));

ENDMACRO;