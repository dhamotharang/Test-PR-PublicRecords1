/*--SOAP--
<message name="FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
	<part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt */
/*--INFO-- OSHAIR Text Search. */

EXPORT FocusSearchService := MACRO

import Text_Search, ut, doxie, OSHAIR;

// boolean-specific parameters
string srchString := '' : STORED('FocusSearch');
in_keys := dataset([], Text_Search.Layout_ExternalKey) :
                     stored('FocusDocIDs',few);

// general-use parameters
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');

// boolean search
STRING stem		:= OSHAIR_Services.Constants.stem;
STRING srcType:= OSHAIR_Services.Constants.srcType;
STRING qual		:= OSHAIR_Services.Constants.qual;
info := Text_Search.FileName_Info_Instance (stem, srcType, qual);

s := Text_Search.Focus_Search_Module (info, srchString,false,,, MaxResults_val,,,in_keys);

ans := s.ExtKeyanswers;
errCode := s.error_code;
errMsg := s.error_msg;

boolean Err := errCode != 0;
IF (Err, ut.outputMessage (errCode, errMsg));

ids := PROJECT (ans, transform (OSHAIR_services.layouts.id, SELF.activity_number := (unsigned6) Left.ExternalKey));

rpen := OSHAIR_Services.raw.search_view.by_id (ids);
Text_Search.MAC_Append_ExternalKey(rpen, rpen2, INTFORMAT((unsigned)l.activity_number,15,1));

rpen_sorted := SORT (rpen2, -Last_Activity_Date);

doxie.MAC_Marshall_Results_NoCount (rpen_sorted, paged_results, , outputCount);

if(~Err, outputCount);
IF(~Err, OUTPUT(paged_results, NAMED('Results')));

ENDMACRO;
