/*--SOAP--
<message name="TextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
  <part name="SSNMask"						type="xsd:string"/>
  <part name="IncludeMultipleSecured"	type="xsd:boolean"/>
  <part name="ReturnRolledDebtors"		type="xsd:boolean"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>	
 </message>
*/
/*--USES-- Text_Search.search_form_xslt */
/*--INFO-- UCCV2 Text Search. */

EXPORT TextSearchService := MACRO

import Text_Search, ut, doxie, UCCV2,AutoStandardI,Alerts;

// boolean-specific parameters
string srchString := '' : STORED('Search');
// general-use parameters
string6		ssn_mask_value := 'NONE'	: stored('SSNMask');
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');
boolean		isAlert := false : stored('ReturnHashes');


// boolean search
TSConsts := UCCV2.Constants('');
STRING stem		:= TSConsts.stem;
STRING srcType:= TSConsts.srcType;
STRING qual		:= TSConsts.qual;
info := Text_Search.FileName_Info_Instance (stem, srcType, qual);

// append a date segment restriction if alert
STRING modSrchStr := if(isAlert, Text_Search.makeDateRstrctStr(srchString,
																															 TSConsts.dateSegName,
																															 TSConsts.alertSWDays),
																 srchString) : GLOBAL;

s := Text_Search.Focus_Search_Module (info, modSrchStr,false,,, MaxResults_val);
ans := s.ExtKeyAnswers;
errCode := s.error_code;
errMsg := s.error_msg;

boolean Err := errCode != 0;
IF (Err, ut.outputMessage (errCode, errMsg));

ids := project(ans, TRANSFORM(UCCV2_services.layout_tmsid, SELF.TMSID := LEFT.ExternalKey));
// fetch search records 
rpen := UCCV2_Services.UCCRaw.report_view.by_tmsid (ids,ssn_mask_value);

rpen_sorted := SORT (rpen, -orig_filing_date, record);

Alerts.mac_ProcessAlerts(rpen_sorted,uccv2_services.alert,final_res);

doxie.MAC_Marshall_Results_NoCount (final_res, res, , outputCount);

if(~Err, outputCount);
IF(~Err, OUTPUT(res, NAMED('Results')));

ENDMACRO;
