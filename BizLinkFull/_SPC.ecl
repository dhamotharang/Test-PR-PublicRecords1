OPTIONS:-ma

MODULE:BizLinkFull
FILENAME:BizHead
PROCESS:Biz:UBER(NEVER)
CONFIG:Config_BIP
IDNAME:proxid
IDFIELD:EXISTS:proxid
IDPARENTS:seleid,orgid,ultid
IDUNCLE:powid
RIDFIELD:rcid

RECORDS:4000000000
POPULATION:250000000
NINES:3

FIELDTYPE:T_ALLCAPS:CAPS:ONFAIL(CLEAN)
FIELDTYPE:T_ALPHANUM:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)
FIELDTYPE:T_ALPHA:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):ONFAIL(CLEAN)
FIELDTYPE:T_NUMBER:ALLOW(0123456789):ONFAIL(CLEAN)
FIELDTYPE:T_FEIN:ALLOW(0123456789):LENGTHS(9):ONFAIL(BLANK)

FUZZY:NormSuffix:RST:CUSTOM(fn_normSuffix):TYPE(STRING5)

FIELD:parent_proxid:WEIGHT(.001):28,0
FIELD:sele_proxid:WEIGHT(.001):28,0
FIELD:org_proxid:WEIGHT(.001):28,0
FIELD:ultimate_proxid:WEIGHT(.001):28,0
FIELD:has_lgid:CARRY:0,0
FIELD:empid:CARRY:28,490
FIELD:source:4,514
FIELD:source_record_id:27,756
FIELD:source_docid:CARRY:27,756
FIELD:company_name:LIKE(T_ALPHANUM):25,249
FIELD:company_name_prefix:TYPE(STRING5):LIKE(T_ALPHANUM):WEIGHT(0.1):14,85
FIELD:cnp_name:TYPE(STRING120):BAGOFWORDS(MOST):EDIT1(3):ABBR(FIRST):INITIAL:LIKE(T_ALPHANUM):25,167
FIELD:cnp_number:13,4
FIELD:cnp_btype:PROP:3,42 
FIELD:cnp_lowv:5,38
FIELD:company_phone:CARRY:26,0
FIELD:company_phone_3:9,48
FIELD:company_phone_3_ex:9,48
FIELD:company_phone_7:23,202
FIELD:company_fein:LIKE(T_FEIN):EDIT1:PROP:25,59
FIELD:company_sic_code1:PROP:10,273
FIELD:active_duns_number:CARRY:25,0
FIELD:prim_range:EDIT1:FORCE(--):13,0
FIELD:prim_name:EDIT1:LIKE(T_ALPHANUM):14,0
FIELD:sec_range:EDIT1:LIKE(T_ALPHANUM):12,112
FIELD:city:EDIT2:PHONETIC:LIKE(T_ALPHANUM):CONTEXT(st):11,53
FIELD:city_clean:LIKE(T_ALPHANUM):WHEEL:11,29
FIELD:st:LIKE(T_ALPHA):5,0
FIELD:zip:LIKE(T_NUMBER):MULTIPLE:WEIGHTED:KEEP(1):14,5
FIELD:company_url:TYPE(STRING120):BAGOFWORDS:LIKE(T_ALPHANUM):27,25
FIELD:isContact:1,282
FIELD:contact_did:25,337
FIELD:title:1,260
FIELD:fname:EDIT1:INITIAL:LIKE(T_ALPHANUM):WEIGHT(0.2):8,422
FIELD:fname_preferred:LIKE(T_ALPHANUM):9,438
FIELD:mname:INITIAL:EDIT2:LIKE(T_ALPHANUM):9,277
FIELD:lname:INITIAL:HYPHEN2:EDIT2:LIKE(T_ALPHANUM):10,349
FIELD:name_suffix:NormSuffix:LIKE(T_ALPHANUM):8,68
FIELD:contact_ssn:27,134
FIELD:contact_email:LIKE(T_ALLCAPS):27,87
FIELD:sele_flag:WEIGHT(0.001):0,0
FIELD:org_flag:WEIGHT(0.001):0,0
FIELD:ult_flag:WEIGHT(0.001):0,0
FIELD:fallback_value:FALLBACK(3):1,0

CONCEPT:CONTACTNAME:fname:mname:lname:SCALE(NEVER):23,492
CONCEPT:STREETADDRESS:prim_range:prim_name:sec_range:SCALE(NEVER):23,96

LINKPATH:L_CNPNAME_ZIP:cnp_name:zip:?:prim_name:st(HASBASE):city:+:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag
LINKPATH:L_CNPNAME_ST:cnp_name:st:?:prim_name:zip(HASBASE):city:+:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag:REQUIRED(L_CNPNAME_ZIP)
LINKPATH:L_CNPNAME:cnp_name:?:prim_name:st:city:+:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag:zip(HASBASE):REQUIRED(L_CNPNAME_ST)
LINKPATH:L_CNPNAME_FUZZY:company_name_prefix:?:cnp_name(HASBASE):zip(HASBASE):city:st:+:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag:NOFAIL
LINKPATH:L_ADDRESS1:prim_name:city:st:?:prim_range:cnp_name(HASBASE):+:zip:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag
LINKPATH:L_ADDRESS2:prim_name:zip:?:prim_range:cnp_name(HASBASE):st(HASBASE):+:city:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag
LINKPATH:L_ADDRESS3:prim_name:prim_range:zip:?:cnp_name(HASBASE):st:+:city:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag:
LINKPATH:L_PHONE:company_phone_7:?:cnp_name(HASBASE):company_phone_3:+:company_phone_3_ex:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:city:st:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag
LINKPATH:L_FEIN:company_fein:+:company_sic_code1:cnp_name:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:city:st:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag:
LINKPATH:L_URL:company_url:?:st:+:company_sic_code1:cnp_name:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:city:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag:
LINKPATH:L_CONTACT:fname_preferred:lname:?:mname:cnp_name(HASBASE):zip:st:+:fname:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_name:city:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag
LINKPATH:L_CONTACT_SSN:contact_ssn:+:contact_email:company_sic_code1:cnp_name:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:city:st:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag
LINKPATH:L_EMAIL:contact_email:+:company_sic_code1:cnp_name:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:city:st:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag
LINKPATH:L_SIC:company_sic_code1:zip:?:cnp_name:prim_name:MAXBLOCKSIZE(2000)
LINKPATH:L_SOURCE:source_record_id:source:?:cnp_name(HASBASE):prim_name:zip:city:st:+:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag
LINKPATH:L_CONTACT_DID:contact_did
