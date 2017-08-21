/*--SOAP--
<message name="PropertyV2_Biz_Search_Service">
<part name="parent_proxid" type="xsd:string"/>
<part name="ultimate_proxid" type="xsd:string"/>
<part name="has_lgid" type="xsd:string"/>
<part name="empid" type="xsd:string"/>
<part name="powid" type="xsd:string"/>
<part name="source" type="xsd:string"/>
<part name="source_record_id" type="xsd:string"/>
<part name="cnp_number" type="xsd:string"/>
<part name="cnp_btype" type="xsd:string"/>
<part name="cnp_lowv" type="xsd:string"/>
<part name="cnp_name" type="xsd:string"/>
<part name="company_phone" type="xsd:string"/>
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
<part name="contact_email" type="xsd:string"/>
<part name="CONTACTNAME" type="xsd:string"/>
<part name="STREETADDRESS" type="xsd:string"/>
<part name="proxid" type="unsignedInt"/>
<part name="ultid" type="unsignedInt"/>
<part name="orgid" type="unsignedInt"/>
<part name="seleid" type="unsignedInt"/>
<part name="rcid" type="unsignedInt"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
 
/*--INFO-- Search PropertyV2 for matching data!</p><p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>cnp_name
</p><p>cnp_name:st
</p><p>prim_name:p_city_name:st
</p><p>prim_name:zip
</p><p>company_phone
</p><p>company_fein
</p><p>fname:lname
</p><p>company_url
</p><p>contact_email
</p><p>source_record_id:source
</p>*/
EXPORT PropertyV2_Biz_Search_Service := MACRO
  IMPORT SALT29,BIPV2_WAF;
  SALT29.StrType Input_parent_proxid := '' : STORED('parent_proxid');
  SALT29.StrType Input_ultimate_proxid := '' : STORED('ultimate_proxid');
  SALT29.StrType Input_has_lgid := '' : STORED('has_lgid');
  SALT29.StrType Input_empid := '' : STORED('empid');
  SALT29.StrType Input_powid := '' : STORED('powid');
  SALT29.StrType Input_source := '' : STORED('source');
  SALT29.StrType Input_source_record_id := '' : STORED('source_record_id');
  SALT29.StrType Input_cnp_number := '' : STORED('cnp_number');
  SALT29.StrType Input_cnp_btype := '' : STORED('cnp_btype');
  SALT29.StrType Input_cnp_lowv := '' : STORED('cnp_lowv');
  SALT29.StrType Input_cnp_name := '' : STORED('cnp_name');
  SALT29.StrType Input_company_phone := '' : STORED('company_phone');
  SALT29.StrType Input_company_fein := '' : STORED('company_fein');
  SALT29.StrType Input_company_sic_code1 := '' : STORED('company_sic_code1');
  SALT29.StrType Input_prim_range := '' : STORED('prim_range');
  SALT29.StrType Input_prim_name := '' : STORED('prim_name');
  SALT29.StrType Input_sec_range := '' : STORED('sec_range');
  SALT29.StrType Input_p_city_name := '' : STORED('p_city_name');
  SALT29.StrType Input_st := '' : STORED('st');
 
  SET OF SALT29.StrType Input_zip := [] : STORED('zip_cases');
  SALT29.StrType Input_company_url := '' : STORED('company_url');
  SALT29.StrType Input_isContact := '' : STORED('isContact');
  SALT29.StrType Input_title := '' : STORED('title');
  SALT29.StrType Input_fname := '' : STORED('fname');
  SALT29.StrType Input_mname := '' : STORED('mname');
  SALT29.StrType Input_lname := '' : STORED('lname');
  SALT29.StrType Input_name_suffix := '' : STORED('name_suffix');
  SALT29.StrType Input_contact_email := '' : STORED('contact_email');
  SALT29.StrType Input_CONTACTNAME := '' : STORED('CONTACTNAME');
  SALT29.StrType Input_STREETADDRESS := '' : STORED('STREETADDRESS');
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds');
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold');
  UNSIGNED e_seleid := 0 : STORED('seleid');
  UNSIGNED e_orgid := 0 : STORED('orgid');
  UNSIGNED e_ultid := 0 : STORED('ultid');
  UNSIGNED e_proxid := 0 : STORED('proxid');
  UNSIGNED e_rcid := 0 : STORED('rcid');
 
  Template := DATASET([],BIPV2_WAF.Process_Biz_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold
  ,(TYPEOF(Template.parent_proxid))Input_parent_proxid
  ,(TYPEOF(Template.ultimate_proxid))Input_ultimate_proxid
  ,(TYPEOF(Template.has_lgid))Input_has_lgid
  ,(TYPEOF(Template.empid))Input_empid
  ,(TYPEOF(Template.powid))Input_powid
  ,(TYPEOF(Template.source))Input_source
  ,(TYPEOF(Template.source_record_id))Input_source_record_id
  ,(TYPEOF(Template.cnp_number))Input_cnp_number
  ,(TYPEOF(Template.cnp_btype))Input_cnp_btype
  ,(TYPEOF(Template.cnp_lowv))Input_cnp_lowv
  ,(TYPEOF(Template.cnp_name))BIPV2_WAF.Fields.Make_cnp_name((SALT29.StrType)Input_cnp_name)
  ,(TYPEOF(Template.company_phone))Input_company_phone
  ,(TYPEOF(Template.company_fein))BIPV2_WAF.Fields.Make_company_fein((SALT29.StrType)Input_company_fein)
  ,(TYPEOF(Template.company_sic_code1))Input_company_sic_code1
  ,(TYPEOF(Template.prim_range))Input_prim_range
  ,(TYPEOF(Template.prim_name))BIPV2_WAF.Fields.Make_prim_name((SALT29.StrType)Input_prim_name)
  ,(TYPEOF(Template.sec_range))BIPV2_WAF.Fields.Make_sec_range((SALT29.StrType)Input_sec_range)
  ,(TYPEOF(Template.p_city_name))BIPV2_WAF.Fields.Make_p_city_name((SALT29.StrType)Input_p_city_name)
  ,(TYPEOF(Template.st))BIPV2_WAF.Fields.Make_st((SALT29.StrType)Input_st)
  ,Input_zip
  ,(TYPEOF(Template.company_url))BIPV2_WAF.Fields.Make_company_url((SALT29.StrType)Input_company_url)
  ,(TYPEOF(Template.isContact))Input_isContact
  ,(TYPEOF(Template.title))Input_title
  ,(TYPEOF(Template.fname))BIPV2_WAF.Fields.Make_fname((SALT29.StrType)Input_fname)
  ,(TYPEOF(Template.mname))BIPV2_WAF.Fields.Make_mname((SALT29.StrType)Input_mname)
  ,(TYPEOF(Template.lname))BIPV2_WAF.Fields.Make_lname((SALT29.StrType)Input_lname)
  ,(TYPEOF(Template.name_suffix))BIPV2_WAF.Fields.Make_name_suffix((SALT29.StrType)Input_name_suffix)
  ,(TYPEOF(Template.contact_email))Input_contact_email
  ,(TYPEOF(Template.CONTACTNAME))Input_CONTACTNAME
  ,(TYPEOF(Template.STREETADDRESS))Input_STREETADDRESS
  ,false,false,e_rcid,e_proxid,e_seleid,e_orgid,e_ultid}],BIPV2_WAF.Process_Biz_Layouts.InputLayout);
 
  pm := BIPV2_WAF.Mod_PropertyV2().MEOW_(Input_Data); // Instantiate search module
  OUTPUT(pm.Raw_Data,NAMED('Results'));
ENDMACRO;
