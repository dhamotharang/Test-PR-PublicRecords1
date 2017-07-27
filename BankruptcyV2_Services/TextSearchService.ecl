
/*--SOAP--
<message name="TextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
	<part name="ApplicationType"   	type="xsd:string"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt
*/
/*--INFO-- Bankruptcy Text Search.
*/
// Code cribbed from LiensTextSearchService 1 Aug 2007.
import alerts,text_search,doxie,BankruptcyV2,ut;
export TextSearchService := macro

 //The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_BankruptcyV2_Services_TextSearchService();
		
#constant('isTextSearchService',true);

// boolean-specific parameters
string	srchString := '' : stored('Search');


// general-use parameters
string6		ssn_mask_value					:= 'NONE'	: stored('SSNMask');
unsigned8	MaxResults_val					:= 2000		: stored('MaxResults');
unsigned8	MaxResultsThisTime_val	:= 2000		: stored('MaxResultsThisTime');
unsigned8	SkipRecords_val					:= 0			: stored('SkipRecords');
boolean		isAlert									:= false	:	stored('ReturnHashes');


// boolean search
TSConsts := BankruptcyV2.Constants('').text_search;

// append a date segment restriction if alert
string modSrchStr := if(isAlert, Text_Search.makeDateRstrctStr(srchString,
																															 TSConsts.dateSegName,
																															 TSConsts.alertSWDays),
																 srchString) : GLOBAL;

info := Text_Search.FileName_Info_Instance(TSConsts.stem, TSConsts.srcType, TSConsts.qual);
s				:= Text_Search.Focus_Search_Module(info, modSrchStr,false,,, MaxResults_val, true);
ans			:= s.ExtKeyAnswers;
errCode	:= s.error_code;
errMsg	:= s.error_msg;
noErr		:= errCode = 0;
if(~noErr, ut.outputMessage(errCode, errMsg));


// DEBUG - fake boolean search ('MARIA and VERGARA and SUN VALLEY and CA')
// ans := dataset([{ {16707,87}, 8.594649, 1, [{0,0,0,0}] }], text_search.Layout_DocHits);
// noErr := true;


// lookup tmsids using docRefs
wkeys := project(ans,	transform(
	                             	BankruptcyV2_Services.layout_TMSID_ext, 
		                            self.isdeepdive := false,
		                            self.TMSID := LEFT.ExternalKey
	                              ));

tmsids := dedup(wkeys, tmsid, all);

// generate the report
rpen := BankruptcyV2_Services.bankruptcy_raw().boolean_source_view(in_tmsids := tmsids, in_ssn_mask := ssn_mask_value);

rpen_sorted := sort(rpen,-date_filed,case_number,
						        if(debtors[1].names[1].cname <> '', debtors[1].names[1].cname, debtors[1].names[1].lname), record);

Alerts.mac_ProcessAlerts(rpen_sorted,bankruptcyv2_services.alert,final_res);

// paging
doxie.MAC_Marshall_Results_NoCount(final_res, paged_results,, outputCount);


// output count & results, and we're done
if(noErr, outputCount);
if(noErr, output( paged_results, named('Results') ));

endmacro;
