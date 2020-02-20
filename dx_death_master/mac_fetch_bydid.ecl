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

  LOCAL key_optout := suppress.key_OptOutSrc(_data_env);
  LOCAL local_dids := DEDUP(SORT(PROJECT(UNGROUP(ds_in), TRANSFORM(doxie.layout_references, SELF.did := (UNSIGNED6) LEFT.did_field)), did), did);
  LOCAL optout_recs := join(local_dids, key_optout, 
    KEYED((UNSIGNED6) LEFT.did = RIGHT.lexid),
    TRANSFORM(suppress.Layout_OptOut, SELF := RIGHT),
    KEEP(1), LIMIT(0));
  LOCAL isOptOutRestricted(unsigned6 did, unsigned4 glb_sid) := FUNCTION
      RETURN EXISTS(optout_recs(
        lexid=did, 
        glb_sid IN global_sids,
        (~suppress.optout_exemption.is_test(exemptions) OR death_params.lexid_source_optout = 2),
        (exemptions & (suppress.optout_exemption.bit_glb(death_params.glb) | suppress.optout_exemption.bit_dppa(death_params.dppa)) = 0)
        ));
  END;

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
  LOCAL out_recs := 
    join(ds_in, key_death, keyed(((UNSIGNED6) left.did_field)=right.l_did)
    and not deathv2_services.functions.Restricted(right.src, right.glb_flag, local_glb_ok, death_params)
    and not isOptOutRestricted(right.l_did, right.global_sid),
    appendDeceased(left, right), 
    #IF(left_outer)
    LEFT OUTER, 
    #END
    KEEP(recs_per_did), LIMIT(0));
  
  RETURN out_recs;
ENDMACRO;
