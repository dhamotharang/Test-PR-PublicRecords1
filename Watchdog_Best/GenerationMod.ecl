// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)

  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.7';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE

  // Core module configuration values
  EXPORT spc_MODULE := 'Watchdog_best';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := 'did'; // cluster id (input)
  EXPORT spc_IDFIELD := 'did'; // cluster id (output)
  EXPORT spc_RIDFIELD := 'rid'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'src';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Hdr';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:rid';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_did */,pflag1,pflag2,pflag3,src,dt_first_seen,dt_last_seen,dt_vendor_last_reported,dt_vendor_first_reported,dt_nonglb_last_seen,rec_type,phone,ssn,dob,title,fname,mname,lname,name_suffix,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,valid_ssn,jflag1,jflag2,jflag3,rawaid,dodgy_tracking,address_ind,name_ind,persistent_record_id,ssnum,address';
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
    'OPTIONS:-ga\n'
    + 'FILENAME:Hdr\n'
    + 'MODULE:Watchdog_best\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + 'IDFIELD:EXISTS:did\n'
    + 'RIDFIELD:rid\n'
    + 'RECORDS:3000000000\n'
    + 'POPULATION:3000000000\n'
    + 'NINES:3\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + '// Field Types\n'
    + 'FIELDTYPE:number:ALLOW(0123456789)\n'
    + 'FIELDTYPE:alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:NAME:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -\'):ONFAIL(CLEAN)\n'
    + '//Title\n'
    + 'BESTTYPE:BestTitle:BASIS(did):COMMONEST:VALID(Watchdog_Best.fn_valid_name_title)\n'
    + '//Suffix\n'
    + 'BESTTYPE:BestSuffix:BASIS(did):COMMONEST:FUZZY:VALID(Watchdog_Best.fn_valid_name_suffix)\n'
    + '//SSN\n'
    + 'BESTTYPE:BestSSN:BASIS(did):COMMONEST:FUZZY:VALID(Watchdog_Best.fn_valid_ssn)\n'
    + 'BESTTYPE:SecondBestSSN:BASIS(did):COMMONEST:FUZZY:VALID(Watchdog_Best.fn_ok_ssn)\n'
    + '//Phone\n'
    + 'BESTTYPE:BestPhoneCurrentWithNpa:BASIS(did):RECENT(dt_last_seen):FUZZY:VALID(Watchdog_Best.fn_valid_phone)\n'
    + '//DOB\n'
    + 'BESTTYPE:BestDOB:BASIS(did):COMMONEST:VALID(Watchdog_Best.fn_valid_dob)\n'
    + 'BESTTYPE:NoDayDOB:BASIS(did):COMMONEST:VALID(Watchdog_Best.fn_dob_noday)\n'
    + 'BESTTYPE:NoMonthDOB:BASIS(did):COMMONEST:VALID(Watchdog_Best.fn_dob_nomonth)\n'
    + '//Address\n'
    + 'BESTTYPE:BestAddress:BASIS(did):RECENT(dt_last_seen):VALID(Watchdog_Best.fn_best_address)\n'
    + 'BESTTYPE:GongAddressBySeen:BASIS(did):RECENT(dt_last_seen):VALID(Watchdog_Best.fn_gong_address)\n'
    + 'BESTTYPE:BetterAddressBySeen:BASIS(did):RECENT(dt_last_seen):VALID(Watchdog_Best.fn_better_address)\n'
    + 'BESTTYPE:RecentAddressBySeen:BASIS(did):RECENT(dt_last_seen):VALID(Watchdog_Best.fn_valid_address)\n'
    + 'BESTTYPE:BetterAddressByReported:BASIS(did):RECENT(dt_vendor_last_reported):VALID(Watchdog_Best.fn_better_address2)\n'
    + 'BESTTYPE:RecentAddressByReported:BASIS(did):RECENT(dt_vendor_last_reported):VALID(Watchdog_Best.fn_valid_address2)\n'
    + 'BESTTYPE:CommonestAddress:BASIS(did):COMMONEST\n'
    + '// first name\n'
    + 'FUZZY:PreferredName:RST:CUSTOM(Watchdog_Best.fn_PreferredName):TYPE(STRING20)\n'
    + 'BESTTYPE:BestFirstName:BASIS(did):COMMONEST:FUZZY:VALID(Watchdog_Best.fn_valid_fname_strict)\n'
    + 'BESTTYPE:CommonFirstName:BASIS(did):COMMONEST:FUZZY:EXTEND:VALID(Watchdog_Best.fn_valid_fname)\n'
    + '// middle name\n'
    + 'BESTTYPE:BestMiddleName:BASIS(did):LONGEST:MINIMUM(2):FUZZY:VALID(Watchdog_Best.fn_valid_mname_strict)\n'
    + 'BESTTYPE:CommonMiddleName:BASIS(did):COMMONEST:FUZZY:EXTEND:VALID(Watchdog_Best.fn_valid_mname)\n'
    + '// last name\n'
    + 'BESTTYPE:BestLastName:BASIS(did):RECENT(dt_last_seen):FUZZY:VALID(Watchdog_Best.fn_valid_lname)\n'
    + 'BESTTYPE:CommonLastName:BASIS(did):COMMONEST:FUZZY:VALID(Watchdog_Best.fn_valid_lname)\n'
    + '// fields\n'
    + '//FIELD:did:TYPE(UNSIGNED6):1,1\n'
    + '//FIELD:rid:TYPE(UNSIGNED6):1,1\n'
    + 'FIELD:pflag1:TYPE(STRING1):44,2\n'
    + 'FIELD:pflag2:TYPE(STRING1):43,20\n'
    + 'FIELD:pflag3:TYPE(STRING1):7,1\n'
    + 'FIELD:src:TYPE(STRING2):311,93\n'
    + 'SOURCEFIELD:src:PERMITS(fn_sources)\n'
    + '//DATEFIELD:dt_first_seen:61,8\n'
    + '//DATEFIELD:dt_last_seen:56,9\n'
    + '//DATEFIELD:dt_vendor_last_reported:48,9\n'
    + '//DATEFIELD:dt_vendor_first_reported:50,8\n'
    + '//DATEFIELD:dt_nonglb_last_seen:64,8\n'
    + 'FIELD:dt_first_seen:TYPE(unsigned3):61,8\n'
    + 'FIELD:dt_last_seen:TYPE(unsigned3):56,9\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(unsigned3):48,9\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(unsigned3):50,8\n'
    + 'FIELD:dt_nonglb_last_seen:TYPE(unsigned3):64,8\n'
    + 'FIELD:rec_type:TYPE(STRING1):12,6\n'
    + 'FIELD:phone:TYPE(QSTRING8):LIKE(number):EDIT1:BestPhoneCurrentWithNpa:17,0\n'
    + 'FIELD:ssn:TYPE(QSTRING7):17,1\n'
    + 'FIELD:dob:TYPE(INTEGER4):BestDOB:NoDayDOB:NoMonthDOB:13,1\n'
    + 'FIELD:title:TYPE(QSTRING4):BestTitle:1,0\n'
    + 'FIELD:fname:TYPE(QSTRING15):EDIT1:INITIAL:BestFirstName:CommonFirstName:1,1\n'
    + 'FIELD:mname:TYPE(QSTRING15):EDIT1:INITIAL:BestMiddleName:CommonMiddleName:1,1\n'
    + 'FIELD:lname:TYPE(QSTRING15):HYPHEN1:CommonLastName:1,1\n'
    + 'FIELD:name_suffix:TYPE(QSTRING4):BestSuffix:70,1\n'
    + 'FIELD:prim_range:TYPE(QSTRING8):115,3\n'
    + 'FIELD:predir:TYPE(STRING2):38,3\n'
    + 'FIELD:prim_name:TYPE(QSTRING21):131,4\n'
    + 'FIELD:suffix:TYPE(QSTRING3):29,4\n'
    + 'FIELD:postdir:TYPE(STRING2):61,2\n'
    + 'FIELD:unit_desig:TYPE(QSTRING8):29,3\n'
    + 'FIELD:sec_range:TYPE(QSTRING6):103,5\n'
    + 'FIELD:city_name:TYPE(QSTRING19):109,3\n'
    + 'FIELD:st:TYPE(STRING2):48,2\n'
    + 'FIELD:zip:TYPE(QSTRING4):129,4\n'
    + 'FIELD:zip4:TYPE(QSTRING3):116,5\n'
    + 'FIELD:tnt:TYPE(STRING1):93,2\n'
    + 'FIELD:valid_ssn:TYPE(STRING1):21,1\n'
    + 'FIELD:jflag1:TYPE(STRING1):24,5\n'
    + 'FIELD:jflag2:TYPE(STRING1):37,0\n'
    + 'FIELD:jflag3:TYPE(STRING1):25,0\n'
    + 'FIELD:rawaid:TYPE(UNSIGNED8):169,5\n'
    + 'FIELD:dodgy_tracking:TYPE(STRING5):53,4\n'
    + 'FIELD:address_ind:TYPE(UNSIGNED2):1,0\n'
    + 'FIELD:name_ind:TYPE(UNSIGNED2):1,1\n'
    + 'FIELD:persistent_record_id:TYPE(UNSIGNED8):1,1\n'
    + 'CONCEPT:ssnum:ssn:valid_ssn:BestSSN:SecondBestSSN:56,5\n'
    + 'CONCEPT:address:prim_range:predir:prim_name:suffix:postdir:unit_desig:sec_range:city_name:st:zip:zip4:tnt:rawaid:dt_first_seen:dt_last_seen:dt_vendor_first_reported:dt_vendor_last_reported:BestAddress:GongAddressBySeen:BetterAddressBySeen:BetterAddressByReported:RecentAddressBySeen:RecentAddressByReported:CommonestAddress:170,5\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking'
    ;

  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;
