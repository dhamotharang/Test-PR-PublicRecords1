﻿IMPORT suppress, data_services;

/*
 * A MACRO to suppress records from consumers who have opted out. Records are suppressed based on:
 *  - Matching LexID.
 *  - Matching Global Source ID.
 *  - Exemption rules (GLB/DPPA settings).
 *
 * @param ds_in                   Input dataset of records to be suppressed; REQUIRED.
 * @param mod_access              Global access module (doxie.IDataAccess), including permissions,
 *                                restrictions, ect; REQUIRED.
 * @param did_field               The field containing LexID as defined by the input dataset layout;
 *                                OPTIONAL, defaults to 'did'.
 * @param gsid_field              The field containing Global Source ID as defined by the input dataset layout. 
 *                                OPTIONAL, defaults to 'global_sid';
 *                                If NULL is specified, the macro will ignore Global Source IDs when applying 
 *                                suppressions. 
 * @param use_distributed         Use it for Thor jobs only. OPTIONAL, defaults to false. 
 * @param data_env                Data cluster; OPTIONAL, defaults to non-FCRA. 
 * 
 * @return                        The input dataset minus any suppressed records.
 *
*/
EXPORT MAC_SuppressSource (ds_in, mod_access, did_field = 'did', gsid_field = 'global_sid', use_distributed = FALSE, data_env = data_services.data_env.iNonFCRA) := FUNCTIONMACRO

  LOCAL key_optout := suppress.key_OptOutSrc(data_env);
  #IF(use_distributed)
  LOCAL suppressed_recs := JOIN(DISTRIBUTE(ds_in, HASH(did_field)), DISTRIBUTE(PULL(key_optout), HASH(lexid)), 
    ((UNSIGNED6) LEFT.did_field = RIGHT.lexid) AND
    #IF(#TEXT(gsid_field) != 'NULL') 
    LEFT.gsid_field IN RIGHT.global_sids AND
    #END
    (~suppress.optout_exemption.is_test(RIGHT.exemptions) OR mod_access.lexid_source_optout = 2) AND
    (RIGHT.exemptions & (suppress.optout_exemption.bit_glb(mod_access.glb) | suppress.optout_exemption.bit_dppa(mod_access.dppa)) = 0),
    TRANSFORM(LEFT), LEFT ONLY, LOCAL);
  #ELSE
  LOCAL suppressed_recs := JOIN(ds_in, key_optout, 
    KEYED((UNSIGNED6) LEFT.did_field = RIGHT.lexid) AND
    #IF(#TEXT(gsid_field) != 'NULL') 
    LEFT.gsid_field IN RIGHT.global_sids AND
    #END
    (~suppress.optout_exemption.is_test(RIGHT.exemptions) OR mod_access.lexid_source_optout = 2) AND
    (RIGHT.exemptions & (suppress.optout_exemption.bit_glb(mod_access.glb) | suppress.optout_exemption.bit_dppa(mod_access.dppa)) = 0),
    TRANSFORM(LEFT), LEFT ONLY);
  #END

  RETURN IF (mod_access.lexid_source_optout > 0, suppressed_recs, ds_in);

ENDMACRO;
