// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
  EXPORT spcString :=
    'OPTIONS:-ga -gs2 -p0\n'
    + 'MODULE:LocationId_iLink\n'
    + 'FILENAME:LocationId\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + 'IDFIELD:EXISTS:LocId\n'
    + 'RIDFIELD:rid\n'
    + 'RECORDS:50000000\n'
    + 'POPULATION:5000000\n'
    + 'NINES:3\n'
    + '\n'
    + 'FIELDTYPE:alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:number:ALLOW(0123456789)\n'
    + 'FIELDTYPE:upper:CAPS:ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:zip5:ALLOW(0123456789):LENGTHS(0,5):ONFAIL(IGNORE)\n'
    + 'FIELDTYPE:hasZip4:ALLOW(0123456789):LENGTHS(0,4):ONFAIL(IGNORE)\n'
    + 'FIELDTYPE:alpha_st:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0,2):ONFAIL(IGNORE)\n'
    + '\n'
    + 'FUZZY:ErrStat:RS:CUSTOM(CustomErrStat):TYPE(STRING4)\n'
    + 'FUZZY:PrimNameCountCheck:RS:CUSTOM(PrimNameCount):TYPE(UNSIGNED8)\n'
    + 'FUZZY:PrimNameFuzzCheck:RS:CUSTOM(PrimNameMatch):TYPE(STRING28)\n'
    + '\n'
    + 'FIELD:aid:CARRY:0,0\n'
    + 'FIELD:prim_range:FORCE(+):13,0\n'
    + 'FIELD:predir:FORCE(--):7,0\n'
    + 'FIELD:prim_name:EDIT1:HYPHEN1:PrimNameFuzzCheck:14,0  \n'
    + 'FIELD:addr_suffix:FORCE(--):4,0\n'
    + 'FIELD:postdir:FORCE(--):6,0\n'
    + 'FIELD:unit_desig:CARRY:0,0\n'
    + 'FIELD:sec_range:HYPHEN1:FORCE(--):14,0\n'
    + 'FIELD:v_city_name:CONTEXT(st):FORCE(+):7,0\n'
    + 'FIELD:st:LIKE(alpha_st):FORCE(+):1,0\n'
    + 'FIELD:zip5:LIKE(zip5):FORCE(+):9,0\n'
    + 'FIELD:rec_type:CARRY:0,0  \n'
    + 'FIELD:err_stat:ErrStat:FORCE(--):3,0 \n'
    + 'FIELD:cntprimname:PrimNameCountCheck:FORCE(+, OR (prim_name)):10,0 \n'
    + ' \n'
    ;
 
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
