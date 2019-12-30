// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_CFPB';
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
  EXPORT spc_FILENAME := 'CFPB';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,record_sid,global_src_id,dt_vendor_first_reported,dt_vendor_last_reported,is_latest,seqno,geoid10_blkgrp,state_fips10,county_fips10,tract_fips10,blkgrp_fips10,total_pop,hispanic_total,non_hispanic_total,nh_white_alone,nh_black_alone,nh_aian_alone,nh_api_alone,nh_other_alone,nh_mult_total,nh_white_other,nh_black_other,nh_aian_other,nh_asian_hpi,nh_api_other,nh_asian_hpi_other';
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
    + 'MODULE:Scrubs_CFPB\n'
    + 'FILENAME:CFPB\n'
    + '\n'
    + 'FIELDTYPE:invalid_no:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_id:LEFTTRIM:LENGTHS(1..5)\n'
    + 'FIELDTYPE:invalid_date:LIKE(invalid_no):LEFTTRIM:LENGTHS(8)\n'
    + 'FIELDTYPE:invalid_seqno:LEFTTRIM:LENGTHS(1..4)\n'
    + 'FIELDTYPE:invalid_geoid10_blkgrp:LIKE(invalid_no):LEFTTRIM:LENGTHS(12)\n'
    + 'FIELDTYPE:invalid_state_fips10:LIKE(invalid_no):LEFTTRIM:LENGTHS(2..)\n'
    + 'FIELDTYPE:invalid_county_fips10:LIKE(invalid_no):LEFTTRIM:LENGTHS(3..)\n'
    + 'FIELDTYPE:invalid_tract_fips10:LIKE(invalid_no):LEFTTRIM:LENGTHS(1..3)\n'
    + 'FIELDTYPE:invalid_blkgrp_fips10:LEFTTRIM:LENGTHS(1..3)\n'
    + '\n'
    + '\n'
    + 'FIELD:record_sid:LIKE(invalid_id):TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:global_src_id:LIKE(invalid_id):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:dt_vendor_first_reported:LIKE(invalid_date):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dt_vendor_last_reported:LIKE(invalid_date):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:is_latest:TYPE(BOOLEAN):0,0\n'
    + 'FIELD:seqno:LIKE(invalid_seqno):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:geoid10_blkgrp:LIKE(invalid_geoid10_blkgrp):TYPE(STRING12):0,0\n'
    + 'FIELD:state_fips10:LIKE(invalid_state_fips10):TYPE(STRING3):0,0\n'
    + 'FIELD:county_fips10:LIKE(invalid_county_fips10):TYPE(STRING6):0,0\n'
    + 'FIELD:tract_fips10:LIKE(invalid_tract_fips10):TYPE(STRING1):0,0\n'
    + 'FIELD:blkgrp_fips10:LIKE(invalid_blkgrp_fips10):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:total_pop:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:hispanic_total:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:non_hispanic_total:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:nh_white_alone:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:nh_black_alone:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:nh_aian_alone:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:nh_api_alone:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:nh_other_alone:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:nh_mult_total:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:nh_white_other:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:nh_black_other:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:nh_aian_other:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:nh_asian_hpi:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:nh_api_other:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:nh_asian_hpi_other:TYPE(UNSIGNED2):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

