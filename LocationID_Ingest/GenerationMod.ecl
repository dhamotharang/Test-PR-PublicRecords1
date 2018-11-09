// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
  EXPORT spcString :=
    'OPTIONS:-gn \n'
    + 'MODULE:LocationID_Ingest\n'
    + '\n'
    + '// -------------------------------------------------------------------\n'
    + '// Ingest\n'
    + '// -------------------------------------------------------------------\n'
    + 'FILENAME:BASE\n'
    + 'IDFIELD:EXISTS:LocId\n'
    + 'RIDFIELD:rid:GENERATE\n'
    + 'SOURCEFIELD:source\n'
    + 'SOURCERIDFIELD:source_record_id\n'
    + 'INGESTFILE:address_update:NAMED(LocationID_Ingest.In_INGEST)\n'
    + 'CONFIG:_CFG\n'
    + '\n'
    + 'FIELDTYPE:WORDBAG:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):SPACES( ):ONFAIL(IGNORE)\n'
    + 'FIELDTYPE:CITY:LIKE(WORDBAG):LENGTHS(0,3..):ONFAIL(IGNORE) \n'
    + 'FIELDTYPE:zip5:ALLOW(0123456789):LENGTHS(0,5):ONFAIL(IGNORE)\n'
    + 'FIELDTYPE:hasZip4:ALLOW(0123456789):LENGTHS(0,4):ONFAIL(IGNORE)\n'
    + 'FIELDTYPE:alpha_st:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0,2):ONFAIL(IGNORE)\n'
    + '\n'
    + '// FIELD:source_record_id:DERIVED:0,0\n'
    + 'FIELD:aid:DERIVED:0,0\n'
    + '// RECORDDATE fields are not considered for matching, and will be rolled up\n'
    + 'FIELD:dateseenfirst:RECORDDATE(FIRST):0,0\n'
    + 'FIELD:dateseenlast:RECORDDATE(LAST):0,0\n'
    + '\n'
    + '// Fields DERIVED by the linking team are not considered for matching, and will receive their "new" value (i.e. ingest file)\n'
    + 'FIELD:prim_range:0,0\n'
    + 'FIELD:predir:0,0\n'
    + 'FIELD:prim_name:0,0\n'
    + 'FIELD:addr_suffix:0,0\n'
    + 'FIELD:postdir:0,0\n'
    + 'FIELD:unit_desig:0,0\n'
    + 'FIELD:sec_range:0,0\n'
    + 'FIELD:v_city_name:like(CITY):0,0\n'
    + 'FIELD:st:LIKE(alpha_st):0,0\n'
    + 'FIELD:zip5:LIKE(zip5):0,0\n'
    + 'FIELD:rec_type:0,0  \n'
    + 'FIELD:err_stat:0,0  \n'
    + 'FIELD:cntprimname:0,0  \n'
    ;
 
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
