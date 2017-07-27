/*--SOAP--
<message name="TextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="LnBranded" type="xsd:boolean"/>
	<part name="LookupType"	type="xsd:string"/>	
	<part name="CurrentOnly" type="xsd:boolean"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>	
 </message>
*/
/*--USES-- Text_Search.search_form_xslt
*/
/*--INFO-- Text Search.
*/
export TextSearchService := MACRO

import Alerts,doxie,LN_PropertyV2,LN_PropertyV2_Services,Text_Search,ut;

// boolean-specific parameters
STRING srchString := '' : STORED('Search');

// general-use parameters
STRING6 ssn_mask_value := 'NONE' : stored('SSNMask');
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');
unsigned8 MaxDocs := MaxResults_val;
boolean isAlert := false : stored('ReturnHashes');


// boolean search
con := LN_PropertyV2.Constants;

// append a date segment restriction if alert
string modSrchStr := if(isAlert, Text_Search.makeDateRstrctStr(srchString,
																															 con.dateSegName,
																															 con.alertSWDays,
																															 con.fileVerEnvVarName),
																 srchString) : GLOBAL;
STRING stem		:= con.stem;
STRING srcType:= con.srcType;
STRING qual		:= con.qual;
info_assess := Text_Search.FileName_Info_Instance(stem, srcType + '::assessment', qual);
info_deeds := Text_Search.FileName_Info_Instance(stem, srcType + '::deeds', qual);

// Fast property
STRING srcTypeFastProperty := con.srcTypeFastProp;
info_fp_assess := Text_Search.FileName_Info_Instance(stem, srcTypeFastProperty + '::assessment', qual);
info_fp_deeds := Text_Search.FileName_Info_Instance(stem, srcTypeFastProperty + '::deeds', qual);

// Only include results that were requested based on lookupType
boolean includeAssess := LN_PropertyV2_Services.input.lookupVal in ['', 'A'];
boolean includeDeeds := LN_PropertyV2_Services.input.lookupVal in ['', 'D'];

// Get assessment source and document ids for property and fast property
s_assess    := Text_Search.Text_Search_Module(info_assess, modSrchStr,false,,,MaxDocs,includeAssess,,true);
s_assess_fp := Text_Search.Text_Search_Module(info_fp_assess, modSrchStr,false,,,MaxDocs,includeAssess,,true);

ans_assess := s_assess.answers;
ans_assess_fp := s_assess_fp.answers;

errCode_assess := if(s_assess.error_code != 0, s_assess.error_code, s_assess_fp.error_code);
errMsg_assess := if(s_assess.error_msg != '', s_assess.error_msg, s_assess_fp.error_msg);

// Get deed source and document ids for property and fast property
s_deeds    := Text_Search.Text_Search_Module(info_deeds, modSrchStr,false,,,MaxDocs,includeDeeds,,true);
s_deeds_fp := Text_Search.Text_Search_Module(info_fp_deeds, modSrchStr,false,,,MaxDocs,includeDeeds,,true);

ans_deeds    := s_deeds.answers;
ans_deeds_fp := s_deeds_fp.answers;

errCode_deeds := if(s_deeds.error_code != 0, s_deeds.error_code, s_deeds_fp.error_code);
errMsg_deeds := if(s_deeds.error_msg != '', s_deeds.error_msg, s_deeds_fp.error_msg);

noErr_assess := ~includeAssess or errCode_assess = 0;
noErr_deeds := ~includeDeeds or errCode_deeds = 0;

IF(~noErr_assess, ut.outputMessage(errCode_assess, errMsg_assess));
IF(~noErr_deeds, ut.outputMessage(errCode_deeds, errMsg_deeds));

// Get assessments fares id
wkey_assess := JOIN(ans_assess, LN_PropertyV2.Key_Boolean_Map,
									keyed(LEFT.docref.src=RIGHT.src) and
									keyed(LEFT.docref.doc=RIGHT.doc),
									TRANSFORM(LN_PropertyV2_Services.layouts.fid, SELF := RIGHT),
									LIMIT(ut.limits.default, skip));

// Fast property assessments
wkey_assess_fp := JOIN(ans_assess_fp, LN_PropertyV2_Fast.Key_Assessment_Map(),
									keyed(LEFT.docref.src=RIGHT.src) and
									keyed(LEFT.docref.doc=RIGHT.doc),
									TRANSFORM(LN_PropertyV2_Services.layouts.fid, SELF := RIGHT),
									LIMIT(ut.limits.default, skip));

// Get deeds fares id
wkey_deeds := JOIN(ans_deeds, LN_PropertyV2.Key_Deed_Boolean_Map,
									keyed(LEFT.docref.src=RIGHT.src) and
									keyed(LEFT.docref.doc=RIGHT.doc),
									TRANSFORM(LN_PropertyV2_Services.layouts.fid, SELF := RIGHT),
									LIMIT(ut.limits.default, skip));

// Fast property deeds
wkey_deeds_fp := JOIN(ans_deeds_fp, LN_PropertyV2_Fast.Key_DM_Map(),
												keyed(LEFT.docref.src=RIGHT.src) and
												keyed(LEFT.docref.doc=RIGHT.doc),
												TRANSFORM(LN_PropertyV2_Services.layouts.fid, SELF := RIGHT),
												LIMIT(ut.limits.default, skip));

wkey := IF(includeAssess,wkey_assess+wkey_assess_fp) + IF(includeDeeds,wkey_deeds+wkey_deeds_fp);

// retrieve results
rpen := LN_PropertyV2_Services.resultFmt.narrow_view.get_by_fid(wkey);
rpen_nar := PROJECT(rpen, TRANSFORM(LN_PropertyV2_Services.layouts.out_narrow, self.isDeepDive := false, self := left)); 

// Need to produce an error if the combined size exceeds MaxDocs
// Must do this after the get_by_fid call, as some filtering occurs there
IF(COUNT(rpen_nar) > MaxDocs, FAIL(Text_Search.Limits.AnsLim_Code, Text_Search.Limits.AnsLim_Msg));

rpen_sorted := LN_PropertyV2_Services.Raw.final_sort(rpen_nar);

Alerts.mac_ProcessAlerts(rpen_sorted,LN_Propertyv2_services.alert,final_res);

doxie.MAC_Marshall_Results_NoCount(final_res,paged_results,,outputCount);

if(noErr_assess and noErr_deeds, outputCount);
IF(noErr_assess and noErr_deeds, OUTPUT(paged_results, NAMED('Results')));

ENDMACRO;