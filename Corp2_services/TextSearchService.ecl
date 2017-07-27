/*--SOAP--
<message name="CorpTextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>	
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
boolean		isAlert := false : stored('ReturnHashes');


// boolean search

con := Corp2.Constants;
STRING stem		:= con.stem;
STRING srcType:= con.srcType;
STRING qual		:= con.qual;
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);

// append a date segment restriction if alert
STRING modSrchStr := if(isAlert, Text_Search.makeDateRstrctStr(srchString,
																															 con.dateSegName,
																															 con.alertSWDays),
																 srchString) : GLOBAL;

s := Text_Search.Focus_Search_Module(info, modSrchStr,,,,MaxDocs);

ans := s.ExtKeyAnswers;
errCode := s.error_code;
errMsg := s.error_msg;

noErr := errCode = 0;

IF(~noErr, ut.outputMessage(errCode, errMsg));

wkey := project(ans, TRANSFORM(corp2_services.layout_corpkey,SELF.corp_key:=LEFT.ExternalKey));


rpen := Corp2_services.corp2_raw.search_view.by_corpkey(wkey);
rpen_trans := PROJECT(rpen, TRANSFORM(corp2_services.layout_corp2_search_rollup_final, 
														SELF.isDeepDive := false, SELF := LEFT));

rpen_sorted := SORT(rpen_trans, -count(contacts), -corp_key, -corp_sos_charter_nbr, record);

Alerts.mac_ProcessAlerts(rpen_sorted,Corp2_services.alert,final_res);

doxie.MAC_Marshall_Results_NoCount(final_res,paged_results,,outputCount);

if(noErr, outputCount);
IF(noErr, OUTPUT(paged_results, NAMED('Results')));

ENDMACRO;