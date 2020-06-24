import dx_death_master, data_services;

/*
  ** A set of macros to "get" deceased information.
*/
EXPORT Get := MODULE


  /*
    ** Get deceased by LexID.
    **
    ** @param ds_in                   Input dataset; REQUIRED. 
    ** @param did_field               The LexID field as defined by the input dataset layout; REQUIRED.
    ** @param death_params            Death master input mod as defined in DeathV2_Services.IParam.DeathRestrictions;
    **                                REQUIRED.
    ** @param skip_GLB_check          Controls whether or not GLB restrictions are enforced whithin this function; 
    **                                OPTIONAL, defaults to FALSE, i.e. enforce GLB restrictions.
    **                                IMPORTANT: If skip_GLB_check=true, caller **MUST** apply GLB restrictions on result 
    **                                dataset prior to returning death information.
    ** @param recs_per_did            Number of matching records to be returned; 
    **                                OPTIONAL: defaults to 1.
    ** @param use_distributed         For use when running THOR jobs; OPTINAL, defaults to FALSE.
    ** @param data_env                Data environment, either FCRA or non-FCRA; 
    **                                OPTIONAL, defaults to non-FCRA;
    ** @returns                       A dataset with deceased information as defined in dx_death_master.layout_death.
    **
  */
  EXPORT byDid(ds_in, did_field, death_params, skip_GLB_check = FALSE, recs_per_did = 1, use_distributed = FALSE, _data_env = Data_Services.data_env.iNonFCRA) 
    := FUNCTIONMACRO

    LOCAL restrictions := IF(skip_GLB_check, dx_death_master.Constants.DataRestrictions.skipGLB, dx_death_master.Constants.DataRestrictions.enforceAll);
    LOCAL recs_death_appended := dx_death_master.mac_fetch_bydid(ds_in, did_field, death_params, 
      restrictions, recs_per_did, /*left_outer*/FALSE, use_distributed, _data_env);

    LOCAL layout_out_rec := RECORD
      ds_in.did_field;
      dx_death_master.layout_death death;
    END;
    LOCAL out_recs := PROJECT(recs_death_appended, TRANSFORM(layout_out_rec, SELF := LEFT));

    RETURN out_recs; 

  ENDMACRO;

  /*
    ** Get deceased by state death id.
    **
    ** @param ds_in                   Input dataset; REQUIRED. 
    ** @param death_id_field          The state death id field as defined by the input dataset layout; REQUIRED.
    ** @param death_params            Death master input mod as defined in DeathV2_Services.IParam.DeathRestrictions;
    **                                REQUIRED.
    ** @param recs_per_did            Number of matching records to be returned; 
    **                                OPTIONAL: defaults to 1.
    ** @param data_env                Data environment, either FCRA or non-FCRA; 
    **                                OPTIONAL, defaults to non-FCRA;
    ** @returns                       A dataset with deceased information attached to input record. 
    **
  */
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

    RETURN suppress.MAC_SuppressSource(out_recs, death_params, death.did, death.global_sid, data_env := _data_env); 

  ENDMACRO;


END;
