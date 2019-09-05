import dx_death_master, data_services;

/*
  A set of macros to get deceased information.
  Note: If skip_GLB_check=true, caller must apply GLB on result dataset
*/
EXPORT Get := MODULE

  EXPORT byDid(ds_in, did_field, death_params, skip_GLB_check = FALSE, recs_per_did = 1, _data_env = Data_Services.data_env.iNonFCRA) 
    := FUNCTIONMACRO
  
    LOCAL recs_death_appended := dx_death_master.mac_fetch_bydid(ds_in, did_field, death_params, 
      skip_GLB_check, recs_per_did, /*left_outer*/FALSE, _data_env);

    LOCAL layout_out_rec := RECORD
      ds_in.did_field;
      dx_death_master.layout_death death;
    END;
    LOCAL out_recs := PROJECT(recs_death_appended, TRANSFORM(layout_out_rec, SELF := LEFT));

    RETURN out_recs;

  ENDMACRO;

END;
