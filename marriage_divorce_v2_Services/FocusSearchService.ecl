/*--SOAP--
<message name="FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
	<part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="ApplicationType"  type="xsd:string"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt
*/
/*--INFO-- Text Search.
*/
export FocusSearchService := MACRO

// boolean-specific parameters
STRING srchString := '' : STORED('FocusSearch');
in_keys := dataset([], Text_Search.Layout_ExternalKey) :
                     stored('FocusDocIDs',few);

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
s := Text_Search.Focus_Search_Module(info, srchString,false,,,MaxResults_val,true,,in_keys);

ans := s.ExtKeyAnswers;
errCode := s.error_code;
errMsg := s.error_msg;

noErr := errCode = 0;

// output results
ids := PROJECT(ans,TRANSFORM(marriage_divorce_v2_services.layouts.expanded_id, 
                             SELF.record_id := (unsigned6)LEFT.ExternalKey));
rpen := marriage_divorce_v2_services.MDRaw.wide_view.by_id(ids);
Text_Search.MAC_Append_ExternalKey(rpen, rpen2, INTFORMAT(l.record_id,15,1));
rpen_sorted := SORT(rpen2, record_id);

// paging
doxie.MAC_Marshall_Results_NoCount(rpen_sorted, paged_results,, outputCount);

if(noErr, outputCount);
IF(noErr, OUTPUT(paged_results, NAMED('Results')));

ENDMACRO;