/*--SOAP--
<message name="FEINV2TextSearchService">
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

// b general-use parameters
STRING6 ssn_mask_value := 'NONE' : stored('SSNMask');
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');
unsigned8 MaxDocs := MaxResults_val;


// boolean search
STRING stem		:= '~thor_data400::base';
STRING srcType:= 'FEINV2';
STRING qual		:= 'test';
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);


s := Text_Search.Text_Search_Module(info, srchString,false,,,MaxDocs);
errCode := s.error_code;
errMsg := s.error_msg;

noErr := errCode = 0;

// Check for bad input
IF(~noErr, ut.outputMessage(errCode, errMsg));


// lookup tmsids using docRefs
tmsids := JOIN(s.answers,DNB_FEINV2.Key_Boolean_Map,keyed(LEFT.docref.src=RIGHT.src) AND keyed(LEFT.docref.doc=RIGHT.doc), 
          transform(DNB_FEINV2_Services.layout_TMSID_ext,self.tmsid:=right.doc2,self := []), KEEP(1));

// get full results
rpen := DNB_FEINV2_Services.raw.boolean_source_view(tmsids,s.TotalCount);

rpen_sorted := SORT(rpen, tmsid);

doxie.MAC_Marshall_Results_NoCount(rpen_sorted,results_paged,,Outputcount);


// outputs
if(noErr, outputCount);
IF(noErr, OUTPUT(results_paged, NAMED('Results')));
ENDMACRO;