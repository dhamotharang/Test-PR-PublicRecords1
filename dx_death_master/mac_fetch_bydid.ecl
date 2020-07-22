import data_services;

/*
  **
  ** Common code to fetch death records for *EXCLUSIVE* use within this module.
  **
  ** NOTE: DO NOT call this function directly. ALWAYS use Get, Append or Exclude instead. 
  **
*/
EXPORT mac_fetch_bydid(ds_in, did_field, death_params, restrictions = 0, recs_per_did = 1, left_outer = TRUE, 
  use_distributed = FALSE, _data_env = data_services.data_env.iNonFCRA)
  := FUNCTIONMACRO

  IMPORT deathv2_services, doxie, suppress, data_services;

  // TODO: define a bitmask to check individual restrictions instead.   
  LOCAL skip_glb_restrictions := restrictions >= dx_death_master.Constants.DataRestrictions.skipGLB;
  LOCAL skip_src_restrictions := restrictions >= dx_death_master.Constants.DataRestrictions.skipGLBAndSource;
  LOCAL skip_all_restrictions := restrictions = dx_death_master.Constants.DataRestrictions.skipAll;
  LOCAL local_glb_ok := skip_glb_restrictions OR death_params.isValidGlb();

  #IF (use_distributed)
  LOCAL in_file := UNGROUP(ds_in);
  #ELSE
  LOCAL in_file := ds_in; // cannot ungroup or some queries will fail with "branches with different grouping" error.
  #END

  LOCAL key_death := IF(_data_env = data_services.data_env.iFCRA, 
    doxie.key_death_masterV2_ssa_DID_fcra, doxie.key_death_masterV2_ssa_DID);

  LOCAL layout_out_rec := RECORD
    RECORDOF(in_file);
    dx_death_master.layout_death death;
  END;

  LOCAL layout_out_rec appendDeceased(RECORDOF(in_file) L, RECORDOF(key_death) R) := TRANSFORM
    SELF.death.is_deceased := R.l_did > 0;
    SELF.death := R;
    SELF := L;
  END;

  #IF (use_distributed)
  LOCAL in_file_dist := DISTRIBUTE(in_file((UNSIGNED6) did_field>0), HASH((UNSIGNED6) did_field));

  // fetch all possible matches first
  LOCAL death_recs_local := JOIN(in_file_dist, DISTRIBUTE(key_death, HASH(l_did)), 
    ((UNSIGNED6) left.did_field = right.l_did)
    AND (skip_src_restrictions OR NOT deathv2_services.functions.Restricted(right.src, right.glb_flag, local_glb_ok, death_params)),
    appendDeceased(left, right), 
    #IF (left_outer)
    LEFT OUTER, 
    #END
    ATMOST((UNSIGNED6) left.did_field = right.l_did, 200), LOCAL);

  // apply opt-out unless skipping all restrictions
  LOCAL death_recs_optout := Suppress.MAC_SuppressSource (death_recs_local, death_params, did_field, death.global_sid, TRUE, _data_env);
  LOCAL death_recs_restricted := IF(skip_all_restrictions, death_recs_local, death_recs_optout);

  LOCAL death_recs_clean := JOIN(in_file_dist, death_recs_restricted,
    ((UNSIGNED6) left.did_field = right.death.l_did),
    TRANSFORM(layout_out_rec,
      SELF.death.is_deceased := right.death.l_did > 0;
      SELF.death := right.death;
      SELF := left;
    ),
    #IF (left_outer) 
    LEFT OUTER,
    #END
    KEEP(recs_per_did), LIMIT(0), LOCAL);

  LOCAL out_recs := death_recs_clean
    #IF (left_outer) // if left outer, must preserve records with no did
    + project(in_file((UNSIGNED6) did_field=0), TRANSFORM(layout_out_rec,
      SELF.death.is_deceased := FALSE;
      SELF.death := [];
      SELF := LEFT))
    #END
    ;

  #ELSE // use_distributed

  LOCAL local_dids := DEDUP(SORT(PROJECT(in_file(((UNSIGNED6) did_field)>0), TRANSFORM(doxie.layout_references, 
    SELF.did := (UNSIGNED6) LEFT.did_field)), did), did);

  LOCAL optout_recs := JOIN(local_dids, suppress.key_OptOutSrc(_data_env), 
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

  // Note: join to opt-out key done in isOptOutRestricted() is not effective, but it avoids "branches with different grouping" 
  // error when syntax checking some queries.
  LOCAL out_recs := JOIN(in_file, key_death, 
    (((UNSIGNED6)left.did_field)>0) AND keyed((UNSIGNED6) left.did_field = right.l_did)
    AND (skip_src_restrictions OR NOT deathv2_services.functions.Restricted(right.src, right.glb_flag, local_glb_ok, death_params))
    AND (skip_all_restrictions OR NOT isOptOutRestricted(right.l_did, right.global_sid)),
    appendDeceased(left, right), 
    #IF(left_outer)
    LEFT OUTER, 
    #END
    KEEP(recs_per_did), LIMIT(0));
  #END


  RETURN out_recs;
ENDMACRO;
