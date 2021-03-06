
/*--SOAP--
<message name="FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
	<part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
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
/*--INFO-- UCCV2 Focus Search. */

EXPORT FocusSearchService := MACRO

import Text_Search, ut, doxie, UCCV2, alerts,AutoStandardI;

// boolean-specific parameters
string srchString := '' : STORED('FocusSearch');
in_UCCkeys := dataset([], Text_Search.Layout_ExternalKey) : stored('FocusDocIDs',few);

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

// Define alert info
AlertInfo := Text_Search.Alert_Info.SetAlertParams(TSConsts.dateSegName,TSConsts.alertSWDays,'',isAlert);

//Flist := project(in_UCCkeys, TRANSFORM(Text_Search.Layout_ExternalKey, SELF.ExternalKey := LEFT.TMSID));
Flist := in_UCCkeys;

s := Text_Search.Focus_Search_Module (info, srchString,false,,, MaxResults_val,,,FList,AlertInfo);
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

// create External Key field
orec := record 
   RECORDOF(final_res);
   Text_Search.Layout_ExternalKey;
END;
orec addExt ( final_res l) := transform
  self := l;
	self.ExternalKey := l.TMSID;
end;
final_res2 := project(final_res, addext(left));

doxie.MAC_Marshall_Results_NoCount (final_res2, res, , outputCount);

if(~Err, outputCount);
IF(~Err, OUTPUT(res, NAMED('Results')));

ENDMACRO;
