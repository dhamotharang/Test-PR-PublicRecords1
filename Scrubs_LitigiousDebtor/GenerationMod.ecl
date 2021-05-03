// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_LitigiousDebtor';
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
  EXPORT spc_FILENAME := 'LitigiousDebtor';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,record_type,recid,courtstate,courtid,courtname,docketnumber,officename,asofdate,classcode,casecaption,datefiled,judgetitle,judgename,referredtojudgetitle,referredtojudge,jurydemand,demandamount,suitnaturecode,suitnaturedesc,leaddocketnumber,jurisdiction,cause,statute,ca,caseclosed,dateretrieved,otherdocketnumber,litigantname,litigantlabel,layoutcode,terminationdate,attorneyname,attorneylabel,firmname,address,city,state,zipcode,country,addtlinfo,termdate,bdid,did,causecode,judge_title,judge_fname,judge_mname,judge_lname,judge_suffix,judge_score,business_person,debtor,debtor_title,debtor_fname,debtor_mname,debtor_lname,debtor_suffix,debtor_score,attorney_title,attorney_fname,attorney_mname,attorney_lname,attorney_suffix,attorney_score,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,fips_state,fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat';
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
    + 'MODULE:Scrubs_LitigiousDebtor\n'
    + 'FILENAME:LitigiousDebtor\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'Num\')\n'
    + 'FIELDTYPE:Invalid_Float:ALLOW(0123456789.,-:)\n'
    + 'FIELDTYPE:Invalid_Alpha:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'Alpha\')\n'
    + 'FIELDTYPE:Invalid_AlphaChar:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaChar\')\n'
    + 'FIELDTYPE:Invalid_AlphaNum:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaNum\')\n'
    + 'FIELDTYPE:Invalid_AlphaNumChar:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaNumChar\')\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.Fn_valid_Date > 0)\n'
    + 'FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0,2)\n'
    + 'FIELDTYPE:Invalid_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ-):LENGTHS(0,6)\n'
    + 'FIELDTYPE:Invalid_Zip:LIKE(Invalid_Float):LENGTHS(0,5,9,10)\n'
    + 'FIELDTYPE:Invalid_YOrN:ALLOW(YN):LENGTHS(0,1)\n'
    + '\n'
    + '\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:recid:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:courtstate:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:courtid:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:courtname:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:docketnumber:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:officename:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:asofdate:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:classcode:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:casecaption:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:datefiled:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:judgetitle:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:judgename:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:referredtojudgetitle:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:referredtojudge:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:jurydemand:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:demandamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:suitnaturecode:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:suitnaturedesc:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:leaddocketnumber:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:jurisdiction:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:cause:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:statute:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:ca:TYPE(STRING):LIKE(Invalid_YOrN):0,0\n'
    + 'FIELD:caseclosed:TYPE(STRING):LIKE(Invalid_YOrN):0,0\n'
    + 'FIELD:dateretrieved:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:otherdocketnumber:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:litigantname:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:litigantlabel:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:layoutcode:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:terminationdate:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:attorneyname:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:attorneylabel:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:firmname:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:address:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:city:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:state:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:zipcode:TYPE(STRING):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:country:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:addtlinfo:TYPE(STRING):0,0\n'
    + 'FIELD:termdate:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):LIKE(Invalid_No):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):LIKE(Invalid_No):0,0\n'
    + 'FIELD:causecode:TYPE(STRING1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:judge_title:TYPE(STRING5):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:judge_fname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:judge_mname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:judge_lname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:judge_suffix:TYPE(STRING5):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:judge_score:TYPE(STRING3):LIKE(Invalid_No):0,0\n'
    + 'FIELD:business_person:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:debtor:TYPE(STRING73):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:debtor_title:TYPE(STRING5):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:debtor_fname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:debtor_mname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:debtor_lname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:debtor_suffix:TYPE(STRING5):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:debtor_score:TYPE(STRING3):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:attorney_title:TYPE(STRING5):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:attorney_fname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:attorney_mname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:attorney_lname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:attorney_suffix:TYPE(STRING5):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:attorney_score:TYPE(STRING3):LIKE(Invalid_No):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):LIKE(Invalid_No):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:st:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dbpc:TYPE(STRING2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:fips_state:TYPE(STRING2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:fips_county:TYPE(STRING3):LIKE(Invalid_No):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):LIKE(Invalid_No):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

