IMPORT Suppress, data_services;
EXPORT MAC_SuppressSource (ds_in, mod_access, did_field = 'did', gsid_field = 'global_sid', env_flag = data_services.data_env.iNonFCRA) := FUNCTIONMACRO
  IMPORT data_services;
  local suppressed_recs := JOIN(ds_in, suppress.key_OptOutSrc(env_flag = data_services.data_env.iFCRA), // FCRA flag?
    KEYED((UNSIGNED6) LEFT.did_field = RIGHT.lexid) AND
      LEFT.gsid_field IN RIGHT.global_sids AND
      RIGHT.exemptions &  (Suppress.Functions.bit_glb(mod_access.glb) | Suppress.Functions.bit_dppa(mod_access.dppa)) = 0,
      TRANSFORM(LEFT), LEFT ONLY);
  
  RETURN IF (mod_access.lexid_source_optout, suppressed_recs, ds_in);

/*
  -- dummy version -- 

   // using any key until opt out key is available. we only want to hit a key to see impact on performance.
  k := suppress.Key_New_Suppression; 

  recordof(ds_in) doSuppression(recordof(ds_in) L, recordof(k) R) := TRANSFORM,
    SKIP(L.gsid_field % 2 = 1)
    SELF := L;
  END;

  suppressed_recs := 
    JOIN(ds_in, k, (UNSIGNED6) LEFT.did_field > 0 
      AND KEYED(LEFT.did_field = RIGHT.product),
      doSuppression(LEFT, RIGHT),
      LEFT OUTER, KEEP(1), LIMIT(0)
    );

  RETURN IF (mod_access.lexid_source_optout,
             //ds_in (gsid_field % 2 = 1),
             suppressed_recs,
             ds_in);
  */           

ENDMACRO;