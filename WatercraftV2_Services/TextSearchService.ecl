/*--SOAP--
<message name="WatercraftTextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
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
unsigned8 MaxDocs := MaxResults_val;

// boolean search
con := watercraftV2_Services.Constants('');
STRING stem		:= con.stem;
STRING srcType:= con.srcType;
STRING qual		:= con.qual;
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);

s := Text_Search.Text_Search_Module(info, srchString,false,,,MaxDocs);

ans := s.answers;
errCode := s.error_code;
errMsg := s.error_msg;

noErr := errCode = 0;

IF(~noErr, ut.outputMessage(errCode, errMsg));


wkeys := JOIN(ans, watercraft.key_boolean_uid,
									keyed(LEFT.docref.doc=RIGHT.uid),
									TRANSFORM(watercraftV2_services.Layouts.search_watercraftkey, SELF := RIGHT),
									LIMIT(ut.limits.default, skip));

rpen := watercraftV2_services.get_watercraft(wkeys).search();

rpen_sorted := SORT(rpen, -date_last_seen, record);

// paging
doxie.MAC_Marshall_Results_NoCount(rpen_sorted,paged_results,,outputCount);

// outputs
if(noErr, outputCount);
IF(noErr, OUTPUT(paged_results, NAMED('Results')));

ENDMACRO;