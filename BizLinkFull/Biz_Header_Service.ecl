/*--SOAP--
<message name="Biz_Header_Service">
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
<part name="SortBy" type="xsd:string"/>
<part name="MatchAllInOneRecord" type="xsd:boolean"/>
<part name="RecordsOnly" type="xsd:boolean"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="bGetAllScores" type="xsd:boolean"/>
<part name="disableForce" type="xsd:boolean"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
 
/*--INFO-- Find those entities having records matching the input criteria.
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
<p>fname_preferred:lname</p>
<p>contact_ssn</p>
<p>contact_email</p>
<p>company_sic_code1:zip</p>
<p>source_record_id:source</p>
<p>contact_did</p>
<p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>
*/
EXPORT Biz_Header_Service := MACRO
  IMPORT SALT37,BizLinkFull;
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID', FORMAT(SEQUENCE(1)));
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds', FORMAT(SEQUENCE(2)));
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold', FORMAT(SEQUENCE(3)));
  SALT37.StrType Input_parent_proxid := '' : STORED('parent_proxid', FORMAT(SEQUENCE(4)));
  SALT37.StrType Input_sele_proxid := '' : STORED('sele_proxid', FORMAT(SEQUENCE(5)));
  SALT37.StrType Input_org_proxid := '' : STORED('org_proxid', FORMAT(SEQUENCE(6)));
  SALT37.StrType Input_ultimate_proxid := '' : STORED('ultimate_proxid', FORMAT(SEQUENCE(7)));
  SALT37.StrType Input_has_lgid := '' : STORED('has_lgid', FORMAT(SEQUENCE(8)));
  SALT37.StrType Input_empid := '' : STORED('empid', FORMAT(SEQUENCE(9)));
  SALT37.StrType Input_source := '' : STORED('source', FORMAT(SEQUENCE(10)));
  SALT37.StrType Input_source_record_id := '' : STORED('source_record_id', FORMAT(SEQUENCE(11)));
  SALT37.StrType Input_source_docid := '' : STORED('source_docid', FORMAT(SEQUENCE(12)));
  SALT37.StrType Input_company_name := '' : STORED('company_name', FORMAT(SEQUENCE(13)));
  SALT37.StrType Input_company_name_prefix := '' : STORED('company_name_prefix', FORMAT(SEQUENCE(14)));
  SALT37.StrType Input_cnp_name := '' : STORED('cnp_name', FORMAT(SEQUENCE(15)));
  SALT37.StrType Input_cnp_number := '' : STORED('cnp_number', FORMAT(SEQUENCE(16)));
  SALT37.StrType Input_cnp_btype := '' : STORED('cnp_btype', FORMAT(SEQUENCE(17)));
  SALT37.StrType Input_cnp_lowv := '' : STORED('cnp_lowv', FORMAT(SEQUENCE(18)));
  SALT37.StrType Input_company_phone := '' : STORED('company_phone', FORMAT(SEQUENCE(19)));
  SALT37.StrType Input_company_phone_3 := '' : STORED('company_phone_3', FORMAT(SEQUENCE(20)));
  SALT37.StrType Input_company_phone_3_ex := '' : STORED('company_phone_3_ex', FORMAT(SEQUENCE(21)));
  SALT37.StrType Input_company_phone_7 := '' : STORED('company_phone_7', FORMAT(SEQUENCE(22)));
  SALT37.StrType Input_company_fein := '' : STORED('company_fein', FORMAT(SEQUENCE(23)));
  SALT37.StrType Input_company_sic_code1 := '' : STORED('company_sic_code1', FORMAT(SEQUENCE(24)));
  SALT37.StrType Input_active_duns_number := '' : STORED('active_duns_number', FORMAT(SEQUENCE(25)));
  SALT37.StrType Input_prim_range := '' : STORED('prim_range', FORMAT(SEQUENCE(26)));
  SALT37.StrType Input_prim_name := '' : STORED('prim_name', FORMAT(SEQUENCE(27)));
  SALT37.StrType Input_sec_range := '' : STORED('sec_range', FORMAT(SEQUENCE(28)));
  SALT37.StrType Input_city := '' : STORED('city', FORMAT(SEQUENCE(29)));
  SALT37.StrType Input_city_clean := '' : STORED('city_clean', FORMAT(SEQUENCE(30)));
  SALT37.StrType Input_st := '' : STORED('st', FORMAT(SEQUENCE(31)));
 
  DATASET(BizLinkFull.process_Biz_layouts.layout_zip_cases) Input_zip := DATASET([],BizLinkFull.process_Biz_layouts.layout_zip_cases)  : STORED('zip_cases', FORMAT(SEQUENCE(32)));
  SALT37.StrType Input_company_url := '' : STORED('company_url', FORMAT(SEQUENCE(33)));
  SALT37.StrType Input_isContact := '' : STORED('isContact', FORMAT(SEQUENCE(34)));
  SALT37.StrType Input_contact_did := '' : STORED('contact_did', FORMAT(SEQUENCE(35)));
  SALT37.StrType Input_title := '' : STORED('title', FORMAT(SEQUENCE(36)));
  SALT37.StrType Input_fname := '' : STORED('fname', FORMAT(SEQUENCE(37)));
  SALT37.StrType Input_fname_preferred := '' : STORED('fname_preferred', FORMAT(SEQUENCE(38)));
  SALT37.StrType Input_mname := '' : STORED('mname', FORMAT(SEQUENCE(39)));
  SALT37.StrType Input_lname := '' : STORED('lname', FORMAT(SEQUENCE(40)));
  SALT37.StrType Input_name_suffix := '' : STORED('name_suffix', FORMAT(SEQUENCE(41)));
  SALT37.StrType Input_contact_ssn := '' : STORED('contact_ssn', FORMAT(SEQUENCE(42)));
  SALT37.StrType Input_contact_email := '' : STORED('contact_email', FORMAT(SEQUENCE(43)));
  SALT37.StrType Input_sele_flag := '' : STORED('sele_flag', FORMAT(SEQUENCE(44)));
  SALT37.StrType Input_org_flag := '' : STORED('org_flag', FORMAT(SEQUENCE(45)));
  SALT37.StrType Input_ult_flag := '' : STORED('ult_flag', FORMAT(SEQUENCE(46)));
  SALT37.StrType Input_fallback_value := '' : STORED('fallback_value', FORMAT(SEQUENCE(47)));
  SALT37.StrType Input_CONTACTNAME := '' : STORED('CONTACTNAME', FORMAT(SEQUENCE(48)));
  SALT37.StrType Input_STREETADDRESS := '' : STORED('STREETADDRESS', FORMAT(SEQUENCE(49)));
  BOOLEAN FullMatch := FALSE : STORED('MatchAllInOneRecord', FORMAT(SEQUENCE(50)));
  BOOLEAN RecordsOnly := FALSE: STORED('RecordsOnly', FORMAT(SEQUENCE(51)));
  SALT37.StrType Input_SortBy := '' : STORED('SortBy', FORMAT(SEQUENCE(52)));
  UNSIGNED e_seleid := 0 : STORED('seleid', FORMAT(SEQUENCE(53)));
  UNSIGNED e_orgid := 0 : STORED('orgid', FORMAT(SEQUENCE(54)));
  UNSIGNED e_ultid := 0 : STORED('ultid', FORMAT(SEQUENCE(55)));
  UNSIGNED e_powid := 0 : STORED('powid', FORMAT(SEQUENCE(56)));
  UNSIGNED e_proxid := 0 : STORED('proxid', FORMAT(SEQUENCE(57)));
  UNSIGNED e_rcid := 0 : STORED('rcid', FORMAT(SEQUENCE(58)));
  BOOLEAN Input_bGetAllScores := FALSE : STORED('bGetAllScores', FORMAT(SEQUENCE(59)));
  BOOLEAN Input_disableForce := FALSE : STORED('disableForce', FORMAT(SEQUENCE(60)));
 
  Template := DATASET([],BizLinkFull.Process_Biz_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold,Input_bGetAllScores,Input_disableForce
  ,(TYPEOF(Template.parent_proxid))Input_parent_proxid
  ,(TYPEOF(Template.sele_proxid))Input_sele_proxid
  ,(TYPEOF(Template.org_proxid))Input_org_proxid
  ,(TYPEOF(Template.ultimate_proxid))Input_ultimate_proxid
  ,(TYPEOF(Template.has_lgid))Input_has_lgid
  ,(TYPEOF(Template.empid))Input_empid
  ,(TYPEOF(Template.source))Input_source
  ,(TYPEOF(Template.source_record_id))Input_source_record_id
  ,(TYPEOF(Template.source_docid))Input_source_docid
  ,(TYPEOF(Template.company_name))BizLinkFull.Fields.Make_company_name((SALT37.StrType)Input_company_name)
  ,(TYPEOF(Template.company_name_prefix))BizLinkFull.Fields.Make_company_name_prefix((SALT37.StrType)Input_company_name_prefix)
  ,(TYPEOF(Template.cnp_name))BizLinkFull.Fields.Make_cnp_name((SALT37.StrType)Input_cnp_name)
  ,(TYPEOF(Template.cnp_number))Input_cnp_number
  ,(TYPEOF(Template.cnp_btype))Input_cnp_btype
  ,(TYPEOF(Template.cnp_lowv))Input_cnp_lowv
  ,(TYPEOF(Template.company_phone))Input_company_phone
  ,(TYPEOF(Template.company_phone_3))Input_company_phone_3
  ,(TYPEOF(Template.company_phone_3_ex))Input_company_phone_3_ex
  ,(TYPEOF(Template.company_phone_7))Input_company_phone_7
  ,IF ( BizLinkFull.Fields.Invalid_company_fein((SALT37.StrType)Input_company_fein)=0,(TYPEOF(Template.company_fein))Input_company_fein,(TYPEOF(Template.company_fein))'')
  ,(TYPEOF(Template.company_sic_code1))Input_company_sic_code1
  ,(TYPEOF(Template.active_duns_number))Input_active_duns_number
  ,(TYPEOF(Template.prim_range))Input_prim_range
  ,(TYPEOF(Template.prim_name))BizLinkFull.Fields.Make_prim_name((SALT37.StrType)Input_prim_name)
  ,(TYPEOF(Template.sec_range))BizLinkFull.Fields.Make_sec_range((SALT37.StrType)Input_sec_range)
  ,(TYPEOF(Template.city))BizLinkFull.Fields.Make_city((SALT37.StrType)Input_city)
  ,(TYPEOF(Template.city_clean))BizLinkFull.Fields.Make_city_clean((SALT37.StrType)Input_city_clean)
  ,(TYPEOF(Template.st))BizLinkFull.Fields.Make_st((SALT37.StrType)Input_st)
  ,Input_zip
  ,(TYPEOF(Template.company_url))BizLinkFull.Fields.Make_company_url((SALT37.StrType)Input_company_url)
  ,(TYPEOF(Template.isContact))Input_isContact
  ,(TYPEOF(Template.contact_did))Input_contact_did
  ,(TYPEOF(Template.title))Input_title
  ,(TYPEOF(Template.fname))BizLinkFull.Fields.Make_fname((SALT37.StrType)Input_fname)
  ,(TYPEOF(Template.fname_preferred))BizLinkFull.Fields.Make_fname_preferred((SALT37.StrType)Input_fname_preferred)
  ,(TYPEOF(Template.mname))BizLinkFull.Fields.Make_mname((SALT37.StrType)Input_mname)
  ,(TYPEOF(Template.lname))BizLinkFull.Fields.Make_lname((SALT37.StrType)Input_lname)
  ,(TYPEOF(Template.name_suffix))BizLinkFull.Fields.Make_name_suffix((SALT37.StrType)Input_name_suffix)
  ,(TYPEOF(Template.contact_ssn))Input_contact_ssn
  ,(TYPEOF(Template.contact_email))BizLinkFull.Fields.Make_contact_email((SALT37.StrType)Input_contact_email)
  ,(TYPEOF(Template.sele_flag))Input_sele_flag
  ,(TYPEOF(Template.org_flag))Input_org_flag
  ,(TYPEOF(Template.ult_flag))Input_ult_flag
  ,(TYPEOF(Template.fallback_value))Input_fallback_value
  ,(TYPEOF(Template.CONTACTNAME))Input_CONTACTNAME
  ,(TYPEOF(Template.STREETADDRESS))Input_STREETADDRESS
  ,RecordsOnly,FullMatch,e_rcid,e_proxid,e_seleid,e_orgid,e_ultid,e_powid}],BizLinkFull.Process_Biz_Layouts.InputLayout);
 
  pm := BizLinkFull.MEOW_Biz(Input_Data); // This module performs regular xproxid functions
  ds := pm.Data_;
  FieldNumber(SALT37.StrType fn) := CASE(fn,'parent_proxid' => 1,'sele_proxid' => 2,'org_proxid' => 3,'ultimate_proxid' => 4,'has_lgid' => 5,'empid' => 6,'source' => 7,'source_record_id' => 8,'source_docid' => 9,'company_name' => 10,'company_name_prefix' => 11,'cnp_name' => 12,'cnp_number' => 13,'cnp_btype' => 14,'cnp_lowv' => 15,'company_phone' => 16,'company_phone_3' => 17,'company_phone_3_ex' => 18,'company_phone_7' => 19,'company_fein' => 20,'company_sic_code1' => 21,'active_duns_number' => 22,'prim_range' => 23,'prim_name' => 24,'sec_range' => 25,'city' => 26,'city_clean' => 27,'st' => 28,'zip' => 29,'company_url' => 30,'isContact' => 31,'contact_did' => 32,'title' => 33,'fname' => 34,'fname_preferred' => 35,'mname' => 36,'lname' => 37,'name_suffix' => 38,'contact_ssn' => 39,'contact_email' => 40,'sele_flag' => 41,'org_flag' => 42,'ult_flag' => 43,'fallback_value' => 44,47);
  result := CHOOSE(FieldNumber(Input_SortBy),SORT(ds,-weight,proxid,parent_proxid,RECORD),SORT(ds,-weight,proxid,sele_proxid,RECORD),SORT(ds,-weight,proxid,org_proxid,RECORD),SORT(ds,-weight,proxid,ultimate_proxid,RECORD),SORT(ds,-weight,proxid,has_lgid,RECORD),SORT(ds,-weight,proxid,empid,RECORD),SORT(ds,-weight,proxid,source,RECORD),SORT(ds,-weight,proxid,source_record_id,RECORD),SORT(ds,-weight,proxid,source_docid,RECORD),SORT(ds,-weight,proxid,company_name,RECORD),SORT(ds,-weight,proxid,company_name_prefix,RECORD),SORT(ds,-weight,proxid,cnp_name,RECORD),SORT(ds,-weight,proxid,cnp_number,RECORD),SORT(ds,-weight,proxid,cnp_btype,RECORD),SORT(ds,-weight,proxid,cnp_lowv,RECORD),SORT(ds,-weight,proxid,company_phone,RECORD),SORT(ds,-weight,proxid,company_phone_3,RECORD),SORT(ds,-weight,proxid,company_phone_3_ex,RECORD),SORT(ds,-weight,proxid,company_phone_7,RECORD),SORT(ds,-weight,proxid,company_fein,RECORD),SORT(ds,-weight,proxid,company_sic_code1,RECORD),SORT(ds,-weight,proxid,active_duns_number,RECORD),SORT(ds,-weight,proxid,prim_range,RECORD),SORT(ds,-weight,proxid,prim_name,RECORD),SORT(ds,-weight,proxid,sec_range,RECORD),SORT(ds,-weight,proxid,city,RECORD),SORT(ds,-weight,proxid,city_clean,RECORD),SORT(ds,-weight,proxid,st,RECORD),SORT(ds,-weight,proxid,zip,RECORD),SORT(ds,-weight,proxid,company_url,RECORD),SORT(ds,-weight,proxid,isContact,RECORD),SORT(ds,-weight,proxid,contact_did,RECORD),SORT(ds,-weight,proxid,title,RECORD),SORT(ds,-weight,proxid,fname,RECORD),SORT(ds,-weight,proxid,fname_preferred,RECORD),SORT(ds,-weight,proxid,mname,RECORD),SORT(ds,-weight,proxid,lname,RECORD),SORT(ds,-weight,proxid,name_suffix,RECORD),SORT(ds,-weight,proxid,contact_ssn,RECORD),SORT(ds,-weight,proxid,contact_email,RECORD),SORT(ds,-weight,proxid,sele_flag,RECORD),SORT(ds,-weight,proxid,org_flag,RECORD),SORT(ds,-weight,proxid,ult_flag,RECORD),SORT(ds,-weight,proxid,fallback_value,RECORD),SORT(ds,-weight,proxid,RECORD));
  OUTPUT(result,NAMED('Header_Data'));
ENDMACRO;
