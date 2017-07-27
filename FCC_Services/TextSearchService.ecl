/*--SOAP--
<message name="TextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
	<part name="ApplicationType"     	type="xsd:string"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt */
/*--INFO-- FCC Text Search. */

EXPORT TextSearchService := MACRO

import Text_Search, ut, doxie, FCC, FCC_Services,AutoStandardI;

// boolean-specific parameters
string srchString := '' : STORED('Search');
// general-use parameters
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

// boolean search
info := Text_Search.FileName_Info_Instance 
  (FCC_Services.Constants.stem, FCC_Services.Constants.srcType, FCC_Services.Constants.qual);

s := Text_Search.Text_Search_Module (info, srchString,false,,, MaxResults_val);
ans := s.answers;
errCode := s.error_code;
errMsg := s.error_msg;

boolean Err := errCode != 0;
IF (Err, ut.outputMessage (errCode, errMsg));

// paging moved to the end: raw method may reduce number of records returned back (see ROLLING AND CA AND BARKER, for example)

fcc_ids := PROJECT (ans, TRANSFORM (FCC_Services.Layouts.id, SELF.fcc_seq := LEFT.docref.doc));
rpen := FCC_Services.raw.search_view.by_id (fcc_ids,appType);

// choose "best" records
rpen_sorted := SORT(rpen, licensees_name, licensees_attention_line, date_license_issued, RECORD);

// Show first page (output sequence number is appended)
doxie.MAC_Marshall_Results_NoCount (rpen_sorted, res, , outputCount);


if(~Err, outputCount);
IF(~Err, OUTPUT (res, NAMED('Results')));
//IF(~Err, OUTPUT (ans, NAMED ('ans'))); // debug info

ENDMACRO;