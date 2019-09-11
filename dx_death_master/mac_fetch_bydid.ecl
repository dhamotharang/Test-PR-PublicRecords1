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

  LOCAL layout_out_rec appendDeceased(RECORDOF(ds_in) L, RECORDOF(key_death) R) := TRANSFORM
    SELF.death.is_deceased := R.l_did > 0;
    SELF.death := R;
    SELF := L;
  END;

  LOCAL local_glb_ok := skip_GLB_check OR death_params.isValidGlb();  
  LOCAL din_with_death := 
    join(ds_in, key_death, keyed(((UNSIGNED6) left.did_field)=right.l_did)
      and	not deathv2_services.functions.Restricted(right.src, right.glb_flag, local_glb_ok, death_params),
    appendDeceased(left, right), 
    #IF(left_outer)
    LEFT OUTER, 
    #END
    KEEP(recs_per_did), LIMIT(0));
  
  LOCAL din_with_death_suppressed := suppress.MAC_FlagSuppressedSource(din_with_death, death_params, did_field, death.global_sid, _data_env); 

  LOCAL out_recs := PROJECT(din_with_death_suppressed, 
    TRANSFORM(layout_out_rec,
      // TODO: uncomment lines below to enable ccpa suppression once dx_death_master changes are in place.
      // #IF(left_outer)
      // SELF.death := IF(~LEFT.is_suppressed, LEFT.death); // if appending (left outer), blank deceased data if suppressed
      // #ELSE
      // SELF.did_field := IF(LEFT.is_suppressed, SKIP, LEFT.did_field); // drop entire record if suppressed 
      // #END
      SELF := LEFT));
  
  RETURN out_recs;
ENDMACRO;
