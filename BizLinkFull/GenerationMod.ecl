// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT44;
EXPORT GenerationMod := MODULE(SALT44.iGenerationMod)

  // SALT Version info
  EXPORT salt_VERSION := 'V4.4.4';
  EXPORT salt_MODULE := 'SALT44'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS4'; // Optional override by HACK:SALTTOOLSMODULE

  // Core module configuration values
  EXPORT spc_MODULE := 'BizLinkFull';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := 'Biz';
  EXPORT spc_PROCLAYOUTS := 'Process_Biz_Layouts';
  EXPORT spc_IDNAME := 'proxid'; // cluster id (input)
  EXPORT spc_IDFIELD := 'proxid'; // cluster id (output)
  EXPORT spc_RIDFIELD := 'rcid'; // record id
  EXPORT spc_CONFIG := 'Config_BIP';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'File_';
  EXPORT spc_FILENAME := 'BizHead';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:rcid,zip_cases:zip';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_proxid */,/* MY_seleid */,/* MY_orgid */,/* MY_ultid */,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,has_lgid,empid,source,source_record_id,source_docid,company_name,company_name_prefix,cnp_name,cnp_number,cnp_btype,cnp_lowv,company_phone,company_phone_3,company_phone_3_ex,company_phone_7,company_fein,company_sic_code1,active_duns_number,prim_range,prim_name,sec_range,city,city_clean,st,zip_cases,company_url,isContact,contact_did,title,fname,fname_preferred,mname,lname,name_suffix,contact_ssn,contact_email,sele_flag,org_flag,ult_flag,fallback_value,CONTACTNAME,STREETADDRESS';
  EXPORT spc_HAS_TWOSTEP := TRUE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := TRUE;
  EXPORT spc_HAS_PARENTS := TRUE;
  EXPORT spc_HAS_FORCE := TRUE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;

  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-ma -gs2\n'
    + '\n'
    + 'MODULE:BizLinkFull\n'
    + 'FILENAME:BizHead\n'
    + 'PROCESS:Biz:UBER(NEVER)\n'
    + 'CONFIG:Config_BIP\n'
    + 'IDNAME:proxid\n'
    + 'IDFIELD:EXISTS:proxid\n'
    + 'IDPARENTS:seleid,orgid,ultid\n'
    + 'IDUNCLE:powid\n'
    + 'RIDFIELD:rcid\n'
    + '\n'
    + 'RECORDS:4000000000\n'
    + 'POPULATION:250000000\n'
    + 'NINES:3\n'
    + '\n'
    + 'FIELDTYPE:T_ALLCAPS:CAPS:ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:T_ALPHANUM:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:T_ALPHA:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:T_NUMBER:ALLOW(0123456789):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:T_FEIN:ALLOW(0123456789):LENGTHS(9):ONFAIL(BLANK)\n'
    + '\n'
    + 'FUZZY:NormSuffix:RST:CUSTOM(fn_normSuffix):TYPE(STRING5)\n'
    + '\n'
    + 'FIELD:parent_proxid:WEIGHT(.001):28,0\n'
    + 'FIELD:sele_proxid:WEIGHT(.001):28,0\n'
    + 'FIELD:org_proxid:WEIGHT(.001):28,0\n'
    + 'FIELD:ultimate_proxid:WEIGHT(.001):28,0\n'
    + 'FIELD:has_lgid:CARRY:0,0\n'
    + 'FIELD:empid:CARRY:28,490\n'
    + 'FIELD:source:4,514\n'
    + 'FIELD:source_record_id:27,756\n'
    + 'FIELD:source_docid:CARRY:27,756\n'
    + 'FIELD:company_name:LIKE(T_ALPHANUM):25,249\n'
    + 'FIELD:company_name_prefix:TYPE(STRING5):LIKE(T_ALPHANUM):WEIGHT(0.1):14,85\n'
    + 'FIELD:cnp_name:TYPE(STRING120):BAGOFWORDS(MOST):EDIT1(3):ABBR(FIRST):INITIAL:LIKE(T_ALPHANUM):25,167\n'
    + 'FIELD:cnp_number:13,4\n'
    + 'FIELD:cnp_btype:PROP:3,42 \n'
    + 'FIELD:cnp_lowv:5,38\n'
    + 'FIELD:company_phone:CARRY:26,0\n'
    + 'FIELD:company_phone_3:9,48\n'
    + 'FIELD:company_phone_3_ex:9,48\n'
    + 'FIELD:company_phone_7:23,202\n'
    + 'FIELD:company_fein:LIKE(T_FEIN):EDIT1:PROP:25,59\n'
    + 'FIELD:company_sic_code1:PROP:10,273\n'
    + 'FIELD:active_duns_number:CARRY:25,0\n'
    + 'FIELD:prim_range:EDIT1:FORCE(--):13,0\n'
    + 'FIELD:prim_name:EDIT1:LIKE(T_ALPHANUM):14,0\n'
    + 'FIELD:sec_range:EDIT1:LIKE(T_ALPHANUM):12,112\n'
    + 'FIELD:city:EDIT2:PHONETIC:LIKE(T_ALPHANUM):CONTEXT(st):11,53\n'
    + 'FIELD:city_clean:LIKE(T_ALPHANUM):WHEEL:11,29\n'
    + 'FIELD:st:LIKE(T_ALPHA):5,0\n'
    + 'FIELD:zip:LIKE(T_NUMBER):MULTIPLE:WEIGHTED:KEEP(1):14,5\n'
    + 'FIELD:company_url:TYPE(STRING120):BAGOFWORDS:LIKE(T_ALPHANUM):27,25\n'
    + 'FIELD:isContact:1,282\n'
    + 'FIELD:contact_did:25,337\n'
    + 'FIELD:title:1,260\n'
    + 'FIELD:fname:EDIT1:INITIAL:LIKE(T_ALPHANUM):WEIGHT(0.2):8,422\n'
    + 'FIELD:fname_preferred:LIKE(T_ALPHANUM):9,438\n'
    + 'FIELD:mname:INITIAL:EDIT2:LIKE(T_ALPHANUM):9,277\n'
    + 'FIELD:lname:INITIAL:HYPHEN2:EDIT2:LIKE(T_ALPHANUM):10,349\n'
    + 'FIELD:name_suffix:NormSuffix:LIKE(T_ALPHANUM):8,68\n'
    + 'FIELD:contact_ssn:27,134\n'
    + 'FIELD:contact_email:LIKE(T_ALLCAPS):27,87\n'
    + 'FIELD:sele_flag:WEIGHT(0.001):1,0\n'
    + 'FIELD:org_flag:WEIGHT(0.001):1,0\n'
    + 'FIELD:ult_flag:WEIGHT(0.001):1,0\n'
    + 'FIELD:fallback_value:FALLBACK(3):1,0\n'
    + '\n'
    + 'CONCEPT:CONTACTNAME:fname:mname:lname:SCALE(NEVER):23,492\n'
    + 'CONCEPT:STREETADDRESS:prim_range:prim_name:sec_range:SCALE(NEVER):23,96\n'
    + '\n'
    + 'EXTERNALFILE:Ext_Data:NAMED(File_Ext_Data):DIVE(NEVER):SEARCH:IGNORE(sele_flag,org_flag,ult_flag):CLEAN\n'
    + '\n'
    + 'HACK:IMPROVE_EF_WEIGHTS\n'
    + 'HACK:SPLIT_COMBINEALLSCORES\n'
    + '\n'
    + 'LINKPATH:L_CNPNAME_ZIP:cnp_name:zip:?:prim_name:st(HASBASE):+:city:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag\n'
    + 'LINKPATH:L_CNPNAME_ST:cnp_name:st:?:prim_name:zip(HASBASE):+:city:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag:REQUIRED(L_CNPNAME_ZIP)\n'
    + 'LINKPATH:L_CNPNAME:cnp_name:?:prim_name:city:+:st:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag:zip(HASBASE):REQUIRED(L_CNPNAME_ST)\n'
    + 'LINKPATH:L_CNPNAME_FUZZY:company_name_prefix:?:cnp_name(HASBASE):st:zip(HASBASE):+:city:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag:NOFAIL\n'
    + 'LINKPATH:L_ADDRESS1:prim_name:city:st:?:prim_range:cnp_name(HASBASE):+:zip:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag\n'
    + 'LINKPATH:L_ADDRESS2:prim_name:zip:?:prim_range:cnp_name(HASBASE):st(HASBASE):+:city:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag\n'
    + 'LINKPATH:L_ADDRESS3:prim_name:prim_range:zip:?:cnp_name(HASBASE):st:+:city:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag:\n'
    + 'LINKPATH:L_PHONE:company_phone_7:?:cnp_name(HASBASE):company_phone_3:+:company_phone_3_ex:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:city:st:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag\n'
    + 'LINKPATH:L_FEIN:company_fein:+:company_sic_code1:cnp_name:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:city:st:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag:\n'
    + 'LINKPATH:L_URL:company_url:?:st:+:company_sic_code1:cnp_name:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:city:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag:\n'
    + '\n'
    + 'LINKPATH:L_CONTACT_ZIP:fname_preferred:lname:zip:?:mname:cnp_name(HASBASE):st:+:fname:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_name:city:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag\n'
    + 'LINKPATH:L_CONTACT_ST:fname_preferred:lname:st:?:mname:cnp_name(HASBASE):+:fname:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_name:city:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag:REQUIRED(L_CONTACT_ZIP)\n'
    + '\n'
    + 'LINKPATH:L_CONTACT_SSN:contact_ssn:+:contact_email:company_sic_code1:cnp_name:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:city:st:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag\n'
    + 'LINKPATH:L_EMAIL:contact_email:+:company_sic_code1:cnp_name:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:city:st:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag\n'
    + 'LINKPATH:L_SIC:company_sic_code1:zip:?:cnp_name:prim_name:MAXBLOCKSIZE(2000)\n'
    + 'LINKPATH:L_SOURCE:source_record_id:source:?:cnp_name(HASBASE):prim_name:zip:city:st:+:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag\n'
    + 'LINKPATH:L_CONTACT_DID:contact_did\n'
    ;

  // Structured values
  EXPORT linkpaths := DATASET([
    {'L_CNPNAME_ZIP','cnp_name,zip','prim_name,st(HASBASE)','city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','',''}
    ,{'L_CNPNAME_ST','cnp_name,st','prim_name,zip(HASBASE)','city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','L_CNPNAME_ZIP',''}
    ,{'L_CNPNAME','cnp_name','prim_name,city','st,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,zip(HASBASE)','L_CNPNAME_ST',''}
    ,{'L_CNPNAME_FUZZY','company_name_prefix','cnp_name(HASBASE),st,zip(HASBASE)','city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','',''}
    ,{'L_ADDRESS1','prim_name,city,st','prim_range,cnp_name(HASBASE)','zip,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','',''}
    ,{'L_ADDRESS2','prim_name,zip','prim_range,cnp_name(HASBASE),st(HASBASE)','city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','',''}
    ,{'L_ADDRESS3','prim_name,prim_range,zip','cnp_name(HASBASE),st','city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','',''}
    ,{'L_PHONE','company_phone_7','cnp_name(HASBASE),company_phone_3','company_phone_3_ex,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,zip,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','',''}
    ,{'L_FEIN','company_fein','','company_sic_code1,cnp_name,cnp_number,cnp_btype,cnp_lowv,zip,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','',''}
    ,{'L_URL','company_url','st','company_sic_code1,cnp_name,cnp_number,cnp_btype,cnp_lowv,zip,prim_name,city,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','',''}
    ,{'L_CONTACT_ZIP','fname_preferred,lname,zip','mname,cnp_name(HASBASE),st','fname,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_name,city,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','',''}
    ,{'L_CONTACT_ST','fname_preferred,lname,st','mname,cnp_name(HASBASE)','fname,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_name,city,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','L_CONTACT_ZIP',''}
    ,{'L_CONTACT_SSN','contact_ssn','','contact_email,company_sic_code1,cnp_name,cnp_number,cnp_btype,cnp_lowv,zip,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','',''}
    ,{'L_EMAIL','contact_email','','company_sic_code1,cnp_name,cnp_number,cnp_btype,cnp_lowv,zip,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','',''}
    ,{'L_SIC','company_sic_code1,zip','cnp_name,prim_name','','',''}
    ,{'L_SOURCE','source_record_id,source','cnp_name(HASBASE),prim_name,zip,city,st','company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag','',''}
    ,{'L_CONTACT_DID','contact_did','','','',''}
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;

