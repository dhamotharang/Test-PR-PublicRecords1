// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
  EXPORT spcString :=
    'OPTIONS:-ma\n'
    + 'MODULE:LocationId_xLink\n'
    + 'FILENAME:LocationId\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + 'IDFIELD:EXISTS:LocId\n'
    + 'IDNAME:LocId\n'
    + 'RIDFIELD:rid\n'
    + 'RECORDS:1554843014\n'
    + 'POPULATION:160000000\n'
    + 'PROCESS:LocationID\n'
    + 'NINES:3\n'
    + 'CONFIG:_CFG\n'
    + 'HACK:KEYINFIX\n'
    + 'HACK:KEYPREFIX\n'
    + 'HACK:KEYSUPERFILE\n'
    + '\n'
    + 'FIELDTYPE:zip5:ALLOW(0123456789):LENGTHS(0,5):ONFAIL(IGNORE)\n'
    + 'FIELDTYPE:alpha_st:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0,2):ONFAIL(IGNORE)\n'
    + 'FIELDTYPE:DFLT:LEFTTRIM:SPACES( <>{}[]-^=!+&,./)\n'
    + '\n'
    + 'FIELD:prim_range:13,0\n'
    + 'FIELD:predir:EDIT1:5,0\n'
    + '// FIELD:prim_name:BAGOFWORDS(MOST):EDIT1:ABBR(FIRST):HYPHEN1:LIKE(DFLT):13,7\n'
    + 'FIELD:prim_name:EDIT1:ABBR(FIRST):HYPHEN1:LIKE(DFLT):16,0\n'
    + 'FIELD:addr_suffix:EDIT1:4,0\n'
    + 'FIELD:postdir:EDIT1:7,0\n'
    + 'FIELD:unit_desig:EDIT1:7,0\n'
    + 'FIELD:sec_range:HYPHEN1:13,0\n'
    + 'FIELD:v_city_name:EDIT1:12,0\n'
    + 'FIELD:st:LIKE(alpha_st):5,0\n'
    + 'FIELD:zip5:LIKE(zip5):14,0\n'
    + '\n'
    + 'LINKPATH:STATECITY:v_city_name:st:prim_range:prim_name:?:sec_range:+:unit_desig:postdir:addr_suffix:predir\n'
    + 'LINKPATH:ZIP:zip5:prim_range:prim_name:?:sec_range:+:unit_desig:postdir:addr_suffix:predir\n'
    ;
 
  EXPORT linkpaths := DATASET([
    {'STATECITY','v_city_name,st,prim_range,prim_name','sec_range','unit_desig,postdir,addr_suffix,predir','',''}
    ,{'ZIP','zip5,prim_range,prim_name','sec_range','unit_desig,postdir,addr_suffix,predir','',''}
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
