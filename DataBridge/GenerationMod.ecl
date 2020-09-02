// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'DataBridge';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_seleid */,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,process_date,dotid,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,proxweight,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight,record_type,global_sid,clean_company_name,clean_telephone_num,mail_score_desc,name_gender_desc,title_desc_1,title_desc_2,title_desc_3,title_desc_4,sic8_desc_1,sic8_desc_2,sic8_desc_3,sic8_desc_4,sic6_desc_1,sic6_desc_2,sic6_desc_3,sic6_desc_4,sic6_desc_5,name,company,address,address2,city,state,scf,zip_code5,zip_code4,mail_score,area_code,telephone_number,name_gender,name_prefix,name_first,name_middle_initial,name_last,suffix,title_code_1,title_code_2,title_code_3,title_code_4,web_address,sic8_1,sic8_2,sic8_3,sic8_4,sic6_1,sic6_2,sic6_3,sic6_4,sic6_5,email,email_present_flag,site_source1,site_source2,site_source3,site_source4,site_source5,site_source6,site_source7,site_source8,site_source9,site_source10,individual_source1,individual_source2,individual_source3,individual_source4,individual_source5,individual_source6,individual_source7,individual_source8,individual_source9,individual_source10,email_status,title,fname,mname,lname,name_score,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,fips_state,fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,raw_aid,ace_aid,prep_address_line1,prep_address_line_last';
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
    + 'MODULE:DataBridge\n'
    + 'FILENAME:Base\n'
    + 'IDFIELD:EXISTS:seleid\n'
    + 'RIDFIELD:record_sid:GENERATE\n'
    + 'SOURCEFIELD:source\n'
    + 'SOURCERIDFIELD: \n'
    + 'INGESTFILE:DataBridge_inputfile:NAMED(DataBridge.In_File)\n'
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
    + 'FIELD:clean_company_name:DERIVED:0,0\n'
    + 'FIELD:clean_telephone_num:DERIVED:0,0\n'
    + 'FIELD:mail_score_desc:DERIVED:0,0\n'
    + 'FIELD:name_gender_desc:DERIVED:0,0\n'
    + 'FIELD:title_desc_1:DERIVED:0,0\n'
    + 'FIELD:title_desc_2:DERIVED:0,0\n'
    + 'FIELD:title_desc_3:DERIVED:0,0\n'
    + 'FIELD:title_desc_4:DERIVED:0,0\n'
    + 'FIELD:sic8_desc_1:DERIVED:0,0\n'
    + 'FIELD:sic8_desc_2:DERIVED:0,0\n'
    + 'FIELD:sic8_desc_3:DERIVED:0,0\n'
    + 'FIELD:sic8_desc_4:DERIVED:0,0\n'
    + 'FIELD:sic6_desc_1:DERIVED:0,0\n'
    + 'FIELD:sic6_desc_2:DERIVED:0,0\n'
    + 'FIELD:sic6_desc_3:DERIVED:0,0\n'
    + 'FIELD:sic6_desc_4:DERIVED:0,0\n'
    + 'FIELD:sic6_desc_5:DERIVED:0,0\n'
    + 'FIELD:name:0,0\n'
    + 'FIELD:company:0,0\n'
    + 'FIELD:address:0,0\n'
    + 'FIELD:address2:0,0\n'
    + 'FIELD:city:0,0\n'
    + 'FIELD:state:0,0\n'
    + 'FIELD:scf:0,0\n'
    + 'FIELD:zip_code5:0,0\n'
    + 'FIELD:zip_code4:0,0\n'
    + 'FIELD:mail_score:0,0\n'
    + 'FIELD:area_code:0,0\n'
    + 'FIELD:telephone_number:0,0\n'
    + 'FIELD:name_gender:0,0\n'
    + 'FIELD:name_prefix:0,0\n'
    + 'FIELD:name_first:0,0\n'
    + 'FIELD:name_middle_initial:0,0\n'
    + 'FIELD:name_last:0,0\n'
    + 'FIELD:suffix:0,0\n'
    + 'FIELD:title_code_1:0,0\n'
    + 'FIELD:title_code_2:0,0\n'
    + 'FIELD:title_code_3:0,0\n'
    + 'FIELD:title_code_4:0,0\n'
    + 'FIELD:web_address:0,0\n'
    + 'FIELD:sic8_1:0,0\n'
    + 'FIELD:sic8_2:0,0\n'
    + 'FIELD:sic8_3:0,0\n'
    + 'FIELD:sic8_4:0,0\n'
    + 'FIELD:sic6_1:0,0\n'
    + 'FIELD:sic6_2:0,0\n'
    + 'FIELD:sic6_3:0,0\n'
    + 'FIELD:sic6_4:0,0\n'
    + 'FIELD:sic6_5:0,0\n'
    + 'FIELD:email:0,0\n'
    + 'FIELD:email_present_flag:0,0\n'
    + 'FIELD:site_source1:0,0\n'
    + 'FIELD:site_source2:0,0\n'
    + 'FIELD:site_source3:0,0\n'
    + 'FIELD:site_source4:0,0\n'
    + 'FIELD:site_source5:0,0\n'
    + 'FIELD:site_source6:0,0\n'
    + 'FIELD:site_source7:0,0\n'
    + 'FIELD:site_source8:0,0\n'
    + 'FIELD:site_source9:0,0\n'
    + 'FIELD:site_source10:0,0\n'
    + 'FIELD:individual_source1:0,0\n'
    + 'FIELD:individual_source2:0,0\n'
    + 'FIELD:individual_source3:0,0\n'
    + 'FIELD:individual_source4:0,0\n'
    + 'FIELD:individual_source5:0,0\n'
    + 'FIELD:individual_source6:0,0\n'
    + 'FIELD:individual_source7:0,0\n'
    + 'FIELD:individual_source8:0,0\n'
    + 'FIELD:individual_source9:0,0\n'
    + 'FIELD:individual_source10:0,0\n'
    + 'FIELD:email_status:0,0\n'
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
    + 'FIELD:zip:DERIVED:0,0\n'
    + 'FIELD:zip4:DERIVED:0,0\n'
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

