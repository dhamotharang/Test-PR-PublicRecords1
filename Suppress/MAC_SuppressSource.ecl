IMPORT Suppress, data_services;

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
EXPORT MAC_SuppressSource (ds_in, mod_access, did_field = 'did', data_env = data_services.data_env.iNonFCRA) := FUNCTIONMACRO
  IMPORT suppress;

  local suppressed_recs := JOIN(ds_in, suppress.key_OptOutSrc(data_env),
    KEYED((UNSIGNED6) LEFT.did_field = RIGHT.lexid) AND
      LEFT.global_sid IN RIGHT.global_sids AND
      RIGHT.exemptions &  (Suppress.Functions.bit_glb(mod_access.glb) | Suppress.Functions.bit_dppa(mod_access.dppa)) = 0,
      TRANSFORM(LEFT), LEFT ONLY);

  // using hard-coded dataset:
  // local suppressed_recs := JOIN(ds_in, CCPA.key_OptOutSrc(data_env),
  //   ((UNSIGNED6) LEFT.did_field = RIGHT.lexid) AND
  //     LEFT.global_sid IN RIGHT.global_sids AND
  //     RIGHT.exemptions &  (Suppress.Functions.bit_glb(mod_access.glb) | Suppress.Functions.bit_dppa(mod_access.dppa)) = 0,
  //     TRANSFORM(LEFT), LEFT ONLY);

  IF (mod_access.lexid_source_optout AND (COUNT(ds_in) > COUNT(suppressed_recs)),
      // #STORED('SourceOptoutOccured', TRUE) // -- doesn't work: always executed.
      OUTPUT (DATASET([{'Source optout may have affected results'}], {string s}), NAMED ('SourceOptoutOccured'), OVERWRITE)
  );

  RETURN IF (mod_access.lexid_source_optout, suppressed_recs, ds_in);

ENDMACRO;
