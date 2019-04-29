IMPORT Suppress, data_services;

/*
 * Use this macro to suppress records based on global source ids in opt out key, as defined by CCPA.
 *
 * @ds_in - a dataset of records to be suppressed.
 * @mod_access - access module (doxie.IDataAccess)
 * @did_field - the 'did' field as defined by the input dataset layout.
 * @flag_only - returns suppressed records flagged as 'is_suppressed'.  
 * @data_env
 * 
 * @returns - the input dataset minus suppressed records or, if flag_only=TRUE, input dataset with flagged suppressed records.
 *
 * UNDER DISCUSSION: 
 *  - Should we have a separate macro to flag suppress records instead instead of flag_only option?
*/
EXPORT MAC_SuppressSource (ds_in, mod_access, did_field = 'did', flag_only = FALSE, data_env = data_services.data_env.iNonFCRA) := FUNCTIONMACRO

  LOCAL l_out := RECORD
   ds_in;
   #IF(flag_only)
   BOOLEAN is_suppressed := false;
   #END
  END;
  
  LOCAL suppressed_recs := JOIN(ds_in, suppress.key_OptOutSrc(data_env), 
    KEYED((UNSIGNED6) LEFT.did_field = RIGHT.lexid) AND
    LEFT.global_sid IN RIGHT.global_sids AND
    RIGHT.exemptions &  
        (Suppress.optout_exemption.bit_glb(mod_access.glb) | Suppress.optout_exemption.bit_dppa(mod_access.dppa)) = 0, 
    TRANSFORM(l_out,
      #IF(flag_only)
      SELF.is_suppressed := RIGHT.lexid > 0;
      #ELSE 
      SELF.did_field := IF(RIGHT.lexid > 0, SKIP, LEFT.did_field);
      #END 
      SELF := LEFT;
    ), LEFT OUTER, KEEP(1), LIMIT(0));

  RETURN IF (mod_access.lexid_source_optout, suppressed_recs, 
    PROJECT(ds_in, TRANSFORM(l_out, SELF := LEFT;)));

ENDMACRO;
