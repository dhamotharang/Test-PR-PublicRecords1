/*--SOAP--
<message name="ProfLicenseTextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	<part name="IncludeProfessionalLicenses" type="xsd:boolean" />
	<part name="IncludeSanctions" type="xsd:boolean" />
	<part name="IncludeProviders" type="xsd:boolean"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="ApplicationType"     	type="xsd:string"/>
 </message>
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

boolean Include_Prof_Lic := false : stored('IncludeProfessionalLicenses');
boolean Include_Prov     := false : stored('IncludeProviders');
boolean Include_Sanc     := false : stored('IncludeSanctions');


// boolean search
con_pro := Prof_LicenseV2.Constants;
ingenix_pro := Ingenix_NatlProf.Constants;
STRING stem_pro		:= con_pro.stem;
STRING srcType_pro:= con_pro.srcType;
STRING qual_pro		:= con_pro.qual;
info_pro := Text_Search.FileName_Info_Instance(stem_pro, srcType_pro, qual_pro);
s_pro := Text_Search.Text_Search_Module(info_pro, srchString,,,,MaxDocs);

ans_pro := s_pro.answers;
errCode_pro := s_pro.error_code;
errMsg_pro := s_pro.error_msg;
noErr_pro := not Include_Prof_Lic or errCode_pro = 0;


con_ing := Ingenix_NatlProf.Constants;
STRING stem_ing		:= con_ing.stem;
STRING srcType_sanc:= con_ing.srcType_sanc;
STRING srcType_prov:= con_ing.srcType_prov;
STRING qual_ing		:= con_ing.qual;
info_sanc := Text_Search.FileName_Info_Instance(stem_ing, srcType_sanc, qual_ing);
info_prov := Text_Search.FileName_Info_Instance(stem_ing, srcType_prov, qual_ing);
s_sanc := Text_Search.Text_Search_Module(info_sanc, srchString,,,,MaxDocs);
s_prov := Text_Search.Text_Search_Module(info_prov, srchString,,,,MaxDocs);

ans_sanc := s_sanc.answers;
ans_prov := s_prov.answers;
errCode_sanc := s_sanc.error_code;
errCode_prov := s_prov.error_code;
errMsg_sanc := s_sanc.error_msg;
errMsg_prov := s_prov.error_msg;
noErr_sanc :=  not Include_Sanc or errCode_sanc = 0;
noErr_prov :=  not Include_Prov or errCode_prov = 0;


IF(~noErr_pro, ut.outputMessage(errCode_pro, errMsg_pro));
IF(~noErr_prov, ut.outputMessage(errCode_prov, errMsg_prov));
IF(~noErr_sanc, ut.outputMessage(errCode_sanc, errMsg_sanc));

prolics := if (Include_prof_lic, PROJECT(ans_pro,TRANSFORM(prof_LicenseV2_Services.Layout_Search_Ids_Prolic, SELF.prolic_seq_id:= LEFT.docref.doc)));
providers := if (Include_Prov, JOIN(ans_prov,Ingenix_NatlProf.Key_Boolean_Provider_Map,keyed(LEFT.docref.src=RIGHT.src) AND keyed(LEFT.docref.doc=RIGHT.doc),
					transform(prof_LicenseV2_Services.Layout_Search_Ids_Prov,self.providerid :=(unsigned6) right.providerid),KEEP(1)));
sanctions := if (Include_Sanc, JOIN(ans_sanc,Ingenix_NatlProf.Key_Boolean_Map,keyed(LEFT.docref.src=RIGHT.src) AND keyed(LEFT.docref.doc=RIGHT.doc),
					transform(prof_LicenseV2_Services.Layout_Search_Ids_Sanc,self.sanc_id :=(unsigned6)  right.sanc_id),KEEP(1)));


rpen := prof_licensev2_services.Prof_Lic_Raw.Search_view.by_ids(prolics,sanctions,providers);

// Need to produce an error if the combined size exceeds MaxDocs
// Must do this after the by_ids call, as some rollup occurs there
IF(COUNT(rpen) > MaxDocs, FAIL(Text_Search.Limits.AnsLim_Code, Text_Search.Limits.AnsLim_Msg));

score_sorted := SORT(rpen, orig_name,company_name, record);

doxie.MAC_Marshall_Results_NoCount(score_sorted,score_sorted_paged,,outputcount);

noErr := noErr_pro and noErr_prov and noErr_sanc;
if(noErr, outputCount);
IF(noErr, OUTPUT(score_sorted_paged, NAMED('Results')));

ENDMACRO;