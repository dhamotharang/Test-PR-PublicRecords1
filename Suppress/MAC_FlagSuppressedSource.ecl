IMPORT Suppress, data_services;

/*
 * Use this macro to suppress records based on global source ids in opt out key, as defined by CCPA.
 *
 * @ds_in - input dataset of records to be suppressed.
 * @mod_access - access module (doxie.IDataAccess)
 * @did_field - the 'did' field as defined by the input dataset layout.
 * @suppression_indicator_field - if the input dataset already has an indicator field defined, provide the field name here. 
 *    If empty, by default, a boolean field named is_suppressed will be added to output dataset. 
 * @data_env - non-FCRA/FCRA 
 * 
 * @returns - the input dataset with flagged suppressed records.
 *
*/
EXPORT MAC_FlagSuppressedSource (ds_in, mod_access, did_field = 'did', gsid_field = 'global_sid', suppression_indicator_field = '', data_env = data_services.data_env.iNonFCRA) := FUNCTIONMACRO

  LOCAL l_out := RECORD
   ds_in;
   #IF(#TEXT(suppression_indicator_field)='')
   BOOLEAN is_suppressed := false;
   #END
  END;
  
  LOCAL suppressed_recs := JOIN(ds_in, suppress.key_OptOutSrc(data_env), 
    KEYED((UNSIGNED6) LEFT.did_field = RIGHT.lexid) AND
    LEFT.gsid_field IN RIGHT.global_sids AND
    (~suppress.optout_exemption.is_test(RIGHT.exemptions) OR mod_access.lexid_source_optout = 2) AND
    (RIGHT.exemptions & (Suppress.optout_exemption.bit_glb(mod_access.glb) | Suppress.optout_exemption.bit_dppa(mod_access.dppa)) = 0), 
    TRANSFORM(l_out,
      #IF(#TEXT(suppression_indicator_field)='')
      SELF.is_suppressed := RIGHT.lexid > 0;
      #ELSE
      SELF.suppression_indicator_field := RIGHT.lexid > 0;
      #END
      SELF := LEFT;
    ), LEFT OUTER, KEEP(1), LIMIT(0));

  RETURN IF (mod_access.lexid_source_optout > 0, suppressed_recs, 
    PROJECT(ds_in, TRANSFORM(l_out, SELF := LEFT;)));

ENDMACRO;
