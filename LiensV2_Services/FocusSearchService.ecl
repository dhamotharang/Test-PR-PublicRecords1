/*--SOAP--
<message name="FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
	<part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt
*/
/*--INFO-- Focus Search.
*/
import LiensV2,text_search,alerts,doxie,ut,AutoStandardI;
export FocusSearchService := macro

// boolean-specific parameters
string	FocusString := '' : stored('FocusSearch');

in_lienskeys := dataset([], Text_Search.Layout_ExternalKey) : stored('FocusDocIDs',few);

// general-use parameters
string6		ssn_mask_value					:= 'NONE'	: stored('SSNMask');
unsigned8	MaxResults_val					:= 2000		: stored('MaxResults');
unsigned8	MaxResultsThisTime_val	:= 2000		: stored('MaxResultsThisTime');
unsigned8	SkipRecords_val					:= 0			:	stored('SkipRecords');
boolean		isAlert									:= false	:	stored('ReturnHashes');
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));


// boolean search
TSConsts := LiensV2.Constants.text_search;
info := Text_Search.FileName_Info_Instance(
	TSConsts.stem,
	TSConsts.srcType,
	TSConsts.qual
);

// Define alert info
AlertInfo := Text_Search.Alert_Info.SetAlertParams(TSConsts.dateSegName,TSConsts.alertSWDays,'',isAlert);

// process Focus Keys
//fdocs := project(in_lienskeys, TRANSFORM(Text_Search.Layout_ExternalKey, SELF.ExternalKey := LEFT.TMSID));
fdocs := in_lienskeys;

focusreq	:= Text_Search.Focus_Search_Module(info, FocusString,false,,, MaxResults_val, true,,fdocs,AlertInfo);
ans			:= focusreq.ExtKeyAnswers;
errCode	:= focusreq.error_code;
errMsg	:= focusreq.error_msg;
noErr		:= errCode = 0;
if(~noErr, ut.outputMessage(errCode, errMsg));

// match tmsids with scores
wkeys := project(ans, TRANSFORM(liensV2_services.layout_TMSID, SELF.TMSID := LEFT.ExternalKey));

tmsids := dedup(wkeys, tmsid, all);

// generate the report
rpen := LiensV2_Services.liens_raw.report_view.by_tmsid(tmsids, ssn_mask_value,,,,,appType);

rpen_sorted := sort(rpen, -orig_filing_date, record);

Alerts.mac_ProcessAlerts(rpen_sorted,liensv2_services.alert,final_res);

orec := record 
   RECORDOF(final_res);
   Text_Search.Layout_ExternalKey;
END;
orec addExt ( final_res l) := transform
  self := l;
	self.ExternalKey := l.TMSID;
end;
final_res2 := project(final_res, addext(left));

// paging
doxie.MAC_Marshall_Results_NoCount(final_res2, paged_results,, outputCount);


// output count & results, and we're done
if(noErr, outputCount);
if(noErr, output( paged_results, named('Results') ));

endmacro;
