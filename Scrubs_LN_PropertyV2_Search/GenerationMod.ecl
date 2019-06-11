// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_LN_PropertyV2_Search';
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
  EXPORT spc_FILENAME := 'LN_PropertyV2_Search';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,vendor_source_flag,ln_fares_id,process_date,source_code,which_orig,conjunctive_name_seq,title,fname,mname,lname,name_suffix,cname,nameasis,append_prepaddr1,append_prepaddr2,append_rawaid,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,phone_number,name_type,prop_addr_propagated_ind,did,bdid,app_ssn,app_tax_id,dotid,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,proxweight,seleid,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight,source_rec_id,ln_party_status,ln_percentage_ownership,ln_entity_type,ln_estate_trust_date,ln_goverment_type,xadl2_weight,addr_ind,best_addr_ind,addr_tx_id,best_addr_tx_id,location_id,best_locid';
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
    + 'MODULE:Scrubs_LN_PropertyV2_Search\n'
    + 'FILENAME:LN_PropertyV2_Search\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date > 0)\n'
    + 'FIELDTYPE:Invalid_LNFaresID:ALLOW(OADM0123456789)\n'
    + 'FIELDTYPE:Invalid_SourceCode:ENUM(OO|OP|SP|BP|SS|CO|CP|BB|CS|)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(-0123456789. )\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ\'\\"\\\\,0123456789&\\(\\) )\n'
    + 'FIELDTYPE:Invalid_RecType:ENUM(S|D|H|P|U|F|R|M|G|)\n'
    + 'FIELDTYPE:Invalid_PartyStatus:ENUM(HW|DC|SI|MA|WF|)\n'
    + 'FIELDTYPE:Invalid_LNEntityType:ENUM(P|B|T|I|)\n'
    + 'FIELDTYPE:Invalid_Percent:ALLOW(0123456789.% )\n'
    + '\n'
    + '\n'
    + 'FIELD:dt_first_seen:LIKE(Invalid_Date):TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:dt_last_seen:LIKE(Invalid_Date):TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:dt_vendor_first_reported:LIKE(Invalid_Date):TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:dt_vendor_last_reported:LIKE(Invalid_Date):TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:vendor_source_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:ln_fares_id:LIKE(Invalid_LNFaresID):TYPE(STRING12):0,0\n'
    + 'FIELD:process_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:source_code:LIKE(Invalid_SourceCode):TYPE(STRING2):0,0\n'
    + 'FIELD:which_orig:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:conjunctive_name_seq:LIKE(Invalid_Num):TYPE(STRING1):0,0\n'
    + 'FIELD:title:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:fname:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:mname:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:lname:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:cname:LIKE(Invalid_Char):TYPE(STRING80):0,0\n'
    + 'FIELD:nameasis:LIKE(Invalid_Char):TYPE(STRING80):0,0\n'
    + 'FIELD:append_prepaddr1:LIKE(Invalid_Char):TYPE(STRING100):0,0\n'
    + 'FIELD:append_prepaddr2:LIKE(Invalid_Char):TYPE(STRING50):0,0\n'
    + 'FIELD:append_rawaid:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:prim_range:LIKE(Invalid_Char):TYPE(STRING10):0,0\n'
    + 'FIELD:predir:LIKE(Invalid_Char):TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:LIKE(Invalid_Char):TYPE(STRING28):0,0\n'
    + 'FIELD:suffix:LIKE(Invalid_Char):TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:LIKE(Invalid_Char):TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:LIKE(Invalid_Char):TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:LIKE(Invalid_Char):TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:LIKE(Invalid_Char):TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:LIKE(Invalid_Char):TYPE(STRING25):0,0\n'
    + 'FIELD:st:LIKE(Invalid_Char):TYPE(STRING2):0,0\n'
    + 'FIELD:zip:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:cart:LIKE(Invalid_Char):TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:LIKE(Invalid_Char):TYPE(STRING1):0,0\n'
    + 'FIELD:lot:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:LIKE(Invalid_Num):TYPE(STRING1):0,0\n'
    + 'FIELD:dbpc:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:LIKE(Invalid_Num):TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:LIKE(Invalid_RecType):TYPE(STRING2):0,0\n'
    + 'FIELD:county:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + 'FIELD:geo_lat:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:LIKE(Invalid_Num):TYPE(STRING11):0,0\n'
    + 'FIELD:msa:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:LIKE(Invalid_Num):TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:LIKE(Invalid_Num):TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:LIKE(Invalid_Char):TYPE(STRING4):0,0\n'
    + 'FIELD:phone_number:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:name_type:TYPE(STRING1):0,0\n'
    + 'FIELD:prop_addr_propagated_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:app_ssn:LIKE(Invalid_Num):TYPE(STRING9):0,0\n'
    + 'FIELD:app_tax_id:LIKE(Invalid_Num):TYPE(STRING9):0,0\n'
    + 'FIELD:dotid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dotscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:dotweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:empscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:powscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:proxscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:selescore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:orgscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:ultscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:source_rec_id:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:ln_party_status:LIKE(Invalid_PartyStatus):TYPE(STRING2):0,0\n'
    + 'FIELD:ln_percentage_ownership:LIKE(Invalid_Percent):TYPE(STRING6):0,0\n'
    + 'FIELD:ln_entity_type:LIKE(Invalid_LNEntityType):TYPE(STRING2):0,0\n'
    + 'FIELD:ln_estate_trust_date:LIKE(Invalid_Num):TYPE(STRING8):0,0\n'
    + 'FIELD:ln_goverment_type:TYPE(STRING1):0,0\n'
    + 'FIELD:xadl2_weight:TYPE(INTEGER2):0,0\n'
    + 'FIELD:addr_ind:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:best_addr_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:addr_tx_id:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:best_addr_tx_id:TYPE(STRING1):0,0\n'
    + 'FIELD:location_id:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:best_locid:TYPE(STRING1):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

