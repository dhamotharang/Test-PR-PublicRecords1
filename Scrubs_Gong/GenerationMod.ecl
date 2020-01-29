// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Gong';
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
  EXPORT spc_FILENAME := 'File_Neustar';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,ACTION_CODE,RECORD_ID,RECORD_TYPE,TELEPHONE,LISTING_TYPE,BUSINESS_NAME,BUSINESS_CAPTIONS,CATEGORY,INDENT,LAST_NAME,SUFFIX_NAME,FIRST_NAME,MIDDLE_NAME,PRIMARY_STREET_NUMBER,PRE_DIR,PRIMARY_STREET_NAME,PRIMARY_STREET_SUFFIX,POST_DIR,SECONDARY_ADDRESS_TYPE,SECONDARY_RANGE,CITY,STATE,ZIP_CODE,ZIP_PLUS4,LATITUDE,LONGITUDE,LAT_LONG_MATCH_LEVEL,UNLICENSED,ADD_DATE,OMIT_ADDRESS,DATA_SOURCE,unknownField,TransactionID,Original_Suffix,Original_First_Name,Original_Middle_Name,Original_Last_Name,Original_Address,Original_Last_Line,filename';
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
    + 'MODULE:Scrubs_Gong\n'
    + 'FILENAME:File_Neustar\n'
    + '\n'
    + 'FIELDTYPE:alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( <>{}[]-^=?!+&,./#\\(\\)@\'`"_:;$*)\n'
    + 'FIELDTYPE:phone:ALLOW(0123456789):LENGTHS(0,10)\n'
    + 'FIELDTYPE:zip:ALLOW(0123456789):LENGTHS(0,5)\n'
    + 'FIELDTYPE:zip4:ALLOW(0123456789):LENGTHS(0,4)\n'
    + 'FIELDTYPE:date:ALLOW(0123456789 ):LENGTHS(0,8)\n'
    + 'FIELDTYPE:date_alt:ALLOW(0123456789):SPACES( ):LENGTHS(0,1,6,8)\n'
    + 'FIELDTYPE:Invalid_Date:Custom(Scrubs.fn_valid_date>0, \'F\')\n'
    + 'FIELDTYPE:RecordTypes:ALLOW(BGPRLCSFZ)\n'
    + 'FIELDTYPE:PublishCodes:ALLOW(LUP)\n'
    + 'FIELDTYPE:ActionCodes:ALLOW(ADI)\n'
    + 'FIELDTYPE:YesNo:ALLOW(YN )\n'
    + 'FIELDTYPE:StateAbrv:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0,2)\n'
    + 'FIELDTYPE:Numeric:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Directional:ENUM(N|S|E|W|NW|Nw|SW|Sw|NE|Ne|SE|Se| )\n'
    + 'FIELDTYPE:primname:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 \'/.#&?;-)\n'
    + '\n'
    + 'FIELD:ACTION_CODE:LIKE(ActionCodes):0,0\n'
    + 'FIELD:RECORD_ID:0,0\n'
    + 'FIELD:RECORD_TYPE:LIKE(RecordTypes):0,0\n'
    + 'FIELD:TELEPHONE:LIKE(phone):0,0\n'
    + 'FIELD:LISTING_TYPE:LIKE(PublishCodes):0,0\n'
    + 'FIELD:BUSINESS_NAME:0,0\n'
    + 'FIELD:BUSINESS_CAPTIONS:0,0\n'
    + 'FIELD:CATEGORY:0,0\n'
    + 'FIELD:INDENT:LIKE(Numeric):0,0\n'
    + 'FIELD:LAST_NAME:0,0\n'
    + 'FIELD:SUFFIX_NAME:0,0\n'
    + 'FIELD:FIRST_NAME:0,0\n'
    + 'FIELD:MIDDLE_NAME:0,0\n'
    + 'FIELD:PRIMARY_STREET_NUMBER:0,0\n'
    + 'FIELD:PRE_DIR:LIKE(Directional):0,0\n'
    + 'FIELD:PRIMARY_STREET_NAME:LIKE(primname):0,0\n'
    + 'FIELD:PRIMARY_STREET_SUFFIX:0,0\n'
    + 'FIELD:POST_DIR:LIKE(Directional):0,0\n'
    + 'FIELD:SECONDARY_ADDRESS_TYPE:0,0\n'
    + 'FIELD:SECONDARY_RANGE:0,0\n'
    + 'FIELD:CITY:0,0\n'
    + 'FIELD:STATE:LIKE(StateAbrv):0,0\n'
    + 'FIELD:ZIP_CODE:LIKE(zip):0,0\n'
    + 'FIELD:ZIP_PLUS4:LIKE(zip4):0,0\n'
    + 'FIELD:LATITUDE:0,0\n'
    + 'FIELD:LONGITUDE:0,0\n'
    + 'FIELD:LAT_LONG_MATCH_LEVEL:0,0\n'
    + 'FIELD:UNLICENSED:0,0\n'
    + 'FIELD:ADD_DATE:LIKE(Invalid_Date):0:0\n'
    + 'FIELD:OMIT_ADDRESS:LIKE(YesNo):0,0\n'
    + 'FIELD:DATA_SOURCE:0,0\t\t\t\n'
    + 'FIELD:unknownField:0,0\n'
    + 'FIELD:TransactionID:0,0\t\t\t\n'
    + 'FIELD:Original_Suffix:0,0\n'
    + 'FIELD:Original_First_Name:0,0\n'
    + 'FIELD:Original_Middle_Name:0,0\n'
    + 'FIELD:Original_Last_Name:0,0\n'
    + 'FIELD:Original_Address:0,0\n'
    + 'FIELD:Original_Last_Line:0,0\n'
    + 'FIELD:filename:0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

