// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Headers_Monthly';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'File';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,did,rid,pflag1,pflag2,pflag3,src,dt_first_seen,dt_last_seen,dt_vendor_last_reported,dt_vendor_first_reported,dt_nonglb_last_seen,rec_type,vendor_id,phone,ssn,dob,title,fname,mname,lname,name_suffix,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,county,geo_blk,cbsa,tnt,valid_ssn,jflag1,jflag2,jflag3,rawaid,dodgy_tracking,nid,address_ind,name_ind,persistent_record_id';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Headers_Monthly\n'
    + 'FILENAME:File\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + '//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '//FUZZY can be used to create new types of FUZZY linking\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + '\n'
    + 'FIELDTYPE:did:SPACES( ):LIKE(Invalid_Num):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:rid:SPACES( ):LIKE(Invalid_Num):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:pflag1:SPACES( ):ALLOW(+A):LENGTHS(1,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:pflag2:SPACES( ):ALLOW(?ANR):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:pflag3:SPACES( ):ALLOW(GV):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:src:SPACES( ):ALLOW(!+.01234567?ABCDEFGHIKLMNOPQRSTUVWXYZ):LENGTHS(2,1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dt_first_seen:SPACES( ):LIKE(Invalid_Num):LENGTHS(6,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dt_last_seen:SPACES( ):LIKE(Invalid_Num):LENGTHS(6,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dt_vendor_last_reported:SPACES( ):LIKE(Invalid_Num):LENGTHS(6,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dt_vendor_first_reported:SPACES( ):LIKE(Invalid_Num):LENGTHS(6,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dt_nonglb_last_seen:SPACES( ):LIKE(Invalid_Num):LENGTHS(0,6):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:rec_type:SPACES( ):ALLOW(123AHS):LENGTHS(1,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:vendor_id:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:phone:SPACES( ):LIKE(Invalid_Num):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:ssn:SPACES( ):LIKE(Invalid_Num):LENGTHS(9,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dob:SPACES( ):LIKE(Invalid_Num):LENGTHS(8,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:title:SPACES( ):ALLOW(MRS):LENGTHS(2,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:fname:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:mname:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:lname:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:name_suffix:SPACES( ):ALLOW(12345JRS):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:prim_range:SPACES( ):ALLOW(-/0123456789ABNW):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:predir:SPACES( ):ALLOW(ENSW):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:prim_name:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:suffix:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:postdir:SPACES( ):ALLOW(ENSW):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:unit_desig:SPACES( ):ALLOW(#ABCDEFILMNOPRSTUX):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:sec_range:SPACES( ):ALLOW(-0123456789ABCDEFGHIJKLMNOPQRSTUVW):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:city_name:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:st:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:zip:SPACES( ):LIKE(Invalid_Num):LENGTHS(5,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:zip4:SPACES( ):LIKE(Invalid_Num):LENGTHS(4,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:county:SPACES( ):LIKE(Invalid_Num):LENGTHS(3,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:geo_blk:SPACES( ):LIKE(Invalid_Num):LENGTHS(7,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:cbsa:SPACES( ):LIKE(Invalid_Num):LENGTHS(5,4,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:tnt:SPACES( ):ALLOW(DNPY):LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:valid_ssn:SPACES( ):ALLOW(BFGORUZ):LENGTHS(1,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:jflag1:SPACES( ):ALLOW(CLTU):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:jflag2:SPACES( ):ALLOW(ABCD):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:jflag3:SPACES( ):ALLOW(C):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:rawaid:SPACES( ):LIKE(Invalid_Num):LENGTHS(13):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dodgy_tracking:SPACES( ):ALLOW(0123456789KNU):LENGTHS(0,3):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:nid:SPACES( ):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:address_ind:SPACES( ):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:name_ind:SPACES( ):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:persistent_record_id:SPACES( ):ONFAIL(CLEAN)\n'
    + '\n'
    + 'FIELD:did:LIKE(did):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:rid:LIKE(rid):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:pflag1:LIKE(pflag1):TYPE(STRING1):0,0\n'
    + 'FIELD:pflag2:LIKE(pflag2):TYPE(STRING1):0,0\n'
    + 'FIELD:pflag3:LIKE(pflag3):TYPE(STRING1):0,0\n'
    + 'FIELD:src:LIKE(src):TYPE(STRING2):0,0\n'
    + 'FIELD:dt_first_seen:LIKE(dt_first_seen):TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:dt_last_seen:LIKE(dt_last_seen):TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:dt_vendor_last_reported:LIKE(dt_vendor_last_reported):TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:dt_vendor_first_reported:LIKE(dt_vendor_first_reported):TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:dt_nonglb_last_seen:LIKE(dt_nonglb_last_seen):TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:rec_type:LIKE(rec_type):TYPE(STRING1):0,0\n'
    + 'FIELD:vendor_id:LIKE(vendor_id):TYPE(QSTRING14):0,0\n'
    + 'FIELD:phone:LIKE(phone):TYPE(QSTRING8):0,0\n'
    + 'FIELD:ssn:LIKE(ssn):TYPE(QSTRING7):0,0\n'
    + 'FIELD:dob:LIKE(dob):TYPE(INTEGER4):0,0\n'
    + 'FIELD:title:LIKE(title):TYPE(QSTRING4):0,0\n'
    + 'FIELD:fname:LIKE(fname):TYPE(QSTRING15):0,0\n'
    + 'FIELD:mname:LIKE(mname):TYPE(QSTRING15):0,0\n'
    + 'FIELD:lname:LIKE(lname):TYPE(QSTRING15):0,0\n'
    + 'FIELD:name_suffix:LIKE(name_suffix):TYPE(QSTRING4):0,0\n'
    + 'FIELD:prim_range:LIKE(prim_range):TYPE(QSTRING8):0,0\n'
    + 'FIELD:predir:LIKE(predir):TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:LIKE(prim_name):TYPE(QSTRING21):0,0\n'
    + 'FIELD:suffix:LIKE(suffix):TYPE(QSTRING3):0,0\n'
    + 'FIELD:postdir:LIKE(postdir):TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:LIKE(unit_desig):TYPE(QSTRING8):0,0\n'
    + 'FIELD:sec_range:LIKE(sec_range):TYPE(QSTRING6):0,0\n'
    + 'FIELD:city_name:LIKE(city_name):TYPE(QSTRING19):0,0\n'
    + 'FIELD:st:LIKE(st):TYPE(STRING2):0,0\n'
    + 'FIELD:zip:LIKE(zip):TYPE(QSTRING4):0,0\n'
    + 'FIELD:zip4:LIKE(zip4):TYPE(QSTRING3):0,0\n'
    + 'FIELD:county:LIKE(county):TYPE(STRING3):0,0\n'
    + 'FIELD:geo_blk:LIKE(geo_blk):TYPE(QSTRING6):0,0\n'
    + 'FIELD:cbsa:LIKE(cbsa):TYPE(QSTRING4):0,0\n'
    + 'FIELD:tnt:LIKE(tnt):TYPE(STRING1):0,0\n'
    + 'FIELD:valid_ssn:LIKE(valid_ssn):TYPE(STRING1):0,0\n'
    + 'FIELD:jflag1:LIKE(jflag1):TYPE(STRING1):0,0\n'
    + 'FIELD:jflag2:LIKE(jflag2):TYPE(STRING1):0,0\n'
    + 'FIELD:jflag3:LIKE(jflag3):TYPE(STRING1):0,0\n'
    + 'FIELD:rawaid:LIKE(rawaid):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:dodgy_tracking:LIKE(dodgy_tracking):TYPE(STRING5):0,0\n'
    + 'FIELD:nid:LIKE(nid):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:address_ind:LIKE(address_ind):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:name_ind:LIKE(name_ind):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:persistent_record_id:LIKE(persistent_record_id):TYPE(UNSIGNED8):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

