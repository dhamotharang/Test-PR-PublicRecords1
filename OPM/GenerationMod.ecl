// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.7';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'OPM';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := 'seleid'; // cluster id (input)
  EXPORT spc_IDFIELD := 'seleid'; // cluster id (output)
  EXPORT spc_RIDFIELD := 'record_sid'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'source';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Base';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:record_sid';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_seleid */,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,process_date,dotid,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,proxweight,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight,record_type,global_sid,employee_name,duty_station,country,state,city,county,agency,agency_sub_element,computation_date,occupational_series,File_Date,occu_series_desc,state_code,title,fname,mname,lname,name_score,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,fips_state,fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,raw_aid,ace_aid,prep_address_line1,prep_address_line_last';
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
    + 'MODULE:OPM\n'
    + 'FILENAME:Base\n'
    + 'IDFIELD:EXISTS:seleid\n'
    + '\n'
    + 'RIDFIELD:record_sid:GENERATE\n'
    + 'SOURCEFIELD:source\n'
    + 'SOURCERIDFIELD: \n'
    + 'INGESTFILE:OPM_inputfile:NAMED(OPM.in_file)\n'
    + '\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED4):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED4):RECORDDATE(LAST):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):RECORDDATE(LAST):0,0\n'
    + '\n'
    + 'FIELD:process_date:DERIVED:0:0\n'
    + 'FIELD:dotid:DERIVED:0,0\n'
    + 'FIELD:dotscore:DERIVED:0,0\n'
    + 'FIELD:dotweight:DERIVED:0,0\n'
    + 'FIELD:empid:DERIVED:0,0\n'
    + 'FIELD:empscore:DERIVED:0,0\n'
    + 'FIELD:empweight:DERIVED:0,0\n'
    + 'FIELD:powid:DERIVED:0,0\n'
    + 'FIELD:powscore:DERIVED:0,0\n'
    + 'FIELD:powweight:DERIVED:0,0\n'
    + 'FIELD:proxid:DERIVED:0,0\n'
    + 'FIELD:proxscore:DERIVED:0,0\n'
    + 'FIELD:proxweight:DERIVED:0,0\n'
    + 'FIELD:selescore:DERIVED:0,0\n'
    + 'FIELD:seleweight:DERIVED:0,0\n'
    + 'FIELD:orgid:DERIVED:0,0\n'
    + 'FIELD:orgscore:DERIVED:0,0\n'
    + 'FIELD:orgweight:DERIVED:0,0\n'
    + 'FIELD:ultid:DERIVED:0,0\n'
    + 'FIELD:ultscore:DERIVED:0,0\n'
    + 'FIELD:ultweight:DERIVED:0,0\n'
    + 'FIELD:record_type:DERIVED:0,0\n'
    + 'FIELD:global_sid:DERIVED:0,0\n'
    + '\n'
    + 'FIELD:employee_name:0,0\n'
    + 'FIELD:duty_station:0,0\n'
    + 'FIELD:country:0,0\n'
    + 'FIELD:state:0,0\n'
    + 'FIELD:city:0,0\n'
    + 'FIELD:county:0,0\n'
    + 'FIELD:agency:0,0\n'
    + 'FIELD:agency_sub_element:0,0\n'
    + 'FIELD:computation_date:0,0\n'
    + 'FIELD:occupational_series:0,0\n'
    + 'FIELD:File_Date:0,0\n'
    + '\n'
    + 'FIELD:occu_series_desc:DERIVED:0,0\n'
    + 'FIELD:state_code:DERIVED:0,0\n'
    + '\n'
    + 'FIELD:title:DERIVED:0,0\n'
    + 'FIELD:fname:DERIVED:0,0\n'
    + 'FIELD:mname:DERIVED:0,0\n'
    + 'FIELD:lname:DERIVED:0,0\n'
    + 'FIELD:name_score:DERIVED:0,0\n'
    + 'FIELD:prim_range:DERIVED:0,0\n'
    + 'FIELD:predir:DERIVED:0,0\n'
    + 'FIELD:prim_name:DERIVED:0,0\n'
    + 'FIELD:addr_suffix:DERIVED:0,0\n'
    + 'FIELD:postdir:DERIVED:0,0\n'
    + 'FIELD:unit_desig:DERIVED:0,0\n'
    + 'FIELD:sec_range:DERIVED:0,0\n'
    + 'FIELD:p_city_name:DERIVED:0,0\n'
    + 'FIELD:v_city_name:DERIVED:0,0\n'
    + 'FIELD:st:DERIVED:0,0\n'
    + 'FIELD:cart:DERIVED:0,0\n'
    + 'FIELD:cr_sort_sz:DERIVED:0,0\n'
    + 'FIELD:lot:DERIVED:0,0\n'
    + 'FIELD:lot_order:DERIVED:0,0\n'
    + 'FIELD:dbpc:DERIVED:0,0\n'
    + 'FIELD:chk_digit:DERIVED:0,0\n'
    + 'FIELD:rec_type:DERIVED:0,0\n'
    + 'FIELD:fips_state:DERIVED:0,0\n'
    + 'FIELD:fips_county:DERIVED:0,0\n'
    + 'FIELD:geo_lat:DERIVED:0,0\n'
    + 'FIELD:geo_long:DERIVED:0,0\n'
    + 'FIELD:msa:DERIVED:0,0\n'
    + 'FIELD:geo_blk:DERIVED:0,0\n'
    + 'FIELD:geo_match:DERIVED:0,0\n'
    + 'FIELD:err_stat:DERIVED:0,0\n'
    + 'FIELD:raw_aid:DERIVED:0,0\n'
    + 'FIELD:ace_aid:DERIVED:0,0\n'
    + 'FIELD:prep_address_line1:DERIVED:0,0\n'
    + 'FIELD:prep_address_line_last:DERIVED:0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

