/*--SOAP--
<message name="Biz_FragHunter_Service">
<part name="parent_proxid" type="xsd:string"/>
<part name="sele_proxid" type="xsd:string"/>
<part name="org_proxid" type="xsd:string"/>
<part name="ultimate_proxid" type="xsd:string"/>
<part name="has_lgid" type="xsd:string"/>
<part name="empid" type="xsd:string"/>
<part name="source" type="xsd:string"/>
<part name="source_record_id" type="xsd:string"/>
<part name="source_docid" type="xsd:string"/>
<part name="company_name" type="xsd:string"/>
<part name="company_name_prefix" type="xsd:string"/>
<part name="cnp_name" type="xsd:string"/>
<part name="cnp_number" type="xsd:string"/>
<part name="cnp_btype" type="xsd:string"/>
<part name="cnp_lowv" type="xsd:string"/>
<part name="company_phone" type="xsd:string"/>
<part name="company_phone_3" type="xsd:string"/>
<part name="company_phone_3_ex" type="xsd:string"/>
<part name="company_phone_7" type="xsd:string"/>
<part name="company_fein" type="xsd:string"/>
<part name="company_sic_code1" type="xsd:string"/>
<part name="active_duns_number" type="xsd:string"/>
<part name="prim_range" type="xsd:string"/>
<part name="prim_name" type="xsd:string"/>
<part name="sec_range" type="xsd:string"/>
<part name="city" type="xsd:string"/>
<part name="city_clean" type="xsd:string"/>
<part name="st" type="xsd:string"/>
<part name="zip_cases" type="tns:XmlDataSet"/>
<part name="company_url" type="xsd:string"/>
<part name="isContact" type="xsd:string"/>
<part name="contact_did" type="xsd:string"/>
<part name="title" type="xsd:string"/>
<part name="fname" type="xsd:string"/>
<part name="fname_preferred" type="xsd:string"/>
<part name="mname" type="xsd:string"/>
<part name="lname" type="xsd:string"/>
<part name="name_suffix" type="xsd:string"/>
<part name="contact_ssn" type="xsd:string"/>
<part name="contact_email" type="xsd:string"/>
<part name="sele_flag" type="xsd:string"/>
<part name="org_flag" type="xsd:string"/>
<part name="ult_flag" type="xsd:string"/>
<part name="fallback_value" type="xsd:string"/>
<part name="CONTACTNAME" type="xsd:string"/>
<part name="STREETADDRESS" type="xsd:string"/>
<part name="proxid" type="unsignedInt"/>
<part name="ultid" type="unsignedInt"/>
<part name="orgid" type="unsignedInt"/>
<part name="seleid" type="unsignedInt"/>
<part name="powid" type="unsignedInt"/>
<part name="rcid" type="unsignedInt"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
 
/*--INFO-- Return all available data for proxid with similar fields to the one provided</p><p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>cnp_name:zip
</p><p>cnp_name:st
</p><p>cnp_name
</p><p>company_name_prefix
</p><p>prim_name:city:st
</p><p>prim_name:zip
</p><p>prim_name:prim_range:zip
</p><p>company_phone_7
</p><p>company_fein
</p><p>company_url
</p><p>fname_preferred:lname
</p><p>contact_ssn
</p><p>contact_email
</p><p>company_sic_code1:zip
</p><p>source_record_id:source
</p><p>contact_did
</p>*/
EXPORT Biz_FragHunter_Service := MACRO
  IMPORT SALT33,BizLinkFull;
  SALT33.StrType Input_parent_proxid := '' : STORED('parent_proxid');
  SALT33.StrType Input_sele_proxid := '' : STORED('sele_proxid');
  SALT33.StrType Input_org_proxid := '' : STORED('org_proxid');
  SALT33.StrType Input_ultimate_proxid := '' : STORED('ultimate_proxid');
  SALT33.StrType Input_has_lgid := '' : STORED('has_lgid');
  SALT33.StrType Input_empid := '' : STORED('empid');
  SALT33.StrType Input_source := '' : STORED('source');
  SALT33.StrType Input_source_record_id := '' : STORED('source_record_id');
  SALT33.StrType Input_source_docid := '' : STORED('source_docid');
  SALT33.StrType Input_company_name := '' : STORED('company_name');
  SALT33.StrType Input_company_name_prefix := '' : STORED('company_name_prefix');
  SALT33.StrType Input_cnp_name := '' : STORED('cnp_name');
  SALT33.StrType Input_cnp_number := '' : STORED('cnp_number');
  SALT33.StrType Input_cnp_btype := '' : STORED('cnp_btype');
  SALT33.StrType Input_cnp_lowv := '' : STORED('cnp_lowv');
  SALT33.StrType Input_company_phone := '' : STORED('company_phone');
  SALT33.StrType Input_company_phone_3 := '' : STORED('company_phone_3');
  SALT33.StrType Input_company_phone_3_ex := '' : STORED('company_phone_3_ex');
  SALT33.StrType Input_company_phone_7 := '' : STORED('company_phone_7');
  SALT33.StrType Input_company_fein := '' : STORED('company_fein');
  SALT33.StrType Input_company_sic_code1 := '' : STORED('company_sic_code1');
  SALT33.StrType Input_active_duns_number := '' : STORED('active_duns_number');
  SALT33.StrType Input_prim_range := '' : STORED('prim_range');
  SALT33.StrType Input_prim_name := '' : STORED('prim_name');
  SALT33.StrType Input_sec_range := '' : STORED('sec_range');
  SALT33.StrType Input_city := '' : STORED('city');
  SALT33.StrType Input_city_clean := '' : STORED('city_clean');
  SALT33.StrType Input_st := '' : STORED('st');
 
  DATASET(BizLinkFull.process_Biz_layouts.layout_zip_cases) Input_zip := DATASET([],BizLinkFull.process_Biz_layouts.layout_zip_cases)  : STORED('zip_cases');
  SALT33.StrType Input_company_url := '' : STORED('company_url');
  SALT33.StrType Input_isContact := '' : STORED('isContact');
  SALT33.StrType Input_contact_did := '' : STORED('contact_did');
  SALT33.StrType Input_title := '' : STORED('title');
  SALT33.StrType Input_fname := '' : STORED('fname');
  SALT33.StrType Input_fname_preferred := '' : STORED('fname_preferred');
  SALT33.StrType Input_mname := '' : STORED('mname');
  SALT33.StrType Input_lname := '' : STORED('lname');
  SALT33.StrType Input_name_suffix := '' : STORED('name_suffix');
  SALT33.StrType Input_contact_ssn := '' : STORED('contact_ssn');
  SALT33.StrType Input_contact_email := '' : STORED('contact_email');
  SALT33.StrType Input_sele_flag := '' : STORED('sele_flag');
  SALT33.StrType Input_org_flag := '' : STORED('org_flag');
  SALT33.StrType Input_ult_flag := '' : STORED('ult_flag');
  SALT33.StrType Input_fallback_value := '' : STORED('fallback_value');
  SALT33.StrType Input_CONTACTNAME := '' : STORED('CONTACTNAME');
  SALT33.StrType Input_STREETADDRESS := '' : STORED('STREETADDRESS');
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds');
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold');
  UNSIGNED e_seleid := 0 : STORED('seleid');
  UNSIGNED e_orgid := 0 : STORED('orgid');
  UNSIGNED e_ultid := 0 : STORED('ultid');
  UNSIGNED e_powid := 0 : STORED('powid');
  UNSIGNED e_proxid := 0 : STORED('proxid');
  UNSIGNED e_rcid := 0 : STORED('rcid');
 
  Template := DATASET([],BizLinkFull.Process_Biz_Layouts.InputLayout);
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
  ,(TYPEOF(Template.company_name))BizLinkFull.Fields.Make_company_name((SALT33.StrType)Input_company_name)
  ,(TYPEOF(Template.company_name_prefix))BizLinkFull.Fields.Make_company_name_prefix((SALT33.StrType)Input_company_name_prefix)
  ,(TYPEOF(Template.cnp_name))BizLinkFull.Fields.Make_cnp_name((SALT33.StrType)Input_cnp_name)
  ,(TYPEOF(Template.cnp_number))Input_cnp_number
  ,(TYPEOF(Template.cnp_btype))Input_cnp_btype
  ,(TYPEOF(Template.cnp_lowv))Input_cnp_lowv
  ,(TYPEOF(Template.company_phone))Input_company_phone
  ,(TYPEOF(Template.company_phone_3))Input_company_phone_3
  ,(TYPEOF(Template.company_phone_3_ex))Input_company_phone_3_ex
  ,(TYPEOF(Template.company_phone_7))Input_company_phone_7
  ,IF ( BizLinkFull.Fields.Invalid_company_fein((SALT33.StrType)Input_company_fein)=0,(TYPEOF(Template.company_fein))Input_company_fein,(TYPEOF(Template.company_fein))'')
  ,(TYPEOF(Template.company_sic_code1))Input_company_sic_code1
  ,(TYPEOF(Template.active_duns_number))Input_active_duns_number
  ,(TYPEOF(Template.prim_range))Input_prim_range
  ,(TYPEOF(Template.prim_name))BizLinkFull.Fields.Make_prim_name((SALT33.StrType)Input_prim_name)
  ,(TYPEOF(Template.sec_range))BizLinkFull.Fields.Make_sec_range((SALT33.StrType)Input_sec_range)
  ,(TYPEOF(Template.city))BizLinkFull.Fields.Make_city((SALT33.StrType)Input_city)
  ,(TYPEOF(Template.city_clean))BizLinkFull.Fields.Make_city_clean((SALT33.StrType)Input_city_clean)
  ,(TYPEOF(Template.st))BizLinkFull.Fields.Make_st((SALT33.StrType)Input_st)
  ,Input_zip
  ,(TYPEOF(Template.company_url))BizLinkFull.Fields.Make_company_url((SALT33.StrType)Input_company_url)
  ,(TYPEOF(Template.isContact))Input_isContact
  ,(TYPEOF(Template.contact_did))Input_contact_did
  ,(TYPEOF(Template.title))Input_title
  ,(TYPEOF(Template.fname))BizLinkFull.Fields.Make_fname((SALT33.StrType)Input_fname)
  ,(TYPEOF(Template.fname_preferred))BizLinkFull.Fields.Make_fname_preferred((SALT33.StrType)Input_fname_preferred)
  ,(TYPEOF(Template.mname))BizLinkFull.Fields.Make_mname((SALT33.StrType)Input_mname)
  ,(TYPEOF(Template.lname))BizLinkFull.Fields.Make_lname((SALT33.StrType)Input_lname)
  ,(TYPEOF(Template.name_suffix))BizLinkFull.Fields.Make_name_suffix((SALT33.StrType)Input_name_suffix)
  ,(TYPEOF(Template.contact_ssn))Input_contact_ssn
  ,(TYPEOF(Template.contact_email))BizLinkFull.Fields.Make_contact_email((SALT33.StrType)Input_contact_email)
  ,(TYPEOF(Template.sele_flag))Input_sele_flag
  ,(TYPEOF(Template.org_flag))Input_org_flag
  ,(TYPEOF(Template.ult_flag))Input_ult_flag
  ,(TYPEOF(Template.fallback_value))Input_fallback_value
  ,(TYPEOF(Template.CONTACTNAME))Input_CONTACTNAME
  ,(TYPEOF(Template.STREETADDRESS))Input_STREETADDRESS
  ,false,false,e_rcid,e_proxid,e_seleid,e_orgid,e_ultid,e_powid}],BizLinkFull.Process_Biz_Layouts.InputLayout);
 
  pm := BizLinkFull.MEOW_Biz(Input_Data); // This module performs regular xproxid functions
  ds := pm.DataToSearch;
  fids := SET(pm.Uid_Results,proxid);
  odm := BizLinkFull.MEOW_Biz(ds,true,fids);
  OUTPUT(odm.Raw_Results,NAMED('PossibleFragments'));
  OUTPUT(odm.Raw_Data,NAMED('FragmentData'));
  OUTPUT(pm.Raw_Data,NAMED('OriginalData'));
ENDMACRO;

