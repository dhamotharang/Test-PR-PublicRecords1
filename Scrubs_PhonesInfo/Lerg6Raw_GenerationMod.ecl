// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Lerg6Raw_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Phonesinfo';
  EXPORT spc_NAMESCOPE := 'Lerg6Raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Phonesinfo';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,lata,lata_name,status,eff_date,npa,nxx,block_id,filler1,coc_type,ssc,dind,td_eo,td_at,portable,aocn,filler2,ocn,loc_name,loc,loc_state,rc_abbre,rc_ty,line_fr,line_to,switch,sha_indicator,filler3,test_line_num,test_line_response,test_line_exp_date,blk_1000_pool,rc_lata,filler4,creation_date,filler5,e_status_date,filler6,last_modified_date,filler7,filename';
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
    + 'MODULE:Scrubs_Phonesinfo\n'
    + 'FILENAME:Phonesinfo\n'
    + 'NAMESCOPE:Lerg6Raw\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ- ) \n'
    + 'FIELDTYPE:Invalid_BlockID:ALLOW(0123456789A) \n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\' )\n'
    + 'FIELDTYPE:Invalid_CocTypeCode:ENUM(700|AIN|ATC|BLG|BRD|CDA|CTV|ENP|EOC|FGB|HVL|INP|N11|ONA|PLN|PMC|RCC|RTG|SIC|SP1|SP2|TST|UFA|VOI)\n'
    + 'FIELDTYPE:Invalid_Filename:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_Nxx:ALLOW(0123456789+)\n'
    + 'FIELDTYPE:Invalid_RcTyCode:ENUM(Z|S|+| ) \n'
    + 'FIELDTYPE:Invalid_StatusCode:ENUM(E|M|D| ) \n'
    + 'FIELDTYPE:Invalid_SccTypeCode:ALLOW(ABCIJMNORSTVWXZ8)\n'
    + 'FIELDTYPE:Invalid_TBlockInd:ENUM(I|N|S|Y)  \n'
    + 'FIELDTYPE:Invalid_TdCode:ALLOW(0123456789NA)\n'
    + 'FIELDTYPE:Invalid_TestRespCode:ENUM(A|M| )\n'
    + 'FIELDTYPE:Invalid_YesNo:ENUM(Y|N)\n'
    + '\n'
    + 'FIELD:lata:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:lata_name:LIKE(Invalid_Alpha):TYPE(STRING):0,0\n'
    + 'FIELD:status:LIKE(Invalid_StatusCode):TYPE(STRING):0,0\n'
    + 'FIELD:eff_date:TYPE(STRING):0,0\n'
    + 'FIELD:npa:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:nxx:LIKE(Invalid_Nxx):TYPE(STRING):0,0\n'
    + 'FIELD:block_id:LIKE(Invalid_BlockID):TYPE(STRING):0,0\n'
    + 'FIELD:filler1:TYPE(STRING):0,0\n'
    + 'FIELD:coc_type:LIKE(Invalid_CocTypeCode):TYPE(STRING):0,0\n'
    + 'FIELD:ssc:LIKE(Invalid_SccTypeCode):TYPE(STRING):0,0\n'
    + 'FIELD:dind:LIKE(Invalid_YesNo):TYPE(STRING):0,0\n'
    + 'FIELD:td_eo:LIKE(Invalid_TdCode):TYPE(STRING):0,0\n'
    + 'FIELD:td_at:LIKE(Invalid_TdCode):TYPE(STRING):0,0\n'
    + 'FIELD:portable:LIKE(Invalid_YesNo):TYPE(STRING):0,0\n'
    + 'FIELD:aocn:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:filler2:TYPE(STRING):0,0\n'
    + 'FIELD:ocn:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:loc_name:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:loc:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:loc_state:LIKE(Invalid_Alpha):TYPE(STRING):0,0\n'
    + 'FIELD:rc_abbre:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:rc_ty:LIKE(Invalid_RcTyCode):TYPE(STRING):0,0\n'
    + 'FIELD:line_fr:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:line_to:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:switch:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:sha_indicator:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:filler3:TYPE(STRING):0,0\n'
    + 'FIELD:test_line_num:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:test_line_response:LIKE(Invalid_TestRespCode):TYPE(STRING):0,0\n'
    + 'FIELD:test_line_exp_date:TYPE(STRING):0,0\n'
    + 'FIELD:blk_1000_pool:LIKE(Invalid_TBlockInd):TYPE(STRING):0,0\n'
    + 'FIELD:rc_lata:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:filler4:TYPE(STRING):0,0\n'
    + 'FIELD:creation_date:TYPE(STRING):0,0\n'
    + 'FIELD:filler5:TYPE(STRING):0,0\n'
    + 'FIELD:e_status_date:TYPE(STRING):0,0\n'
    + 'FIELD:filler6:TYPE(STRING):0,0\n'
    + 'FIELD:last_modified_date:TYPE(STRING):0,0\n'
    + 'FIELD:filler7:TYPE(STRING):0,0\n'
    + 'FIELD:filename:LIKE(Invalid_Filename):TYPE(STRING255):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

