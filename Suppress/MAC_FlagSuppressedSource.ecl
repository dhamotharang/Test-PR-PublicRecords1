IMPORT Suppress, data_services;

/*
 * A MACRO to flag records from consumers who have opted out. Records are flagged as suppressed based on:
 *  - Matching LexID.
 *  - Matching Global Source ID.
 *  - Exemption rules (GLB/DPPA settings).
 *
 * IMPORTANT: The caller is responsible for making sure records flagged as suppressed are not returned/used.
 *
 * @param ds_in                   Input dataset of records to be suppressed; REQUIRED.
 * @param mod_access              Global access module (doxie.IDataAccess), including permissions,
 *                                restrictions, ect; REQUIRED.
 * @param did_field               The field containing LexID as defined by the input dataset layout;
 *                                OPTIONAL, defaults to 'did'.
 * @param gsid_field              The field containing Global Source ID as defined by the input dataset layout. 
 *                                OPTIONAL, defaults to 'global_sid';
 *                                If NULL is specified, the macro will ignore Global Source ID when applying 
 *                                suppressions. 
 * @param use_distributed         Use it for Thor jobs only. OPTONAL, defaults to false.  
 * @param data_env                Data cluster; OPTIONAL, defaults to non-FCRA. 
 * 
 * @return                        The input dataset with suppression indicator (is_suppressed).
 *
*/
EXPORT MAC_FlagSuppressedSource (ds_in, mod_access, did_field = 'did', gsid_field = 'global_sid', use_distributed = FALSE, data_env = data_services.data_env.iNonFCRA) := FUNCTIONMACRO

	IMPORT _Control;
  LOCAL rec_suppressed := RECORD
    BOOLEAN is_suppressed := false;
  END;
  LOCAL l_out := RECORDOF(ds_in) OR rec_suppressed;
  
  LOCAL key_optout := suppress.key_OptOutSrc(data_env);
  #IF(use_distributed)
  LOCAL suppressed_recs := JOIN(DISTRIBUTE(ds_in((unsigned)did_field<>0), HASH(did_field)), DISTRIBUTE(PULL(key_optout), HASH(lexid)), 
    ((UNSIGNED6) LEFT.did_field = RIGHT.lexid) AND
    #IF(#TEXT(gsid_field) != 'NULL') 
    LEFT.gsid_field IN RIGHT.global_sids AND
    #END
    (~suppress.optout_exemption.is_test(RIGHT.exemptions) OR mod_access.lexid_source_optout = 2) AND
    (RIGHT.exemptions & (Suppress.optout_exemption.bit_glb(mod_access.glb) | Suppress.optout_exemption.bit_dppa(mod_access.dppa)) = 0), 
    TRANSFORM(l_out,
      SELF.is_suppressed := RIGHT.lexid > 0;
      SELF := LEFT;
    ), LEFT OUTER, KEEP(1), LIMIT(0), LOCAL) + ds_in((unsigned)did_field=0); // add back the records that have did=0
  #ELSE
  LOCAL suppressed_recs := JOIN(ds_in, key_optout,
		(unsigned)left.did_field<>0 and 
    KEYED((UNSIGNED6) LEFT.did_field = RIGHT.lexid) AND
    #IF(#TEXT(gsid_field) != 'NULL') 
    LEFT.gsid_field IN RIGHT.global_sids AND
    #END
    (~suppress.optout_exemption.is_test(RIGHT.exemptions) OR mod_access.lexid_source_optout = 2) AND
    (RIGHT.exemptions & (Suppress.optout_exemption.bit_glb(mod_access.glb) | Suppress.optout_exemption.bit_dppa(mod_access.dppa)) = 0), 
    TRANSFORM(l_out,
      SELF.is_suppressed := RIGHT.lexid > 0;
      SELF := LEFT;
    ), LEFT OUTER, KEEP(1), LIMIT(0));
  #END

#IF(_CONTROL.Environment.onThor_LeadIntegrity)
	RETURN PROJECT(ds_in, TRANSFORM(l_out, SELF := LEFT;));
#ELSE
  RETURN IF (mod_access.lexid_source_optout > 0, suppressed_recs, 
    PROJECT(ds_in, TRANSFORM(l_out, SELF := LEFT;)));
#END

ENDMACRO;
