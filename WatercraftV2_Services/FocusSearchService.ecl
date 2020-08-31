/*--SOAP--
<message name="FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
  <part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
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
EXPORT FocusSearchService := MACRO

// boolean-specific parameters
STRING srchString := '' : STORED('FocusSearch');
in_keys := DATASET([], Text_Search.Layout_ExternalKey) : STORED('FocusDocIDs',few);

// general-use parameters
STRING6 ssn_mask_value := 'NONE' : STORED('SSNMask');
UNSIGNED8 MaxResults_val := 2000 : STORED('MaxResults');
UNSIGNED8 MaxResultsThisTime_val := 2000 : STORED('MaxResultsThisTime');
UNSIGNED8 SkipRecords_val := 0 : STORED('SkipRecords');
UNSIGNED8 MaxDocs := MaxResults_val;

// boolean search
con := watercraftV2_Services.Constants('');
STRING stem := con.stem;
STRING srcType:= con.srcType;
STRING qual := con.qual;
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);

s := Text_Search.Focus_Search_Module(info, srchString,FALSE,,,MaxDocs,,,in_keys);

ans := s.ExtKeyAnswers;
errCode := s.error_code;
errMsg := s.error_msg;

noErr := errCode = 0;

IF(~noErr, ut.outputMessage(errCode, errMsg));


wk := SIZEOF(WatercraftV2_Services.Layouts.search_watercraftkey.watercraft_key);
sk := SIZEOF(WatercraftV2_Services.Layouts.search_watercraftkey.sequence_key);
wkeys := PROJECT(ans, TRANSFORM(WatercraftV2_Services.Layouts.search_watercraftkey,
  SELF.watercraft_key:=LEFT.ExternalKey,
  SELF.sequence_key:=LEFT.ExternalKey[wk+1..],
  SELF.state_origin:=LEFT.ExternalKey[wk+sk+1..],
  SELF:=[]));

rpen := watercraftV2_services.get_watercraft(wkeys).search();

Text_Search.MAC_Append_ExternalKey(rpen, rpen2, l.watercraft_key + l.sequence_key + l.state_origin);

rpen_sorted := SORT(rpen2, -date_last_seen, RECORD);

// paging
doxie.MAC_Marshall_Results_NoCount(rpen_sorted,paged_results,,outputCount);

// outputs
IF(noErr, outputCount);
IF(noErr, OUTPUT(paged_results, NAMED('Results')));

ENDMACRO;
