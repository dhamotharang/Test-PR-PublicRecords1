// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Advo';
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
  EXPORT spc_FILENAME := 'Scrubs';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,ZIP_5,Route_Num,ZIP_4,WALK_Sequence,STREET_NUM,STREET_PRE_DIRectional,STREET_NAME,STREET_POST_DIRectional,STREET_SUFFIX,Secondary_Unit_Designator,Secondary_Unit_Number,Address_Vacancy_Indicator,Throw_Back_Indicator,Seasonal_Delivery_Indicator,Seasonal_Start_Suppression_Date,Seasonal_End_Suppression_Date,DND_Indicator,College_Indicator,College_Start_Suppression_Date,College_End_Suppression_Date,Address_Style_Flag,Simplify_Address_Count,Drop_Indicator,Residential_or_Business_Ind,DPBC_Digit,DPBC_Check_Digit,Update_Date,File_Release_Date,Override_file_release_date,County_Num,County_Name,City_Name,State_Code,State_Num,Congressional_District_Number,OWGM_Indicator,Record_Type_Code,ADVO_Key,Address_Type,Mixed_Address_Usage,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,VAC_BEGDT,VAC_ENDDT,MONTHS_VAC_CURR,MONTHS_VAC_MAX,VAC_COUNT,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,fips_county,county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,RawAID,cleanaid,addresstype,Active_flag';
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
    + 'SALT:Scrubs_SPC;\n'
    + 'MODULE:Advo\n'
    + 'FILENAME:Scrubs\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + '\n'
    + 'FIELDTYPE:invalid_street:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /-.)\n'
    + 'FIELDTYPE:invalid_prepostdir:ALLOW(NEWS):LENGTHS(0,1,2)\n'
    + 'FIELDTYPE:invalid_num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:invalid_AddrUsg:ALLOW(ABCDEFGHSTUV):LENGTHS(0,1)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(0,4,5)\n'
    + 'FIELDTYPE:invalid_route_num:ALLOW(0123456789BHGRC):LENGTHS(0,4)\n'
    + 'FIELDTYPE:invalid_SupDate:ALLOW(0123456789/):LENGTHS(0,5)\n'
    + 'FIELDTYPE:invalid_Dates:ALLOW(0123456789-):LENGTHS(0,10)\n'
    + 'FIELDTYPE:invalid_Vacdate:ALLOW(0123456789):LENGTHS(0,1,2,8)\n'
    + 'FIELDTYPE:invalid_cda:ALLOW(0123456789LA):Lengths(0,1,2)\n'
    + 'FIELDTYPE:invalid_ResBusInd:ALLOW(ABCD):LENGTHS(0,1)\n'
    + 'FIELDTYPE:invalid_addr_type:ALLOW(0129):LENGTHS(0,1)\n'
    + 'FIELDTYPE:invalid_addrtype:ALLOW(A):LENGTHS(0,1)\n'
    + 'FIELDTYPE:invalid_YN:ALLOW(YN):LENGTHS(0,1)\n'
    + 'FIELDTYPE:invalid_YNE:ALLOW(YNE):LENGTHS(0,1)\n'
    + 'FIELDTYPE:invalid_AddrStyleFlag:ALLOW(CS):LENGTHS(0,1)\n'
    + 'FIELDTYPE:invalid_YNC:ALLOW(YNC):LENGTHS(0,1)\n'
    + 'FIELDTYPE:invalid_RTC:ALLOW(SHPR):LENGTHS(0,1)\n'
    + '\n'
    + 'FIELD:ZIP_5:LIKE(invalid_zip):TYPE(string5):0,0\n'
    + 'FIELD:Route_Num:LIKE(invalid_route_num):TYPE(string4):0,0\n'
    + 'FIELD:ZIP_4:LIKE(invalid_zip):TYPE(string4):0,0\n'
    + 'FIELD:WALK_Sequence:LIKE(invalid_num):TYPE(string9):0,0\n'
    + 'FIELD:STREET_NUM:LIKE(invalid_street):TYPE(string10):0,0\n'
    + 'FIELD:STREET_PRE_DIRectional:LIKE(invalid_prepostdir):TYPE(string2):0,0\n'
    + 'FIELD:STREET_NAME:LIKE(invalid_street):TYPE(string28):0,0\n'
    + 'FIELD:STREET_POST_DIRectional:LIKE(invalid_prepostdir):TYPE(string2):0,0\n'
    + 'FIELD:STREET_SUFFIX:LIKE(invalid_alpha):TYPE(string4):0,0\n'
    + 'FIELD:Secondary_Unit_Designator:LIKE(invalid_alpha):TYPE(string4):0,0\n'
    + 'FIELD:Secondary_Unit_Number:LIKE(invalid_street):TYPE(string8):0,0\n'
    + 'FIELD:Address_Vacancy_Indicator:LIKE(invalid_YN):TYPE(string1):0,0\n'
    + 'FIELD:Throw_Back_Indicator:LIKE(invalid_YN):TYPE(string1):0,0\n'
    + 'FIELD:Seasonal_Delivery_Indicator:LIKE(invalid_YNE):TYPE(string1):0,0\n'
    + 'FIELD:Seasonal_Start_Suppression_Date:LIKE(invalid_SupDate):TYPE(string5):0,0\n'
    + 'FIELD:Seasonal_End_Suppression_Date:LIKE(invalid_SupDate):TYPE(string5):0,0\n'
    + 'FIELD:DND_Indicator:LIKE(invalid_YN):TYPE(string1):0,0\n'
    + 'FIELD:College_Indicator:LIKE(invalid_YN):TYPE(string1):0,0\n'
    + 'FIELD:College_Start_Suppression_Date:LIKE(invalid_Dates):TYPE(string10):0,0\n'
    + 'FIELD:College_End_Suppression_Date:LIKE(invalid_Dates):TYPE(string10):0,0\n'
    + 'FIELD:Address_Style_Flag:LIKE(invalid_AddrStyleFlag):TYPE(string1):0,0\n'
    + 'FIELD:Simplify_Address_Count:LIKE(invalid_num):TYPE(string5):0,0\n'
    + 'FIELD:Drop_Indicator:LIKE(invalid_YNC):TYPE(string1):0,0\n'
    + 'FIELD:Residential_or_Business_Ind:LIKE(invalid_ResBusInd):TYPE(string1):0,0\n'
    + 'FIELD:DPBC_Digit:LIKE(invalid_num):TYPE(string2):0,0\n'
    + 'FIELD:DPBC_Check_Digit:LIKE(invalid_num):TYPE(string1):0,0\n'
    + 'FIELD:Update_Date:LIKE(invalid_Dates):TYPE(string10):0,0\n'
    + 'FIELD:File_Release_Date:LIKE(invalid_Dates):TYPE(string10):0,0\n'
    + 'FIELD:Override_file_release_date:LIKE(invalid_Dates):TYPE(string10):0,0\n'
    + 'FIELD:County_Num:LIKE(invalid_num):TYPE(string3):0,0\n'
    + 'FIELD:County_Name:LIKE(invalid_street):TYPE(string28):0,0\n'
    + 'FIELD:City_Name:LIKE(invalid_street):TYPE(string28):0,0\n'
    + 'FIELD:State_Code:LIKE(invalid_alpha):TYPE(string2):0,0\n'
    + 'FIELD:State_Num:LIKE(invalid_num):TYPE(string2):0,0\n'
    + 'FIELD:Congressional_District_Number:LIKE(invalid_cda):TYPE(string2):0,0\n'
    + 'FIELD:OWGM_Indicator:LIKE(invalid_YN):TYPE(string1):0,0\n'
    + 'FIELD:Record_Type_Code:LIKE(invalid_RTC):TYPE(string1):0,0\n'
    + 'FIELD:ADVO_Key:LIKE(invalid_num):TYPE(string10):0,0\n'
    + 'FIELD:Address_Type:LIKE(invalid_addr_type):TYPE(string1):0,0\n'
    + 'FIELD:Mixed_Address_Usage:LIKE(invalid_AddrUsg):TYPE(string1):0,0\n'
    + 'FIELD:date_first_seen:LIKE(invalid_Vacdate):TYPE(string8):0,0\n'
    + 'FIELD:date_last_seen:LIKE(invalid_Vacdate):TYPE(string8):0,0\n'
    + 'FIELD:date_vendor_first_reported:LIKE(invalid_Vacdate):TYPE(string8):0,0\n'
    + 'FIELD:date_vendor_last_reported:LIKE(invalid_Vacdate):TYPE(string8):0,0\n'
    + 'FIELD:VAC_BEGDT:LIKE(invalid_Vacdate):TYPE(string8):0,0\n'
    + 'FIELD:VAC_ENDDT:LIKE(invalid_Vacdate):TYPE(string8):0,0\n'
    + 'FIELD:MONTHS_VAC_CURR:LIKE(invalid_Vacdate):TYPE(string8):0,0\n'
    + 'FIELD:MONTHS_VAC_MAX:LIKE(invalid_Vacdate):TYPE(string8):0,0\n'
    + 'FIELD:VAC_COUNT:LIKE(invalid_Vacdate):TYPE(string8):0,0\n'
    + 'FIELD:prim_range:TYPE(string10):0,0\n'
    + 'FIELD:predir:TYPE(string2):0,0\n'
    + 'FIELD:prim_name:TYPE(string28):0,0\n'
    + 'FIELD:addr_suffix:TYPE(string4):0,0\n'
    + 'FIELD:postdir:TYPE(string2):0,0\n'
    + 'FIELD:unit_desig:TYPE(string10):0,0\n'
    + 'FIELD:sec_range:TYPE(string8):0,0\n'
    + 'FIELD:p_city_name:TYPE(string25):0,0\n'
    + 'FIELD:v_city_name:TYPE(string25):0,0\n'
    + 'FIELD:st:TYPE(string2):0,0\n'
    + 'FIELD:zip:TYPE(string5):0,0\n'
    + 'FIELD:zip4:TYPE(string4):0,0\n'
    + 'FIELD:cart:TYPE(string4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(string1):0,0\n'
    + 'FIELD:lot:TYPE(string4):0,0\n'
    + 'FIELD:lot_order:TYPE(string1):0,0\n'
    + 'FIELD:dbpc:TYPE(string2):0,0\n'
    + 'FIELD:chk_digit:TYPE(string1):0,0\n'
    + 'FIELD:rec_type:TYPE(string2):0,0\n'
    + 'FIELD:fips_county:TYPE(string2):0,0\n'
    + 'FIELD:county:TYPE(string3):0,0\n'
    + 'FIELD:geo_lat:TYPE(string10):0,0\n'
    + 'FIELD:geo_long:TYPE(string11):0,0\n'
    + 'FIELD:msa:TYPE(string4):0,0\n'
    + 'FIELD:geo_blk:TYPE(string7):0,0\n'
    + 'FIELD:geo_match:TYPE(string1):0,0\n'
    + 'FIELD:err_stat:TYPE(string4):0,0\n'
    + 'FIELD:RawAID:TYPE(Unsigned8):0,0\n'
    + 'FIELD:cleanaid:TYPE(Unsigned8):0,0\n'
    + 'FIELD:addresstype:LIKE(invalid_addrtype):TYPE(string1):0,0\n'
    + 'FIELD:Active_flag:LIKE(invalid_YN):TYPE(string1):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

