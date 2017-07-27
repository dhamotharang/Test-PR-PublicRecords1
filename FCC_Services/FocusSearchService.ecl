/*--SOAP--
<message name="FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
	<part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
	<part name="ApplicationType"     	type="xsd:string"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt */
/*--INFO-- FCC Text Search. */

EXPORT FocusSearchService := MACRO

import Text_Search, ut, doxie, FCC, FCC_Services,AutoStandardI;

// boolean-specific parameters
string srchString := '' : STORED('FocusSearch');
in_keys := dataset([], Text_Search.Layout_ExternalKey) :
                     stored('FocusDocIDs',few);
// general-use parameters
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

// boolean search
info := Text_Search.FileName_Info_Instance 
  (FCC_Services.Constants.stem, FCC_Services.Constants.srcType, FCC_Services.Constants.qual);

s := Text_Search.Focus_Search_Module (info, srchString,false,,, MaxResults_val,,,in_keys);
ans := s.ExtKeyanswers;
errCode := s.error_code;
errMsg := s.error_msg;

boolean Err := errCode != 0;
IF (Err, ut.outputMessage (errCode, errMsg));

// paging moved to the end: raw method may reduce number of records returned back (see ROLLING AND CA AND BARKER, for example)

fcc_ids := PROJECT (ans, TRANSFORM (FCC_Services.Layouts.id, SELF.fcc_seq := (unsigned6) LEFT.ExternalKey));
rpen := FCC_Services.raw.search_view.by_id (fcc_ids, appType);

Text_Search.MAC_Append_ExternalKey(rpen, rpen2, INTFORMAT(l.fcc_seq,15,1));

// choose "best" records
rpen_sorted := SORT(rpen2, licensees_name, licensees_attention_line, date_license_issued, RECORD);

// Show first page (output sequence number is appended)
doxie.MAC_Marshall_Results_NoCount (rpen_sorted, res, , outputCount);


if(~Err, outputCount);
IF(~Err, OUTPUT (res, NAMED('Results')));
//IF(~Err, OUTPUT (ans, NAMED ('ans'))); // debug info

ENDMACRO;