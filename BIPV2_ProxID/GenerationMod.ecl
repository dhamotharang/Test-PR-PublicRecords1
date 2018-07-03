﻿// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
  EXPORT spcString :=
    'OPTIONS:-gh -ga -gs2\n'
    + 'MODULE:BIPV2_ProxID\n'
    + 'FILENAME:DOT_Base\n'
    + '\n'
    + 'IDFIELD:EXISTS:Proxid\n'
    + 'RIDFIELD:rcid\n'
    + 'RECORDS:6801149648\n'
    + 'POPULATION:200000000\n'
    + 'NINES:3\n'
    + 'THRESHOLD:30\n'
    + 'BLOCKTHRESHOLD:5\n'
    + 'HACK:MAXBLOCKSIZE:20000\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields \n'
    + '//FIELDTYPE:wordbag:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:number:ALLOW(0123456789)\n'
    + 'FIELDTYPE:upper:CAPS:ONFAIL(CLEAN)\n'
    + '// FIELDTYPE:positive:ALLOW(0123456789):CUSTOM(fn_positive):ONFAIL(REJECT)\n'
    + '//FIELDTYPE:cname:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( <>{}[]-^=!+&,./):CUSTOM(fn_cname):ONFAIL(REJECT)\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + 'FUZZY:Right4:RST:CUSTOM(fn_Right4):TYPE(STRING4)\n'
    + 'FUZZY:PreferredName:RST:CUSTOM(fn_PreferredName):TYPE(STRING20)\n'
    + 'FUZZY:NormSuffix:RST:CUSTOM(fn_normSuffix):TYPE(STRING5)\n'
    + '// ------------------------------------\n'
    + '//  1. Company\n'
    + '// ------------------------------------\n'
    + '// Active ID fields from reliable sources\n'
    + 'FIELD:active_duns_number:PROP:28,24\n'
    + 'FIELD:active_enterprise_number:FORCE(--):PROP:27,7\n'
    + 'FIELD:active_domestic_corp_key:FORCE(--):PROP:27,6\n'
    + '// Historical and non-domestic IDs from reliable sources\n'
    + '// If match, add to score, if not, don\'t care(SWITCH0)\n'
    + 'FIELD:hist_enterprise_number:PROP:27,7\n'
    + 'FIELD:hist_duns_number:PROP:28,21\n'
    + 'FIELD:hist_domestic_corp_key:PROP:27,61\n'
    + 'FIELD:foreign_corp_key:SWITCH0:PROP:27,174\n'
    + 'FIELD:unk_corp_key:SWITCH0:PROP:27,49\n'
    + 'FIELD:ebr_file_number:PROP:28,224\n'
    + 'FIELD:company_fein:PROP:EDIT1:27,161\n'
    + 'FIELD:company_name:CARRY:0,0\n'
    + 'FIELD:cnp_name:TYPE(STRING250):BAGOFWORDS(MOST):EDIT1:FORCE(+6,OR(active_domestic_corp_key),OR(active_duns_number),OR(company_fein)):ABBR(ACRONYM,INITIAL,MAXSPC(13)):HYPHEN1:TYPE(string250):15,166\n'
    + '// FIELD:cnp_name:BAGOFWORDS(MOST):EDIT1:FORCE(+13,OR(active_domestic_corp_key),OR(active_duns_number)):ABBR(FIRST):HYPHEN1:TYPE(string250):15,137\n'
    + '//FIELD:source:CARRY:0,0\n'
    + 'FIELD:company_name_type_raw:CARRY:0,0\n'
    + 'FIELD:company_name_type_derived:WEIGHT(0.001):PROP:2,0\n'
    + 'FIELD:cnp_hasnumber:CARRY:0,0\n'
    + 'FIELD:cnp_number:FORCE:PROP:15,0\n'
    + '//FIELD:cnp_btype:FORCE(--):2,1  CO and inc for same name forced apart here\n'
    + 'FIELD:cnp_btype:3,51\n'
    + 'FIELD:cnp_lowv:CARRY:0,0\n'
    + 'FIELD:cnp_translated:CARRY:0,0\n'
    + 'FIELD:cnp_classid:CARRY:0,0\n'
    + '//FIELD:company_org_structure_derived:FORCE(--):PROP:0,0\n'
    + '//FIELD:company_charter_state:PROP:7,72\n'
    + '//FIELD:company_charter_number:CONTEXT(company_charter_state):PROP:EDIT1:18,25\n'
    + 'FIELD:company_foreign_domestic:CARRY:0,0\n'
    + 'FIELD:company_bdid:CARRY:0,0\n'
    + '// -- could add this field as SWITCH0 \n'
    + 'FIELD:company_phone:SWITCH0:PROP:27,298\n'
    + '//FIELD:current:PROP:FORCE(--):3,0\n'
    + '//FIELD:iscorp:SWITCH0:PROP:1,0\n'
    + '// ------------------------------------\n'
    + '//  2. Place\n'
    + '// ------------------------------------\n'
    + 'FIELD:prim_name:CARRY:0,0\n'
    + 'FIELD:prim_name_derived:BAGOFWORDS(MOST):EDIT1:FORCE(+5):ABBR(FIRST):HYPHEN1:13,7\n'
    + '// FIELD:prim_name:BAGOFWORDS(MOST):EDIT1:FORCE(+5):ABBR(FIRST):HYPHEN1:13,4\n'
    + '//FIELD:prim_name:FORCE(+):15,0\n'
    + 'FIELD:sec_range:HYPHEN1:PROP:12,84\n'
    + 'FIELD:v_city_name:CONTEXT(st):11,13\n'
    + 'FIELD:st:LIKE(alpha):FORCE(+):5,0\n'
    + 'FIELD:zip:LIKE(number):14,6\n'
    + 'BESTTYPE:SINGLEPRIMRANGE:BASIS(cnp_name:prim_name_derived:v_city_name:st:zip):UNIQUE:PROP\n'
    + 'FIELD:prim_range:CARRY:0,0\n'
    + 'FIELD:prim_range_derived:FORCE:SINGLEPRIMRANGE:13,3\n'
    + 'CONCEPT:company_csz:v_city_name:st:zip:FORCE(+-2):14,24\n'
    + 'CONCEPT:company_addr1:prim_range_derived:prim_name_derived:sec_range:24,99\n'
    + 'CONCEPT:company_address:company_addr1:company_csz:FORCE(+):25,116\n'
    + '// ------------------------------------\n'
    + '//  3. Contact\n'
    + '// ------------------------------------\n'
    + '// -- could add these fields as SWITCH0.  maybe just the concept...\n'
    + '//FIELD:isContact:CARRY:0,0\n'
    + '//FIELD:title:SWITCH0:1,13\n'
    + '//FIELD:fname:SWITCH0:11,98\n'
    + '//FIELD:mname:SWITCH0:8,56\n'
    + '//FIELD:lname:SWITCH0:15,64\n'
    + '//FIELD:name_suffix:SWITCH0:8,22\n'
    + '//CONCEPT:contact_name:fname:mname:lname:BAGOFWORDS:23,158\n'
    + '//CONCEPT:contact_fullname:contact_name:name_suffix:23,164\n'
    + '//FIELD:contact_ssn:SWITCH0:28,5\n'
    + '//FIELD:contact_phone:SWITCH0:23,44\n'
    + '//FIELD:contact_email:LIKE(upper):SWITCH0:29,4\n'
    + '//FIELD:contact_job_title_raw:SWITCH0:6,457\n'
    + '//FIELD:company_department:SWITCH0:0,0\n'
    + '// ------------------------------------\n'
    + '//  Metadata\n'
    + '// ------------------------------------\n'
    + 'FIELD:dt_first_seen:RECORDDATE(FIRST):0,0\n'
    + 'FIELD:dt_last_seen:RECORDDATE(LAST):0,0\n'
    + 'SOURCEFIELD:source:PARTITION(BIPV2.Mod_Sources.src2partition)\n'
    + 'HACK:CUSTOMINTERNALJOIN:_mj_extra\n'
    + '// ------------------------------------\n'
    + '//  Cleaves\n'
    + '// ------------------------------------\n'
    + 'CLEAVE:solo_corp_key:BASIS(active_domestic_corp_key):MINIMUM(1)\n'
    + '//CLEAVE:solo_active_duns:BASIS(active_duns_number):MINIMUM(1)\n'
    + 'CLEAVE:solo_cnp_number:BASIS(cnp_number):MINIMUM(1)\n'
    + '// ------------------------------------\n'
    + '//  Attribute Files\n'
    + '// ------------------------------------\n'
    + 'ATTRIBUTEFILE:SrcRidVlid:NAMED(file_SrcRidVlid):VALUES(source:source_record_id:vl_id):IDFIELD(Proxid):SUPPORTS(cnp_name):27,647\n'
    + 'ATTRIBUTEFILE:ForeignCorpkey:NAMED(file_Foreign_Corpkey):VALUES(company_charter_number<company_inc_state):FORCE(--,ALL):IDFIELD(Proxid):27,39\n'
    + 'ATTRIBUTEFILE:RAAddresses:NAMED(file_RA_Addresses):VALUES(cname):FORCE:IDFIELD(Proxid):28,84\n'
    + 'ATTRIBUTEFILE:FilterPrimNames:NAMED(file_filter_Prim_names):VALUES(pname_digits):FORCE:IDFIELD(Proxid):13,3\n'
    + '// ------------------------------------\n'
    + '//  ID Parents\n'
    + '// ------------------------------------\n'
    + 'IDPARENTS:lgid3,orgid,ultid\n'
    + 'IDCHILDREN:dotid\n'
    + 'BLOCKLINK:NAMED(OverLinks):BASIS(cnp_name)\n'
    + '//ATTRIBUTEFILE:SrcVlid:NAMED(file_SrcVlid):VALUES(source:vl_id):IDFIELD(Proxid):SUPPORTS(cnp_name):19,167\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    + '// DotID\n'
    + '// ?  a contact name (or the absence of a contact) at a company name at a physical address.  Separate legal entities within an office will consist of separate Dots.\n'
    + '// o  The only thing new here is the word ?physical?.  I want to allow for other address types to join in at the Dot level.\n'
    + '// ProxID\n'
    + '// 1. A legal entity at a physical address. (fuzzy matching to account for typos and different representations of same name)\n'
    + '// 2. has no more than 1 active charter for a given state (fuzzy matching to account for typos).  Now this should allow for charters from different states\n'
    + '//    to be ok, but not two charters in the same state.\n'
    + '// 3. has no more than 1 active Duns or LNCA lowest level ID.\n'
    + '// 4. Has no more than 1 status (active vs defunct).\n'
    + '// 5. Has no more than 1 legal name.\n'
    + '// 6. FEIN is sometimes useful for pulling records together, but won?t be pushed to push records apart.\n'
    + '// 7. Unincorporated businesses will need more than just company name & address to bring them together into a Prox.  Address + contact is enough.\n'
    + '// Beyond ProxID\n'
    + '// 1. LNCA hierarchy\n'
    + '// 2. Duns hierarchy\n'
    + '// Business Relatives (outside of hierarchy - linkable from a report)\n'
    + '// TBD, but essentially any other connection we come across in this process but do not feel is strong enough for ProxID linking.\n'
    ;
 
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
