/*--SOAP--
<message name="TextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt */
/*--INFO-- TXBUS Text Search. */

EXPORT TextSearchService := MACRO

import Text_Search, ut, doxie, TXBUS;

// boolean-specific parameters
string srchString := '' : STORED('Search');
// general-use parameters
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');

// boolean search
STRING stem		:= TXBUS.Constants.stem;
STRING srcType:= TXBUS.Constants.srcType;
STRING qual		:= TXBUS.Constants.qual;
info := Text_Search.FileName_Info_Instance (stem, srcType, qual);

s := Text_Search.Text_Search_Module (info, srchString,false,,, MaxResults_val);
ans := s.answers;
errCode := s.error_code;
errMsg := s.error_msg;

boolean Err := errCode != 0;
IF (Err, ut.outputMessage (errCode, errMsg));

ids := JOIN (ans, TXBUS.key_boolean_map,
             keyed (Left.docref.doc = Right.doc) AND
             keyed (Left.docref.src = Right.src),
             transform (TxbusV2_services.layout_search_IDs, SELF := Right),
             LIMIT (ut.limits.default, SKIP));

// fetch search records
rpen := TXBUSV2_Services.Txbus_raw.search_view.by_TaxPayerNumber (ids, '', true);

rpen_sorted := SORT (rpen, dt_last_seen,dt_first_seen, record);

doxie.MAC_Marshall_Results_NoCount (rpen_sorted, res, , outputCount);

if(~Err, outputCount);
IF(~Err, OUTPUT (res, NAMED('Results')));

ENDMACRO;
