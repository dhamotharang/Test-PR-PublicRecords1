import dx_death_master, data_services;

/*
  A set of macros to append deceased information to a dataset.
  Note: If skip_GLB_check=true, caller must apply GLB on result dataset
*/
EXPORT Append := MODULE

  EXPORT byDid(ds_in, did_field, death_params, skip_GLB_check = FALSE, recs_per_did = 1, _data_env = Data_Services.data_env.iNonFCRA) 
    := FUNCTIONMACRO
  
    LOCAL out_recs := dx_death_master.mac_fetch_bydid(ds_in, did_field, death_params, 
      skip_GLB_check, recs_per_did, /*left_outer*/TRUE, _data_env);

    RETURN out_recs;

  ENDMACRO;

END;
