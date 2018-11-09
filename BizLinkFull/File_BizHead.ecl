#OPTION('multiplePersistInstances',FALSE);
IMPORT BIPV2;
IMPORT BIPv2_HRCHY;
IMPORT BIPV2_Files;
IMPORT BIPV2_Company_Names;
IMPORT ut;
IMPORT MDR;
IMPORT lib_date;
//*
 // dBase:=PROJECT(BIPV2.CommonBase.DS_CLEAN, TRANSFORM(BIPV2.CommonBase.Layout, SELF:=LEFT, SELF:=[]));
 dBase:=PROJECT(BIPV2.CommonBase.ds_xlink, TRANSFORM(BIPV2.CommonBase.Layout, SELF:=LEFT, SELF:=[]));
// dBase:=BIPV2.CommonBase.DS_OMNI(prod);
// Deduping after removing the fields that are not needed for any searching or reporting purposes
dSlimmed:=TABLE(dBase(rec_type!='Ol'),{proxid;seleid;orgid;ultid;empid;powid;dotid;parent_proxid;sele_proxid;org_proxid;ultimate_proxid;has_lgid;company_name;
  title;fname;mname;lname;name_suffix;iscontact;contact_ssn;contact_email;prim_range;predir;prim_name;addr_suffix;postdir;
  unit_desig;sec_range;p_city_name;v_city_name;st;zip;zip4;fips_county;source;dt_first_seen;dt_last_seen;dt_vendor_last_reported;
  company_bdid;company_fein;active_duns_number;company_phone;phone_type;company_url;company_sic_code1;company_status_derived;vl_id;source_record_id;source_docid;contact_did;contact_email_domain;
  contact_job_title_derived;err_stat;is_sele_level;is_org_level;is_ult_level;rcid;address_type_derived;});
dDeduped:=DEDUP(SORT(DISTRIBUTE(dSlimmed,HASH32(proxid)),RECORD,LOCAL),RECORD,EXCEPT rcid,LOCAL);
// Distributing the HRCHY file and "pre-cleaning" targeted fields
dPreCleaned:=PROJECT(dDeduped,TRANSFORM({RECORDOF(LEFT);UNSIGNED rid;},
  sSSN:=REGEXREPLACE('[^0-9]',LEFT.contact_ssn,'');
  SELF.company_name:=IF(LEFT.company_name='',TRIM(LEFT.fname,LEFT,RIGHT)+' '+TRIM(LEFT.lname,LEFT,RIGHT),TRIM(LEFT.company_name,LEFT,RIGHT));
  SELF.st:=IF(LEFT.st IN ['AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY','PR','VI','GU','AE','MP','AP','AS','AA','MH','PW','FM','TT','CM'],LEFT.st,'');
  SELF.p_city_name:=IF(REGEXFIND('[A-Z]',LEFT.p_city_name),LEFT.p_city_name,'');
  SELF.v_city_name:=IF(REGEXFIND('[A-Z]',LEFT.v_city_name),LEFT.v_city_name,'');
  SELF.fname:=IF(REGEXFIND('[0-9]',LEFT.fname),'',LEFT.fname);
  SELF.mname:=IF(REGEXFIND('[0-9]',LEFT.mname),'',LEFT.mname);
  SELF.lname:=IF(REGEXFIND('[0-9]',LEFT.lname),'',LEFT.lname);
  SELF.contact_ssn:=IF(LENGTH(sSSN)<>9 OR sSSN[..3] IN ['000','666'] OR sSSN[1]='9' OR sSSN[4..5]='00' OR sSSN[6..]='0000' OR sSSN[..8]='98765432','',sSSN);
  SELF.contact_email:=IF(REGEXFIND('[^@]+@[^.]+[.].+',LEFT.contact_email),LEFT.contact_email,'');
  SELF.prim_range:=IF(REGEXREPLACE('[ 0]',LEFT.prim_range,'')='','',LEFT.prim_range);
  SELF.prim_name:=IF(REGEXREPLACE('[ 0]',LEFT.prim_name,'')='','',LEFT.prim_name);
  SELF.zip:=IF(REGEXREPLACE('[ 0]',LEFT.zip,'')='','',LEFT.zip);
  SELF.company_phone:=IF(REGEXREPLACE('[ 0]',LEFT.company_phone,'')='','',LEFT.company_phone);
  SELF.company_fein:=IF(REGEXREPLACE('[ 0]',LEFT.company_fein,'')='','',LEFT.company_fein);
  SELF.rid:=LEFT.rcid;
  SELF:=LEFT;
));
BIPV2_Company_Names.functions.mac_go(dPreCleaned,dCnpName,rid,company_name,,FALSE);
// Re-joining the cleaned company name information to the HRCHY file.  At the
// same time, addingi
lFileBizHead:=RECORD
  RECORDOF(dSlimmed) AND NOT [err_stat,is_sele_level,is_org_level,is_ult_level] OR RECORDOF(dCnpName) AND NOT [rid,cnp_nameid];
  STRING5 company_name_prefix;
  STRING25 city;
  STRING25 city_clean;
  STRING3 company_phone_3;
  STRING3 company_phone_3_ex;
  STRING7 company_phone_7;
  STRING20 fname_preferred;
  STRING1 sele_flag;
  STRING1 org_flag;
  STRING1 ult_flag;
  UNSIGNED1 fallback_value;
END;
dWithCnpName:=PROJECT(dCnpName,TRANSFORM(lFileBizHead,
  phone_cleaned:=REGEXREPLACE('[^0-9]',LEFT.company_phone,'');
  SELF.company_name_prefix:=BizLinkFull.fn_company_name_prefix(LEFT.cnp_name);//[..5];
  SELF.city:=IF(LEFT.p_city_name='',LEFT.v_city_name,LEFT.p_city_name);
  SELF.city_clean:=IF(LEFT.err_stat[1]='S',SELF.city,'');
  SELF.company_phone_3:=IF(LENGTH(phone_cleaned)=10,phone_cleaned[..3],'');
  SELF.company_phone_3_ex:=IF(LENGTH(phone_cleaned)=10,phone_cleaned[..3],'');
  SELF.company_phone_7:=IF(LENGTH(phone_cleaned)=10,phone_cleaned[4..],'');
  SELF.fname_preferred:=fn_PreferredName(LEFT.fname);
  SELF.sele_flag:=IF(LEFT.is_sele_level,'T','F');
  SELF.org_flag:=IF(LEFT.is_org_level,'T','F');
  SELF.ult_flag:=IF(LEFT.is_ult_level,'T','F');
  SELF.fallback_value:=MAP(
    MDR.sourceTools.SourceIsDCA(LEFT.source) => 2,
    lib_date.getage((STRING)LEFT.dt_last_seen) <= 2 => 1,
    0
  );
  SELF:=LEFT;
))(cnp_name!='');
// Adding in rows where there is a different v_city_name
dAdditionalCity:=PROJECT(dWithCnpName(v_city_name<>'' AND v_city_name<>city),TRANSFORM(RECORDOF(LEFT),
  SELF.city:=LEFT.v_city_name;
  SELF:=LEFT;
));
dBaseFile:=dWithCnpName+dAdditionalCity:PERSIST('~BizLinkFull::persist::file_bizhead',EXPIRE(60));
//dBaseFile:=dWithCnpName+dAdditionalCity:PERSIST('~dhw::persist::file_bizhead',EXPIRE(60));
EXPORT File_BizHead:=dBaseFile;
/*/
l:=RECORD
  unsigned6 proxid;
  unsigned6 seleid;
  unsigned6 orgid;
  unsigned6 ultid;
  unsigned6 empid;
  unsigned6 powid;
  unsigned6 dotid;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  boolean has_lgid;
  string120 company_name;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string1 iscontact;
  string9 contact_ssn;
  string60 contact_email;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string3 fips_county;
  string2 source;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned6 company_bdid;
  string9 company_fein;
  string9 active_duns_number;
  string10 company_phone;
  string1 phone_type;
  string80 company_url;
  string8 company_sic_code1;
  string50 company_status_derived;
  string34 vl_id;
  unsigned8 source_record_id;
  string100 source_docid;
  unsigned6 contact_did;
  string30 contact_email_domain;
  string50 contact_job_title_derived;
  unsigned6 rcid;
  string4 err_stat;
  boolean is_sele_level;
  boolean is_org_level;
  boolean is_ult_level;
  string250 cnp_name;
  string30 cnp_number;
  string10 cnp_store_number;
  string10 cnp_btype;
  string1 cnp_component_code;
  string20 cnp_lowv;
  boolean cnp_translated;
  integer4 cnp_classid;
  string5 company_name_prefix;
  string25 city;
  string25 city_clean;
  string3 company_phone_3;
  string3 company_phone_3_ex;
  string7 company_phone_7;
  string20 fname_preferred;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  unsigned1 fallback_value;
 END;
// EXPORT File_BizHead:=DATASET('~BizLinkFull::persist::file_bizhead',l,THOR);
EXPORT File_BizHead:=DATASET('~dhw::persist::file_bizhead',l,THOR);
//*/
