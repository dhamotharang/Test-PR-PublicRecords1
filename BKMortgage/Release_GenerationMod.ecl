// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Release_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'BKMortgage';
  EXPORT spc_NAMESCOPE := 'Release';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := 'record_id'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'BKMortgage';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:record_id';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,process_date,source,ln_filedate,bk_infile_type,rectype,documenttype,fipscode,mainaddendum,releaserecdate,releaseeffecdate,mortgagepayoffdate,releasedoc,releasebk,releasepg,multiplepageimage,bkfsimageid,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,loannumber,currentlenderben,mers,mersvalidation,mspsvrloan,currentlenderpool,borrowername,borrmailfulladdress,borrmailunit,borrmailcity,borrmailstate,borrmailzip,borrmailzip4,apn,multiapncode,taxacctid,propertyfulladd,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,dataentrydate,dataentryopercode,vendorsourcecode,hids_recordingflag,hids_docnumber,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle,pid,matchedororphan,deed_pid,sam_pid,assessorparcelnumber_matched,assessorpropertyfulladd,assessorpropertyunittype,assessorpropertyunit,assessorpropertycity,assessorpropertystate,assessorpropertyzip,assessorpropertyzip4,assessorpropertyaddrsource,clnlenderben,clncurrentlenderben,DBALenderBen,DBACurrentLenderBen,raw_file_name';
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
    'OPTIONS:-gn\n'
    + 'MODULE:BKMortgage\n'
    + 'FILENAME:BKMortgage\n'
    + 'NAMESCOPE:Release\n'
    + '\n'
    + 'RIDFIELD:record_id:GENERATE\n'
    + 'INGESTFILE:release_update:NAMED(BKMortgage.Release_prep_ingest_file)\n'
    + '\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:date_vendor_first_reported:TYPE(STRING8):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:date_vendor_last_reported:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:source:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:ln_filedate:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:bk_infile_type:DERIVED:TYPE(STRING30):0,0\n'
    + 'FIELD:rectype:TYPE(STRING1):0,0\n'
    + 'FIELD:documenttype:TYPE(STRING2):0,0\n'
    + 'FIELD:fipscode:TYPE(STRING5):0,0\n'
    + 'FIELD:mainaddendum:TYPE(STRING1):0,0\n'
    + 'FIELD:releaserecdate:TYPE(STRING8):0,0\n'
    + 'FIELD:releaseeffecdate:TYPE(STRING8):0,0\n'
    + 'FIELD:mortgagepayoffdate:TYPE(STRING8):0,0\n'
    + 'FIELD:releasedoc:TYPE(STRING20):0,0\n'
    + 'FIELD:releasebk:TYPE(STRING10):0,0\n'
    + 'FIELD:releasepg:TYPE(STRING10):0,0\n'
    + 'FIELD:multiplepageimage:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:bkfsimageid:DERIVED:TYPE(STRING50):0,0\n'
    + 'FIELD:origdotrecdate:TYPE(STRING8):0,0\n'
    + 'FIELD:origdotcontractdate:TYPE(STRING8):0,0\n'
    + 'FIELD:origdotdoc:TYPE(STRING20):0,0\n'
    + 'FIELD:origdotbk:TYPE(STRING10):0,0\n'
    + 'FIELD:origdotpg:TYPE(STRING10):0,0\n'
    + 'FIELD:origlenderben:TYPE(STRING):0,0\n'
    + 'FIELD:origloanamnt:TYPE(STRING10):0,0\n'
    + 'FIELD:loannumber:TYPE(STRING30):0,0\n'
    + 'FIELD:currentlenderben:TYPE(STRING):0,0\n'
    + 'FIELD:mers:TYPE(STRING18):0,0\n'
    + 'FIELD:mersvalidation:TYPE(STRING1):0,0\n'
    + 'FIELD:mspsvrloan:DERIVED:TYPE(STRING22):0,0 //Not being used\n'
    + 'FIELD:currentlenderpool:TYPE(STRING25):0,0\n'
    + 'FIELD:borrowername:TYPE(STRING):0,0\n'
    + 'FIELD:borrmailfulladdress:TYPE(STRING70):0,0\n'
    + 'FIELD:borrmailunit:TYPE(STRING6):0,0\n'
    + 'FIELD:borrmailcity:TYPE(STRING30):0,0\n'
    + 'FIELD:borrmailstate:TYPE(STRING2):0,0\n'
    + 'FIELD:borrmailzip:TYPE(STRING5):0,0\n'
    + 'FIELD:borrmailzip4:TYPE(STRING4):0,0\n'
    + 'FIELD:apn:TYPE(STRING45):0,0\n'
    + 'FIELD:multiapncode:TYPE(STRING1):0,0\n'
    + 'FIELD:taxacctid:TYPE(STRING45):0,0\n'
    + 'FIELD:propertyfulladd:TYPE(STRING70):0,0\n'
    + 'FIELD:propertyunit:TYPE(STRING16):0,0\n'
    + 'FIELD:propertycity:TYPE(STRING30):0,0\n'
    + 'FIELD:propertystate:TYPE(STRING2):0,0\n'
    + 'FIELD:propertyzip:TYPE(STRING5):0,0\n'
    + 'FIELD:propertyzip4:TYPE(STRING4):0,0\n'
    + 'FIELD:dataentrydate:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:dataentryopercode:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:vendorsourcecode:TYPE(STRING3):0,0\n'
    + 'FIELD:hids_recordingflag:TYPE(STRING1):0,0\n'
    + 'FIELD:hids_docnumber:TYPE(STRING9):0,0\n'
    + 'FIELD:transfercertificateoftitle:TYPE(STRING8):0,0\n'
    + 'FIELD:hi_condo_cpr_hpr:TYPE(STRING4):0,0\n'
    + 'FIELD:hi_situs_unit_number:TYPE(STRING10):0,0\n'
    + 'FIELD:hids_previous_docnumber:TYPE(STRING9):0,0\n'
    + 'FIELD:prevtransfercertificateoftitle:TYPE(STRING8):0,0\n'
    + 'FIELD:pid:DERIVED:TYPE(STRING9):0,0\n'
    + 'FIELD:matchedororphan:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:deed_pid:DERIVED:TYPE(STRING9):0,0\n'
    + 'FIELD:sam_pid:DERIVED:TYPE(STRING9):0,0\n'
    + 'FIELD:assessorparcelnumber_matched:DERIVED:TYPE(STRING37):0,0\n'
    + 'FIELD:assessorpropertyfulladd:DERIVED:TYPE(STRING60):0,0\n'
    + 'FIELD:assessorpropertyunittype:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:assessorpropertyunit:DERIVED:TYPE(STRING6):0,0\n'
    + 'FIELD:assessorpropertycity:DERIVED:TYPE(STRING30):0,0\n'
    + 'FIELD:assessorpropertystate:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:assessorpropertyzip:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:assessorpropertyzip4:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:assessorpropertyaddrsource:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:clnlenderben:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:clncurrentlenderben:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:DBALenderBen:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:DBACurrentLenderBen:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:raw_file_name:DERIVED:TYPE(STRING100):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

