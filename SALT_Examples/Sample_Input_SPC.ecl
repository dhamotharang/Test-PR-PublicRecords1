MODULE:<EnterModuleNameHere>
FILENAME:Sample
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("'):
FIELDTYPE:NUMBER:ALLOW(0123456789):
FIELDTYPE:ALPHA:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):
FIELDTYPE:WORDBAG:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN):
FIELDTYPE:CITY:LIKE(WORDBAG):LENGTHS(0,4..):ONFAIL(CLEAN):
FIELD:rcid:0,0
FIELD:bdid:0,0
FIELD:source:0,0
FIELD:vendor_id:0,0
FIELD:dt_first_seen:0,0
FIELD:dt_last_seen:0,0
FIELD:company_name:LIKE(WORDBAG):0,0
FIELD:prim_range:0,0
FIELD:predir:0,0
FIELD:prim_name:0,0
FIELD:addr_suffix:LIKE(ALPHA):0,0
FIELD:postdir:0,0
FIELD:unit_desig:0,0
FIELD:sec_range:0,0
FIELD:city:0,0
FIELD:state:LIKE(ALPHA):0,0
FIELD:zip:LIKE(NUMBER):0,0
FIELD:zip4:LIKE(NUMBER):0,0
FIELD:county:0,0
FIELD:msa:LIKE(NUMBER):0,0
FIELD:Phone:LIKE(NUMBER):0,0
FIELD:fein:LIKE(NUMBER):0,0
SOURCEFIELD:source
