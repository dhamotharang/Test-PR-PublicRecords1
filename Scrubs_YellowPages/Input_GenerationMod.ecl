// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_YellowPages';
  EXPORT spc_NAMESCOPE := 'Input';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'YellowPages';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,primary_key,chainid,filler1,pub_date,busshortname,business_name,busdeptname,house,predir,street,streettype,postdir,apttype,aptnbr,boxnbr,exppubcity,orig_city,orig_state,orig_zip,dpc,carrierroute,fips,countycode,z4type,ctract,cblockgroup,cblockid,msa,cbsa,mcdcode,filler2,addrsensitivity,maildeliverabilitycode,sic1_4,sic_code,sic2,sic3,sic4,indstryclass,naics_code,mlsc,filler3,orig_phone10,nosolicitcode,dso,timezone,validationflag,validationdate,secvalidationcode,singleaddrflag,filler4,gender,execname,exectitlecode,exectitle,condtitlecode,condtitle,contfunctioncode,contfunction,profession,emplsizecode,annualsalescode,yrsinbus,ethniccode,filler5,latlongmatchlevel,orig_latitude,orig_longitude,filler6,heading_string,ypheading2,ypheading3,ypheading4,ypheading5,ypheading6,maxypadsize,filler7,faxac,faxexchge,faxphone,altac,altexchge,altphone,mobileac,mobileexchge,mobilephone,tollfreeac,tollfreeexchge,tollfreephone,creditcards,brands,stdhrs,hrsopen,web_address,filler8,email_address,services,condheading,tagline,filler9,totaladspend,filler10,crlf';
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
    + 'MODULE:Scrubs_YellowPages\n'
    + 'FILENAME:YellowPages\n'
    + 'NAMESCOPE:Input\n'
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
    + '\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_YellowPages.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_YellowPages.Functions.fn_populated_strings>0)\n'
    + 'FIELDTYPE:invalid_date:CUSTOM(Scrubs_YellowPages.Functions.fn_valid_date>0)\n'
    + '\n'
    + 'FIELDTYPE:invalid_orig_city:CUSTOM(Scrubs_YellowPages.Functions.fn_populated_strings>0,orig_state,orig_zip)\n'
    + 'FIELDTYPE:invalid_orig_state:CUSTOM(Scrubs_YellowPages.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_orig_zip:CUSTOM(Scrubs_YellowPages.Functions.fn_verify_zip59>0)\n'
    + 'FIELDTYPE:invalid_sic_code:CUSTOM(Scrubs_YellowPages.Functions.fn_valid_SicCode>0)\n'
    + 'FIELDTYPE:invalid_sic2:CUSTOM(Scrubs_YellowPages.Functions.fn_valid_SicCode>0)\n'
    + 'FIELDTYPE:invalid_sic3:CUSTOM(Scrubs_YellowPages.Functions.fn_valid_SicCode>0)\n'
    + 'FIELDTYPE:invalid_sic4:CUSTOM(Scrubs_YellowPages.Functions.fn_valid_SicCode>0)\n'
    + 'FIELDTYPE:invalid_naics_code:CUSTOM(Scrubs_YellowPages.Functions.fn_validate_NAICSCode>0)\n'
    + 'FIELDTYPE:invalid_orig_phone10:CUSTOM(Scrubs_YellowPages.Functions.fn_numeric>0,10)\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:primary_key:TYPE(STRING12):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:chainid:TYPE(STRING4):0,0\n'
    + 'FIELD:filler1:TYPE(STRING14):0,0\n'
    + 'FIELD:pub_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:busshortname:TYPE(STRING30):0,0\n'
    + 'FIELD:business_name:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:busdeptname:TYPE(STRING100):0,0\n'
    + 'FIELD:house:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):0,0\n'
    + 'FIELD:street:TYPE(STRING28):0,0\n'
    + 'FIELD:streettype:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:apttype:TYPE(STRING4):0,0\n'
    + 'FIELD:aptnbr:TYPE(STRING8):0,0\n'
    + 'FIELD:boxnbr:TYPE(STRING10):0,0\n'
    + 'FIELD:exppubcity:TYPE(STRING28):0,0\n'
    + 'FIELD:orig_city:TYPE(STRING28):LIKE(invalid_orig_city):0,0\n'
    + 'FIELD:orig_state:TYPE(STRING2):LIKE(invalid_orig_state):0,0\n'
    + 'FIELD:orig_zip:TYPE(STRING9):LIKE(invalid_orig_zip):0,0\n'
    + 'FIELD:dpc:TYPE(STRING3):0,0\n'
    + 'FIELD:carrierroute:TYPE(STRING4):0,0\n'
    + 'FIELD:fips:TYPE(STRING2):0,0\n'
    + 'FIELD:countycode:TYPE(STRING3):0,0\n'
    + 'FIELD:z4type:TYPE(STRING1):0,0\n'
    + 'FIELD:ctract:TYPE(STRING6):0,0\n'
    + 'FIELD:cblockgroup:TYPE(STRING1):0,0\n'
    + 'FIELD:cblockid:TYPE(STRING3):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:cbsa:TYPE(STRING5):0,0\n'
    + 'FIELD:mcdcode:TYPE(STRING5):0,0\n'
    + 'FIELD:filler2:TYPE(STRING8):0,0\n'
    + 'FIELD:addrsensitivity:TYPE(STRING1):0,0\n'
    + 'FIELD:maildeliverabilitycode:TYPE(STRING1):0,0\n'
    + 'FIELD:sic1_4:TYPE(STRING4):0,0\n'
    + 'FIELD:sic_code:TYPE(STRING8):LIKE(invalid_sic_code):0,0\n'
    + 'FIELD:sic2:TYPE(STRING8):LIKE(invalid_sic2):0,0\n'
    + 'FIELD:sic3:TYPE(STRING8):LIKE(invalid_sic3):0,0\n'
    + 'FIELD:sic4:TYPE(STRING8):LIKE(invalid_sic4):0,0\n'
    + 'FIELD:indstryclass:TYPE(STRING1):0,0\n'
    + 'FIELD:naics_code:TYPE(STRING6):LIKE(invalid_naics_code):0,0\n'
    + 'FIELD:mlsc:TYPE(STRING1):0,0\n'
    + 'FIELD:filler3:TYPE(STRING8):0,0\n'
    + 'FIELD:orig_phone10:TYPE(STRING10):LIKE(invalid_orig_phone10):0,0\n'
    + 'FIELD:nosolicitcode:TYPE(STRING1):0,0\n'
    + 'FIELD:dso:TYPE(STRING1):0,0\n'
    + 'FIELD:timezone:TYPE(STRING1):0,0\n'
    + 'FIELD:validationflag:TYPE(STRING1):0,0\n'
    + 'FIELD:validationdate:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:secvalidationcode:TYPE(STRING1):0,0\n'
    + 'FIELD:singleaddrflag:TYPE(STRING2):0,0\n'
    + 'FIELD:filler4:TYPE(STRING2):0,0\n'
    + 'FIELD:gender:TYPE(STRING2):0,0\n'
    + 'FIELD:execname:TYPE(STRING40):0,0\n'
    + 'FIELD:exectitlecode:TYPE(STRING4):0,0\n'
    + 'FIELD:exectitle:TYPE(STRING40):0,0\n'
    + 'FIELD:condtitlecode:TYPE(STRING4):0,0\n'
    + 'FIELD:condtitle:TYPE(STRING40):0,0\n'
    + 'FIELD:contfunctioncode:TYPE(STRING4):0,0\n'
    + 'FIELD:contfunction:TYPE(STRING40):0,0\n'
    + 'FIELD:profession:TYPE(STRING40):0,0\n'
    + 'FIELD:emplsizecode:TYPE(STRING1):0,0\n'
    + 'FIELD:annualsalescode:TYPE(STRING1):0,0\n'
    + 'FIELD:yrsinbus:TYPE(STRING1):0,0\n'
    + 'FIELD:ethniccode:TYPE(STRING8):0,0\n'
    + 'FIELD:filler5:TYPE(STRING6):0,0\n'
    + 'FIELD:latlongmatchlevel:TYPE(STRING1):0,0\n'
    + 'FIELD:orig_latitude:TYPE(STRING11):0,0\n'
    + 'FIELD:orig_longitude:TYPE(STRING11):0,0\n'
    + 'FIELD:filler6:TYPE(STRING17):0,0\n'
    + 'FIELD:heading_string:TYPE(STRING100):0,0\n'
    + 'FIELD:ypheading2:TYPE(STRING100):0,0\n'
    + 'FIELD:ypheading3:TYPE(STRING100):0,0\n'
    + 'FIELD:ypheading4:TYPE(STRING100):0,0\n'
    + 'FIELD:ypheading5:TYPE(STRING100):0,0\n'
    + 'FIELD:ypheading6:TYPE(STRING100):0,0\n'
    + 'FIELD:maxypadsize:TYPE(STRING1):0,0\n'
    + 'FIELD:filler7:TYPE(STRING4):0,0\n'
    + 'FIELD:faxac:TYPE(STRING3):0,0\n'
    + 'FIELD:faxexchge:TYPE(STRING3):0,0\n'
    + 'FIELD:faxphone:TYPE(STRING4):0,0\n'
    + 'FIELD:altac:TYPE(STRING3):0,0\n'
    + 'FIELD:altexchge:TYPE(STRING3):0,0\n'
    + 'FIELD:altphone:TYPE(STRING4):0,0\n'
    + 'FIELD:mobileac:TYPE(STRING3):0,0\n'
    + 'FIELD:mobileexchge:TYPE(STRING3):0,0\n'
    + 'FIELD:mobilephone:TYPE(STRING4):0,0\n'
    + 'FIELD:tollfreeac:TYPE(STRING3):0,0\n'
    + 'FIELD:tollfreeexchge:TYPE(STRING3):0,0\n'
    + 'FIELD:tollfreephone:TYPE(STRING4):0,0\n'
    + 'FIELD:creditcards:TYPE(STRING3):0,0\n'
    + 'FIELD:brands:TYPE(STRING200):0,0\n'
    + 'FIELD:stdhrs:TYPE(STRING88):0,0\n'
    + 'FIELD:hrsopen:TYPE(STRING100):0,0\n'
    + 'FIELD:web_address:TYPE(STRING60):0,0\n'
    + 'FIELD:filler8:TYPE(STRING60):0,0\n'
    + 'FIELD:email_address:TYPE(STRING30):0,0\n'
    + 'FIELD:services:TYPE(STRING200):0,0\n'
    + 'FIELD:condheading:TYPE(STRING100):0,0\n'
    + 'FIELD:tagline:TYPE(STRING100):0,0\n'
    + 'FIELD:filler9:TYPE(STRING244):0,0\n'
    + 'FIELD:totaladspend:TYPE(STRING10):0,0\n'
    + 'FIELD:filler10:TYPE(STRING160):0,0\n'
    + 'FIELD:crlf:TYPE(STRING2):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

