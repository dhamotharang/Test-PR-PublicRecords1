// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.3';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'InsuranceHeader_Address';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := 'ADDRESS_GROUP_ID'; // cluster id (input)
  EXPORT spc_IDFIELD := 'ADDRESS_GROUP_ID'; // cluster id (output)
  EXPORT spc_RIDFIELD := 'RID'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Address_Link';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:RID';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ADDRESS_GROUP_ID */,DID,src,dt_first_seen,dt_last_seen,prim_range,prim_range_alpha,prim_range_num,prim_range_fract,predir,prim_name,prim_name_num,prim_name_alpha,addr_suffix,addr_ind,postdir,unit_desig,sec_range,sec_range_alpha,sec_range_num,city,st,zip,rec_cnt,src_cnt,addr,locale';
  EXPORT spc_HAS_TWOSTEP := TRUE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := TRUE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-ga -gs2\n'
    + 'THRESHOLD:12\n'
    + 'MODULE:InsuranceHeader_Address\n'
    + 'IDNAME:ADDRESS_GROUP_ID\n'
    + 'RIDFIELD:RID\n'
    + 'FILENAME:Address_Link\n'
    + 'IDFIELD:EXISTS:ADDRESS_GROUP_ID\n'
    + 'RECORDS:3556054198\n'
    + 'POPULATION:3378251488\n'
    + 'NINES:3\n'
    + '// HACK:SLICEDISTANCE:18\n'
    + 'FIELDTYPE:WORDBAG:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN):\n'
    + 'FIELD:DID:WEIGHT(.01):FORCE(--):30,0\n'
    + 'FIELD:src:CARRY:\n'
    + 'FIELD:dt_first_seen:CARRY:\n'
    + 'FIELD:dt_last_seen:CARRY:\n'
    + 'FIELD:prim_range:CARRY:\n'
    + 'FIELD:prim_range_alpha:FORCE(--):PROP:10,0\n'
    + 'FIELD:prim_range_num:LIKE(WORDBAG):TYPE(STRING10):BAGOFWORDS(MOST):PROP:FORCE(--):13,0\n'
    + 'FIELD:prim_range_fract:FORCE(--):PROP:9,0\n'
    + 'FIELD:predir:CARRY:\n'
    + 'FIELD:prim_name:CARRY:\n'
    + 'FIELD:prim_name_num:LIKE(WORDBAG):TYPE(STRING28):BAGOFWORDS(MOST):FORCE(--):13,0\n'
    + 'FIELD:prim_name_alpha:LIKE(WORDBAG):TYPE(STRING50):BAGOFWORDS(MOST):FORCE(--):INITIAL:ABBR:HYPHEN2:10,0\n'
    + 'FIELD:addr_suffix:CARRY:\n'
    + 'FIELD:addr_ind:CARRY:\n'
    + 'FIELD:postdir:CARRY:\n'
    + 'FIELD:unit_desig:CARRY:\n'
    + 'FIELD:sec_range:CARRY:\n'
    + 'FIELD:sec_range_alpha:FORCE(--):PROP:9,0\n'
    + 'FIELD:sec_range_num:INITIAL:FORCE(--):PROP:9,0\n'
    + 'FIELD:city:LIKE(WORDBAG):TYPE(STRING25):BAGOFWORDS(MOST):EDIT1:HYPHEN2:8,0\n'
    + 'FIELD:st:FORCE(--):6,0\n'
    + 'FIELD:zip:14,0\n'
    + 'FIELD:rec_cnt:CARRY:\n'
    + 'FIELD:src_cnt:CARRY:\n'
    + 'CONCEPT:addr:prim_range_num:prim_range_alpha:prim_range_fract:prim_name_num:prim_name_alpha:sec_range_num:sec_range_alpha:FORCE(--):26,0\n'
    + 'CONCEPT:locale:city:st:zip:15,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

