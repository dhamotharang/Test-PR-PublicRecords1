// Machine-readable versions of the spec file and subsets thereof
EXPORT incident_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_SANCTNKeys';
  EXPORT spc_NAMESCOPE := 'incident';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_SANCTNKeys\n'
    + 'FILENAME:SANCTNKeys\n'
    + 'NAMESCOPE:incident\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Batch:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_):LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Date:ALLOW(0123456789/)\n'
    + 'FIELDTYPE:Invalid_CleanDate:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + '\n'
    + 'FIELD:batch_number:LIKE(Invalid_Batch):TYPE(STRING8):0,0\n'
    + 'FIELD:incident_number:LIKE(Invalid_Num):TYPE(STRING8):0,0\n'
    + 'FIELD:party_number:LIKE(Invalid_Num):TYPE(STRING8):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):0,0\n'
    + 'FIELD:order_number:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:ag_code:TYPE(STRING8):0,0\n'
    + 'FIELD:case_number:TYPE(STRING20):0,0\n'
    + 'FIELD:incident_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:jurisdiction:TYPE(STRING90):0,0\n'
    + 'FIELD:source_document:TYPE(STRING70):0,0\n'
    + 'FIELD:additional_info:TYPE(STRING70):0,0\n'
    + 'FIELD:agency:TYPE(STRING70):0,0\n'
    + 'FIELD:alleged_amount:TYPE(STRING10):0,0\n'
    + 'FIELD:estimated_loss:TYPE(STRING10):0,0\n'
    + 'FIELD:fcr_date:LIKE(Invalid_Date):TYPE(STRING10):0,0\n'
    + 'FIELD:ok_for_fcr:TYPE(STRING1):0,0\n'
    + 'FIELD:modified_date:LIKE(Invalid_Date):TYPE(STRING10):0,0\n'
    + 'FIELD:load_date:LIKE(Invalid_Date):TYPE(STRING10):0,0\n'
    + 'FIELD:incident_text:TYPE(STRING255):0,0\n'
    + 'FIELD:incident_date_clean:LIKE(Invalid_CleanDate):TYPE(STRING8):0,0\n'
    + 'FIELD:fcr_date_clean:LIKE(Invalid_CleanDate):TYPE(STRING8):0,0\n'
    + 'FIELD:cln_modified_date:LIKE(Invalid_CleanDate):TYPE(STRING8):0,0\n'
    + 'FIELD:cln_load_date:LIKE(Invalid_CleanDate):TYPE(STRING8):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
