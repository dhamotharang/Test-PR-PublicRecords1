/*--SOAP--
<message name="TextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	
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
/*--INFO-- Text Search.
*/
import AutoStandardI,LiensV2,Text_Search,ut,Alerts,doxie;
export TextSearchService := macro

// boolean-specific parameters
string	srchString := '' : stored('Search');


// general-use parameters
string6		ssn_mask_value					:= 'NONE'	: stored('SSNMask');
unsigned8	MaxResults_val					:= 2000		: stored('MaxResults');
unsigned8	MaxResultsThisTime_val	:= 2000		: stored('MaxResultsThisTime');
unsigned8	SkipRecords_val					:= 0			: stored('SkipRecords');
boolean		isAlert									:= false	: stored('ReturnHashes');
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));


// boolean search
TSConsts := LiensV2.Constants.text_search;
info := Text_Search.FileName_Info_Instance(
	TSConsts.stem,
	TSConsts.srcType,
	TSConsts.qual
);

// append a date segment restriction if alert
STRING modSrchStr := if(isAlert, Text_Search.makeDateRstrctStr(srchString,
																															 TSConsts.dateSegName,
																															 TSConsts.alertSWDays),
																 srchString) : GLOBAL;

s				:= Text_Search.Focus_Search_Module(info, modSrchStr,false,,, MaxResults_val, true);
ans			:= s.ExtKeyAnswers;
errCode	:= s.error_code;
errMsg	:= s.error_msg;
noErr		:= errCode = 0;
if(~noErr, ut.outputMessage(errCode, errMsg));


// DEBUG - fake boolean search ('MARIA and VERGARA and SUN VALLEY and CA')
// ans := dataset([{ {16707,87}, 8.594649, 1, [{0,0,0,0}] }], text_search.Layout_DocHits);
// noErr := true;


// match tmsids with scores
wkeys := project(ans, TRANSFORM(liensV2_services.layout_TMSID, SELF.TMSID := LEFT.ExternalKey));

tmsids := dedup(wkeys, tmsid, all);

// generate the report
rpen := LiensV2_Services.liens_raw.report_view.by_tmsid(tmsids, ssn_mask_value,,,,,appType);

rpen_sorted := sort(rpen, -orig_filing_date, record);

Alerts.mac_ProcessAlerts(rpen_sorted,liensv2_services.alert,final_res);

// paging
doxie.MAC_Marshall_Results_NoCount(final_res, paged_results,, outputCount);


// output count & results, and we're done
if(noErr, outputCount);
if(noErr, output( paged_results, named('Results') ));

endmacro;
