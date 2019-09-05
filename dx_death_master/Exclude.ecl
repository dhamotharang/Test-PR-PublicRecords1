import data_services;

/*
  A macro to exclude records from deceased individuals from a dataset.
*/
EXPORT Exclude(ds_in, did_field, death_params, _data_env = Data_Services.data_env.iNonFCRA) 
  := FUNCTIONMACRO
  
  LOCAL layout_out_rec := RECORDOF(ds_in);
  LOCAL recs_death_appended := dx_death_master.Append.byDid(ds_in, did_field, death_params,,,_data_env);
  LOCAL out_recs := PROJECT(recs_death_appended, 
    TRANSFORM(layout_out_rec,
      SELF.did_field := IF(LEFT.death.is_deceased, SKIP, LEFT.did_field); // if deceased, drop it
      SELF := LEFT;));
  
  RETURN out_recs;

ENDMACRO;
