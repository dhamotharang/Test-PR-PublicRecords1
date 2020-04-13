import dx_death_master, data_services;

/*
  ** A set of macros to append deceased information to a dataset.
*/
EXPORT Append := MODULE

  /*
    ** Append deceased by LexID.
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
    ** @returns                       Input dataset with deceased information as defined in dx_death_master.layout_death.
    **
  */
  EXPORT byDid(ds_in, did_field, death_params, skip_GLB_check = FALSE, recs_per_did = 1, use_distributed = FALSE, _data_env = Data_Services.data_env.iNonFCRA) 
    := FUNCTIONMACRO
   
    LOCAL restrictions := IF(skip_GLB_check, dx_death_master.Constants.DataRestrictions.skipGLB, dx_death_master.Constants.DataRestrictions.enforceAll);
    LOCAL out_recs := dx_death_master.mac_fetch_bydid(ds_in, did_field, death_params,
      restrictions, recs_per_did, /*left_outer*/TRUE, use_distributed, _data_env);

    RETURN out_recs;

  ENDMACRO;

  /*
    ** Append supplemental death data by state death id.
    **
    ** @param ds_in                   Input dataset; REQUIRED. 
    ** @param death_id_field          The state death id field as defined by the input dataset layout; REQUIRED.
    ** @param format_date             Format dates to YYYYMMDD. OPTIONAL, set to true by default.
    **
    ** @returns                       Input dataset with deceased information as defined in dx_death_master.layout_death.
    **
  */
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
  
  /*
    ** Append DOD by LexID with unrestricted access. Note: May return blank DOD if deceased subject is in opt-out (CCPA).
    **
    ** @param ds_in                   Input dataset; REQUIRED. 
    ** @param did_field               The LexID field as defined by the input dataset layout; REQUIRED.
    ** @param death_params            Death master input mod as defined in DeathV2_Services.IParam.DeathRestrictions;
    **                                REQUIRED.
    ** @param recs_per_did            Number of matching records to be returned; 
    **                                OPTIONAL: defaults to 1.
    ** @param use_distributed         For use when running THOR jobs; OPTINAL, defaults to FALSE.
    ** @param data_env                Data environment, either FCRA or non-FCRA; 
    **                                OPTIONAL, defaults to non-FCRA;
    ** @returns                       Input dataset with 2 DOD fields (dod and dodSSA).
    **
  */
  EXPORT byDidUnrestricted(ds_in, did_field, death_params, recs_per_did = 1, use_distributed = FALSE, _data_env = Data_Services.data_env.iNonFCRA) 
    := FUNCTIONMACRO
  
    import MDR;
    LOCAL layout_death_unrestricted := RECORD
      unsigned dod;
      unsigned dodSSA;
    END;
    LOCAL l_out := RECORDOF(ds_in) OR layout_death_unrestricted;

    LOCAL death_appended := dx_death_master.mac_fetch_bydid(ds_in, did_field, death_params,
      dx_death_master.Constants.DataRestrictions.skipGLBAndSource, recs_per_did, 
      /*left_outer*/TRUE, use_distributed, _data_env);

    LOCAL out_recs := PROJECT(death_appended, TRANSFORM(l_out,
      SELF.dod := if(left.death.src <> MDR.sourceTools.src_Death_Restricted, (UNSIGNED) left.death.dod8, 0); //excludes SSA 
      SELF.dodSSA := (UNSIGNED) LEFT.death.dod8; //unrestricted so includes SSA
      SELF := LEFT;
      ));

    RETURN out_recs;

  ENDMACRO;


END;
