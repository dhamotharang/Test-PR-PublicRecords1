/*--SOAP--
<message name="MFINDTextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>

 </message>
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
STRING stem		:= '~thor_data400::base';
STRING srcType:= 'Mfind';
STRING qual		:= 'test';
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);

s := Text_Search.Text_Search_Module(info, srchString, false,,,MaxResults_val);

errCode := s.error_code;
errMsg := s.error_msg;

noErr := errCode = 0;

// Check for bad input
IF(~noErr, ut.outputMessage(errCode, errMsg));

// lookup vids using docRefs
vids := JOIN(s.answers,MFind.key_boolean_tmsid,keyed(LEFT.docref.src=RIGHT.src) AND keyed(LEFT.docref.doc=RIGHT.doc), 
             transform(MFindV2_Services.layout_search_IDs,self.vid := (string) right.doc2), KEEP(1));

rpen := MFindV2_Services.MFind_raw.report_view.by_vid(vids);

rpen_sorted := SORT(rpen, lname,fname,mname);

doxie.MAC_Marshall_Results_NoCount (rpen_sorted, res, , outputCount);

IF(noErr, outputCount);
IF(noErr, OUTPUT(res, NAMED('Results')));

ENDMACRO;