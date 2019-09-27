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

  EXPORT supplementalByDeathId(ds_in, death_id_field, format_date = TRUE)
    := FUNCTIONMACRO
  
    IMPORT death_master;
    LOCAL key_death_supplemental := death_master.key_death_id_supplemental_ssa;
    LOCAL layout_out_rec := RECORD
      RECORDOF(ds_in);
      // for generic append operations like these, it seems safer to declare death_supp as a record (as opposed to simply inheriting supp layout); 
      // or else we may override common fields that may be defined on both left and right layouts.
      dx_death_master.layout_death_supplemental death_supp; 
    END;

    LOCAL layout_out_rec append_supplemental(RECORDOF(ds_in) L, RECORDOF(key_death_supplemental) R) := TRANSFORM
      SELF.death_supp.process_date := IF(format_date, dx_death_master.Functions.formatDate(R.process_date), R.process_date);
      SELF.death_supp.filed_date := IF(format_date, dx_death_master.Functions.formatDate(R.filed_date), R.filed_date);
      SELF.death_supp.disposition_date := IF(format_date, dx_death_master.Functions.formatDate(R.disposition_date), R.disposition_date);
      SELF.death_supp.injury_date := IF(format_date, dx_death_master.Functions.formatDate(R.injury_date), R.injury_date);
      SELF.death_supp.surgery_date := IF(format_date, dx_death_master.Functions.formatDate(R.surgery_date), R.surgery_date);
      SELF.death_supp.date_last_trans := IF(format_date, dx_death_master.Functions.formatDate(R.date_last_trans), R.date_last_trans);
      SELF.death_supp := R;
      SELF := L;
    END;

    LOCAL out_recs := join(ds_in, key_death_supplemental, 
      keyed(left.death_id_field=right.state_death_id),
      append_supplemental(left, right), 
      LEFT OUTER, 
      KEEP(1), LIMIT(0));
    
    // *** No CCPA suppression needed; always applied after fetching state death ids.
    
    RETURN out_recs;

  ENDMACRO;

END;
