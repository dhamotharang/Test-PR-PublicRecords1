IMPORT AutoStandardI, codes, data_services, mdr, STD;

EXPORT compliance := MODULE

   // a bit set for ignoring any particular restriction;
  EXPORT ALLOW := MODULE
    EXPORT unsigned1 GLB := 1;
    EXPORT unsigned1 DPPA := 2;
    // any other, like application type, ln-branded, etc.
    // ...
    EXPORT unsigned1 ALL := -1; // means all are unrestricted
  END;

  // from doxie.mac_header_field_declare() -- i.e. translated
  EXPORT GetGlobalDataAccessModule () := FUNCTIONMACRO
    IMPORT STD;
    // a hack: DPM and DRM are not provided
    local gm := AutoStandardI.GlobalModule();
    local access := MODULE (doxie.IDataAccess)
      EXPORT unsigned1 unrestricted := 0 | IF (gm.AllowGLB, doxie.compliance.ALLOW.GLB, 0)
                                         | IF (gm.AllowDPPA, doxie.compliance.ALLOW.DPPA, 0)
                                         | IF (gm.AllowALL, doxie.compliance.ALLOW.ALL, 0);
      EXPORT unsigned1 glb := GLB_Purpose;
      EXPORT unsigned1 dppa := DPPA_Purpose;
      EXPORT string DataPermissionMask := gm.DataPermissionMask;
      EXPORT string DataRestrictionMask := gm.DataRestrictionMask;
      EXPORT boolean ln_branded := ln_branded_value;
      EXPORT boolean probation_override := probation_override_value;
      EXPORT string5 industry_class := STD.Str.ToUpperCase(TRIM(industry_class_value, LEFT, RIGHT));
      EXPORT string32 application_type := application_type_value;
      EXPORT boolean no_scrub := ^.no_scrub;
      EXPORT unsigned3 date_threshold := dateVal;
      EXPORT boolean suppress_dmv := suppressDMVInfo_value;
      EXPORT unsigned1 lexid_source_optout := gm.LexIdSourceOptout;
      // "unsigned", so that we could accommodate different log levels, if needed
      EXPORT boolean log_record_source := gm.LogRecordSource AND ((unsigned)thorlib.getenv ('LogRecordSource', '1') > 0);
      EXPORT boolean show_minors := gm.IncludeMinors OR (GLB_Purpose = 2);
      EXPORT string ssn_mask := ssn_mask_value;
      EXPORT unsigned1 dl_mask :=  dl_mask_val;
      EXPORT unsigned1 dob_mask := dob_mask_value;
      EXPORT unsigned1 reseller_type := ^.reseller_type;
      EXPORT unsigned1 intended_use := ^.intended_use;
      EXPORT string transaction_id := if(gm.TransactionID <> '', gm.TransactionID, gm.BatchUID);
      EXPORT unsigned6 global_company_id := gm.GlobalCompanyId;
    END;
    RETURN access;
  ENDMACRO;

  // from global module -- needs translations
  EXPORT GetGlobalDataAccessModuleTranslated (gm) := FUNCTIONMACRO
    IMPORT doxie, AutoStandardI, STD;
    local glb_auto := AutoStandardI.InterfaceTranslator.GLB_Purpose.val(project(gm,AutoStandardI.InterfaceTranslator.GLB_Purpose.params));
    local access := MODULE (doxie.IDataAccess)
      EXPORT unsigned1 unrestricted := 0 | IF (gm.AllowGLB, doxie.compliance.ALLOW.GLB, 0)
                                         | IF (gm.AllowDPPA, doxie.compliance.ALLOW.DPPA, 0)
                                         | IF (gm.AllowALL, doxie.compliance.ALLOW.ALL, 0);
      EXPORT unsigned1 glb := glb_auto;
      EXPORT unsigned1 dppa := AutoStandardI.InterfaceTranslator.DPPA_Purpose.val(project(gm,AutoStandardI.InterfaceTranslator.DPPA_Purpose.params));
      EXPORT string DataPermissionMask := gm.DataPermissionMask;
      EXPORT string DataRestrictionMask := gm.DataRestrictionMask;
      EXPORT boolean ln_branded := AutoStandardI.InterfaceTranslator.ln_branded_value.val(project(gm,AutoStandardI.InterfaceTranslator.ln_branded_value.params));
      EXPORT boolean probation_override := AutoStandardI.InterfaceTranslator.probation_override_value.val(project(gm,AutoStandardI.InterfaceTranslator.probation_override_value.params));
      EXPORT string5 industry_class := STD.Str.ToUpperCase(TRIM(gm.industryclass, LEFT, RIGHT));
      EXPORT string32 application_type := AutoStandardI.InterfaceTranslator.application_type_val.val(project(gm,AutoStandardI.InterfaceTranslator.application_type_val.params));
      EXPORT boolean no_scrub := AutoStandardI.InterfaceTranslator.no_scrub.val(project(gm,AutoStandardI.InterfaceTranslator.no_scrub.params));
      EXPORT unsigned3 date_threshold := AutoStandardI.InterfaceTranslator.dateVal.val(project(gm,AutoStandardI.InterfaceTranslator.dateVal.params));
      EXPORT boolean suppress_dmv := gm.SuppressDMVInfo;
      EXPORT unsigned1 lexid_source_optout := gm.LexIdSourceOptout;
      // "unsigned", so that we could accommodate different log levels, if needed
      EXPORT boolean log_record_source := gm.LogRecordSource AND ((unsigned)thorlib.getenv ('LogRecordSource', '1') > 0);
      EXPORT boolean show_minors := gm.IncludeMinors OR (glb_auto = 2);
      EXPORT string ssn_mask := AutoStandardI.InterfaceTranslator.ssn_mask_value.val(project(gm,AutoStandardI.InterfaceTranslator.ssn_mask_value.params));
      EXPORT unsigned1 dl_mask :=  AutoStandardI.InterfaceTranslator.dl_mask_val.val(project(gm,AutoStandardI.InterfaceTranslator.dl_mask_val.params));
      EXPORT unsigned1 dob_mask := AutoStandardI.InterfaceTranslator.dob_mask_value.val(project(gm,AutoStandardI.InterfaceTranslator.dob_mask_value.params));
      EXPORT unsigned1 reseller_type := AutoStandardI.InterfaceTranslator.reseller_type_value.val(project(gm,AutoStandardI.InterfaceTranslator.reseller_type_value.params));;
      EXPORT unsigned1 intended_use := AutoStandardI.InterfaceTranslator.intended_use_value.val(project(gm,AutoStandardI.InterfaceTranslator.intended_use_value.params));
      EXPORT string transaction_id := if(gm.TransactionID <> '', gm.TransactionID, gm.BatchUID);
      EXPORT unsigned6 global_company_id := gm.GlobalCompanyId;
    END;
    RETURN access;
  ENDMACRO;

  //Temporary: a macro copying new-style compliance parameters to the old one;
  //can be convenient for creating a module of AutoStandardI.PermissionI_Tools.params type from mod_access
  EXPORT MAC_CopyComplianceValuesToLegacy (mod) := MACRO
    EXPORT boolean AllowAll  := mod.unrestricted = doxie.compliance.ALLOW.ALL;
    EXPORT boolean AllowGLB  := mod.unrestricted & doxie.compliance.ALLOW.GLB > 0;
    EXPORT boolean AllowDPPA := mod.unrestricted & doxie.compliance.ALLOW.DPPA > 0;
    EXPORT unsigned1 GLBPurpose := mod.glb;
    EXPORT unsigned1 DPPAPurpose := mod.dppa;
    EXPORT string DataPermissionMask := mod.DataPermissionMask;
    EXPORT string DataRestrictionMask := mod.DataRestrictionMask;
    EXPORT boolean lnbranded := mod.ln_branded;
    EXPORT string5 IndustryClass := mod.industry_class;
    EXPORT string32 ApplicationType := mod.application_type;
    EXPORT unsigned3 dateval := mod.date_threshold;
    EXPORT boolean IncludeMinors := mod.show_minors;
    EXPORT string6 ssn_mask := mod.ssn_mask;
    EXPORT boolean mask_dl := mod.dl_mask = 1;
    EXPORT unsigned1 dob_mask := mod.dob_mask;
    //... there are some others available as well: probation_override_value, no_scrub, suppress_dmv, etc.
    //These are not defined in IDataAccess, so, if required, the must be re-defined after this macro call:
    EXPORT boolean ignoreFares    := FALSE;
    EXPORT boolean ignoreFidelity := FALSE;
  ENDMACRO;

  //assign module's fields one-by-one from existing mod_access-compatible module
  EXPORT MAC_CopyModAccessValues (mod) := MACRO
      EXPORT unsigned1 unrestricted := mod.unrestricted;
      EXPORT unsigned1 glb := mod.glb;
      EXPORT unsigned1 dppa := mod.dppa;
      EXPORT string DataPermissionMask := mod.DataPermissionMask;
      EXPORT string DataRestrictionMask := mod.DataRestrictionMask;
      EXPORT boolean ln_branded := mod.ln_branded;
      EXPORT boolean probation_override := mod.probation_override;
      EXPORT string5 industry_class := mod.industry_class;
      EXPORT string32 application_type := mod.application_type;
      EXPORT boolean no_scrub := mod.no_scrub;
      EXPORT unsigned3 date_threshold := mod.date_threshold;
      EXPORT boolean suppress_dmv := mod.suppress_dmv;
      EXPORT unsigned1 lexid_source_optout := mod.lexid_source_optout;
      EXPORT boolean log_record_source := mod.log_record_source;
      EXPORT boolean show_minors := mod.show_minors;
      EXPORT string ssn_mask := mod.ssn_mask;
      EXPORT unsigned1 dl_mask :=  mod.dl_mask;
      EXPORT unsigned1 dob_mask := mod.dob_mask;
      EXPORT unsigned1 reseller_type := mod.reseller_type;
      EXPORT unsigned1 intended_use := mod.intended_use;
      EXPORT string transaction_id := mod.transaction_id;
      EXPORT unsigned6 global_company_id :=mod.global_company_id;
  ENDMACRO;

  shared restrictedSet := ['0',''];
  // ==============================================================================================
  //          Restrictions based on DRM.
  //          Most of these restrictions can be by-passed if "allow all" is requested.
  // ==============================================================================================
  // EXPORT FARES := (~allow and fixed_DRM[1]<>'0') OR in_mod.ignoreFares; // Fares=property data
  EXPORT boolean isQsentRestricted       (string drm) := drm[2]<>'0'; // QSent = realtime phones gateway
  EXPORT boolean isEBRRestricted         (string drm) := drm[3] NOT IN restrictedSet; // EBR=Experian Business Reports
  // EXPORT WH     := ~allow and fixed_DRM[4]<>'0'; // WH=Weekly header
  // EXPORT Fidelity := (~allow and (fixed_DRM[5] not in ['0',''])) OR in_mod.ignoreFidelity;

  // The "Fidelity" clause above differs from the other due to a need for
  // backward compatibility.  For property testing, at least, its been fairly
  // common to set DataRestrictionMask=0 to indicate "I want everything".  To
  // preserve that, I had to include the empty string comparison when I added
  // the Fidelity clause.  I didnt feel comfortable changing the logic in the
  // other clauses to match that, because I have no way of knowing whose test
  // cases or database entries might be counting on the existing behavior to
  // remain _exactly_ as it is.

  EXPORT boolean isECHRestricted        (string drm) := drm[6] <> '0'; // ECH = Experian Credit Header data
  // CY = Certegy data
  // EXPORT CY := ~allowAll and (drm[7] NOT IN ['0','']);
  EXPORT boolean isEQCHRestricted       (string drm) := drm[8] NOT IN restrictedSet; //Equifax Credit Header data
  //Restricting CreditHeader data from being returned in the qsent gateway
  //EXPORT string1 RequestCredential := if(fixed_DRM[9] = '','0', fixed_DRM[9]);
  // TCH = Transunion Credit Header data
  EXPORT boolean isTCHRestricted        (string drm) := drm[10] NOT IN restrictedSet;
  EXPORT boolean isTTRestricted         (string drm) := drm[11] NOT IN restrictedSet; //TeleTrack, a.k.a. TT
  EXPORT boolean isAdvoRestricted       (string drm) := drm[12] NOT IN restrictedSet;
  EXPORT boolean isInfutorMVRestricted  (string drm) := drm[17] NOT IN restrictedSet;
  EXPORT boolean isPhoneFinderTargusRestricted  (string drm) := drm[20] NOT IN restrictedSet;  //Targus gateway for phone finder
  EXPORT boolean isPreGLBRestricted     (string drm) := drm[23] NOT IN restrictedSet; //customer can see GLB protected data prior to June 2001
  EXPORT boolean isPhoneMartRestricted  (string drm) := drm[24] NOT IN restrictedSet; //Equifax (PhoneMart) phones
  EXPORT boolean isFdnInquiry           (string drm) := drm[25] not in restrictedSet;
  EXPORT boolean isJuliRestricted       (string drm) := drm[41] NOT IN restrictedSet;
  EXPORT boolean isAccuDataRestricted   (string drm) := drm[44] not in restrictedSet;
  EXPORT BOOLEAN isBriteVerifyRestricted(string drm) := drm[46] NOT IN restrictedSet; // BriteVerify gateway for Email verification
  // ----------------------------------------------------------------------------------------------

  // TODO: functions for checking access; they should be defined in a separate attribute
  //       (I probably want to replace existing permission Tools)
  shared tools := AutoStandardI.PermissionI_Tools;
	shared RNA_GLB_Set := tools.RNA_GLB_Set; //[0, 1, 3, 12];
	shared RNA_DPPA_Set := tools.RNA_DPPA_Set;//[0, 2, 3, 5, 7];

  shared minVal := 1;
  shared maxVal := 7;

  // Restrictions set: if purpose is here, the data are restricted
  EXPORT is_glb_RNA (unsigned1 purpose) := purpose in RNA_GLB_Set;
  EXPORT is_dppa_RNA (unsigned1 purpose) := purpose in RNA_DPPA_Set;

  EXPORT boolean glb_ok  (unsigned1 purpose, boolean RNA=false, unsigned1 unr = 0) :=
           ((purpose >= minVal and purpose <= maxVal) or purpose in [11, 12] or (unr & ALLOW.GLB = ALLOW.GLB)) AND // glb is fine
           ~(RNA AND is_glb_RNA(purpose));                                               // not restricted for relatives

  EXPORT boolean dppa_ok (unsigned1 purpose, boolean RNA=false, unsigned1 unr = 0) :=
           ((purpose >= minVal and purpose <= maxVal) or (unr & ALLOW.DPPA = ALLOW.DPPA)) AND // dppa is fine
           ~(RNA AND is_dppa_RNA(purpose));                                      // not restricted for relatives

  EXPORT boolean dppa_state_ok (string2 st, unsigned1 d, string2 header_source='', string2 source_code='', unsigned1 unr = 0) := FUNCTION
    isExperian := (MDR.sourceTools.SourceIsExperianVehicle (header_source) OR // old *E, but not DE or FE
                   MDR.sourceTools.SourceIsExperianVehicle(source_code) OR // old AE
                   MDR.sourceTools.SourceIsExperianDL(source_code));  // old AX

    strfn := IF (isExperian, 'EXPERIAN-DL-PURPOSE', 'DL-PURPOSE');

    valid_state_dppa := ~EXISTS (codes.Key_Codes_V3 (KEYED (file_name='GENERAL'), KEYED (field_name=strfn),
                                                     KEYED (field_name2=st), KEYED (code=(STRING1)d)));

    //((userPermission = constantAllowValue) OR (restrictionNotFound and userPermissionIsValid))
    RETURN (unr & ALLOW.DPPA = ALLOW.DPPA) OR (valid_state_dppa AND dppa_ok (d));
  END;

  shared dateEffective := 200106;

  shared dateOK (unsigned3 nonglb_last_seen, unsigned3 first_seen) :=
           (nonglb_last_seen <> 0 or (first_seen <= dateEffective and first_seen > 0));

  EXPORT SrcNeverRestricted (string2 src) := src NOT IN mdr.sourcetools.set_GLB;
  shared SrcAlwaysRestricted (string2 src) := src IN mdr.sourcetools.set_AlwaysGLB;

  EXPORT HeaderIsPreGLB (unsigned3 nonglb_last_seen, unsigned3 first_seen, string2 src, string drm) :=
    MAP (SrcAlwaysRestricted (src) => FALSE,
         SrcNeverRestricted (src) => TRUE,
         isPreGLBRestricted (drm) => FALSE,
         dateOK (nonglb_last_seen, first_seen));

  //SrcOk from ut/PermissionTools; has DRM in addition to other parameters
  EXPORT boolean source_ok (unsigned1 purpose, string drm, string2 src, unsigned3 first_seen = 0, unsigned3 nonglb_last_seen = 0) :=
                   glb_ok(purpose) OR HeaderIsPreGLB(nonglb_last_seen, first_seen, src, drm);

  EXPORT boolean minor_ok (unsigned1 age, boolean ok_to_show_minors) := //aka minorOK
				ok_to_show_minors OR (age = 0) or (age >= 18);


  EXPORT MAC_FilterOutMinors (inrec, didfield = 'did', dobfield = '?', ok_to_show_minors) := FUNCTIONMACRO
      IMPORT dx_header, ut;

    // need to check for minors on zero DIDs that have a valid DOB.
    // if input layout to the macro doesn't contain a DOB field, just let the
    // zero DIDs pass through
    #IF (#TEXT(dobfield) <> '?')
      local j0 := inrec ((unsigned6)didfield = 0 and ((unsigned8)dobfield = 0 or ut.age ((unsigned4) dobfield) >= 18));
    #ELSE
      local j0 := inrec ((unsigned6)didfield = 0);
    #END

    local jj := JOIN (inrec((unsigned6)didfield > 0), dx_header.key_minors_hash(),
                     KEYED (hash32((unsigned6)LEFT.didfield)=RIGHT.hash32_did) AND
                     KEYED ((unsigned6)LEFT.didfield = RIGHT.did) AND  //at build time, key contains only minors
                     ut.age (RIGHT.dob) < 18,            //check age since a few will turn 18 between builds
                     TRANSFORM (RECORDOF(inrec), SELF := LEFT),
                     LEFT ONLY);

    RETURN IF (ok_to_show_minors, inrec, jj + j0);
  ENDMACRO;


  EXPORT boolean isHeaderSourceRestricted (string src, string drm) := MAP (
      MDR.sourceTools.SourceIsExperian_Credit_Header (src) => isECHRestricted(drm),
      MDR.sourceTools.SourceIsTransUnion_Credit_Header (src) => isTCHRestricted(drm),
      MDR.sourceTools.SourceIsEquifax (src) => isEQCHRestricted(drm),
      FALSE);


// This macro will be used to conditionally remove records for certain source(s) from an
// input file based upon the contents of a specific field within the input file and
// based upon the passed-in Data Restriction Mask (DRM).
  EXPORT MAC_FilterSources (infile, src_field='src', drm) := FUNCTIONMACRO
    RETURN infile (NOT doxie.compliance.isHeaderSourceRestricted (src_field, drm));
  ENDMACRO;

  // ==============================================================================================
  //          Restrictions based on DPM.
  // ==============================================================================================
  // NOTE: These are all the DPM bit positions definitions, as of 02/10/2021 per Sam Mathe in MBS Engineering, with Roxie 
  //       engineer's comment added as to which ones are used in Roxie by below or by AutoStandardI.DataPermissionI
  // BIT  1 => qsent    // in-house(not gateway) qsent data
  // BIT  2 => targus   // targus gateway
  // BIT  3 => confirm  // confirm if phone is active (typically, through gateway call)
  // BIT  4 => PVS
  // BIT  5 => LE
  // BIT  6 => LastResort
  // BIT  7 => Polk
  // BIT  8 => MidexNonpublic
  // BIT  9 => MidexFreddieMac
  // BIT 10 => DeathMasterSSAUpdates
  // BIT 11 => FDNContributoryData  //Contributory Fraud and Test Fraud
  // BIT 12 => SBFEData
  // BIT 13 => InsuranceDLData
  // BIT 14 => ABMS                                 // In MBS, but not used in Roxie
  // BIT 15 => DMD Email                            // In MBS, but not used in Roxie
  // BIT 16 => HIBCC                                // In MBS, but not used in Roxie
  // BIT 17 => StateLicenseAddress                  // In MBS, but not used in Roxie
  // BIT 18 => StateLicenseLicNbr                   // In MBS, but not used in Roxie
  // BIT 19 => Surescripts                          // In MBS, but not used in Roxie
  // BIT 20 => TrisContributoryData
	// BIT 21 => ZumigoIdentity
  // BIT 22 => reserved for HealthLinkDimensions    // In MBS, but not used in Roxie
  // BIT 23 => EquifaxAcctDecisioning
  // BIT 24 => AccuityBankData
  // BIT 25 => DMD MeNbr                            // In MBS, but not used in Roxie
  // BIT 26 => Symphony                             // In MBS, but not used in Roxie
  // BIT 27 => SKA                                  // In MBS, but not used in Roxie
  // BIT 28 => DnB
  // BIT 29 => DHC                                  // In MBS, but not used in Roxie
  // BIT 30 => Strenuus                             // In MBS, but not used in Roxie
  // BIT 31 => StrenuusHIX                          // In MBS, but not used in Roxie
  // BIT 32 => NCPDPFull                            // In MBS, but not used in Roxie
  // BIT 33 => AHAFull                              // In MBS, but not used in Roxie
  // BIT 34 => FedExData
  // BIT 35 => GS1                                  // In MBS, but not used in Roxie
  // BIT 36 => CitizenshipScore, but now deprecated // In MBS, but not used in Roxie
  // BIT 37 => iConectiv PortData Comply
  // BIT 38 => iConectiv PortData Validate
  EXPORT boolean use_qsent(string dpm)               := dpm [1] NOT IN restrictedSet; // use in-house(not gateway) qsent data
  EXPORT boolean use_targus(string dpm)              := dpm [2] NOT IN restrictedSet; // use targus gateway
  EXPORT boolean use_confirm(string dpm)             := dpm [3] NOT IN restrictedSet; // confirm if phone is active (typically, thorugh gateway call)
  EXPORT boolean use_LastResort(string dpm)          := dpm [6] NOT IN restrictedSet;
  EXPORT boolean use_Polk(string dpm)                := dpm [7] NOT IN restrictedSet;
  EXPORT boolean use_DM_SSA_updates(string dpm)      := dpm[10] NOT IN restrictedSet;
  EXPORT boolean use_FdnContributoryData(string dpm) := dpm[11] NOT IN restrictedSet;	//Contributory Fraud and Test Fraud
  EXPORT boolean use_InsuranceDLData(string dpm)     := dpm[13] NOT IN restrictedSet;
  EXPORT boolean use_ZumigoIdentity(string dpm)      := dpm[21] NOT IN restrictedSet;
  EXPORT boolean use_AccuityBankData(string dpm)     := dpm[24] NOT IN restrictedSet;
  EXPORT boolean use_DnB(string dpm)                 := dpm[28] NOT IN restrictedSet;
  EXPORT boolean use_WDNC(string dpm)                 := dpm[37] NOT IN restrictedSet;
  EXPORT boolean use_IconectivPortDataValidate(string dpm) := dpm[38] NOT IN restrictedSet;  // iconectiv phone porting data for Law Enforcement(LE)

  // ----------------------------------------------------------------------------------------------
  EXPORT boolean isBusHeaderSourceAllowed (string src, string dpm, string drm) := MAP (
    MDR.sourceTools.SourceIsDunn_Bradstreet (src) => use_DnB(dpm),
    MDR.sourceTools.SourceIsEBR (src) => NOT isEBRRestricted(drm),    
  TRUE);

    // to exclude utility sources:
    EXPORT isUtilityRestricted(string _industry) := _industry = 'UTILI' OR _industry='DRMKT';

  // NOTE: CCPA logging will likely be deprecated. Just commenting the calls below out for now, pending final decision for removal.

  // CCPA logging
  EXPORT logSoldToSources(ds_in, mod_access, did_field='did') := MACRO
    #uniquename(dummy); %dummy% := 0; // just to make ECL compiler happy.
    //doxie.log.logSoldToSources(ds_in, mod_access, did_field);
  ENDMACRO;

  // CCPA logging
  EXPORT logSoldToTransaction(mod_access, env_flag = data_services.data_env.iNonFCRA) := FUNCTIONMACRO
    RETURN doxie.log.logSoldToTransaction(mod_access, env_flag);
  ENDMACRO;

  // Marketing Restrictions
  EXPORT isMarketingAllowed(string src, string st = '') := FUNCTION
    Boolean  isAllowed := NOT (src = MDR.sourceTools.src_LnPropV2_Lexis_Asrs       AND st IN ['ID','IL','KS','NM','SC','WA', '']) AND
                          NOT (src = MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs AND st IN ['ID','IL','KS','NM','SC','WA', '']) AND
                          EXISTS(Codes.Key_Codes_V3(KEYED(file_name = 'VENDOR_SOURCES') AND
                                                  KEYED(field_name= 'DIRECTMARKETING') AND
                                                  KEYED(field_name2 = 'SCODE') AND
                                                  KEYED(code = src)));
    RETURN isAllowed;

    END;

  EXPORT Boolean isDirectMarketing(String _industry_class) := STD.Str.ToUpperCase(_industry_class) = 'DRMKT';

END;
