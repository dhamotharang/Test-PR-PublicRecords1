IMPORT suppress, data_services;

/*
 * Use this macro to suppress records based on global source ids in opt out key, as defined by CCPA.
 *
 * @ds_in - input dataset of records to be suppressed.
 * @mod_access - access module (doxie.IDataAccess)
 * @did_field - the 'did' field as defined by the input dataset layout.
 * @data_env - non-FCRA/FCRA 
 * 
 * @returns - the input dataset minus suppressed records.
 *
*/
EXPORT MAC_SuppressSource (ds_in, mod_access, did_field = 'did', gcid_field = 'global_sid', data_env = data_services.data_env.iNonFCRA) := FUNCTIONMACRO

  LOCAL suppressed_recs := JOIN(ds_in, suppress.key_OptOutSrc(data_env), 
    KEYED((UNSIGNED6) LEFT.did_field = RIGHT.lexid) AND
      LEFT.gcid_field IN RIGHT.global_sids AND
      (~suppress.optout_exemption.is_test(RIGHT.exemptions) OR mod_access.lexid_source_optout = 2) AND
      (RIGHT.exemptions & (suppress.optout_exemption.bit_glb(mod_access.glb) | suppress.optout_exemption.bit_dppa(mod_access.dppa)) = 0),
      TRANSFORM(LEFT), LEFT ONLY);

  RETURN IF (mod_access.lexid_source_optout > 0, suppressed_recs, ds_in);

ENDMACRO;
