// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_GenerationMod := MODULE(SALT311.iGenerationMod)

  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE

  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_IDA';
  EXPORT spc_NAMESCOPE := 'Base';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'IDA';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,persistent_record_id,src,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,did,did_score,orig_first_name,orig_middle_name,orig_last_name,orig_suffix,orig_address1,orig_address2,orig_city,orig_state_province,orig_zip4,orig_zip5,orig_dob,orig_ssn,orig_dl,orig_dlstate,orig_phone,clientassigneduniquerecordid,adl_ind,orig_email,orig_ipaddress,orig_filecategory,title,fname,mname,lname,name_suffix,nid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,fips_st,fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,rawaid,aceaid,clean_phone,clean_dob';
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
    + 'MODULE:Scrubs_IDA\n'
    + 'FILENAME:IDA\n'
    + 'NAMESCOPE:Base\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_Rec_ID:ALLOW(0123456789_):LENGTHS(15)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs_IDA.Functions.Fn_Valid_Date > 0)\n'
    + 'FIELDTYPE:Invalid_FName:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ-):LENGTHS(2..20):WORDS(0,1)\n'
    + 'FIELDTYPE:Invalid_MName:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ.):LENGTHS(0..15):WORDS(0,1)\n'
    + 'FIELDTYPE:Invalid_LName:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ.-):LENGTHS(2..20):WORDS(0..2)\n'
    + 'FIELDTYPE:Invalid_Suffix:SPACES( ):ALLOW(SRJr.IVXPHMD):LENGTHS(0,1,2,3):WORDS(0,1)\n'
    + 'FIELDTYPE:Invalid_Title:SPACES( ):ALLOW(DMRS):LENGTHS(0,1,2,3):WORDS(0,1)\n'
    + 'FIELDTYPE:Invalid_Address1:SPACES( .):LIKE(Invalid_AlphaNum):WORDS(0..7)\n'
    + 'FIELDTYPE:Invalid_Address2:SPACES( #):LIKE(Invalid_AlphaNum):WORDS(0..2)\n'
    + 'FIELDTYPE:Invalid_City:SPACES( ):LIKE(Invalid_Alpha):WORDS(0..4)\n'
    + 'FIELDTYPE:Invalid_State:CUSTOM(Scrubs.Functions.fn_verify_state > 0)\n'
    + 'FIELDTYPE:Invalid_Zip:LIKE(Invalid_Num):LENGTHS(0,5)\n'
    + 'FIELDTYPE:Invalid_Zip4:LIKE(Invalid_Num):LENGTHS(0,4)\n'
    + 'FIELDTYPE:Invalid_SSN:LIKE(Invalid_Num):LENGTHS(0,9)\n'
    + 'FIELDTYPE:Invalid_DL:CUSTOM(Scrubs_IDA.Functions.Fn_Valid_DL > 0)\n'
    + 'FIELDTYPE:Invalid_Phone:ALLOW(0123456789):LENGTHS(0,10)\n'
    + 'FIELDTYPE:Invalid_Clientassigneduniquerecordid:ALLOW(abcdefghijklmnopqrstuvwxyz0123456789):LENGTHS(17,18,19)\n'
    + 'FIELDTYPE:Invalid_Emailaddress:CUSTOM(Scrubs.Functions.fn_valid_email > 0)\n'
    + 'FIELDTYPE:Invalid_Ipaddress:CUSTOM(Scrubs.Functions.fn_valid_IP > 0)\n'
    + 'FIELDTYPE:Invalid_NID:LIKE(Invalid_Num):LENGTHS(0,18,19,20)\n'
    + 'FIELDTYPE:Invalid_Dir:ALLOW(NESW):LENGTHS(0..2)\n'
    + 'FIELDTYPE:Invalid_Add:SPACES( ):LIKE(Invalid_AlphaNum):WORDS(0..3)\n'
    + 'FIELDTYPE:Invalid_Add_Suff:LIKE(Invalid_AlphaNum):LENGTHS(0,2..4)\n'
    + 'FIELDTYPE:Invalid_Coor:CUSTOM(Scrubs.Functions.fn_geo_coord > 0)\n'
    + 'FIELDTYPE:Invalid_Err:LIKE(Invalid_AlphaNum):LENGTHS(4)\n'
    + 'FIELDTYPE:Invalid_AID:LIKE(Invalid_Num):LENGTHS(12,13)\n'
    + '\n'
    + 'FIELD:persistent_record_id:TYPE(STRING15):LIKE(Invalid_Rec_ID):0,0\n'
    + 'FIELD:src:TYPE(STRING2):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED6):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED6):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED6):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED6):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):LIKE(Invalid_Num):0,0\n'
    + 'FIELD:did_score:TYPE(UNSIGNED1):LIKE(Invalid_Num):0,0\n'
    + 'FIELD:orig_first_name:TYPE(STRING):LIKE(Invalid_FName):0,0\n'
    + 'FIELD:orig_middle_name:TYPE(STRING):LIKE(Invalid_MName):0,0\n'
    + 'FIELD:orig_last_name:TYPE(STRING):LIKE(Invalid_LName):0,0\n'
    + 'FIELD:orig_suffix:TYPE(STRING3):LIKE(Invalid_Suffix):0,0\n'
    + 'FIELD:orig_address1:TYPE(STRING):LIKE(Invalid_Address1):0,0\n'
    + 'FIELD:orig_address2:TYPE(STRING):LIKE(Invalid_Address2):0,0\n'
    + 'FIELD:orig_city:TYPE(STRING):LIKE(Invalid_City):0,0\n'
    + 'FIELD:orig_state_province:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:orig_zip4:TYPE(STRING):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:orig_zip5:TYPE(STRING):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:orig_dob:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:orig_ssn:TYPE(STRING12):LIKE(Invalid_SSN):0,0\n'
    + 'FIELD:orig_dl:TYPE(STRING12):LIKE(Invalid_DL):0,0\n'
    + 'FIELD:orig_dlstate:TYPE(STRING5):LIKE(Invalid_State):0,0\n'
    + 'FIELD:orig_phone:TYPE(STRING):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:clientassigneduniquerecordid:TYPE(STRING):LIKE(Invalid_Clientassigneduniquerecordid):0,0\n'
    + 'FIELD:adl_ind:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:orig_email:TYPE(STRING):LIKE(Invalid_Emailaddress):0,0\n'
    + 'FIELD:orig_ipaddress:TYPE(STRING15):LIKE(Invalid_Ipaddress):0,0\n'
    + 'FIELD:orig_filecategory:TYPE(STRING20):0,0\n'
    + 'FIELD:title:TYPE(STRING5):LIKE(Invalid_Title):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):LIKE(Invalid_FName):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):LIKE(Invalid_MName):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):LIKE(Invalid_LName):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):LIKE(Invalid_Suffix):0,0\n'
    + 'FIELD:nid:TYPE(UNSIGNED8):LIKE(Invalid_NID):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):LIKE(Invalid_Num):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):LIKE(Invalid_Dir):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):LIKE(Invalid_Add):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):LIKE(Invalid_Add_Suff):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):LIKE(Invalid_Dir):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):LIKE(Invalid_Add_Suff):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):LIKE(Invalid_Num):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):LIKE(Invalid_City):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):LIKE(Invalid_City):0,0\n'
    + 'FIELD:st:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):LIKE(Invalid_Zip4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):LIKE(Invalid_Num):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dbpc:TYPE(STRING2):LIKE(Invalid_Num):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):LIKE(Invalid_Num):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:fips_st:TYPE(STRING2):LIKE(Invalid_Num):0,0\n'
    + 'FIELD:fips_county:TYPE(STRING3):LIKE(Invalid_Num):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):LIKE(Invalid_Coor):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):LIKE(Invalid_Coor):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):LIKE(Invalid_Num):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):LIKE(Invalid_Num):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):LIKE(Invalid_Num):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):LIKE(Invalid_Err):0,0\n'
    + 'FIELD:rawaid:TYPE(UNSIGNED8):LIKE(Invalid_AID):0,0\n'
    + 'FIELD:aceaid:TYPE(UNSIGNED8):LIKE(Invalid_AID):0,0\n'
    + 'FIELD:clean_phone:TYPE(STRING10):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:clean_dob:TYPE(STRING8):LIKE(Invalid_Date):0,0'
    ;

  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;
