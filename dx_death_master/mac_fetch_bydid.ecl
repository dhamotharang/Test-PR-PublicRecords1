import data_services;

/*
  **
  ** Common (internal) code to fetch deceased records by did, used by this module's public interface:
  **   - Append
  **   - Get
  **   - Exclude
  **
*/
EXPORT mac_fetch_bydid(ds_in, did_field, death_params, skip_GLB_check = FALSE, recs_per_did = 1, left_outer = TRUE, _data_env = Data_Services.data_env.iNonFCRA) 
  := FUNCTIONMACRO

  IMPORT deathv2_services, doxie, suppress;
  LOCAL key_death := doxie.key_death_masterV2_ssa_DID;
  LOCAL layout_out_rec := RECORD
    RECORDOF(ds_in);
    dx_death_master.layout_death death;
  END;

  LOCAL local_glb_ok := skip_GLB_check OR death_params.isValidGlb();  
  LOCAL local_dids := DEDUP(SORT(PROJECT(ds_in, TRANSFORM(doxie.layout_references, SELF.did := (UNSIGNED6) LEFT.did_field;)), did), did);
  LOCAL din_with_death := 
    JOIN(local_dids, key_death, keyed(left.did=right.l_did) and
      not deathv2_services.functions.Restricted(right.src, right.glb_flag, local_glb_ok, death_params),
    TRANSFORM(RIGHT), 
    KEEP(30), LIMIT(0)); // as of nov.2019 we have a max of 21 records per did, average 1.25 records per did.
  
  LOCAL din_with_death_suppressed := suppress.MAC_SuppressSource(din_with_death, death_params, l_did, global_sid, data_env := _data_env); 

  LOCAL layout_out_rec appendDeceased(RECORDOF(ds_in) L, RECORDOF(key_death) R) := TRANSFORM
    SELF.death.is_deceased := R.l_did > 0;
    SELF.death := R;
    SELF := L;
  END;

  LOCAL out_recs := 
    join(ds_in, din_with_death_suppressed, (UNSIGNED6) left.did_field = right.l_did,
    appendDeceased(left, right), 
    #IF(left_outer)
    LEFT OUTER, 
    #END
    KEEP(recs_per_did), LIMIT(0));

    RETURN out_recs;

ENDMACRO;
