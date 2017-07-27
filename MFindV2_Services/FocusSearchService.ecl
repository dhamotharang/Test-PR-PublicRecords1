/*--SOAP--
<message name="MFINDFocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
	<part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>

 </message>
*/
/*--USES-- Text_Search.search_form_xslt */
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
STRING stem		:= '~thor_data400::base';
STRING srcType:= 'Mfind';
STRING qual		:= 'test';
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);

s := Text_Search.Focus_Search_Module(info, srchString, false,,,MaxResults_val,,,in_keys);

errCode := s.error_code;
errMsg := s.error_msg;

noErr := errCode = 0;

// Check for bad input
IF(~noErr, ut.outputMessage(errCode, errMsg));

// lookup vids using docRefs
// vids := JOIN(s.answers,MFind.key_boolean_tmsid,keyed(LEFT.docref.src=RIGHT.src) AND keyed(LEFT.docref.doc=RIGHT.doc), 
             // transform(MFindV2_Services.layout_search_IDs,self.vid := (string) right.doc2), KEEP(1));
vids := PROJECT( s.ExtKeyAnswers, TRANSFORM( MFindV2_Services.layout_search_IDs,
                                             self.vid := left.ExternalKey ) );


rpen := MFindV2_Services.MFind_raw.report_view.by_vid(vids);
Text_Search.MAC_Append_ExternalKey(rpen, rpen2, l.trim_vid);
rpen_sorted := SORT(rpen2, lname,fname,mname);

doxie.MAC_Marshall_Results_NoCount (rpen_sorted, res, , outputCount);

IF(noErr, outputCount);
IF(noErr, OUTPUT(res, NAMED('Results')));

ENDMACRO;