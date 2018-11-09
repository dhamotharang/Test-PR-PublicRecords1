/*--SOAP--
<message name="Biz_Comp_Service">
<part name="parent_proxid" type="xsd:string"/>
<part name="ultimate_proxid" type="xsd:string"/>
<part name="has_lgid" type="xsd:string"/>
<part name="empid" type="xsd:string"/>
<part name="powid" type="xsd:string"/>
<part name="source" type="xsd:string"/>
<part name="source_record_id" type="xsd:string"/>
<part name="company_name" type="xsd:string"/>
<part name="cnp_name" type="xsd:string"/>
<part name="cnp_number" type="xsd:string"/>
<part name="cnp_btype" type="xsd:string"/>
<part name="cnp_lowv" type="xsd:string"/>
<part name="company_phone" type="xsd:string"/>
<part name="company_phone_3" type="xsd:string"/>
<part name="company_phone_7" type="xsd:string"/>
<part name="company_fein" type="xsd:string"/>
<part name="company_sic_code1" type="xsd:string"/>
<part name="prim_range" type="xsd:string"/>
<part name="prim_name" type="xsd:string"/>
<part name="sec_range" type="xsd:string"/>
<part name="p_city_name" type="xsd:string"/>
<part name="st" type="xsd:string"/>
<part name="zip_cases" type="tns:EspStringArray"/>
<part name="company_url" type="xsd:string"/>
<part name="isContact" type="xsd:string"/>
<part name="title" type="xsd:string"/>
<part name="fname" type="xsd:string"/>
<part name="mname" type="xsd:string"/>
<part name="lname" type="xsd:string"/>
<part name="name_suffix" type="xsd:string"/>
<part name="contact_ssn" type="xsd:string"/>
<part name="contact_email" type="xsd:string"/>
<part name="sele_flag" type="xsd:string"/>
<part name="org_flag" type="xsd:string"/>
<part name="ult_flag" type="xsd:string"/>
<part name="CONTACTNAME" type="xsd:string"/>
<part name="STREETADDRESS" type="xsd:string"/>
<part name="ultid" type="unsignedInt"/>
<part name="orgid" type="unsignedInt"/>
<part name="seleid" type="unsignedInt"/>
<part name="proxid" type="unsignedInt"/>
<part name="rcid" type="unsignedInt"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
/*--INFO-- Return all available data for a given entity set. <p>The search criteria needs to be very tight!</p><p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>cnp_name
</p><p>cnp_name:st
</p><p>prim_name:p_city_name:st
</p><p>prim_name:zip
</p><p>prim_name:prim_range:zip
</p><p>company_phone_7
</p><p>company_fein
</p><p>fname:lname
</p><p>company_url
</p><p>contact_email
</p><p>contact_ssn
</p><p>source_record_id:source
</p>*/
EXPORT Biz_Comp_Service := MACRO
  IMPORT SALT26,BizLinkFull;
  SALT26.StrType Input_parent_proxid := '' : STORED('parent_proxid');
  SALT26.StrType Input_ultimate_proxid := '' : STORED('ultimate_proxid');
  SALT26.StrType Input_has_lgid := '' : STORED('has_lgid');
  SALT26.StrType Input_empid := '' : STORED('empid');
  SALT26.StrType Input_powid := '' : STORED('powid');
  SALT26.StrType Input_source := '' : STORED('source');
  SALT26.StrType Input_source_record_id := '' : STORED('source_record_id');
  SALT26.StrType Input_company_name := '' : STORED('company_name');
  SALT26.StrType Input_cnp_name := '' : STORED('cnp_name');
  SALT26.StrType Input_cnp_number := '' : STORED('cnp_number');
  SALT26.StrType Input_cnp_btype := '' : STORED('cnp_btype');
  SALT26.StrType Input_cnp_lowv := '' : STORED('cnp_lowv');
  SALT26.StrType Input_company_phone := '' : STORED('company_phone');
  SALT26.StrType Input_company_phone_3 := '' : STORED('company_phone_3');
  SALT26.StrType Input_company_phone_7 := '' : STORED('company_phone_7');
  SALT26.StrType Input_company_fein := '' : STORED('company_fein');
  SALT26.StrType Input_company_sic_code1 := '' : STORED('company_sic_code1');
  SALT26.StrType Input_prim_range := '' : STORED('prim_range');
  SALT26.StrType Input_prim_name := '' : STORED('prim_name');
  SALT26.StrType Input_sec_range := '' : STORED('sec_range');
  SALT26.StrType Input_p_city_name := '' : STORED('p_city_name');
  SALT26.StrType Input_st := '' : STORED('st');
  SET OF SALT26.StrType Input_zip := [] : STORED('zip_cases');
  SALT26.StrType Input_company_url := '' : STORED('company_url');
  SALT26.StrType Input_isContact := '' : STORED('isContact');
  SALT26.StrType Input_title := '' : STORED('title');
  SALT26.StrType Input_fname := '' : STORED('fname');
  SALT26.StrType Input_mname := '' : STORED('mname');
  SALT26.StrType Input_lname := '' : STORED('lname');
  SALT26.StrType Input_name_suffix := '' : STORED('name_suffix');
  SALT26.StrType Input_contact_ssn := '' : STORED('contact_ssn');
  SALT26.StrType Input_contact_email := '' : STORED('contact_email');
  SALT26.StrType Input_sele_flag := '' : STORED('sele_flag');
  SALT26.StrType Input_org_flag := '' : STORED('org_flag');
  SALT26.StrType Input_ult_flag := '' : STORED('ult_flag');
  SALT26.StrType Input_CONTACTNAME := '' : STORED('CONTACTNAME');
  SALT26.StrType Input_STREETADDRESS := '' : STORED('STREETADDRESS');
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED e_seleid := 0 : STORED('seleid');
  UNSIGNED e_orgid := 0 : STORED('orgid');
  UNSIGNED e_ultid := 0 : STORED('ultid');
  UNSIGNED e_proxid := 0 : STORED('proxid');
  UNSIGNED e_rcid := 0 : STORED('rcid');
// Options to override the data-bomb fetch
  Template := DATASET([],BizLinkFull.Process_Biz_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID
  ,(typeof(Template.parent_proxid))Input_parent_proxid
  ,(typeof(Template.ultimate_proxid))Input_ultimate_proxid
  ,(typeof(Template.has_lgid))Input_has_lgid
  ,(typeof(Template.empid))Input_empid
  ,(typeof(Template.powid))Input_powid
  ,(typeof(Template.source))Input_source
  ,(typeof(Template.source_record_id))Input_source_record_id
  ,(typeof(Template.company_name))BizLinkFull.Fields.Make_company_name((SALT26.StrType)Input_company_name)
  ,(typeof(Template.cnp_name))BizLinkFull.Fields.Make_cnp_name((SALT26.StrType)Input_cnp_name)
  ,(typeof(Template.cnp_number))Input_cnp_number
  ,(typeof(Template.cnp_btype))Input_cnp_btype
  ,(typeof(Template.cnp_lowv))Input_cnp_lowv
  ,(typeof(Template.company_phone))Input_company_phone
  ,(typeof(Template.company_phone_3))Input_company_phone_3
  ,(typeof(Template.company_phone_7))Input_company_phone_7
  ,(typeof(Template.company_fein))BizLinkFull.Fields.Make_company_fein((SALT26.StrType)Input_company_fein)
  ,(typeof(Template.company_sic_code1))Input_company_sic_code1
  ,(typeof(Template.prim_range))Input_prim_range
  ,(typeof(Template.prim_name))BizLinkFull.Fields.Make_prim_name((SALT26.StrType)Input_prim_name)
  ,(typeof(Template.sec_range))BizLinkFull.Fields.Make_sec_range((SALT26.StrType)Input_sec_range)
  ,(typeof(Template.p_city_name))BizLinkFull.Fields.Make_p_city_name((SALT26.StrType)Input_p_city_name)
  ,(typeof(Template.st))BizLinkFull.Fields.Make_st((SALT26.StrType)Input_st)
  ,Input_zip
  ,(typeof(Template.company_url))BizLinkFull.Fields.Make_company_url((SALT26.StrType)Input_company_url)
  ,(typeof(Template.isContact))Input_isContact
  ,(typeof(Template.title))Input_title
  ,(typeof(Template.fname))BizLinkFull.Fields.Make_fname((SALT26.StrType)Input_fname)
  ,(typeof(Template.mname))BizLinkFull.Fields.Make_mname((SALT26.StrType)Input_mname)
  ,(typeof(Template.lname))BizLinkFull.Fields.Make_lname((SALT26.StrType)Input_lname)
  ,(typeof(Template.name_suffix))BizLinkFull.Fields.Make_name_suffix((SALT26.StrType)Input_name_suffix)
  ,(typeof(Template.contact_ssn))Input_contact_ssn
  ,(typeof(Template.contact_email))Input_contact_email
  ,(typeof(Template.sele_flag))Input_sele_flag
  ,(typeof(Template.org_flag))Input_org_flag
  ,(typeof(Template.ult_flag))Input_ult_flag
  ,(typeof(Template.CONTACTNAME))Input_CONTACTNAME
  ,(typeof(Template.STREETADDRESS))Input_STREETADDRESS
  ,false,false,e_rcid,e_proxid,e_seleid,e_orgid,e_ultid}],BizLinkFull.Process_Biz_Layouts.InputLayout);
  pm := BizLinkFull.MEOW_Biz(Input_Data); // This module performs regular xproxid functions
  Options := MODULE(BizLinkFull.Externals.FetchParams) // Interface to pass parameters to fetch
    EXPORT SET OF INTEGER2 ToFetch := [];
  END;
  e := BizLinkFull.Externals.Fetch(pm.Uid_Results,Options); // Perform data-bomb fetch
  OUTPUT(e,NAMED('DataBombs'));
ENDMACRO;

