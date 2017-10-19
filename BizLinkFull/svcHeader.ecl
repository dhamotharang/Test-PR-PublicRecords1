EXPORT svcHeader := MACRO
IMPORT SALT28,BizLinkFull;
IMPORT BIPV2;
IMPORT BIPV2_Company_Names;
IMPORT lib_ziplib;
IMPORT lib_stringlib;
IMPORT RiskWise;
THISMODULE:=BizLinkFull;
//�
  UNSIGNED e_proxid := 0 : STORED('proxid',FORMAT(SEQUENCE(1)));
  SALT29.StrType Input_company_name := '' : STORED('company_name',FORMAT(SEQUENCE(2)));
  SALT29.StrType Input_prim_range := '' : STORED('prim_range',FORMAT(FIELDWIDTH(10),SEQUENCE(3)));
  SALT29.StrType Input_prim_name := '' : STORED('prim_name',FORMAT(SEQUENCE(4)));
  SALT29.StrType Input_sec_range := '' : STORED('sec_range',FORMAT(SEQUENCE(5)));
  SALT29.StrType Input_city := '' : STORED('city',FORMAT(SEQUENCE(6)));
  SALT29.StrType Input_st := '' : STORED('st',FORMAT(SEQUENCE(7)));
  SALT29.StrType Input_company_phone := '' : STORED('company_phone',FORMAT(SEQUENCE(10)));
  SALT29.StrType Input_company_url := '' : STORED('company_url',FORMAT(SEQUENCE(11)));
  SALT29.StrType Input_contact_did := '' : STORED('contact_did',FORMAT(SEQUENCE(12)));
  SALT29.StrType Input_title := '' : STORED('title',FORMAT(SEQUENCE(13)));
  SALT29.StrType Input_fname := '' : STORED('fname',FORMAT(SEQUENCE(14)));
  SALT29.StrType Input_mname := '' : STORED('mname',FORMAT(SEQUENCE(15)));
  SALT29.StrType Input_lname := '' : STORED('lname',FORMAT(SEQUENCE(16)));
  SALT29.StrType Input_name_suffix := '' : STORED('name_suffix',FORMAT(SEQUENCE(17)));
  SALT29.StrType Input_contact_email := '' : STORED('contact_email',FORMAT(SEQUENCE(18)));
  SALT29.StrType Input_contact_ssn := '' : STORED('contact_ssn',FORMAT(SEQUENCE(19)));
  SALT29.StrType Input_company_fein := '' : STORED('company_fein',FORMAT(SEQUENCE(20)));
  SALT29.StrType Input_company_sic_code1 := '' : STORED('company_sic_code1',FORMAT(SEQUENCE(21)));
  SALT29.StrType Input_active_duns_number := '' : STORED('active_duns_number',FORMAT(SEQUENCE(22)));
  SALT29.StrType Input_source := '' : STORED('source',FORMAT(SEQUENCE(23)));
  SALT29.StrType Input_source_record_id := '' : STORED('source_record_id',FORMAT(SEQUENCE(24)));
  SALT29.StrType Input_source_docid := '' : STORED('source_docid',FORMAT(SEQUENCE(25)));
  SALT29.StrType Input_parent_proxid := '' : STORED('parent_proxid',FORMAT(SEQUENCE(26)));
  SALT29.StrType Input_sele_proxid := '' : STORED('sele_proxid',FORMAT(SEQUENCE(27)));
  SALT29.StrType Input_org_proxid := '' : STORED('org_proxid',FORMAT(SEQUENCE(28)));
  SALT29.StrType Input_ultimate_proxid := '' : STORED('ultimate_proxid',FORMAT(SEQUENCE(29)));
  SALT29.StrType Input_has_lgid := '' : STORED('has_lgid',FORMAT(SEQUENCE(30)));
  SALT29.StrType Input_empid := '' : STORED('empid',FORMAT(FEW,SEQUENCE(31)));
  UNSIGNED e_powid := 0 : STORED('powid',FORMAT(SEQUENCE(32)));
  SALT29.StrType Input_isContact := '' : STORED('isContact',FORMAT(SEQUENCE(33)));
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID',FORMAT(SEQUENCE(34)));
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
//---------------------------------------------------------------------------
// If an airport code is entered, derive the city and state from that
//---------------------------------------------------------------------------
dAirportReplacement:=BIPV2.fn_translate_city(stringlib.StringToUpperCase(Input_city));
sNewCity:=stringlib.StringToUpperCase(IF(LENGTH(TRIM(Input_city))=3,IF(COUNT(dAirportReplacement)=0,Input_city,dAirportReplacement[1]),Input_city));
sNewState_:=stringlib.StringToUpperCase(IF(LENGTH(TRIM(Input_city))=3,IF(COUNT(dAirportReplacement)=0,Input_st,dAirportReplacement[2]),Input_st));
//---------------------------------------------------------------------------
// Derive cnp_name from the company name inputted
//---------------------------------------------------------------------------
dInputPrep:=DATASET([{1,Input_company_name}],{UNSIGNED rid;STRING company_name;});
BIPV2_Company_Names.functions.mac_go(dInputPrep,dCleaned,rid,company_name,,FALSE);
dCnpName:=dCleaned;
//---------------------------------------------------------------------------
// If city is entered, but not state, determine if the city can only be in
// one state and if so, add the state
//---------------------------------------------------------------------------
sNewState:=IF(sNewState_<>'',sNewState_,IF(sNewCity='','',address.Key_CityStChance(city_name=sNewCity and percent_chance>=99)[1].st));
//---------------------------------------------------------------------------
// Derive the list of zip codes to use based on the radius
//---------------------------------------------------------------------------
dZips:=BIPV2.fn_get_zips_2(sNewCity,sNewState,Input_zip,Input_zip_radius);
dZipWeights:=IF(dZips[1].zip='',DATASET([],THISMODULE.Process_Biz_Layouts.layout_zip_cases),PROJECT(dZips,TRANSFORM(THISMODULE.Process_Biz_Layouts.layout_zip_cases,SELF.weight:=100-((LEFT.radius/Input_zip_radius)*50);SELF:=LEFT;)));
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
Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold
  ,(TYPEOF(Template.parent_proxid))Input_parent_proxid
  ,(TYPEOF(Template.sele_proxid))Input_sele_proxid
  ,(TYPEOF(Template.org_proxid))Input_org_proxid
  ,(TYPEOF(Template.ultimate_proxid))Input_ultimate_proxid
  ,(TYPEOF(Template.has_lgid))Input_has_lgid
  ,(TYPEOF(Template.empid))Input_empid
  ,(TYPEOF(Template.source))Input_source
  ,(TYPEOF(Template.source_record_id))Input_source_record_id
  ,(TYPEOF(Template.source_docid))Input_source_docid
  ,(TYPEOF(Template.company_name))THISMODULE.Fields.Make_company_name((SALT29.StrType)Input_company_name)
  ,(TYPEOF(Template.company_name_prefix))THISMODULE.Fields.Make_company_name_prefix((SALT29.StrType)dCnpName[1].cnp_name[..5])
  ,(TYPEOF(Template.cnp_name))THISMODULE.Fields.Make_cnp_name((SALT29.StrType)dCnpName[1].cnp_name)
  ,(TYPEOF(Template.cnp_number))dCnpName[1].cnp_number
  ,(TYPEOF(Template.cnp_btype))dCnpName[1].cnp_btype
  ,(TYPEOF(Template.cnp_lowv))dCnpName[1].cnp_lowv
  ,(TYPEOF(Template.company_phone))Input_company_phone
  ,(TYPEOF(Template.company_phone_3))sPhone3
  ,(TYPEOF(Template.company_phone_3_ex))sPhone3_ex
  ,(TYPEOF(Template.company_phone_7))sPhone7
  ,(TYPEOF(Template.company_fein))THISMODULE.Fields.Make_company_fein((SALT29.StrType)Input_company_fein)
  ,(TYPEOF(Template.company_sic_code1))Input_company_sic_code1
  ,(TYPEOF(Template.active_duns_number))Input_active_duns_number
  ,(TYPEOF(Template.prim_range))Input_prim_range
  ,(TYPEOF(Template.prim_name))THISMODULE.Fields.Make_prim_name((SALT29.StrType)Input_prim_name)
  ,(TYPEOF(Template.sec_range))THISMODULE.Fields.Make_sec_range((SALT29.StrType)Input_sec_range)
  ,(TYPEOF(Template.city))THISMODULE.Fields.Make_city((SALT29.StrType)sCity)
  ,(TYPEOF(Template.city_clean))THISMODULE.Fields.Make_city_clean((SALT29.StrType)'')
  ,(TYPEOF(Template.st))THISMODULE.Fields.Make_st((SALT29.StrType)sState)
  ,dZipWeights
  ,(TYPEOF(Template.company_url))THISMODULE.Fields.Make_company_url((SALT29.StrType)Input_company_url)
  ,(TYPEOF(Template.isContact))Input_isContact
  ,(TYPEOF(Template.contact_did))Input_contact_did
  ,(TYPEOF(Template.title))Input_title
  ,(TYPEOF(Template.fname))THISMODULE.Fields.Make_fname((SALT29.StrType)Input_fname)
  ,(TYPEOF(Template.fname_preferred))THISMODULE.Fields.Make_fname_preferred((SALT29.StrType)sFNamePreferred)
  ,(TYPEOF(Template.mname))THISMODULE.Fields.Make_mname((SALT29.StrType)Input_mname)
  ,(TYPEOF(Template.lname))THISMODULE.Fields.Make_lname((SALT29.StrType)Input_lname)
  ,(TYPEOF(Template.name_suffix))THISMODULE.Fields.Make_name_suffix((SALT29.StrType)Input_name_suffix)
  ,(TYPEOF(Template.contact_ssn))Input_contact_ssn
  ,(TYPEOF(Template.contact_email))THISMODULE.Fields.Make_contact_email((SALT29.StrType)Input_contact_email)
  ,(TYPEOF(Template.sele_flag))sSortFlag
  ,(TYPEOF(Template.org_flag))sSortFlag
  ,(TYPEOF(Template.ult_flag))sSortFlag
  ,(TYPEOF(Template.CONTACTNAME))(THISMODULE.Fields.Make_fname((SALT29.StrType)Input_fname)+' '+THISMODULE.Fields.Make_mname((SALT29.StrType)Input_mname)+' '+THISMODULE.Fields.Make_lname((SALT29.StrType)Input_lname))
  ,(TYPEOF(Template.STREETADDRESS))(TRIM(Input_prim_range)+' '+THISMODULE.Fields.Make_prim_name((SALT29.StrType)Input_prim_name)+' '+THISMODULE.Fields.Make_sec_range((SALT29.StrType)Input_sec_range))
  ,RecordsOnly,FullMatch,e_rcid,e_proxid,e_seleid,e_orgid,e_ultid,e_powid}],THISMODULE.Process_Biz_Layouts.InputLayout);
//�
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
IF(bSoapCall,
OUTPUT(THISMODULE.MEOW_Biz(Input_Data).Raw_Results,NAMED('soap_results')),
SEQUENTIAL(
  IF(GroupProxID,OUTPUT(dAggregated,named('Header_Data_Grouped')),IF(bDebug,OUTPUT(THISMODULE.MEOW_Biz(Input_Data)),OUTPUT(dResults,named('Header_Data'),ALL))),
  OUTPUT(dInputData,NAMED('InputData')),
  OUTPUT(dProxids,NAMED('ProxidsReturned')),
  OUTPUT(dNamesAddresses,NAMED('NamesAndAddresses')),
  OUTPUT(dKeysUsed,NAMED('KeysUsed')),
  OUTPUT(dKeyLegend,NAMED('KeyLegend'))
));
ENDMACRO;
