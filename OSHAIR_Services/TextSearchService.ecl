/*--SOAP--
<message name="TextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt */
/*--INFO-- OSHAIR Text Search. */

EXPORT TextSearchService := MACRO

import Text_Search, ut, doxie, OSHAIR;

// boolean-specific parameters
string srchString := '' : STORED('Search');

// general-use parameters
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');

// boolean search
STRING stem		:= OSHAIR_Services.Constants.stem;
STRING srcType:= OSHAIR_Services.Constants.srcType;
STRING qual		:= OSHAIR_Services.Constants.qual;
info := Text_Search.FileName_Info_Instance (stem, srcType, qual);

s := Text_Search.Text_Search_Module (info, srchString,false,,, MaxResults_val);

ans := s.answers;
errCode := s.error_code;
errMsg := s.error_msg;

boolean Err := errCode != 0;
IF (Err, ut.outputMessage (errCode, errMsg));

ids := PROJECT (ans, transform (OSHAIR_services.layouts.id, SELF.activity_number := Left.docref.doc));

rpen := OSHAIR_Services.raw.search_view.by_id (ids);

rpen_sorted := SORT (rpen, -Last_Activity_Date);

doxie.MAC_Marshall_Results_NoCount (rpen_sorted, paged_results, , outputCount);

if(~Err, outputCount);
IF(~Err, OUTPUT(paged_results, NAMED('Results')));

ENDMACRO;
