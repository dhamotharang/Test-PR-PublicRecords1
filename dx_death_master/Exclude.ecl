import data_services;

/*
  ** A macro to exclude records from deceased subjects from input dataset.
  **
  ** @param ds_in                   Input dataset; REQUIRED. 
  ** @param did_field               The LexID field as defined by the input dataset layout; REQUIRED.
  ** @param death_params            Death master input mod as defined in DeathV2_Services.IParam.DeathRestrictions;
  **                                REQUIRED.
  ** @param use_distributed         For use when running THOR jobs; OPTINAL, defaults to FALSE.
  ** @param data_env                Data environment, either FCRA or non-FCRA; 
  **                                OPTIONAL, defaults to non-FCRA;
  ** @returns                       A dataset with no deceased subjects.
  **
*/
EXPORT Exclude(ds_in, did_field, death_params, use_distributed = FALSE, _data_env = Data_Services.data_env.iNonFCRA) 
  := FUNCTIONMACRO
  
  LOCAL layout_out_rec := RECORDOF(ds_in);

  LOCAL recs_death_appended := dx_death_master.mac_fetch_bydid(ds_in, did_field, death_params, dx_death_master.Constants.DataRestrictions.enforceAll,
    /*recs_per_did*/ 1, /*left_outer*/ TRUE, use_distributed, _data_env);
  LOCAL out_recs := PROJECT(recs_death_appended(~death.is_deceased), // drop all deceased records
    TRANSFORM(layout_out_rec, SELF := LEFT));
  RETURN out_recs;

ENDMACRO;
