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
/*--INFO-- FBN Text Search. */


//#stored ('Search', 'MARTIN and JEFFRIES and CALIMESA');
//#stored ('Search', 'MEDICAL BILLING SERVICES and ORANGE and CA');
//#stored ('Search', 'KOALA AND ENTERPRISES');

EXPORT FocusSearchService := MACRO

import Text_Search, ut, doxie, FBNV2, FBNV2_services;

// boolean-specific parameters
string srchString := '' : STORED('FocusSearch');
in_keys := dataset([], Text_Search.Layout_ExternalKey) : stored('FocusDocIDs',few);

// general-use parameters
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');

// boolean search
STRING stem		:= FBNV2.Constant('').stem;
STRING srcType:= FBNV2.Constant('').srcType;
STRING qual		:= FBNV2.Constant('').qual;
info := Text_Search.FileName_Info_Instance (stem, srcType, qual);

s := Text_Search.Focus_Search_Module (info, srchString,false,,, MaxResults_val,,,in_keys); 

ans := s.ExtKeyanswers;
errCode := s.error_code;
errMsg := s.error_msg;

boolean Err := errCode != 0;
IF (Err, ut.outputMessage (errCode, errMsg));


// ids := JOIN (ans, FBNV2.Key_Boolean_Fbnkey_map,
             // keyed (Left.docref.doc = Right.doc),
             // transform (FBNV2_services.layout_search_IDs, SELF := Right),
             // LIMIT (ut.limits.default, SKIP));
ids := PROJECT( ans, TRANSFORM(FBNV2_services.layout_search_IDs,
                               self.tmsid := left.ExternalKey[1..38],
															 self.rmsid := left.ExternalKey[39..73],
															 self := []));
															 

// fetch search records
rpen := FBNV2_services.FBN_raw.search_view.by_rmsid (ids, true);

Text_Search.MAC_Append_ExternalKey(rpen, rpen2, l.tmsid + l.rmsid);

rpen_sorted := SORT(rpen2, -orig_filing_date, -filing_date, filing_jurisdiction, orig_filing_number);

// Show first page (output sequence number is appended)
doxie.MAC_Marshall_Results_NoCount (rpen_sorted, res, , outputCount);

IF (~Err, outputCount);
IF (~Err, OUTPUT(res, NAMED('Results')));

ENDMACRO;
