/*--SOAP--
<message name="TextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="ApplicationType"     	type="xsd:string"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt
*/
/*--INFO-- Text Search.
*/
export TextSearchService := MACRO

// boolean-specific parameters
STRING srchString := '' : STORED('Search');

// general-use parameters
STRING6 ssn_mask_value := 'NONE' : stored('SSNMask');
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');

// boolean search
con := marriage_divorce_v2.Constants('');
STRING stem		:= con.stem;
STRING srcType:= con.srcType;
STRING qual		:= con.qual;
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);
s := Text_Search.Text_Search_Module(info, srchString,false,,,MaxResults_val,true);

ans := s.answers;
errCode := s.error_code;
errMsg := s.error_msg;

noErr := errCode = 0;

// output results
ids := PROJECT(ans,TRANSFORM(marriage_divorce_v2_services.layouts.expanded_id, SELF.record_id := LEFT.docref.doc));
rpen := marriage_divorce_v2_services.MDRaw.wide_view.by_id(ids);

rpen_sorted := SORT(rpen, record_id);

// paging
doxie.MAC_Marshall_Results_NoCount(rpen_sorted, paged_results,, outputCount);

if(noErr, outputCount);
IF(noErr, OUTPUT(paged_results, NAMED('Results')));

ENDMACRO;