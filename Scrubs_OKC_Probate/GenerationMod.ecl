// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT38;
EXPORT GenerationMod := MODULE(SALT38.iGenerationMod)

  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.2';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE

  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_OKC_Probate';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'OKC_Probate_Profile';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;

  // The entire spec file
  EXPORT spcString :=
    'MODULE:Scrubs_OKC_Probate\n'
    + ' FILENAME:OKC_Probate_Profile\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + '\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + 'FIELDTYPE:nums:ALLOW(0123456789)\n'
    + 'FIELDTYPE:lowercase:ALLOW(abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:uppercase:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:alphas:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:lowercaseandnums:ALLOW(abcdefghijklmnopqrstuvwxyz0123456789)\n'
    + 'FIELDTYPE:uppercaseandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)\n'
    + 'FIELDTYPE:alphasandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)\n'
    + 'FIELDTYPE:allupper:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:allupperandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)\n'
    + 'FIELDTYPE:allalphaandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)\n'
    + '\n'
    + 'FIELDTYPE:blank:LENGTHS(0)\n'
    + 'FIELDTYPE:invalid_blank:LIKE(blank)\n'
    + 'FIELDTYPE:invalid_alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ\'):SPACES( -):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_Num:ALLOW(0123456789):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_date:LIKE(nums):SPACES( -/):LENGTHS(0,8,9,10)\n'
    + 'FIELDTYPE:invalid_name:LIKE(allupperandnums):SPACES( -,./\'):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_company:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( -,&\\/.:#;()"):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_address:CAPS:LIKE(allupperandnums):SPACES( -&/\\#%.;,\'):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_city:LIKE(uppercase):SPACES( -,&\\/.:#;()"):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_state:LIKE(uppercase):LENGTHS(0,2)\n'
    + 'FIELDTYPE:invalid_zip:LIKE(nums):SPACES( -):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_phone:LIKE(nums):SPACES( ()-+):LENGTHS(0..15)\n'
    + 'FIELDTYPE:invalid_casenumber:LIKE(alphasandnums):SPACES( +.-):LENGTHS(0..)\n'
    + '\n'
    + 'FIELDTYPE:predir:SPACES( ):ALLOW(ENSW):LENGTHS(0,1,2)\n'
    + 'FIELDTYPE:prim_name:LIKE(uppercaseandnums):SPACES( /-):LENGTHS(0..)\n'
    + 'FIELDTYPE:addr_suffix:LIKE(uppercase):SPACES( ):LENGTHS(2,3,0,4)\n'
    + 'FIELDTYPE:postdir:SPACES( ):ALLOW(ENSW):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:unit_desig:LIKE(uppercase):SPACES( #):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:sec_range:LIKE(uppercaseandnums):SPACES( -):LENGTHS(0..)\n'
    + 'FIELDTYPE:p_city_name:LIKE(uppercase):SPACES( ):LENGTHS(0..)\n'
    + 'FIELDTYPE:v_city_name:LIKE(uppercase):SPACES( ):LENGTHS(0..)\n'
    + 'FIELDTYPE:st:LIKE(uppercase):SPACES( -):LENGTHS(0,2)\n'
    + 'FIELDTYPE:zip:LIKE(invalid_Num):SPACES( ):LENGTHS(5,0)\n'
    + 'FIELDTYPE:zip4:LIKE(invalid_Num):SPACES( ):LENGTHS(4,0)\n'
    + 'FIELDTYPE:cart:SPACES( ):ALLOW(0123456789BCHR):LENGTHS(4,0)\n'
    + 'FIELDTYPE:cr_sort_sz:SPACES( ):ALLOW(BCD):LENGTHS(0,1)\n'
    + 'FIELDTYPE:lot:LIKE(invalid_Num):SPACES( ):LENGTHS(4,0)\n'
    + 'FIELDTYPE:lot_order:SPACES( ):ALLOW(AD):LENGTHS(1,0)\n'
    + 'FIELDTYPE:dbpc:LIKE(invalid_Num):SPACES( ):LENGTHS(2,0)\n'
    + 'FIELDTYPE:chk_digit:LIKE(invalid_Num):SPACES( ):LENGTHS(0,1)\n'
    + 'FIELDTYPE:rec_type:SPACES( ):ALLOW(DFHMPRS):LENGTHS(0,1,2)\n'
    + 'FIELDTYPE:fips_county:LIKE(invalid_Num):SPACES( ):LENGTHS(3,0)\n'
    + 'FIELDTYPE:geo_lat:LIKE(invalid_Num):SPACES( .):LENGTHS(9,0)\n'
    + 'FIELDTYPE:geo_long:LIKE(invalid_Num):SPACES( -.):LENGTHS(10,11,0)\n'
    + 'FIELDTYPE:msa:LIKE(invalid_Num):SPACES( ):LENGTHS(4,0)\n'
    + 'FIELDTYPE:geo_blk:LIKE(invalid_Num):SPACES( ):LENGTHS(7,0)\n'
    + 'FIELDTYPE:geo_match:SPACES( ):ALLOW(0145):LENGTHS(1)\n'
    + 'FIELDTYPE:err_stat:SPACES( ):ALLOW(0123456789ABCDEFS):LENGTHS(4)\n'
    + 'FIELDTYPE:rawaid:LIKE(invalid_Num):SPACES( ):LENGTHS(1,13)\n'
    + '\n'
    + 'FIELD:name_score:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:filedate:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:dod:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:dob:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:masterid:LIKE(alphasandnums):TYPE(STRING):0,0\n'
    + 'FIELD:debtorfirstname:LIKE(invalid_name):TYPE(STRING):0,0\n'
    + 'FIELD:debtorlastname:LIKE(invalid_name):TYPE(STRING):0,0\n'
    + 'FIELD:debtoraddress1:LIKE(invalid_address):TYPE(STRING):0,0\n'
    + 'FIELD:debtoraddress2:LIKE(invalid_address):TYPE(STRING):0,0\n'
    + 'FIELD:debtoraddresscity:LIKE(invalid_city):TYPE(STRING):0,0\n'
    + 'FIELD:debtoraddressstate:LIKE(invalid_state):TYPE(STRING):0,0\n'
    + 'FIELD:debtoraddresszipcode:LIKE(invalid_zip):TYPE(STRING):0,0\n'
    + 'FIELD:dateofdeath:LIKE(invalid_date):TYPE(STRING):0,0\n'
    + 'FIELD:dateofbirth:LIKE(invalid_date):TYPE(STRING):0,0\n'
    + 'FIELD:isprobatelocated:TYPE(STRING):0,0\n'
    + 'FIELD:casenumber:LIKE(invalid_casenumber):TYPE(STRING):0,0\n'
    + 'FIELD:filingdate:LIKE(invalid_date):TYPE(STRING):0,0\n'
    + 'FIELD:lastdatetofileclaim:LIKE(invalid_date):TYPE(STRING):0,0\n'
    + 'FIELD:issubjecttocreditorsclaim:TYPE(STRING):0,0\n'
    + 'FIELD:publicationstartdate:LIKE(invalid_date):TYPE(STRING):0,0\n'
    + 'FIELD:isestateopen:TYPE(STRING):0,0\n'
    + 'FIELD:executorfirstname:LIKE(invalid_name):TYPE(STRING):0,0\n'
    + 'FIELD:executorlastname:LIKE(invalid_name):TYPE(STRING):0,0\n'
    + 'FIELD:executoraddress1:LIKE(invalid_address):TYPE(STRING):0,0\n'
    + 'FIELD:executoraddress2:LIKE(invalid_address):TYPE(STRING):0,0\n'
    + 'FIELD:executoraddresscity:LIKE(invalid_city):TYPE(STRING):0,0\n'
    + 'FIELD:executoraddressstate:LIKE(invalid_state):TYPE(STRING):0,0\n'
    + 'FIELD:executoraddresszipcode:LIKE(invalid_zip):TYPE(STRING):0,0\n'
    + 'FIELD:executorphone:LIKE(invalid_phone):TYPE(STRING):0,0\n'
    + 'FIELD:attorneyfirstname:LIKE(invalid_name):TYPE(STRING):0,0\n'
    + 'FIELD:attorneylastname:LIKE(invalid_name):TYPE(STRING):0,0\n'
    + 'FIELD:firm:TYPE(STRING):0,0\n'
    + 'FIELD:attorneyaddress1:LIKE(invalid_address):TYPE(STRING):0,0\n'
    + 'FIELD:attorneyaddress2:LIKE(invalid_address):TYPE(STRING):0,0\n'
    + 'FIELD:attorneyaddresscity:LIKE(invalid_city):TYPE(STRING):0,0\n'
    + 'FIELD:attorneyaddressstate:LIKE(invalid_state):TYPE(STRING):0,0\n'
    + 'FIELD:attorneyaddresszipcode:LIKE(invalid_zip):TYPE(STRING):0,0\n'
    + 'FIELD:attorneyphone:LIKE(invalid_phone):TYPE(STRING):0,0\n'
    + 'FIELD:attorneyemail:TYPE(STRING):0,0\n'
    + 'FIELD:documenttypes:TYPE(STRING):0,0\n'
    + 'FIELD:corr_dateofdeath:TYPE(STRING):0,0\n'
    + 'FIELD:pdid:TYPE(STRING20):0,0\n'
    + 'FIELD:pfrd_address_ind:TYPE(STRING20):0,0\n'
    + 'FIELD:nid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:cln_title:TYPE(STRING25):0,0\n'
    + 'FIELD:cln_fname:LIKE(invalid_name):TYPE(STRING30):0,00,0\n'
    + 'FIELD:cln_mname:LIKE(invalid_name):TYPE(STRING30):0,00,0\n'
    + 'FIELD:cln_lname:LIKE(invalid_name):TYPE(STRING30):0,00,0\n'
    + 'FIELD:cln_suffix:LIKE(invalid_name):TYPE(STRING5):0,0\n'
    + 'FIELD:cln_title2:TYPE(STRING25):0,0\n'
    + 'FIELD:cln_fname2:LIKE(invalid_name):TYPE(STRING30):0,00,0\n'
    + 'FIELD:cln_mname2:LIKE(invalid_name):TYPE(STRING30):0,00,0\n'
    + 'FIELD:cln_lname2:LIKE(invalid_name):TYPE(STRING30):0,00,0\n'
    + 'FIELD:cln_suffix2:LIKE(invalid_name):TYPE(STRING5):0,0\n'
    + 'FIELD:persistent_record_id:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:cname:LIKE(invalid_company):TYPE(STRING100):0,0\n'
    + 'FIELD:cleanaid:TYPE(Unsigned8):0,0\n'
    + 'FIELD:addresstype:TYPE(STRING5):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:LIKE(predir):TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:LIKE(prim_name):TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:LIKE(addr_suffix):TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:LIKE(postdir):TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:LIKE(unit_desig):TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:LIKE(sec_range):TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:LIKE(p_city_name):TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:LIKE(v_city_name):TYPE(STRING25):0,0\n'
    + 'FIELD:st:LIKE(st):TYPE(STRING2):0,0\n'
    + 'FIELD:zip:LIKE(zip):TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:LIKE(zip4):TYPE(STRING4):0,0\n'
    + 'FIELD:cart:LIKE(cart):TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:LIKE(cr_sort_sz):TYPE(STRING1):0,0\n'
    + 'FIELD:lot:LIKE(lot):TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:LIKE(lot_order):TYPE(STRING1):0,0\n'
    + 'FIELD:dbpc:LIKE(dbpc):TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:LIKE(chk_digit):TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:LIKE(rec_type):TYPE(STRING2):0,0\n'
    + 'FIELD:fips_county:LIKE(fips_county):TYPE(STRING2):0,0\n'
    + 'FIELD:geo_lat:LIKE(geo_lat):TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:LIKE(geo_long):TYPE(STRING11):0,0\n'
    + 'FIELD:msa:LIKE(msa):TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:LIKE(geo_blk):TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:LIKE(geo_match):TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:LIKE(err_stat):TYPE(STRING4):0,0\n'
    + 'FIELD:rawaid:LIKE(rawaid):TYPE(UNSIGNED8):0,0'
    ;

  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;
