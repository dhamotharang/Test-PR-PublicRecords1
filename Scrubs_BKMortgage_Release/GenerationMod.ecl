// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_BKMortgage_Release';
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
  EXPORT spc_FILENAME := 'BKMortgage_Release';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,ln_filedate,bk_infile_type,rectype,documenttype,fipscode,mainaddendum,releaserecdate,releaseeffecdate,mortgagepayoffdate,releasedoc,releasebk,releasepg,multiplepageimage,bkfsimageid,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,loannumber,currentlenderben,mers,mersvalidation,mspsvrloan,currentlenderpool,borrowername,borrmailfulladdress,borrmailunit,borrmailcity,borrmailstate,borrmailzip,borrmailzip4,apn,multiapncode,taxacctid,propertyfulladd,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,dataentrydate,dataentryopercode,vendorsourcecode,hids_recordingflag,hids_docnumber,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle,pid,matchedororphan,deed_pid,sam_pid,assessorparcelnumber_matched,assessorpropertyfulladd,assessorpropertyunittype,assessorpropertyunit,assessorpropertycity,assessorpropertystate,assessorpropertyzip,assessorpropertyzip4,assessorpropertyaddrsource,raw_file_name';
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
    + 'MODULE:Scrubs_BKMortgage_Release\n'
    + 'FILENAME:BKMortgage_Release\n'
    + '\n'
    + 'FIELDTYPE:invalid_number:ALLOW(0123456789):\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\'):SPACES( <>{}[]-^=!+&,()#.;/)\n'
    + 'FIELDTYPE:invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\'):SPACES( -()#.,/%:&)\n'
    + 'FIELDTYPE:invalid_apn:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( -&,;.:()#*_/+)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(0123456789):SPACES( _-):LENGTHS(0,4,5)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(0,4,8,10)\n'
    + 'FIELDTYPE:invalid_mers:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( .-) \n'
    + 'FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):LENGTHS(0,2) \n'
    + 'FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\'):SPACES( _-&,.():\'`#+;"\\/*@[]{}%$!|)\n'
    + 'FIELDTYPE:Invalid_RecType:ENUM(P|Q|)\n'
    + 'FIELDTYPE:Invalid_DocType:ENUM(RM|FL|SB|ML|LM|AM|MS|PT|PN|CR|RR|OR|PP|SO|)\n'
    + '\n'
    + 'FIELD:ln_filedate:LIKE(invalid_date):0,0\n'
    + 'FIELD:bk_infile_type:TYPE(STRING30):0,0\n'
    + 'FIELD:rectype:LIKE(Invalid_RecType):0,0\n'
    + 'FIELD:documenttype:LIKE(Invalid_DocType):0,0\n'
    + 'FIELD:fipscode:LIKE(invalid_number):0,0\n'
    + 'FIELD:mainaddendum:TYPE(STRING1):0,0\n'
    + 'FIELD:releaserecdate:LIKE(invalid_date):0,0\n'
    + 'FIELD:releaseeffecdate:LIKE(invalid_date):0,0\n'
    + 'FIELD:mortgagepayoffdate:LIKE(invalid_date):0,0\n'
    + 'FIELD:releasedoc:TYPE(STRING20):0,0\n'
    + 'FIELD:releasebk:TYPE(STRING10):0,0\n'
    + 'FIELD:releasepg:TYPE(STRING10):0,0\n'
    + 'FIELD:multiplepageimage:TYPE(STRING1):0,0\n'
    + 'FIELD:bkfsimageid:TYPE(STRING50):0,0\n'
    + 'FIELD:origdotrecdate:LIKE(invalid_date):0,0\n'
    + 'FIELD:origdotcontractdate:LIKE(invalid_date):0,0\n'
    + 'FIELD:origdotdoc:TYPE(STRING20):0,0\n'
    + 'FIELD:origdotbk:TYPE(STRING10):0,0\n'
    + 'FIELD:origdotpg:TYPE(STRING10):0,0\n'
    + 'FIELD:origlenderben:LIKE(invalid_name):0,0\n'
    + 'FIELD:origloanamnt:TYPE(STRING10):0,0\n'
    + 'FIELD:loannumber:TYPE(STRING30):0,0\n'
    + 'FIELD:currentlenderben:LIKE(invalid_name):0,0\n'
    + 'FIELD:mers:LIKE(invalid_mers):0,0\n'
    + 'FIELD:mersvalidation:TYPE(STRING1):0,0\n'
    + 'FIELD:mspsvrloan:TYPE(STRING22):0,0\n'
    + 'FIELD:currentlenderpool:TYPE(STRING25):0,0\n'
    + 'FIELD:borrowername:LIKE(invalid_name):0,0\n'
    + 'FIELD:borrmailfulladdress:LIKE(invalid_AlphaNum):0,0\n'
    + 'FIELD:borrmailunit:TYPE(STRING6):0,0\n'
    + 'FIELD:borrmailcity:LIKE(invalid_AlphaNum):0,0\n'
    + 'FIELD:borrmailstate:LIKE(invalid_state):0,0\n'
    + 'FIELD:borrmailzip:LIKE(invalid_zip):0,0\n'
    + 'FIELD:borrmailzip4:LIKE(invalid_zip):0,0\n'
    + 'FIELD:apn:LIKE(invalid_apn):0,0\n'
    + 'FIELD:multiapncode:TYPE(STRING1):0,0\n'
    + 'FIELD:taxacctid:TYPE(STRING45):0,0\n'
    + 'FIELD:propertyfulladd:LIKE(invalid_AlphaNum):0,0\n'
    + 'FIELD:propertyunit:TYPE(STRING16):0,0\n'
    + 'FIELD:propertycity:LIKE(invalid_AlphaNum):0,0\n'
    + 'FIELD:propertystate:LIKE(invalid_state):0,0\n'
    + 'FIELD:propertyzip:LIKE(invalid_zip):0,0\n'
    + 'FIELD:propertyzip4:LIKE(invalid_zip):0,0\n'
    + 'FIELD:dataentrydate:TYPE(STRING8):0,0\n'
    + 'FIELD:dataentryopercode:TYPE(STRING4):0,0\n'
    + 'FIELD:vendorsourcecode:TYPE(STRING3):0,0\n'
    + 'FIELD:hids_recordingflag:TYPE(STRING1):0,0\n'
    + 'FIELD:hids_docnumber:TYPE(STRING9):0,0\n'
    + 'FIELD:transfercertificateoftitle:TYPE(STRING8):0,0\n'
    + 'FIELD:hi_condo_cpr_hpr:TYPE(STRING4):0,0\n'
    + 'FIELD:hi_situs_unit_number:TYPE(STRING10):0,0\n'
    + 'FIELD:hids_previous_docnumber:TYPE(STRING9):0,0\n'
    + 'FIELD:prevtransfercertificateoftitle:TYPE(STRING8):0,0\n'
    + 'FIELD:pid:TYPE(STRING9):0,0\n'
    + 'FIELD:matchedororphan:TYPE(STRING1):0,0\n'
    + 'FIELD:deed_pid:TYPE(STRING9):0,0\n'
    + 'FIELD:sam_pid:TYPE(STRING9):0,0\n'
    + 'FIELD:assessorparcelnumber_matched:TYPE(STRING37):0,0\n'
    + 'FIELD:assessorpropertyfulladd:LIKE(invalid_AlphaNum):0,0\n'
    + 'FIELD:assessorpropertyunittype:TYPE(STRING4):0,0\n'
    + 'FIELD:assessorpropertyunit:TYPE(STRING6):0,0\n'
    + 'FIELD:assessorpropertycity:LIKE(invalid_AlphaNum):0,0\n'
    + 'FIELD:assessorpropertystate:LIKE(invalid_state):0,0\n'
    + 'FIELD:assessorpropertyzip:LIKE(invalid_zip):0,0\n'
    + 'FIELD:assessorpropertyzip4:LIKE(invalid_zip):0,0\n'
    + 'FIELD:assessorpropertyaddrsource:TYPE(STRING1):0,0\n'
    + 'FIELD:raw_file_name:TYPE(STRING100):0,0\n'
    + '\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

