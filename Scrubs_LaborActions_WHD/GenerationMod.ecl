// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_LaborActions_WHD';
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
  EXPORT spc_FILENAME := 'LaborActions_WHD';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dartid,dateadded,dateupdated,website,state,caseid,employername,address1,city,employerstate,zipcode,naicscode,totalviolations,bw_totalagreedamount,cmp_totalassessments,ee_totalviolations,ee_totalagreedcount,ca_countviolations,ca_bw_agreedamount,ca_ee_agreedcount,ccpa_countviolations,ccpa_bw_agreedamount,ccpa_ee_agreedcount,crew_countviolations,crew_bw_agreedamount,crew_cmp_assessedamount,crew_ee_agreedcount,cwhssa_countviolations,cwhssa_bw_agreedamount,cwhssa_ee_agreedcount,dbra_cl_countviolations,dbra_bw_agreedamount,dbra_ee_agreedcount,eev_countviolations,eppa_countviolations,eppa_bw_agreedamount,eppa_cmp_assessedamount,eppa_ee_agreedcount,flsa_countviolations,flsa_bw_15a3_agreedamount,flsa_bw_agreedamount,flsa_bw_minwage_agreedamount,flsa_bw_overtime_agreedamount,flsa_cmp_assessedamount,flsa_ee_agreedcount,flsa_cl_countviolations,flsa_cl_countminorsemployed,flsa_cl_cmp_assessedamount,flsa_hmwkr_countviolations,flsa_hmwkr_bw_agreedamount,flsa_hmwkr_cmp_assessedamount,flsa_hmwkr_ee_agreedcount,flsa_smw14_bw_agreedamount,flsa_smw14_countviolations,flsa_smw14_ee_agreedcount,flsa_smwap_countviolations,flsa_smwap_bw_agreedamount,flsa_smwap_ee_agreedcount,flsa_smwft_countviolations,flsa_smwft_bw_agreedamount,flsa_smwft_ee_agreedcount,flsa_smwl_countviolations,flsa_smwl_bw_agreedamount,flsa_smwl_ee_agreedcount,flsa_smwmg_countviolations,flsa_smwmg_bw_agreedamount,flsa_smwmg_ee_agreedcount,flsa_smwpw_countviolations,flsa_smwpw_bw_agreedamount,flsa_smwpw_ee_agreedcount,flsa_smwsl_countviolations,flsa_smwsl_bw_agreedamount,flsa_smwsl_ee_agreedcount,fmla_countviolations,fmla_bw_agreedamount,fmla_cmp_assessedamount,fmla_ee_agreedcount,h1a_countviolations,h1a_bw_agreedamount,h1a_cmp_assessedamount,h1a_ee_agreedcount,h1b_countviolations,h1b_bw_agreedamount,h1b_cmp_assessedamount,h1b_ee_agreedcount,h2a_countviolations,h2a_bw_agreedamount,h2a_cmp_assessedamount,h2a_ee_agreedcount,h2b_countviolations,h2b_bw_agreedamount,h2b_ee_agreedcount,mpsa_countviolations,mpsa_bw_agreedamount,mpsa_cmp_assessedamount,mpsa_ee_agreedcount,osha_countviolations,osha_bw_agreedamount,osha_cmp_assessedamount,osha_ee_agreedcount,pca_countviolations,pca_bw_agreedamount,pca_ee_agreedcount,sca_countviolations,sca_bw_agreedamount,sca_ee_agreedcount,sraw_countviolations,sraw_bw_agreedamount,sraw_ee_agreedcount';
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
    + 'MODULE:Scrubs_LaborActions_WHD\n'
    + 'FILENAME:LaborActions_WHD\n'
    + '\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'Num\')\n'
    + 'FIELDTYPE:Invalid_Float:ALLOW(0123456789 .)\n'
    + 'FIELDTYPE:Invalid_Alpha:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'Alpha\')\n'
    + 'FIELDTYPE:Invalid_AlphaChar:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaChar\')\n'
    + 'FIELDTYPE:Invalid_AlphaNumChar:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaNumChar\')\n'
    + 'FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0,2)\n'
    + 'FIELDTYPE:Invalid_Zip:CUSTOM(Scrubs.Fn_Valid_Zip > 0)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.Fn_Valid_Date > 0)\n'
    + '\n'
    + '\n'
    + 'FIELD:dartid:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:dateadded:TYPE(UNSIGNED8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dateupdated:TYPE(UNSIGNED8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:website:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:state:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:caseid:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:employername:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:address1:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:city:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:employerstate:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:zipcode:TYPE(STRING):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:naicscode:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:totalviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:bw_totalagreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:cmp_totalassessments:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:ee_totalviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:ee_totalagreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:ca_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:ca_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:ca_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:ccpa_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:ccpa_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:ccpa_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:crew_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:crew_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:crew_cmp_assessedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:crew_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:cwhssa_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:cwhssa_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:cwhssa_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:dbra_cl_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:dbra_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:dbra_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:eev_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:eppa_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:eppa_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:eppa_cmp_assessedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:eppa_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_bw_15a3_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_bw_minwage_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_bw_overtime_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_cmp_assessedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_cl_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_cl_countminorsemployed:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_cl_cmp_assessedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_hmwkr_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_hmwkr_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_hmwkr_cmp_assessedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_hmwkr_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smw14_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_smw14_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smw14_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smwap_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smwap_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_smwap_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smwft_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smwft_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_smwft_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smwl_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smwl_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_smwl_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smwmg_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smwmg_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_smwmg_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smwpw_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smwpw_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_smwpw_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smwsl_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:flsa_smwsl_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:flsa_smwsl_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:fmla_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:fmla_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:fmla_cmp_assessedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:fmla_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:h1a_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:h1a_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:h1a_cmp_assessedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:h1a_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:h1b_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:h1b_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:h1b_cmp_assessedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:h1b_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:h2a_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:h2a_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:h2a_cmp_assessedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:h2a_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:h2b_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:h2b_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:h2b_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:mpsa_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:mpsa_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:mpsa_cmp_assessedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:mpsa_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:osha_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:osha_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:osha_cmp_assessedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:osha_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:pca_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:pca_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:pca_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:sca_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:sca_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:sca_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:sraw_countviolations:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:sraw_bw_agreedamount:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:sraw_ee_agreedcount:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

