// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_AVM';
  EXPORT spc_NAMESCOPE := 'Base';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'AVM';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,history_date,ln_fares_id_ta,ln_fares_id_pi,unformatted_apn,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,p_city_name,st,zip,zip4,lat,long,geo_blk,fips_code,land_use,recording_date,assessed_value_year,sales_price,assessed_total_value,market_total_value,tax_assessment_valuation,price_index_valuation,hedonic_valuation,automated_valuation,confidence_score,comp1,comp2,comp3,comp4,comp5,nearby1,nearby2,nearby3,nearby4,nearby5,history_history_date,history_land_use,history_recording_date,history_assessed_value_year,history_sales_price,history_assessed_total_value,history_market_total_value,history_tax_assessment_valuation,history_price_index_valuation,history_hedonic_valuation,history_automated_valuation,history_confidence_score';
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
    + 'MODULE:Scrubs_AVM\n'
    + 'FILENAME:AVM\n'
    + 'NAMESCOPE:Base\n'
    + '\n'
    + '//FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Date:ALLOW(0123456789):LENGTHS(..8)\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Comps:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + '\n'
    + 'FIELD:history_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:ln_fares_id_ta:LIKE(Invalid_Comps):TYPE(STRING12):0,0\n'
    + 'FIELD:ln_fares_id_pi:LIKE(Invalid_Comps):TYPE(STRING12):0,0\n'
    + 'FIELD:unformatted_apn:LIKE(Invalid_Comps):TYPE(STRING45):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:st:LIKE(Invalid_Alpha):TYPE(STRING2):0,0\n'
    + 'FIELD:zip:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:lat:TYPE(STRING10):0,0\n'
    + 'FIELD:long:TYPE(STRING11):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:fips_code:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + 'FIELD:land_use:TYPE(STRING1):0,0\n'
    + 'FIELD:recording_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:assessed_value_year:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:sales_price:LIKE(Invalid_Num):TYPE(STRING11):0,0\n'
    + 'FIELD:assessed_total_value:LIKE(Invalid_Num):TYPE(STRING11):0,0\n'
    + 'FIELD:market_total_value:LIKE(Invalid_Num):TYPE(STRING11):0,0\n'
    + 'FIELD:tax_assessment_valuation:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    + 'FIELD:price_index_valuation:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    + 'FIELD:hedonic_valuation:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    + 'FIELD:automated_valuation:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    + 'FIELD:confidence_score:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    + 'FIELD:comp1:LIKE(Invalid_Comps):TYPE(STRING12):0,0\n'
    + 'FIELD:comp2:LIKE(Invalid_Comps):TYPE(STRING12):0,0\n'
    + 'FIELD:comp3:LIKE(Invalid_Comps):TYPE(STRING12):0,0\n'
    + 'FIELD:comp4:LIKE(Invalid_Comps):TYPE(STRING12):0,0\n'
    + 'FIELD:comp5:LIKE(Invalid_Comps):TYPE(STRING12):0,0\n'
    + 'FIELD:nearby1:LIKE(Invalid_Comps):TYPE(STRING12):0,0\n'
    + 'FIELD:nearby2:LIKE(Invalid_Comps):TYPE(STRING12):0,0\n'
    + 'FIELD:nearby3:LIKE(Invalid_Comps):TYPE(STRING12):0,0\n'
    + 'FIELD:nearby4:LIKE(Invalid_Comps):TYPE(STRING12):0,0\n'
    + 'FIELD:nearby5:LIKE(Invalid_Comps):TYPE(STRING12):0,0\n'
    + 'FIELD:history_history_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:history_land_use:TYPE(STRING1):0,0\n'
    + 'FIELD:history_recording_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:history_assessed_value_year:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:history_sales_price:LIKE(Invalid_Num):TYPE(STRING11):0,0\n'
    + 'FIELD:history_assessed_total_value:LIKE(Invalid_Num):TYPE(STRING11):0,0\n'
    + 'FIELD:history_market_total_value:LIKE(Invalid_Num):TYPE(STRING11):0,0\n'
    + 'FIELD:history_tax_assessment_valuation:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    + 'FIELD:history_price_index_valuation:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    + 'FIELD:history_hedonic_valuation:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    + 'FIELD:history_automated_valuation:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    + 'FIELD:history_confidence_score:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

