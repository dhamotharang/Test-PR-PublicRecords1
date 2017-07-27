/*--SOAP--
<message name="FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
  <part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>	
 </message>
*/
/*--INFO-- Corps Focus Search.
*/
export FocusSearchService := MACRO

// boolean-specific parameters
STRING focusString := '' : STORED('FocusSearch');

bothkeys := record
  corp2_services.layout_corpkey;
  Text_Search.Layout_ExternalKey;
END;
  
in_corpkeys := dataset([], bothkeys) : stored('FocusDocIDs',few);

// general-use parameters
STRING6 ssn_mask_value := 'NONE' : stored('SSNMask');
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');
unsigned8 MaxDocs := MaxResults_val;
boolean		isAlert := false : stored('ReturnHashes');

// focus search

con := Corp2.Constants;

STRING stem		:= con.stem;
STRING srcType:= con.srcType;
STRING qual		:= con.qual;
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);

// Define alert info
AlertInfo := Text_Search.Alert_Info.SetAlertParams(con.dateSegName,con.alertSWDays,'',isAlert);

fdocs1 := project(in_corpkeys, TRANSFORM(Text_Search.Layout_ExternalKey, SELF.ExternalKey := LEFT.corp_key));
fdocs2 := project(in_corpkeys, TRANSFORM(Text_Search.Layout_ExternalKey,SELF := LEFT));
fdocs := DEDUP(SORT(fdocs1+fdocs2(ExternalKey != ''),ExternalKey),ExternalKey);
	
fs := Text_Search.Focus_Search_Module(info,focusString,TRUE,,,MaxDocs,,,fdocs,AlertInfo);

ans := fs.ExtKeyAnswers;
rpn := fs.rpn_srch;
errCode := fs.error_code;
errMsg := fs.error_msg;

noErr := errCode = 0;

IF(~noErr, ut.outputMessage(errCode, errMsg));

wkey := project(ans, TRANSFORM(corp2_services.layout_corpkey, SELF.corp_key := LEFT.ExternalKey));

rpen := Corp2_services.corp2_raw.search_view.by_corpkey(wkey);
rpen_trans := PROJECT(rpen, TRANSFORM(corp2_services.layout_corp2_search_rollup_final, 
														SELF.isDeepDive := false, SELF := LEFT));

rpen_sorted := SORT(rpen_trans, -count(contacts), -corp_key, -corp_sos_charter_nbr, record);

Alerts.mac_ProcessAlerts(rpen_sorted,Corp2_services.alert,final_res);

orec := record 
   RECORDOF(final_res);
   Text_Search.Layout_ExternalKey;
END;
orec addExt ( final_res l) := transform
  self := l;
	self.ExternalKey := l.corp_key;
end;
final_res2 := project(final_res, addext(left));

doxie.MAC_Marshall_Results_NoCount(final_res2,paged_results,,outputCount);

if(noErr, outputCount);
IF(noErr, OUTPUT(paged_results, NAMED('Results')));

ENDMACRO;