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
IMPORT SALT28,BizLinkFull_HS;
IMPORT BIPV2;
IMPORT BIPV2_Company_Names;
IMPORT lib_ziplib;
IMPORT lib_stringlib;
IMPORT RiskWise;
THISMODULE:=BizLinkFull_HS;
//¶
  UNSIGNED e_proxid := 0 : STORED('proxid');
  SALT31.StrType Input_company_name := '' : STORED('company_name');
  SALT31.StrType Input_prim_range := '' : STORED('prim_range');
  SALT31.StrType Input_prim_name := '' : STORED('prim_name');
  SALT31.StrType Input_sec_range := '' : STORED('sec_range');
  SALT31.StrType Input_city := '' : STORED('city');
  SALT31.StrType Input_st := '' : STORED('st');
  SALT31.StrType Input_company_phone := '' : STORED('company_phone');
  SALT31.StrType Input_company_url := '' : STORED('company_url');
  SALT31.StrType Input_contact_did := '' : STORED('contact_did');
  SALT31.StrType Input_title := '' : STORED('title');
  SALT31.StrType Input_fname := '' : STORED('fname');
  SALT31.StrType Input_mname := '' : STORED('mname');
  SALT31.StrType Input_lname := '' : STORED('lname');
  SALT31.StrType Input_name_suffix := '' : STORED('name_suffix');
  SALT31.StrType Input_contact_email := '' : STORED('contact_email');
  SALT31.StrType Input_contact_ssn := '' : STORED('contact_ssn');
  SALT31.StrType Input_company_fein := '' : STORED('company_fein');
  SALT31.StrType Input_active_duns_number := '' : STORED('active_duns_number');
  SALT31.StrType Input_company_sic_code1 := '' : STORED('company_sic_code1');
  SALT31.StrType Input_source := '' : STORED('source');
  SALT31.StrType Input_source_docid := '' : STORED('source_docid');
  SALT31.StrType Input_source_record_id := '' : STORED('source_record_id');
  SALT31.StrType Input_parent_proxid := '' : STORED('parent_proxid');
  SALT31.StrType Input_sele_proxid := '' : STORED('sele_proxid');
  SALT31.StrType Input_org_proxid := '' : STORED('org_proxid');
  SALT31.StrType Input_ultimate_proxid := '' : STORED('ultimate_proxid');
  SALT31.StrType Input_has_lgid := '' : STORED('has_lgid');
  SALT31.StrType Input_empid := '' : STORED('empid');
  UNSIGNED e_powid := 0 : STORED('powid');
  SALT31.StrType Input_isContact := '' : STORED('isContact');
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds');
  BOOLEAN FullMatch := FALSE : STORED('MatchAllInOneRecord');
  BOOLEAN RecordsOnly := FALSE: STORED('RecordsOnly');
//¶
  UNSIGNED e_seleid := 0 : STORED('seleid');
  UNSIGNED e_orgid := 0 : STORED('orgid');
  UNSIGNED e_ultid := 0 : STORED('ultid');
  UNSIGNED e_rcid := 0 : STORED('rcid');
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  STRING Input_zip := '' : STORED('zip');
  UNSIGNED Input_zip_radius:=0:STORED('zip_radius');
  BOOLEAN allow7digitmatch:=FALSE:STORED('allow7digitmatch');
  BOOLEAN GroupProxID:=false: stored('GroupProxID');
  BOOLEAN bDebug:=TRUE:STORED('DebugMode');
  BOOLEAN bBatch:=FALSE:STORED('BatachMode');
  BOOLEAN bHSort:=FALSE:STORED('HierarchicalSort');
  BOOLEAN bSoapCall:=FALSE:STORED('SoapCallMode');
  UNSIGNED Input_LeadThreshold:=10:STORED('LeadThreshold');
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
//¶
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
  ,(TYPEOF(Template.company_name))THISMODULE.Fields.Make_company_name((SALT33.StrType)Input_company_name)
  ,(TYPEOF(Template.company_name_prefix))THISMODULE.Fields.Make_company_name_prefix((SALT33.StrType)Input_company_name[..5])
  ,(TYPEOF(Template.cnp_name))THISMODULE.Fields.Make_cnp_name((SALT33.StrType)dCnpName[1].cnp_name)
  ,(TYPEOF(Template.cnp_number))dCnpName[1].cnp_number
  ,(TYPEOF(Template.cnp_btype))dCnpName[1].cnp_btype
  ,(TYPEOF(Template.cnp_lowv))dCnpName[1].cnp_lowv
  ,(TYPEOF(Template.company_phone))Input_company_phone
  ,(TYPEOF(Template.company_phone_3))sPhone3
  ,(TYPEOF(Template.company_phone_3_ex))sPhone3_ex
  ,(TYPEOF(Template.company_phone_7))sPhone7
  ,IF ( THISMODULE.Fields.Invalid_company_fein((SALT33.StrType)Input_company_fein)=0,(TYPEOF(Template.company_fein))Input_company_fein,(TYPEOF(Template.company_fein))'')
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
  ,(TYPEOF(Template.CONTACTNAME))(THISMODULE.Fields.Make_fname((SALT29.StrType)Input_fname)+' '+THISMODULE.Fields.Make_mname((SALT29.StrType)Input_mname)+' '+THISMODULE.Fields.Make_lname((SALT29.StrType)Input_lname))
  ,(TYPEOF(Template.STREETADDRESS))(TRIM(Input_prim_range)+' '+THISMODULE.Fields.Make_prim_name((SALT29.StrType)Input_prim_name)+' '+THISMODULE.Fields.Make_sec_range((SALT29.StrType)Input_sec_range))
  ,RecordsOnly,FullMatch,e_rcid,e_proxid,e_seleid,e_orgid,e_ultid,e_powid}],THISMODULE.Process_Biz_Layouts.InputLayout);
//¶
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
  IF(GroupProxID,OUTPUT(dAggregated,named('Header_Data_Grouped')),IF(bDebug,OUTPUT(THISMODULE.MEOW_Biz(Input_Data)),OUTPUT(dResults,named('Header_Data')))),
  OUTPUT(dInputData,NAMED('InputData')),
  OUTPUT(dProxids,NAMED('ProxidsReturned')),
  OUTPUT(dNamesAddresses,NAMED('NamesAndAddresses')),
  OUTPUT(dKeysUsed,NAMED('KeysUsed')),
  OUTPUT(dKeyLegend,NAMED('KeyLegend'))
));
ENDMACRO;
