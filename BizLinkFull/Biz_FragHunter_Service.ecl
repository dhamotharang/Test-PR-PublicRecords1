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
<part name="bGetAllScores" type="xsd:boolean"/>
<part name="disableForce" type="xsd:boolean"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/


/*--INFO-- Return all available data for proxid with similar fields to the one provided</p>
<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>cnp_name:zip</p>
<p>cnp_name:st</p>
<p>cnp_name</p>
<p>company_name_prefix</p>
<p>prim_name:city:st</p>
<p>prim_name:zip</p>
<p>prim_name:prim_range:zip</p>
<p>company_phone_7</p>
<p>company_fein</p>
<p>company_url</p>
<p>fname_preferred:lname:zip</p>
<p>fname_preferred:lname:st</p>
<p>contact_ssn</p>
<p>contact_email</p>
<p>company_sic_code1:zip</p>
<p>source_record_id:source</p>
<p>contact_did</p>
*/
EXPORT Biz_FragHunter_Service := MACRO
  IMPORT SALT44,BizLinkFull;
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID', FORMAT(SEQUENCE(1)));
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds', FORMAT(SEQUENCE(2)));
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold', FORMAT(SEQUENCE(3)));

  SALT44.StrType Input_parent_proxid := '' : STORED('parent_proxid', FORMAT(SEQUENCE(4)));

  SALT44.StrType Input_sele_proxid := '' : STORED('sele_proxid', FORMAT(SEQUENCE(5)));

  SALT44.StrType Input_org_proxid := '' : STORED('org_proxid', FORMAT(SEQUENCE(6)));

  SALT44.StrType Input_ultimate_proxid := '' : STORED('ultimate_proxid', FORMAT(SEQUENCE(7)));

  SALT44.StrType Input_has_lgid := '' : STORED('has_lgid', FORMAT(SEQUENCE(8)));

  SALT44.StrType Input_empid := '' : STORED('empid', FORMAT(SEQUENCE(9)));

  SALT44.StrType Input_source := '' : STORED('source', FORMAT(SEQUENCE(10)));

  SALT44.StrType Input_source_record_id := '' : STORED('source_record_id', FORMAT(SEQUENCE(11)));

  SALT44.StrType Input_source_docid := '' : STORED('source_docid', FORMAT(SEQUENCE(12)));

  SALT44.StrType Input_company_name := '' : STORED('company_name', FORMAT(SEQUENCE(13)));

  SALT44.StrType Input_company_name_prefix := '' : STORED('company_name_prefix', FORMAT(SEQUENCE(14)));

  SALT44.StrType Input_cnp_name := '' : STORED('cnp_name', FORMAT(SEQUENCE(15)));

  SALT44.StrType Input_cnp_number := '' : STORED('cnp_number', FORMAT(SEQUENCE(16)));

  SALT44.StrType Input_cnp_btype := '' : STORED('cnp_btype', FORMAT(SEQUENCE(17)));

  SALT44.StrType Input_cnp_lowv := '' : STORED('cnp_lowv', FORMAT(SEQUENCE(18)));

  SALT44.StrType Input_company_phone := '' : STORED('company_phone', FORMAT(SEQUENCE(19)));

  SALT44.StrType Input_company_phone_3 := '' : STORED('company_phone_3', FORMAT(SEQUENCE(20)));

  SALT44.StrType Input_company_phone_3_ex := '' : STORED('company_phone_3_ex', FORMAT(SEQUENCE(21)));

  SALT44.StrType Input_company_phone_7 := '' : STORED('company_phone_7', FORMAT(SEQUENCE(22)));

  SALT44.StrType Input_company_fein := '' : STORED('company_fein', FORMAT(SEQUENCE(23)));

  SALT44.StrType Input_company_sic_code1 := '' : STORED('company_sic_code1', FORMAT(SEQUENCE(24)));

  SALT44.StrType Input_active_duns_number := '' : STORED('active_duns_number', FORMAT(SEQUENCE(25)));

  SALT44.StrType Input_prim_range := '' : STORED('prim_range', FORMAT(SEQUENCE(26)));

  SALT44.StrType Input_prim_name := '' : STORED('prim_name', FORMAT(SEQUENCE(27)));

  SALT44.StrType Input_sec_range := '' : STORED('sec_range', FORMAT(SEQUENCE(28)));

  SALT44.StrType Input_city := '' : STORED('city', FORMAT(SEQUENCE(29)));

  SALT44.StrType Input_city_clean := '' : STORED('city_clean', FORMAT(SEQUENCE(30)));

  SALT44.StrType Input_st := '' : STORED('st', FORMAT(SEQUENCE(31)));

  DATASET(BizLinkFull.Process_Biz_Layouts.layout_zip_cases) Input_zip := DATASET([],BizLinkFull.Process_Biz_Layouts.layout_zip_cases)  : STORED('zip_cases', FORMAT(SEQUENCE(32)));
  SALT44.StrType Input_company_url := '' : STORED('company_url', FORMAT(SEQUENCE(33)));

  SALT44.StrType Input_isContact := '' : STORED('isContact', FORMAT(SEQUENCE(34)));

  SALT44.StrType Input_contact_did := '' : STORED('contact_did', FORMAT(SEQUENCE(35)));

  SALT44.StrType Input_title := '' : STORED('title', FORMAT(SEQUENCE(36)));

  SALT44.StrType Input_fname := '' : STORED('fname', FORMAT(SEQUENCE(37)));

  SALT44.StrType Input_fname_preferred := '' : STORED('fname_preferred', FORMAT(SEQUENCE(38)));

  SALT44.StrType Input_mname := '' : STORED('mname', FORMAT(SEQUENCE(39)));

  SALT44.StrType Input_lname := '' : STORED('lname', FORMAT(SEQUENCE(40)));

  SALT44.StrType Input_name_suffix := '' : STORED('name_suffix', FORMAT(SEQUENCE(41)));

  SALT44.StrType Input_contact_ssn := '' : STORED('contact_ssn', FORMAT(SEQUENCE(42)));

  SALT44.StrType Input_contact_email := '' : STORED('contact_email', FORMAT(SEQUENCE(43)));

  SALT44.StrType Input_sele_flag := '' : STORED('sele_flag', FORMAT(SEQUENCE(44)));

  SALT44.StrType Input_org_flag := '' : STORED('org_flag', FORMAT(SEQUENCE(45)));

  SALT44.StrType Input_ult_flag := '' : STORED('ult_flag', FORMAT(SEQUENCE(46)));

  SALT44.StrType Input_fallback_value := '' : STORED('fallback_value', FORMAT(SEQUENCE(47)));

  SALT44.StrType Input_CONTACTNAME := '' : STORED('CONTACTNAME', FORMAT(SEQUENCE(48)));

  SALT44.StrType Input_STREETADDRESS := '' : STORED('STREETADDRESS', FORMAT(SEQUENCE(49)));




  UNSIGNED e_seleid := 0 : STORED('seleid', FORMAT(SEQUENCE(50)));
  UNSIGNED e_orgid := 0 : STORED('orgid', FORMAT(SEQUENCE(51)));
  UNSIGNED e_ultid := 0 : STORED('ultid', FORMAT(SEQUENCE(52)));
  UNSIGNED e_powid := 0 : STORED('powid', FORMAT(SEQUENCE(53)));
  UNSIGNED e_proxid := 0 : STORED('proxid', FORMAT(SEQUENCE(54)));
  UNSIGNED e_rcid := 0 : STORED('rcid', FORMAT(SEQUENCE(55)));

  BOOLEAN Input_bGetAllScores := FALSE : STORED('bGetAllScores', FORMAT(SEQUENCE(56)));

  BOOLEAN Input_disableForce := FALSE : STORED('disableForce', FORMAT(SEQUENCE(57)));



  Template := DATASET([],BizLinkFull.Process_Biz_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold,Input_bGetAllScores,Input_disableForce,0
  ,(TYPEOF(Template.parent_proxid))Input_parent_proxid
  ,(TYPEOF(Template.sele_proxid))Input_sele_proxid
  ,(TYPEOF(Template.org_proxid))Input_org_proxid
  ,(TYPEOF(Template.ultimate_proxid))Input_ultimate_proxid
  ,(TYPEOF(Template.has_lgid))Input_has_lgid
  ,(TYPEOF(Template.empid))Input_empid
  ,(TYPEOF(Template.source))Input_source
  ,(TYPEOF(Template.source_record_id))Input_source_record_id
  ,(TYPEOF(Template.source_docid))Input_source_docid
  ,(TYPEOF(Template.company_name))BizLinkFull.Fields.Make_company_name((SALT44.StrType)Input_company_name)
  ,(TYPEOF(Template.company_name_prefix))BizLinkFull.Fields.Make_company_name_prefix((SALT44.StrType)Input_company_name_prefix)
  ,(TYPEOF(Template.cnp_name))BizLinkFull.Fields.Make_cnp_name((SALT44.StrType)Input_cnp_name)
  ,(TYPEOF(Template.cnp_number))Input_cnp_number
  ,(TYPEOF(Template.cnp_btype))Input_cnp_btype
  ,(TYPEOF(Template.cnp_lowv))Input_cnp_lowv
  ,(TYPEOF(Template.company_phone))Input_company_phone
  ,(TYPEOF(Template.company_phone_3))Input_company_phone_3
  ,(TYPEOF(Template.company_phone_3_ex))Input_company_phone_3_ex
  ,(TYPEOF(Template.company_phone_7))Input_company_phone_7
  ,IF ( BizLinkFull.Fields.Invalid_company_fein((SALT44.StrType)Input_company_fein)=0,(TYPEOF(Template.company_fein))Input_company_fein,(TYPEOF(Template.company_fein))'')
  ,(TYPEOF(Template.company_sic_code1))Input_company_sic_code1
  ,(TYPEOF(Template.active_duns_number))Input_active_duns_number
  ,(TYPEOF(Template.prim_range))Input_prim_range
  ,(TYPEOF(Template.prim_name))BizLinkFull.Fields.Make_prim_name((SALT44.StrType)Input_prim_name)
  ,(TYPEOF(Template.sec_range))BizLinkFull.Fields.Make_sec_range((SALT44.StrType)Input_sec_range)
  ,(TYPEOF(Template.city))BizLinkFull.Fields.Make_city((SALT44.StrType)Input_city)
  ,(TYPEOF(Template.city_clean))BizLinkFull.Fields.Make_city_clean((SALT44.StrType)Input_city_clean)
  ,(TYPEOF(Template.st))BizLinkFull.Fields.Make_st((SALT44.StrType)Input_st)
  ,Input_zip
  ,(TYPEOF(Template.company_url))BizLinkFull.Fields.Make_company_url((SALT44.StrType)Input_company_url)
  ,(TYPEOF(Template.isContact))Input_isContact
  ,(TYPEOF(Template.contact_did))Input_contact_did
  ,(TYPEOF(Template.title))Input_title
  ,(TYPEOF(Template.fname))BizLinkFull.Fields.Make_fname((SALT44.StrType)Input_fname)
  ,(TYPEOF(Template.fname_preferred))BizLinkFull.Fields.Make_fname_preferred((SALT44.StrType)Input_fname_preferred)
  ,(TYPEOF(Template.mname))BizLinkFull.Fields.Make_mname((SALT44.StrType)Input_mname)
  ,(TYPEOF(Template.lname))BizLinkFull.Fields.Make_lname((SALT44.StrType)Input_lname)
  ,(TYPEOF(Template.name_suffix))BizLinkFull.Fields.Make_name_suffix((SALT44.StrType)Input_name_suffix)
  ,(TYPEOF(Template.contact_ssn))Input_contact_ssn
  ,(TYPEOF(Template.contact_email))BizLinkFull.Fields.Make_contact_email((SALT44.StrType)Input_contact_email)
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
  odm := BizLinkFull.MEOW_Biz(ds, true, fids);
  OUTPUT(odm.Raw_Results,NAMED('PossibleFragments'));
  OUTPUT(odm.Raw_Data,NAMED('FragmentData'));
  OUTPUT(pm.Raw_Data,NAMED('OriginalData'));
ENDMACRO;

