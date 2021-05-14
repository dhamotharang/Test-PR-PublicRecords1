// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Source_Level_Base_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'PhonesPlus_V2';
  EXPORT spc_NAMESCOPE := 'Source_Level_Base';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := 'record_sid'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'source';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Source_Level_Base';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:record_sid';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,cellphoneidkey,source,src_bitmap,household_flag,rules,cellphone,npa,phone7,phone7_did_key,pdid,did,did_score,datefirstseen,datelastseen,datevendorfirstreported,datevendorlastreported,dt_nonglb_last_seen,glb_dppa_flag,did_type,origname,address1,address2,origcity,origstate,origzip,orig_phone,orig_carrier_name,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,state,zip5,zip4,cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,rec_type,ace_fips_st,ace_fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,title,fname,mname,lname,name_suffix,name_score,dob,rawaid,cleanaid,current_rec,first_build_date,last_build_date,ingest_tpe,verified,cord_cutter,activity_status,prepaid,global_sid,record_sid';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := FALSE;
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
    + 'NAMESCOPE:Source_Level_Base\n'
    + 'FILENAME:Source_Level_Base\n'
    + 'MODULE:PhonesPlus_V2\n'
    + '\n'
    + 'RIDFIELD:record_sid\n'
    + 'SOURCEFIELD:source\n'
    + '\n'
    + '//DF-27472 update rules field on detail records\n'
    + '\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELD:cellphoneidkey:TYPE(DATA16):0,0\n'
    + 'FIELD:source:TYPE(STRING2):0,0\n'
    + 'FIELD:src_bitmap:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:household_flag:TYPE(BOOLEAN):0,0\n'
    + 'FIELD:rules:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:cellphone:TYPE(STRING10):0,0\n'
    + 'FIELD:npa:TYPE(STRING3):0,0\n'
    + 'FIELD:phone7:TYPE(STRING7):0,0\n'
    + 'FIELD:phone7_did_key:TYPE(DATA16):0,0\n'
    + 'FIELD:pdid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:did_score:TYPE(STRING3):0,0\n'
    + 'FIELD:datefirstseen:TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:datelastseen:TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:datevendorfirstreported:TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:datevendorlastreported:TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:dt_nonglb_last_seen:TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:glb_dppa_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:did_type:TYPE(STRING10):0,0\n'
    + 'FIELD:origname:TYPE(STRING90):0,0\n'
    + 'FIELD:address1:TYPE(STRING25):0,0\n'
    + 'FIELD:address2:TYPE(STRING25):0,0\n'
    + 'FIELD:origcity:TYPE(STRING20):0,0\n'
    + 'FIELD:origstate:TYPE(STRING2):0,0\n'
    + 'FIELD:origzip:TYPE(STRING9):0,0\n'
    + 'FIELD:orig_phone:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_carrier_name:TYPE(STRING60):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:state:TYPE(STRING2):0,0\n'
    + 'FIELD:zip5:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dpbc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_st:TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_county:TYPE(STRING3):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:TYPE(STRING3):0,0\n'
    + 'FIELD:dob:TYPE(STRING8):0,0\n'
    + 'FIELD:rawaid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:cleanaid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:current_rec:TYPE(BOOLEAN):0,0\n'
    + 'FIELD:first_build_date:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:last_build_date:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:ingest_tpe:TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:verified:TYPE(STRING1):0,0\n'
    + 'FIELD:cord_cutter:TYPE(STRING1):0,0\n'
    + 'FIELD:activity_status:TYPE(STRING2):0,0\n'
    + 'FIELD:prepaid:TYPE(STRING1):0,0\n'
    + 'FIELD:global_sid:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:record_sid:TYPE(UNSIGNED8):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

