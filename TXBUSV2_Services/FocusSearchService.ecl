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
/*--INFO-- TXBUS Text Search. */

EXPORT FocusSearchService := MACRO

import Text_Search, ut, doxie, TXBUS;

// boolean-specific parameters
STRING srchString := '' : STORED('FocusSearch');
in_keys := dataset([], Text_Search.Layout_ExternalKey) :
                     stored('FocusDocIDs',few);
// general-use parameters
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');

// boolean search
STRING stem		:= TXBUS.Constants.stem;
STRING srcType:= TXBUS.Constants.srcType;
STRING qual		:= TXBUS.Constants.qual;
info := Text_Search.FileName_Info_Instance (stem, srcType, qual);

s := Text_Search.Focus_Search_Module (info, srchString,false,,, MaxResults_val,,,in_keys);
ans := s.ExtKeyanswers;
errCode := s.error_code;
errMsg := s.error_msg;

boolean Err := errCode != 0;
IF (Err, ut.outputMessage (errCode, errMsg));

// ids := JOIN (ans, TXBUS.key_boolean_map,
             // keyed (Left.docref.doc = Right.doc) AND
             // keyed (Left.docref.src = Right.src),
             // transform (TxbusV2_services.layout_search_IDs, SELF := Right),
             // LIMIT (ut.limits.default, SKIP));

ids := PROJECT( ans, TRANSFORM( TxbusV2_services.layout_search_IDs,
                                self.taxpayer_number := left.ExternalKey ) );
// fetch search records
rpen := TXBUSV2_Services.Txbus_raw.search_view.by_TaxPayerNumber (ids, '', true);

Text_Search.MAC_Append_ExternalKey(rpen, rpen2, l.taxpayer_number);

rpen_sorted := SORT (rpen2, dt_last_seen,dt_first_seen, record);

doxie.MAC_Marshall_Results_NoCount (rpen_sorted, res, , outputCount);

if(~Err, outputCount);
IF(~Err, OUTPUT (res, NAMED('Results')));

ENDMACRO;
