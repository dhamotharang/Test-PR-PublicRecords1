IMPORT suppress;
IMPORT $;

EXPORT IDataAccess := INTERFACE
  EXPORT unsigned1 glb := 0;
  EXPORT unsigned1 dppa := 0;
  EXPORT string DataPermissionMask := '';
  EXPORT string DataRestrictionMask := '111111111111111111111111111111111111111111111111111111111111';
  EXPORT boolean ln_branded := FALSE; //?
  EXPORT boolean probation_override := FALSE; //if TRUE, have to check whether src is in the probation list 
  EXPORT string5 industry_class := 'UTILI';
  EXPORT string32 application_type := ''; //?
  EXPORT boolean no_scrub := FALSE; // If TRUE, records put on probation will be returned (same as input parameter "raw")
  EXPORT unsigned3 date_threshold := 0; // a.k.a. dateVal
  EXPORT boolean suppress_dmv := TRUE; // as simple as "SuppressDMVInfo := false : stored('ExcludeDMVPII');"

  // this controls whether to skip logging (for instance, in Cert environment, to save the diskspace)
  EXPORT boolean log_record_source := TRUE; //save records' source info in Roxie logs
  EXPORT boolean lexid_source_optout := TRUE; //suppress LexId by record's source (CCPA, for instance)

  // a combination of "include" and dppa; I don't like it, but need to keep for backward compatibility 
  //TODO: try rid of it completely, or at least of "include" part
  EXPORT boolean show_minors := FALSE;  //a.k.a. OKtoShowMinors

  //masking
  EXPORT string ssn_mask := suppress.constants.ssn_mask_type.ALL; // FIRST5, LAST4, NONE (string6?)
  EXPORT unsigned1 dl_mask := 1; // means, do mask
  EXPORT unsigned1 dob_mask := suppress.constants.dateMask.ALL;

  //ccpa restrictions/logging
  EXPORT string transaction_id := ''; // esp transaction id or batch uid
  EXPORT unsigned6 global_company_id := 0; // mbs gcid
  

  // --------------------------------------------------------------------------------------------
  // Functions.
  // Implemented mostly through proxy calls -- to keep the interface as simple as possible.
  // Unlike ut/* family, none of the following read from global module;
  //     the idea is to replace ut/* and AutostandardI/Permission_Tools
  // --------------------------------------------------------------------------------------------
   
  EXPORT boolean isValidGLB (boolean RNA=false) := $.compliance.glb_ok (glb, RNA); 
  EXPORT boolean isValidDPPA (boolean RNA=false) := $.compliance.dppa_ok (dppa, RNA);

  // used by Header/MAC_GLB_DPPA_Clean_RNA
  EXPORT boolean isRnaRestrictedGLB () := $.compliance.is_glb_RNA (glb);
  EXPORT boolean isRnaRestrictedDPPA () := $.compliance.is_dppa_RNA (dppa);

  EXPORT boolean isValidDPPAState (string2 st, string2 header_source='', string2 source_code='') :=
           $.compliance.dppa_state_ok (st, dppa, header_source, source_code);
  EXPORT boolean isHeaderPreGLB (unsigned3 nonglb_last_seen, unsigned3 first_seen, string2 src) := 
           $.compliance.HeaderIsPreGLB (nonglb_last_seen, first_seen, src, DataRestrictionMask);

  EXPORT boolean isConsumer () := industry_class = 'CNSMR';
  EXPORT boolean isDirectMarketing () := industry_class = 'DRMKT';
  EXPORT boolean isUtility () := industry_class = 'UTILI';  // should we look for 'DRMKT' here as well?

  // restrictions based on data restriction mask flags
  EXPORT boolean isPreGLBRestricted () := $.compliance.isPreGLBRestricted (DataRestrictionMask);
  EXPORT boolean isECHRestricted () := $.compliance.isECHRestricted (DataRestrictionMask);
  EXPORT boolean isEQCHRestricted () := $.compliance.isEQCHRestricted (DataRestrictionMask);

    EXPORT boolean isHeaderSourceRestricted (string2 src) := 
           $.compliance.isHeaderSourceRestricted (src, DataRestrictionMask);

END;
