import dx_death_master, data_services;

/*
  A set of macros to get deceased information.
  Note: If skip_GLB_check=true, caller must apply GLB on result dataset
*/
EXPORT Get := MODULE

  EXPORT byDid(ds_in, did_field, death_params, skip_GLB_check = FALSE, recs_per_did = 1, _data_env = Data_Services.data_env.iNonFCRA) 
    := FUNCTIONMACRO
  
    IMPORT deathv2_services, doxie, suppress;
    LOCAL key_death := doxie.key_death_masterV2_ssa_DID;
    LOCAL layout_out_rec := RECORD
      ds_in.did_field;
      dx_death_master.layout_death death;
    END;

    LOCAL layout_out_rec appendDeceased(RECORDOF(ds_in) L, RECORDOF(key_death) R) := TRANSFORM
      SELF.did_field := L.did_field;
      SELF.death.is_deceased := R.l_did > 0;
      SELF.death := R;
    END;

    LOCAL local_glb_ok := skip_GLB_check OR death_params.isValidGlb();  
    LOCAL din_with_death := 
      join(ds_in, key_death, keyed(left.did_field=right.l_did)
        and	not deathv2_services.functions.Restricted(right.src, right.glb_flag, local_glb_ok, death_params),
      appendDeceased(left, right), 
      INNER, LIMIT(0), KEEP(recs_per_did));
    
    LOCAL din_with_death_suppressed := suppress.MAC_SuppressSource(din_with_death, death_params, did_field, death.global_sid); 
    
    LOCAL out_recs := PROJECT(din_with_death_suppressed, 
      TRANSFORM(layout_out_rec,
        // TODO: uncomment line below to enable ccpa suppression once dx_death changes are in place.
        // SELF.death := IF(~LEFT.is_suppressed, LEFT.death);
        SELF := LEFT));
    
    RETURN out_recs;
  ENDMACRO;

END;
