/*--SOAP--
<message name="FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
	<part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>	
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
/*--INFO-- Text Search.
*/
import Text_Search, LN_PropertyV2, doxie, ut, Alerts;

export FocusSearchService := MACRO


// boolean-specific parameters
STRING srchString := '' : STORED('FocusSearch');
in_PropertyKeys := dataset([], Text_Search.Layout_ExternalKey) : stored('FocusDocIDs',few);

// general-use parameters
STRING6 ssn_mask_value := 'NONE' : stored('SSNMask');
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');
boolean	currentOnly	:= false : stored('CurrentOnly');

// If current only is set, a post filter is applied after the original index search. 
// To avoid false too many docs found errors, tripled the maxvalue for the orignal search.
unsigned8 MaxDocs := IF(currentOnly,MaxResults_val*3,MaxResults_val);
boolean isAlert := false : stored('ReturnHashes');


// boolean search
con := LN_PropertyV2.Constants;

// Define alert info
AlertInfo := Text_Search.Alert_Info.SetAlertParams(con.dateSegName,con.alertSWDays,'',isAlert);

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

s_assess    := Text_Search.Focus_Search_Module(info_assess, srchString,false,,,MaxDocs,includeAssess,,in_PropertyKeys,AlertInfo);
s_assess_fp := Text_Search.Focus_Search_Module(info_fp_assess, srchString,false,,,MaxDocs,includeAssess,,in_PropertyKeys,AlertInfo);

ans_assess := s_assess.ExtKeyAnswers + s_assess_fp.ExtKeyAnswers;
errCode_assess := if(s_assess.error_code != 0, s_assess.error_code, s_assess_fp.error_code);
errMsg_assess := if(s_assess.error_msg != '', s_assess.error_msg, s_assess_fp.error_msg);

s_deeds    := Text_Search.Focus_Search_Module(info_deeds, srchString,false,,,MaxDocs,includeDeeds,,in_PropertyKeys,AlertInfo);
s_deeds_fp := Text_Search.Focus_Search_Module(info_fp_deeds, srchString,false,,,MaxDocs,includeDeeds,,in_PropertyKeys,AlertInfo);

ans_deeds := s_deeds.ExtKeyAnswers + s_deeds_fp.ExtKeyAnswers;
errCode_deeds := if(s_deeds.error_code != 0, s_deeds.error_code, s_deeds_fp.error_code);
errMsg_deeds := if(s_deeds.error_msg != '', s_deeds.error_msg, s_deeds_fp.error_msg);

noErr_assess := ~includeAssess or errCode_assess = 0;
noErr_deeds := ~includeDeeds or errCode_deeds = 0;

IF(~noErr_assess, ut.outputMessage(errCode_assess, errMsg_assess));
IF(~noErr_deeds, ut.outputMessage(errCode_deeds, errMsg_deeds));

wkey_assess := project(ans_assess, TRANSFORM(LN_PropertyV2_Services.layouts.fid, SELF.ln_fares_id := LEFT.ExternalKey, SELF:=[]));
// wkey_assess := JOIN(ans_assess, LN_PropertyV2.Key_Boolean_Map,
									// keyed(LEFT.docref.src=RIGHT.src) and
									// keyed(LEFT.docref.doc=RIGHT.doc),
									// TRANSFORM(LN_PropertyV2_Services.layouts.fid, SELF := RIGHT),
									// LIMIT(ut.limits.default, skip));

wkey_deeds := project(ans_deeds, TRANSFORM(LN_PropertyV2_Services.layouts.fid, SELF.ln_fares_id := LEFT.ExternalKey, SELF:=[]));
// wkey_deeds := JOIN(ans_deeds, LN_PropertyV2.Key_Deed_Boolean_Map,
									// keyed(LEFT.docref.src=RIGHT.src) and
									// keyed(LEFT.docref.doc=RIGHT.doc),
									// TRANSFORM(LN_PropertyV2_Services.layouts.fid, SELF := RIGHT),
									// LIMIT(ut.limits.default, skip));

wkey := IF(includeAssess,wkey_assess) + IF(includeDeeds,wkey_deeds);
wkey1:= dedup(sort(wkey,ln_fares_id,search_did),ln_fares_id,search_did);

// retrieve results
rpen := LN_PropertyV2_Services.resultFmt.narrow_view.get_by_fid(wkey1);
rpen_nar := PROJECT(rpen, TRANSFORM(LN_PropertyV2_Services.layouts.out_narrow, self.isDeepDive := false, self := left)); 

// Need to produce an error if the combined size exceeds MaxDocs
// Must do this after the get_by_fid call, as some filtering occurs there
IF(COUNT(rpen_nar) > MaxDocs, FAIL(Text_Search.Limits.AnsLim_Code, Text_Search.Limits.AnsLim_Msg));

rpen_sorted := LN_PropertyV2_Services.Raw.final_sort(rpen_nar);

Alerts.mac_ProcessAlerts(rpen_sorted,LN_Propertyv2_services.alert,final_res);

// create External Key field
Text_Search.MAC_Append_ExternalKey(final_res, final_res2, l.ln_fares_id);

doxie.MAC_Marshall_Results_NoCount(final_res2,paged_results,,outputCount);

if(noErr_assess and noErr_deeds, outputCount);
IF(noErr_assess and noErr_deeds, OUTPUT(paged_results, NAMED('Results')));

ENDMACRO;