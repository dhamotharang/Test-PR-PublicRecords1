// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.3';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'BIPV2_LGID3';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := 'LGID3'; // cluster id (input)
  EXPORT spc_IDFIELD := 'LGID3'; // cluster id (output)
  EXPORT spc_RIDFIELD := 'rcid'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'source';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'LGID3';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:rcid';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_LGID3 */,/* MY_seleid */,/* MY_orgid */,/* MY_ultid */,sbfe_id,nodes_below_st,Lgid3IfHrchy,OriginalSeleId,OriginalOrgId,company_name,cnp_number,active_duns_number,duns_number,duns_number_concept,company_fein,company_inc_state,company_charter_number,cnp_btype,company_name_type_derived,hist_duns_number,active_domestic_corp_key,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,cnp_name,cnp_hasNumber,cnp_lowv,cnp_translated,cnp_classid,prim_range,prim_name,sec_range,v_city_name,st,zip,has_lgid,is_sele_level,is_org_level,is_ult_level,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,levels_from_top,nodes_total,dt_first_seen,dt_last_seen,/* MY_SALT_Partition */';
  EXPORT spc_HAS_TWOSTEP := TRUE;
  EXPORT spc_HAS_PARTITION := TRUE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := TRUE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := TRUE;
  EXPORT spc_HAS_FORCE := TRUE;
  EXPORT spc_HAS_BLOCKLINK := TRUE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh -ga -p2 -gs2\n'
    + 'MODULE:BIPV2_LGID3 \n'
    + 'FILENAME:LGID3\n'
    + ' \n'
    + '// ------------------------------------\n'
    + '//  IDs and Tuning\n'
    + '// ------------------------------------\n'
    + 'IDFIELD:EXISTS:LGID3\n'
    + 'RIDFIELD:rcid\n'
    + 'IDPARENTS:seleid,orgid,ultid\n'
    + 'IDCHILDREN:proxid,dotid\n'
    + 'RECORDS:7082984780\n'
    + 'POPULATION:225000000\n'
    + 'NINES:3\n'
    + 'BLOCKTHRESHOLD:5 \n'
    + 'HACK:SLICETHRESHOLD:1 // No slices allowed!\n'
    + 'THRESHOLD:40\n'
    + '// This won\'t be needed after GitHub issue 667 is fixed\n'
    + 'HACK:CUSTOMINTERNALJOIN:_mj_extra\n'
    + '// ------------------------------------\n'
    + '//  Field validation/cleaning\n'
    + '// ------------------------------------\n'
    + 'FIELDTYPE:multiword:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:Noblanks:LIKE(multiword):LENGTHS(1..):ONFAIL(CLEAN,REJECT)\n'
    + '// ------------------------------------\n'
    + '//  Linking fields\n'
    + '// ------------------------------------\n'
    + '// Exclude clusters linked by Hrchy\n'
    + '//FIELDTYPE:not_hrchy:ENUM(0|1):ONFAIL(REJECT)\n'
    + '//FIELD:nodes_total:LIKE(not_hrchy):CARRY:0,0\n'
    + 'FIELD:sbfe_id:27,475\n'
    + 'FIELDTYPE:not_hrchy_parent:ENUM(_ENUM_Not_Hrchy_Parent):ONFAIL(REJECT)\n'
    + 'FIELD:nodes_below_st:LIKE(not_hrchy_parent):CARRY:0,0\n'
    + 'FIELD:Lgid3IfHrchy:FORCE(--):PROP:27,0\n'
    + '//LGID3 iteration may split sele cluster, the following will be used to merge them back.\n'
    + 'FIELD:OriginalSeleId:CARRY:0,0\n'
    + 'FIELD:OriginalOrgId:CARRY:0,0\n'
    + '// Legal Name\n'
    + '// FIELD:company_name:LIKE(multiword):BAGOFWORDS(MOST):EDIT1(2):PROP:FORCE(+):TYPE(string250):25,147\n'
    + 'FIELD:company_name:TYPE(STRING250):LIKE(Noblanks):BAGOFWORDS(MOST):EDIT1(2):PROP:TYPE(string250):26,398\n'
    + 'FIELD:cnp_number:PROP:FORCE(--,OR(sbfe_id)):13,2\n'
    + '// NOTE: This assumes we hack the data to blank company_name except when it\'s a Legal Name.\n'
    + '// Given field specificities and the THRESHOLD we\'ve set above, we in-effect require\n'
    + '// a match on at least one of: duns_number, company_charter_number, or company_fein\n'
    + '// DUNS number (v2)\n'
    + 'FIELD:active_duns_number:PROP:SWITCH0:27,57\n'
    + 'FIELD:duns_number:PROP:SWITCH0:27,68\n'
    + 'CONCEPT:duns_number_concept:active_duns_number:duns_number:27,111\n'
    + '//CONCEPT:company_csz:v_city_name:st:zip:FORCE(+-2):14,23\n'
    + '//FIELD:duns_number:PROP:25,260\n'
    + '// Company_charter_number or company_fein (v1)\n'
    + 'FIELD:company_fein:26,196\n'
    + 'FIELD:company_inc_state:PROP:FORCE(+,OR(active_duns_number),OR(duns_number),OR(duns_number_concept),OR(company_fein),OR(sbfe_id)):6,34\n'
    + 'FIELD:company_charter_number:PROP:CONTEXT(company_inc_state):26,110\n'
    + 'FIELD:cnp_btype:3,56\n'
    + '// ----------------------------------------------------\n'
    + '//  FYI -- no effect, but helpful during sample review\n'
    + '// ----------------------------------------------------\n'
    + '// FIELD:active_duns_number:CARRY:26,1\n'
    + 'FIELD:company_name_type_derived:CARRY:0,0\n'
    + 'FIELD:hist_duns_number:CARRY:0,0\n'
    + 'FIELD:active_domestic_corp_key:CARRY:0,0\n'
    + 'FIELD:hist_domestic_corp_key:CARRY:0,0\n'
    + 'FIELD:foreign_corp_key:CARRY:0,0\n'
    + 'FIELD:unk_corp_key:CARRY:0,0\n'
    + 'FIELD:cnp_name:CARRY:0,0\n'
    + 'FIELD:cnp_hasNumber:CARRY:0,0\n'
    + '// FIELD:cnp_number:CARRY:0,0\n'
    + 'FIELD:cnp_lowv:CARRY:0,0\n'
    + 'FIELD:cnp_translated:CARRY:0,0\n'
    + 'FIELD:cnp_classid:CARRY:0,0\n'
    + 'FIELD:prim_range:CARRY:0,0\n'
    + 'FIELD:prim_name:CARRY:0,0\n'
    + 'FIELD:sec_range:CARRY:0,0\n'
    + 'FIELD:v_city_name:CARRY:0,0\n'
    + 'FIELD:st:CARRY:0,0\n'
    + 'FIELD:zip:CARRY:0,0\n'
    + '//For the postprocess update. HS added\n'
    + 'FIELD:has_lgid:CARRY:0,0\t\n'
    + 'FIELD:is_sele_level:CARRY:0,0\n'
    + 'FIELD:is_org_level:CARRY:0,0\n'
    + 'FIELD:is_ult_level:CARRY:0,0\n'
    + 'FIELD:parent_proxid:CARRY:0,0\n'
    + 'FIELD:sele_proxid:CARRY:0,0\n'
    + 'FIELD:org_proxid:CARRY:0,0\n'
    + 'FIELD:ultimate_proxid:CARRY:0,0\n'
    + 'FIELD:levels_from_top:CARRY:0,0\n'
    + 'FIELD:nodes_total:CARRY:0,0\n'
    + '// ------------------------------------\n'
    + '//  Metadata\n'
    + '// ------------------------------------\n'
    + 'FIELD:dt_first_seen:RECORDDATE(FIRST):0,0\n'
    + 'FIELD:dt_last_seen:RECORDDATE(LAST):0,0\n'
    + 'SOURCEFIELD:source:CONSISTENT(company_inc_state,company_charter_number,company_name,cnp_btype,company_fein):PARTITION(BIPV2.Mod_Sources.src2partition)\n'
    + 'BLOCKLINK:NAMED(OverLinks):BASIS(company_name)\n'
    + '\n'
    + '//Underlinks\n'
    + 'ATTRIBUTEFILE:UnderLinks:NAMED(file_underLink):VALUES(UnderLinkId):IDFIELD(LGID3):41,0\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

