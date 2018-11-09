/*HACK06*//*HACK06*//*--SOAP-- 
<message name="Biz_Header_Service_2">
<part name="proxid" type="unsignedInt"/>
<part name="company_name" type="xsd:string"/>
<part name="prim_range" type="xsd:string"/>
<part name="prim_name" type="xsd:string"/>
<part name="sec_range" type="xsd:string"/>
<part name="city" type="xsd:string"/>
<part name="st" type="xsd:string"/>
<part name="zip" type="xsd:string"/>
<part name="zip_radius" type="xsd:float"/>
<part name="company_phone" type="xsd:string"/>
<part name="allow7digitmatch" type="xsd:boolean"/>
<part name="company_url" type="xsd:string"/>
<part name="contact_did" type="xsd:unsignedInt"/>
<part name="title" type="xsd:string"/>
<part name="fname" type="xsd:string"/>
<part name="mname" type="xsd:string"/>
<part name="lname" type="xsd:string"/>
<part name="name_suffix" type="xsd:string"/>
<part name="contact_email" type="xsd:string"/>
<part name="contact_ssn" type="xsd:string"/>
<part name="company_fein" type="xsd:string"/>
<part name="company_sic_code1" type="xsd:string"/>
<part name="source" type="xsd:string"/>
<part name="source_record_id" type="xsd:string"/>
<part name="parent_proxid" type="xsd:string"/>
<part name="ultimate_proxid" type="xsd:string"/>
<part name="has_lgid" type="xsd:string"/>
<part name="empid" type="xsd:string"/>
<part name="powid" type="xsd:string"/>
<part name="isContact" type="xsd:string"/>
<part name="UniqueID" type="xsd:integer"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="MatchAllInOneRecord" type="xsd:boolean"/>
<part name="RecordsOnly" type="xsd:boolean"/>
<part name="GroupProxID" type="xsd:boolean"/>
<part name="BatchMode" type="xsd:boolean"/>
<part name="HierarchicalSort" type="xsd:boolean"/>
<part name="DebugMode" type="xsd:boolean"/>
</message>
*/
EXPORT Biz_Header_Service_2 := MACRO
IMPORT SALT33,BizLinkFull;
IMPORT BIPV2;
IMPORT BIPV2_Company_Names;
IMPORT lib_ziplib;
IMPORT lib_stringlib;
IMPORT RiskWise;
THISMODULE:=BizLinkFull;
//�
  UNSIGNED e_proxid := 0 : STORED('proxid',FORMAT(SEQUENCE(1)));
  SALT33.StrType Input_company_name := '' : STORED('company_name',FORMAT(SEQUENCE(2)));
  SALT33.StrType Input_prim_range := '' : STORED('prim_range',FORMAT(FIELDWIDTH(10),SEQUENCE(3)));
  SALT33.StrType Input_prim_name := '' : STORED('prim_name',FORMAT(SEQUENCE(4)));
  SALT33.StrType Input_sec_range := '' : STORED('sec_range',FORMAT(SEQUENCE(5)));
  SALT33.StrType Input_city := '' : STORED('city',FORMAT(SEQUENCE(6)));
  SALT33.StrType Input_st := '' : STORED('st',FORMAT(SEQUENCE(7)));
  SALT33.StrType Input_company_phone := '' : STORED('company_phone',FORMAT(SEQUENCE(10)));
  SALT33.StrType Input_company_url := '' : STORED('company_url',FORMAT(SEQUENCE(11)));
  SALT33.StrType Input_contact_did := '' : STORED('contact_did',FORMAT(SEQUENCE(12)));
  SALT33.StrType Input_title := '' : STORED('title',FORMAT(SEQUENCE(13)));
  SALT33.StrType Input_fname := '' : STORED('fname',FORMAT(SEQUENCE(14)));
  SALT33.StrType Input_mname := '' : STORED('mname',FORMAT(SEQUENCE(15)));
  SALT33.StrType Input_lname := '' : STORED('lname',FORMAT(SEQUENCE(16)));
  SALT33.StrType Input_name_suffix := '' : STORED('name_suffix',FORMAT(SEQUENCE(17)));
  SALT33.StrType Input_contact_email := '' : STORED('contact_email',FORMAT(SEQUENCE(18)));
  SALT33.StrType Input_contact_ssn := '' : STORED('contact_ssn',FORMAT(SEQUENCE(19)));
  SALT33.StrType Input_company_fein := '' : STORED('company_fein',FORMAT(SEQUENCE(20)));
  SALT33.StrType Input_company_sic_code1 := '' : STORED('company_sic_code1',FORMAT(SEQUENCE(21)));
  SALT33.StrType Input_active_duns_number := '' : STORED('active_duns_number',FORMAT(SEQUENCE(22)));
  SALT33.StrType Input_source := '' : STORED('source',FORMAT(SEQUENCE(23)));
  SALT33.StrType Input_source_record_id := '' : STORED('source_record_id',FORMAT(SEQUENCE(24)));
  SALT33.StrType Input_source_docid := '' : STORED('source_docid',FORMAT(SEQUENCE(25)));
  SALT33.StrType Input_parent_proxid := '' : STORED('parent_proxid',FORMAT(SEQUENCE(26)));
  SALT33.StrType Input_sele_proxid := '' : STORED('sele_proxid',FORMAT(SEQUENCE(27)));
  SALT33.StrType Input_org_proxid := '' : STORED('org_proxid',FORMAT(SEQUENCE(28)));
  SALT33.StrType Input_ultimate_proxid := '' : STORED('ultimate_proxid',FORMAT(SEQUENCE(29)));
  SALT33.StrType Input_has_lgid := '' : STORED('has_lgid',FORMAT(SEQUENCE(30)));
  SALT33.StrType Input_empid := '' : STORED('empid',FORMAT(FEW,SEQUENCE(31)));
  UNSIGNED e_powid := 0 : STORED('powid',FORMAT(SEQUENCE(32)));
  SALT33.StrType Input_isContact := '' : STORED('isContact',FORMAT(SEQUENCE(33)));
  UNSIGNED Input_UniqueID := 1 : STORED('UniqueID',FORMAT(SEQUENCE(34)));
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds',FORMAT(SEQUENCE(35)));
  BOOLEAN FullMatch := FALSE : STORED('MatchAllInOneRecord',FORMAT(SEQUENCE(36)));
  BOOLEAN RecordsOnly := FALSE: STORED('RecordsOnly',FORMAT(SEQUENCE(37)));
//�
  UNSIGNED e_seleid := 0 : STORED('seleid',FORMAT(SEQUENCE(38)));
  UNSIGNED e_orgid := 0 : STORED('orgid',FORMAT(SEQUENCE(39)));
  UNSIGNED e_ultid := 0 : STORED('ultid',FORMAT(SEQUENCE(40)));
  UNSIGNED e_rcid := 0 : STORED('rcid',FORMAT(SEQUENCE(41)));
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  STRING Input_zip := '' : STORED('zip',FORMAT(FIELDWIDTH(10),SEQUENCE(8)));
  UNSIGNED Input_zip_radius:=0:STORED('zip_radius',FORMAT(FIELDWIDTH(4),SEQUENCE(9)));
  BOOLEAN allow7digitmatch:=FALSE:STORED('allow7digitmatch',FORMAT(SEQUENCE(42)));
  BOOLEAN GroupProxID:=false: stored('GroupProxID',FORMAT(SEQUENCE(43)));
  BOOLEAN bDebug:=TRUE:STORED('DebugMode',FORMAT(SEQUENCE(44)));
  BOOLEAN bBatch:=FALSE:STORED('BatachMode',FORMAT(SEQUENCE(45)));
  BOOLEAN bHSort:=FALSE:STORED('HierarchicalSort',FORMAT(SEQUENCE(46)));
  BOOLEAN bSoapCall:=FALSE:STORED('SoapCallMode',FORMAT(SEQUENCE(47)));
  UNSIGNED Input_LeadThreshold:=10:STORED('LeadThreshold',FORMAT(SEQUENCE(48)));
  BOOLEAN bResearch:=FALSE:STORED('Research',FORMAT(SEQUENCE(49)));
//---------------------------------------------------------------------------
// If an airport code is entered, derive the city and state from that
//---------------------------------------------------------------------------
dAirportReplacement:=BIPV2.fn_translate_city(stringlib.StringToUpperCase(Input_city));
sNewCity:=IF(LENGTH(TRIM(Input_city))=3,IF(COUNT(dAirportReplacement)=0,Input_city,dAirportReplacement[1]),Input_city);
sNewState:=IF(LENGTH(TRIM(Input_city))=3,IF(COUNT(dAirportReplacement)=0,Input_st,dAirportReplacement[2]),Input_st);
//---------------------------------------------------------------------------
// Derive cnp_name from the company name inputted
//---------------------------------------------------------------------------
dInputPrep:=DATASET([{1,Input_company_name}],{UNSIGNED rid;STRING company_name;});
BIPV2_Company_Names.functions.mac_go(dInputPrep,dCleaned,rid,company_name,,FALSE);
dCnpName:=dCleaned;
//---------------------------------------------------------------------------
// Derive the list of zip codes to use based on the radius
//---------------------------------------------------------------------------
dZips:=BIPV2.fn_get_zips_2(sNewCity,sNewState,Input_zip,Input_zip_radius);
dZipWeights:=IF(dZips[1].zip='',DATASET([],THISMODULE.Process_Biz_Layouts.layout_zip_cases),PROJECT(dZips,TRANSFORM(THISMODULE.Process_Biz_Layouts.layout_zip_cases,SELF.weight:=100-((LEFT.radius/Input_zip_radius)*80);SELF:=LEFT;)));
sCity:=dZips[1].city;
sState:=dZips[1].state;
//---------------------------------------------------------------------------
// Derive phone parts
//---------------------------------------------------------------------------
sPhone3:=IF(allow7digitmatch,'',IF(LENGTH(TRIM(Input_company_phone))=10,Input_company_phone[..3],''));
sPhone3_ex:=IF(allow7digitmatch,IF(LENGTH(TRIM(Input_company_phone))=10,Input_company_phone[..3],''),'');
sPhone7:=IF(LENGTH(TRIM(Input_company_phone))=10,Input_company_phone[4..],IF(LENGTH(TRIM(Input_company_phone))=7,Input_company_phone,''));
//---------------------------------------------------------------------------
// Derive preferred contact first name
//---------------------------------------------------------------------------
sFNamePreferred:=THISMODULE.fn_PreferredName(Input_fname);
//---------------------------------------------------------------------------
// Flag for sorting hierarchically.
//---------------------------------------------------------------------------
sSortFlag:=IF(bHSort,'T','_');
Template := dataset([],THISMODULE.Process_Biz_Layouts.InputLayout);
//�
Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold,TRUE,TRUE
  ,(TYPEOF(Template.parent_proxid))Input_parent_proxid
  ,(TYPEOF(Template.sele_proxid))Input_sele_proxid
  ,(TYPEOF(Template.org_proxid))Input_org_proxid
  ,(TYPEOF(Template.ultimate_proxid))Input_ultimate_proxid
  ,(TYPEOF(Template.has_lgid))Input_has_lgid
  ,(TYPEOF(Template.empid))Input_empid
  ,(TYPEOF(Template.source))Input_source
  ,(TYPEOF(Template.source_record_id))Input_source_record_id
  ,(TYPEOF(Template.source_docid))Input_source_docid
  ,(TYPEOF(Template.company_name))THISMODULE.Fields.Make_company_name((SALT33.StrType)Input_company_name)
  ,(TYPEOF(Template.company_name_prefix))THISMODULE.Fields.Make_company_name_prefix((SALT33.StrType)BizLinkFull.fn_company_name_prefix(dCnpName[1].cnp_name))
  ,(TYPEOF(Template.cnp_name))THISMODULE.Fields.Make_cnp_name((SALT33.StrType)dCnpName[1].cnp_name)
  ,(TYPEOF(Template.cnp_number))dCnpName[1].cnp_number
  ,(TYPEOF(Template.cnp_btype))dCnpName[1].cnp_btype
  ,(TYPEOF(Template.cnp_lowv))dCnpName[1].cnp_lowv
  ,(TYPEOF(Template.company_phone))Input_company_phone
  ,(TYPEOF(Template.company_phone_3))sPhone3
  ,(TYPEOF(Template.company_phone_3_ex))sPhone3_ex
  ,(TYPEOF(Template.company_phone_7))sPhone7
  ,IF(THISMODULE.Fields.Invalid_company_fein((SALT33.StrType)Input_company_fein)=0,(TYPEOF(Template.company_fein))Input_company_fein,(TYPEOF(Template.company_fein))'')
  ,(TYPEOF(Template.company_sic_code1))Input_company_sic_code1
  ,(TYPEOF(Template.active_duns_number))Input_active_duns_number
  ,(TYPEOF(Template.prim_range))Input_prim_range
  ,(TYPEOF(Template.prim_name))THISMODULE.Fields.Make_prim_name((SALT33.StrType)Input_prim_name)
  ,(TYPEOF(Template.sec_range))THISMODULE.Fields.Make_sec_range((SALT33.StrType)Input_sec_range)
  ,(TYPEOF(Template.city))THISMODULE.Fields.Make_city((SALT33.StrType)sCity)
  ,(TYPEOF(Template.city_clean))THISMODULE.Fields.Make_city_clean((SALT33.StrType)'')
  ,(TYPEOF(Template.st))THISMODULE.Fields.Make_st((SALT33.StrType)sState)
  ,dZipWeights
  ,(TYPEOF(Template.company_url))THISMODULE.Fields.Make_company_url((SALT33.StrType)Input_company_url)
  ,(TYPEOF(Template.isContact))Input_isContact
  ,(TYPEOF(Template.contact_did))Input_contact_did
  ,(TYPEOF(Template.title))Input_title
  ,(TYPEOF(Template.fname))THISMODULE.Fields.Make_fname((SALT33.StrType)Input_fname)
  ,(TYPEOF(Template.fname_preferred))THISMODULE.Fields.Make_fname_preferred((SALT33.StrType)sFNamePreferred)
  ,(TYPEOF(Template.mname))THISMODULE.Fields.Make_mname((SALT33.StrType)Input_mname)
  ,(TYPEOF(Template.lname))THISMODULE.Fields.Make_lname((SALT33.StrType)Input_lname)
  ,(TYPEOF(Template.name_suffix))THISMODULE.Fields.Make_name_suffix((SALT33.StrType)Input_name_suffix)
  ,(TYPEOF(Template.contact_ssn))Input_contact_ssn
  ,(TYPEOF(Template.contact_email))THISMODULE.Fields.Make_contact_email((SALT33.StrType)Input_contact_email)
  ,(TYPEOF(Template.sele_flag))sSortFlag
  ,(TYPEOF(Template.org_flag))sSortFlag
  ,(TYPEOF(Template.ult_flag))sSortFlag
  ,(TYPEOF(Template.fallback_value))0
  ,(TYPEOF(Template.CONTACTNAME))(THISMODULE.Fields.Make_fname((SALT33.StrType)Input_fname)+' '+THISMODULE.Fields.Make_mname((SALT33.StrType)Input_mname)+' '+THISMODULE.Fields.Make_lname((SALT33.StrType)Input_lname))
  ,(TYPEOF(Template.STREETADDRESS))(TRIM(Input_prim_range)+' '+THISMODULE.Fields.Make_prim_name((SALT33.StrType)Input_prim_name)+' '+THISMODULE.Fields.Make_sec_range((SALT33.StrType)Input_sec_range))
  ,RecordsOnly,FullMatch,e_rcid,e_proxid,e_seleid,e_orgid,e_ultid,e_powid}],THISMODULE.Process_Biz_Layouts.InputLayout);
//�

dRawResultsNormed:=NORMALIZE(THISMODULE.MEOW_Biz(Input_Data).raw_results,LEFT.Results,TRANSFORM({LEFT.uniqueid;RECORDOF(RIGHT);},SELF:=LEFT;SELF:=RIGHT;));
lMatches:={STRING field;STRING input_value;STRING match_value;INTEGER2 weight;INTEGER1 match_code;};
dProxidMatches:=PROJECT(dRawResultsNormed,TRANSFORM({LEFT.uniqueid;STRING proxid__html;LEFT.weight;LEFT.score;DATASET(lMatches) matches;},
  SELF.matches:=DATASET([
    {'parent_proxid'     ,(STRING)Input_Data[1].parent_proxid   ,(STRING)LEFT.parent_proxid   ,LEFT.parent_proxidweight     ,LEFT.parent_proxid_match_code},
    {'sele_proxid'       ,(STRING)Input_Data[1].sele_proxid     ,(STRING)LEFT.sele_proxid     ,LEFT.sele_proxidweight       ,LEFT.sele_proxid_match_code},
    {'org_proxid'        ,(STRING)Input_Data[1].org_proxid      ,(STRING)LEFT.org_proxid      ,LEFT.org_proxidweight        ,LEFT.org_proxid_match_code},
    {'ultimate_proxid'   ,(STRING)Input_Data[1].ultimate_proxid ,(STRING)LEFT.ultimate_proxid ,LEFT.ultimate_proxidweight   ,LEFT.ultimate_proxid_match_code},
    {'has_lgid'          ,Input_Data[1].has_lgid                ,LEFT.has_lgid                ,LEFT.has_lgidweight          ,LEFT.has_lgid_match_code},
    {'empid'             ,(STRING)Input_Data[1].empid           ,(STRING)LEFT.empid           ,LEFT.empidweight             ,LEFT.empid_match_code},
    {'source'            ,TRIM(Input_Data[1].source)            ,TRIM(LEFT.source)            ,LEFT.sourceweight            ,LEFT.source_match_code},
    {'source_record_id'  ,Input_Data[1].source_record_id        ,LEFT.source_record_id        ,LEFT.source_record_idweight  ,LEFT.source_record_id_match_code},
    {'source_docid'      ,TRIM(Input_Data[1].source_docid)      ,TRIM(LEFT.source_docid)      ,LEFT.source_docidweight      ,LEFT.source_docid_match_code},
    {'company_name'      ,TRIM(Input_Data[1].company_name)      ,TRIM(LEFT.company_name)      ,LEFT.company_nameweight      ,LEFT.company_name_match_code},
    {'cnp_name'          ,TRIM(Input_Data[1].cnp_name)          ,TRIM(LEFT.cnp_name)          ,LEFT.cnp_nameweight          ,0},
    {'cnp_number'        ,TRIM(Input_Data[1].cnp_number)        ,TRIM(LEFT.cnp_number)        ,LEFT.cnp_numberweight        ,LEFT.cnp_number_match_code},
    {'cnp_btype'         ,TRIM(Input_Data[1].cnp_btype)         ,TRIM(LEFT.cnp_btype)         ,LEFT.cnp_btypeweight         ,LEFT.cnp_btype_match_code},
    {'cnp_lowv'          ,TRIM(Input_Data[1].cnp_lowv)          ,TRIM(LEFT.cnp_lowv)          ,LEFT.cnp_lowvweight          ,LEFT.cnp_lowv_match_code},
    {'company_phone'     ,TRIM(Input_Data[1].company_phone)     ,TRIM(LEFT.company_phone)     ,LEFT.company_phoneweight     ,LEFT.company_phone_match_code},
    {'company_phone_3'   ,TRIM(Input_Data[1].company_phone_3)   ,TRIM(LEFT.company_phone_3)   ,LEFT.company_phone_3weight   ,LEFT.company_phone_3_match_code},
    {'company_phone_3_ex',TRIM(Input_Data[1].company_phone_3_ex),TRIM(LEFT.company_phone_3_ex),LEFT.company_phone_3_exweight,LEFT.company_phone_3_ex_match_code},
    {'company_phone_7'   ,TRIM(Input_Data[1].company_phone_7)   ,TRIM(LEFT.company_phone_7)   ,LEFT.company_phone_7weight   ,LEFT.company_phone_7_match_code},
    {'company_fein'      ,TRIM(Input_Data[1].company_fein)      ,TRIM(LEFT.company_fein)      ,LEFT.company_feinweight      ,LEFT.company_fein_match_code},
    {'company_sic_code1' ,TRIM(Input_Data[1].company_sic_code1) ,TRIM(LEFT.company_sic_code1) ,LEFT.company_sic_code1weight ,LEFT.company_sic_code1_match_code},
    {'active_duns_number',TRIM(Input_Data[1].active_duns_number),TRIM(LEFT.active_duns_number),LEFT.active_duns_numberweight,LEFT.active_duns_number_match_code},
    {'prim_range'        ,TRIM(Input_Data[1].prim_range)        ,TRIM(LEFT.prim_range)        ,LEFT.prim_rangeweight        ,LEFT.prim_range_match_code},
    {'prim_name'         ,TRIM(Input_Data[1].prim_name)         ,TRIM(LEFT.prim_name)         ,LEFT.prim_nameweight         ,LEFT.prim_name_match_code},
    {'sec_range'         ,TRIM(Input_Data[1].sec_range)         ,TRIM(LEFT.sec_range)         ,LEFT.sec_rangeweight         ,LEFT.sec_range_match_code},
    {'city'              ,TRIM(Input_Data[1].city)              ,TRIM(LEFT.city)              ,LEFT.cityweight              ,LEFT.city_match_code},
    {'city_clean'        ,TRIM(Input_Data[1].city_clean)        ,TRIM(LEFT.city_clean)        ,LEFT.city_cleanweight        ,LEFT.city_clean_match_code},
    {'st'                ,TRIM(Input_Data[1].st)                ,TRIM(LEFT.st)                ,LEFT.stweight                ,LEFT.st_match_code},
    {'zip_cases'         ,''                                    ,''                           ,LEFT.zipWeight               ,LEFT.zip_match_code},
    {'company_url'       ,TRIM(Input_Data[1].company_url)       ,TRIM(LEFT.company_url)       ,LEFT.company_urlweight       ,0},
    {'isContact'         ,TRIM(Input_Data[1].isContact)         ,TRIM(LEFT.isContact)         ,LEFT.isContactweight         ,LEFT.isContact_match_code},
    {'contact_did'       ,Input_Data[1].contact_did             ,LEFT.contact_did             ,LEFT.contact_didweight       ,LEFT.contact_did_match_code},
    {'title'             ,TRIM(Input_Data[1].title)             ,TRIM(LEFT.title)             ,LEFT.titleweight             ,LEFT.title_match_code},
    {'fname'             ,TRIM(Input_Data[1].fname)             ,TRIM(LEFT.fname)             ,LEFT.fnameweight             ,LEFT.fname_match_code},
    {'fname_preferred'   ,TRIM(Input_Data[1].fname_preferred)   ,TRIM(LEFT.fname_preferred)   ,LEFT.fname_preferredweight   ,LEFT.fname_preferred_match_code},
    {'mname'             ,TRIM(Input_Data[1].mname)             ,TRIM(LEFT.mname)             ,LEFT.mnameweight             ,LEFT.mname_match_code},
    {'lname'             ,TRIM(Input_Data[1].lname)             ,TRIM(LEFT.lname)             ,LEFT.lnameweight             ,LEFT.lname_match_code},
    {'name_suffix'       ,TRIM(Input_Data[1].name_suffix)       ,TRIM(LEFT.name_suffix)       ,LEFT.name_suffixweight       ,LEFT.name_suffix_match_code},
    {'contact_ssn'       ,TRIM(Input_Data[1].contact_ssn)       ,TRIM(LEFT.contact_ssn)       ,LEFT.contact_ssnweight       ,LEFT.contact_ssn_match_code},
    {'contact_email'     ,TRIM(Input_Data[1].contact_email)     ,TRIM(LEFT.contact_email)     ,LEFT.contact_emailweight     ,LEFT.contact_email_match_code},
    {'sele_flag'         ,TRIM(Input_Data[1].sele_flag)         ,TRIM(LEFT.sele_flag)         ,LEFT.sele_flagweight         ,LEFT.sele_flag_match_code},
    {'org_flag'          ,TRIM(Input_Data[1].org_flag)          ,TRIM(LEFT.org_flag)          ,LEFT.org_flagweight          ,LEFT.org_flag_match_code},
    {'ult_flag'          ,TRIM(Input_Data[1].ult_flag)          ,TRIM(LEFT.ult_flag)          ,LEFT.ult_flagweight          ,LEFT.ult_flag_match_code},
    {'CONTACTNAME'       ,TRIM(Input_Data[1].CONTACTNAME)       ,TRIM(LEFT.CONTACTNAME)       ,LEFT.CONTACTNAMEweight       ,LEFT.CONTACTNAME_match_code},
    {'STREETADDRESS'     ,TRIM(Input_Data[1].STREETADDRESS)     ,TRIM(LEFT.STREETADDRESS)     ,LEFT.STREETADDRESSweight     ,LEFT.STREETADDRESS_match_code}
  ],lMatches)(weight<>0);
  SELF.proxid__html:=BIPV2.Hyperlink().BIPHeader(LEFT.proxid);
  SELF:=LEFT;
));

dSeleProxids:=THISMODULE.Process_Biz_Layouts.KeyseleidUp(keyed(seleid=e_seleid)); // 20180329 JA: replaced KeyproxidUp(ultid=e_seleid AND orgid=e_seleid AND seleid=e_seleid);
dLinkIDs:=BIPV2_Best.Key_LinkIds.kfetch(
  inputs:=DEDUP(PROJECT(dSeleProxids,BIPV2.IDlayouts.l_xlink_ids),ALL),
  Level:=BIPV2.IDconstants.Fetch_Level_PROXID
);
lSlimmed:=RECORD
  STRING proxid__html;
  DATASET({STRING name;}) names;
  DATASET({STRING prim_range;STRING prim_name;STRING sec_range;STRING city;STRING st;STRING zip;}) addresses;
  DATASET({STRING phone;}) phones;
  DATASET({STRING fein;}) feins;
  DATASET({STRING duns_number;}) duns_numbers;
  DATASET({STRING sic_code;}) sic_codes;
  DATASET({STRING naics_code;}) naics_codes;
END;
dSlimmed:=PROJECT(dLinkIDs(proxid <> 0),TRANSFORM(lSlimmed, // 20180329 JA: added filter proxid <> 0 because change to KeyseleidUp means dLinkIDs includes rollup record at sele level, and we don't need hyperlink to non-existant proxid
  SELF.proxid__html:=BIPV2.Hyperlink().BIPHeader(LEFT.proxid);
  SELF.names:=PROJECT(LEFT.company_name,TRANSFORM(RECORDOF(lSlimmed.names),SELF.name:=LEFT.company_name;));
  SELF.addresses:=PROJECT(LEFT.company_address,TRANSFORM(RECORDOF(lSlimmed.addresses),SELF.prim_range:=LEFT.company_prim_range;SELF.prim_name:=LEFT.company_prim_name;SELF.sec_range:=LEFT.company_sec_range;SELF.city:=LEFT.company_p_city_name;SELF.st:=LEFT.company_st;SELF.zip:=LEFT.company_zip5;));
  SELF.phones:=PROJECT(LEFT.company_phone,TRANSFORM(RECORDOF(lSlimmed.phones),SELF.phone:=LEFT.company_phone;));
  SELF.feins:=PROJECT(LEFT.company_fein,TRANSFORM(RECORDOF(lSlimmed.feins),SELF.fein:=LEFT.company_fein;));
  SELF.duns_numbers:=PROJECT(LEFT.duns_number,TRANSFORM(RECORDOF(lSlimmed.duns_numbers),SELF.duns_number:=LEFT.duns_number;));
  SELF.sic_codes:=PROJECT(LEFT.sic_code,TRANSFORM(RECORDOF(lSlimmed.sic_codes),SELF.sic_code:=LEFT.company_sic_code1;));
  SELF.naics_codes:=PROJECT(LEFT.naics_code,TRANSFORM(RECORDOF(lSlimmed.naics_codes),SELF.naics_code:=LEFT.company_naics_code1;));
  SELF:=[];
));


dResults:=THISMODULE.MEOW_Biz(Input_Data).Data_;
dProxids:=SORT(TABLE(dResults,{proxid;weight;KeysUsed;KeysFailed;UNSIGNED proxid_count:=COUNT(GROUP);},proxid,KeysFailed),-weight,proxid,KeysFailed);
dNamesAddresses:=TABLE(dResults,{company_name;prim_range;prim_name;city;st;zip;},company_name,prim_range,prim_name,city,st,zip);
dAggregated:=SORT(tools.mac_AggregateFieldsPerID(dResults,proxid),-weights[1].weight);
dInputData:=PROJECT(Input_Data,TRANSFORM({RECORDOF(LEFT) AND NOT [zip_cases];STRING city_entered;STRING state_entered;STRING derived_city;STRING derived_state;STRING zip_entered;UNSIGNED zip_radius;UNSIGNED zip_count;},
  SELF.city_entered:=Input_city;
  SELF.state_entered:=Input_st;
  SELF.derived_city:=sNewCity;
  SELF.derived_state:=sNewState;
  SELF.zip_entered:=Input_zip;
  SELF.zip_radius:=Input_zip_radius;
  SELF.zip_count:=COUNT(LEFT.zip_cases);
  SELF:=LEFT;
));
dKeysUsed:=TABLE(dProxids,{KeysUsed;STRING keys:=THISMODULE.Process_Biz_Layouts.KeysUsedToText(KeysUsed);},KeysUsed);
dKeyLegend:=THISMODULE.linkpaths;
IF(bResearch,
  SEQUENTIAL
  (
    OUTPUT(IF(e_seleid>0,COUNT(dSlimmed),COUNT(dProxidMatches)),NAMED('ProxidCount')),
    IF(e_seleid>0,OUTPUT(dSlimmed,NAMED('SeleProxids'),ALL),OUTPUT(dProxidMatches,NAMED('ProxidMatches'),ALL))
  ),
  IF(bSoapCall,
    OUTPUT(THISMODULE.MEOW_Biz(Input_Data).Raw_Results,NAMED('soap_results')),
    SEQUENTIAL
    (
      IF(GroupProxID,OUTPUT(dAggregated,named('Header_Data_Grouped')),IF(bDebug,OUTPUT(THISMODULE.MEOW_Biz(Input_Data)),OUTPUT(dResults,named('Header_Data')))),
      OUTPUT(dInputData,NAMED('InputData')),
      OUTPUT(dProxids,NAMED('ProxidsReturned')),
      OUTPUT(dNamesAddresses,NAMED('NamesAndAddresses')),
      OUTPUT(dKeysUsed,NAMED('KeysUsed')),
      OUTPUT(dKeyLegend,NAMED('KeyLegend'))
    )
  )
);
ENDMACRO;

