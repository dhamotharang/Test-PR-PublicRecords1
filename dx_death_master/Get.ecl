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

  EXPORT byDeathId(ds_in, death_id_field, death_params, recs_per_id = 1, _data_env = Data_Services.data_env.iNonFCRA) 
    := FUNCTIONMACRO
  
    IMPORT deathv2_services, doxie, suppress, death_master;

    LOCAL key_death := death_master.Key_Death_id_base_ssa;
    LOCAL layout_out_rec := RECORD
      RECORDOF(ds_in);
      dx_death_master.layout_death death;
    END;

    LOCAL layout_out_rec getDeceased(RECORDOF(ds_in) L, RECORDOF(key_death) R) := TRANSFORM
      SELF.death.is_deceased := R.death_id_field <> '';
      // We don't have an l_did field in the state death id key. 
      // Below I'm assigning a value to l_did just to try and keep dx death layout consistent,
      // but we should never had both l_did and did fields in the did key to begin with ...
      SELF.death.l_did := (UNSIGNED6) R.did;  
      SELF.death := R;
      SELF := L;
    END;

    LOCAL local_glb_ok := death_params.isValidGlb();  
    LOCAL out_recs := 
      join(ds_in, key_death, 
        keyed(left.death_id_field=right.state_death_id)
        and	not deathv2_services.functions.Restricted(right.src, right.glb_flag, local_glb_ok, death_params),
      getDeceased(left, right), 
      KEEP(recs_per_id), LIMIT(0));

    // TODO: uncomment below to enable ccpa suppression.    
    // RETURN suppress.MAC_SuppressSource(out_recs, death_params, death.did, death.global_sid, data_env := _data_env); 
    RETURN out_recs;

  ENDMACRO;

END;
