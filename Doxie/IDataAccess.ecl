IMPORT suppress;
IMPORT $;

EXPORT IDataAccess := INTERFACE
  EXPORT unsigned1 unrestricted := 0; // bitmask for ignoring certain restrictions (a.k.a. "allow");
                                      // should be used with extreme caution and almost exclusively for debug purposes.
                                      // currently allow-all encompases glb/dppa
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
  EXPORT unsigned1 reseller_type := 0; // 0 - 'End User' (not reseller)| 1 - 'Reseller - We Bill'| 2 - 'Reseller - They Bill'| 3 - Integrator| 4 - Integrator Child| 5 - 'Sales Agent - They Sell'| 6 - 'Sales Agent - We Sell'| 7 - 'Billing Intermediary'| 8 - 'Reseller - LNAC'|
  EXPORT unsigned1 intended_use := 0; // a bit mask with first bit reserved for marketing

  // this controls whether to skip logging (for instance, in Cert environment, to save diskspace)
  EXPORT boolean log_record_source := TRUE; //save records' source info in Roxie logs
  EXPORT unsigned1 lexid_source_optout := 1; //suppress LexId by record's source (CCPA, for instance): 0 - disabled | 1 - enabled | 2 - enabled test mode

  // a combination of "include" and dppa; I don't like it, but need to keep for backward compatibility 
  //TODO: try rid of it completely, or at least of "include" part
  EXPORT boolean show_minors := FALSE;  //a.k.a. OKtoShowMinors

  //masking
  EXPORT string ssn_mask := suppress.constants.ssn_mask_type.ALL; // FIRST5, LAST4, NONE (string6?)
  EXPORT unsigned1 dl_mask := 1; // means, do mask
  EXPORT unsigned1 dob_mask := suppress.constants.dateMask.ALL;
  
  // ccpa logging
  EXPORT string transaction_id := ''; // esp transaction id or batch uid
  EXPORT unsigned6 global_company_id := 0; // mbs gcid
  

  // --------------------------------------------------------------------------------------------
  // Functions.
  // Implemented mostly through proxy calls -- to keep the interface as simple as possible.
  // Unlike ut/* family, none of the following read from global module;
  //     the idea is to replace ut/* and AutostandardI/Permission_Tools
  // --------------------------------------------------------------------------------------------
   
  EXPORT boolean isValidGLB (boolean RNA=false) := $.compliance.glb_ok (glb, RNA, unrestricted);
  EXPORT boolean isValidDPPA (boolean RNA=false) := $.compliance.dppa_ok (dppa, RNA, unrestricted); 

  // used by Header/MAC_GLB_DPPA_Clean_RNA
  EXPORT boolean isRnaRestrictedGLB () := $.compliance.is_glb_RNA (glb);
  EXPORT boolean isRnaRestrictedDPPA () := $.compliance.is_dppa_RNA (dppa);

  EXPORT boolean isValidDPPAState (string2 st, string2 header_source='', string2 source_code='') :=
           $.compliance.dppa_state_ok (st, dppa, header_source, source_code, unrestricted);
  EXPORT boolean isHeaderPreGLB (unsigned3 nonglb_last_seen, unsigned3 first_seen, string2 src) := 
           $.compliance.HeaderIsPreGLB (nonglb_last_seen, first_seen, src, DataRestrictionMask);

  EXPORT boolean isResellerAccount () := reseller_type > 0; // 0 - 'End User' (not reseller)| 1 - 'Reseller - We Bill'| 2 - 'Reseller - They Bill'| 3 - Integrator| 4 - Integrator Child| 5 - 'Sales Agent - They Sell'| 6 - 'Sales Agent - We Sell'| 7 - 'Billing Intermediary'| 8 - 'Reseller - LNAC'|
  EXPORT boolean isConsumer () := industry_class = 'CNSMR';
  EXPORT boolean isDirectMarketing () := industry_class = 'DRMKT' 
                                         OR (intended_use & 1) = 1; // hardcoded 1 here (designated for marketing) for simplicity. Didn't create Constant since for now it is the only value expected for use case

  EXPORT boolean isUtility () := industry_class = 'UTILI' OR isDirectMarketing(); // indicates restriction of utility sources 

  // restrictions based on data restriction mask flags
  EXPORT boolean isECHRestricted ()         := $.compliance.isECHRestricted         (DataRestrictionMask);
  EXPORT boolean isEQCHRestricted ()        := $.compliance.isEQCHRestricted        (DataRestrictionMask);
  EXPORT boolean isTCHRestricted ()         := $.compliance.isTCHRestricted         (DataRestrictionMask);
  EXPORT boolean isTTRestricted ()          := $.compliance.isTTRestricted          (DataRestrictionMask); //TeleTrack
  EXPORT boolean isAdvoRestricted()         := $.compliance.isAdvoRestricted        (DataRestrictionMask);
  EXPORT boolean isInfutorMVRestricted ()   := $.compliance.isInfutorMVRestricted   (DataRestrictionMask); //Infutor Motorvehicles
  EXPORT boolean isPreGLBRestricted ()      := $.compliance.isPreGLBRestricted      (DataRestrictionMask);
  EXPORT boolean isFdnInquiry ()            := $.compliance.isFdnInquiry            (DataRestrictionMask);
  EXPORT boolean isJuliRestricted ()        := $.compliance.isJuliRestricted        (DataRestrictionMask);
  EXPORT boolean isAccuDataRestricted    () := $.compliance.isAccuDataRestricted    (DataRestrictionMask);
  EXPORT BOOLEAN isBriteVerifyRestricted () := $.compliance.isBriteVerifyRestricted (DataRestrictionMask); // BriteVerify gateway for Email verification 

  EXPORT boolean isHeaderSourceRestricted (string2 src) := 
           $.compliance.isHeaderSourceRestricted (src, DataRestrictionMask);

  EXPORT BOOLEAN use_DnB()                  := $.compliance.use_DnB(DataPermissionMask);
   
END;
