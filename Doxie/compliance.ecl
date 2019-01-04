IMPORT AutoStandardI, mdr, codes;

EXPORT compliance := MODULE
 
  // from doxie.mac_header_field_declare() -- i.e. translated
  EXPORT GetGlobalDataAccessModule () := FUNCTIONMACRO
    // a hack: DPM and DRM are not provided
    local gm := AutoStandardI.GlobalModule();
    local access := MODULE (doxie.IDataAccess)
      EXPORT unsigned1 glb := GLB_Purpose;
      EXPORT unsigned1 dppa := DPPA_Purpose;
      EXPORT string DataPermissionMask := gm.DataPermissionMask;
      EXPORT string DataRestrictionMask := gm.DataRestrictionMask;
      EXPORT boolean ln_branded := ln_branded_value;
      EXPORT boolean probation_override := probation_override_value;
      EXPORT string5 industry_class := industry_class_value;
      EXPORT string32 application_type := application_type_value;
      EXPORT boolean no_scrub := ^.no_scrub;
      EXPORT unsigned3 date_threshold := dateVal;
      EXPORT boolean suppress_dmv := suppressDMVInfo_value;
      EXPORT boolean show_minors := gm.IncludeMinors OR (GLB_Purpose = 2);
      EXPORT string ssn_mask := ssn_mask_value;
      EXPORT unsigned1 dl_mask :=  dl_mask_val;
      EXPORT unsigned1 dob_mask := dob_mask_value;
    END;
    RETURN access;
  ENDMACRO;

  // from global module -- needs translations
  EXPORT GetGlobalDataAccessModuleTranslated (gm) := FUNCTIONMACRO
    IMPORT doxie, AutoStandardI;
    local glb_auto := AutoStandardI.InterfaceTranslator.GLB_Purpose.val(project(gm,AutoStandardI.InterfaceTranslator.GLB_Purpose.params));
    local access := MODULE (doxie.IDataAccess)
      EXPORT unsigned1 glb := glb_auto;
      EXPORT unsigned1 dppa := AutoStandardI.InterfaceTranslator.DPPA_Purpose.val(project(gm,AutoStandardI.InterfaceTranslator.DPPA_Purpose.params));
      EXPORT string DataPermissionMask := gm.DataPermissionMask;
      EXPORT string DataRestrictionMask := gm.DataRestrictionMask;
      EXPORT boolean ln_branded := AutoStandardI.InterfaceTranslator.ln_branded_value.val(project(gm,AutoStandardI.InterfaceTranslator.ln_branded_value.params));
      EXPORT boolean probation_override := AutoStandardI.InterfaceTranslator.probation_override_value.val(project(gm,AutoStandardI.InterfaceTranslator.probation_override_value.params));
      EXPORT string5 industry_class := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(gm,AutoStandardI.InterfaceTranslator.industry_class_val.params));
      EXPORT string32 application_type := AutoStandardI.InterfaceTranslator.application_type_val.val(project(gm,AutoStandardI.InterfaceTranslator.application_type_val.params));
      EXPORT boolean no_scrub := AutoStandardI.InterfaceTranslator.no_scrub.val(project(gm,AutoStandardI.InterfaceTranslator.no_scrub.params));
      EXPORT unsigned3 date_threshold := AutoStandardI.InterfaceTranslator.dateVal.val(project(gm,AutoStandardI.InterfaceTranslator.dateVal.params));
      EXPORT boolean suppress_dmv := gm.SuppressDMVInfo;
      EXPORT boolean show_minors := gm.IncludeMinors OR (glb_auto = 2);
      EXPORT string ssn_mask := AutoStandardI.InterfaceTranslator.ssn_mask_value.val(project(gm,AutoStandardI.InterfaceTranslator.ssn_mask_value.params));
      EXPORT unsigned1 dl_mask :=  AutoStandardI.InterfaceTranslator.dl_mask_val.val(project(gm,AutoStandardI.InterfaceTranslator.dl_mask_val.params));
      EXPORT unsigned1 dob_mask := AutoStandardI.InterfaceTranslator.dob_mask_value.val(project(gm,AutoStandardI.InterfaceTranslator.dob_mask_value.params));
    END;
    RETURN access;
  ENDMACRO;

  // TODO: functions for checking access; they should be defined in a separate attribute
  //       (I probably want to replace existing permission Tools)
  shared tools := AutoStandardI.PermissionI_Tools;

  shared minVal := 1;
  shared maxVal := 7;
  shared allow  := 255;

	shared RNA_GLB_Set := tools.RNA_GLB_Set; //[0, 1, 3, 12];  
	shared RNA_DPPA_Set := tools.RNA_DPPA_Set;//[0, 2, 3, 5, 7];

  // Restrictions set: if purpose is here, the data are restricted
  EXPORT is_glb_RNA (unsigned1 purpose) := purpose in RNA_GLB_Set;
  EXPORT is_dppa_RNA (unsigned1 purpose) := purpose in RNA_DPPA_Set;

  EXPORT boolean glb_ok  (unsigned1 purpose, boolean RNA=false) := 
           ((purpose >= minVal and purpose <= maxVal) or purpose in [11, 12, allow]) AND // glb is fine
           ~(RNA AND is_glb_RNA(purpose));                                               // not restricted for relatives 

  EXPORT boolean dppa_ok (unsigned1 purpose, boolean RNA=false) := 
           ((purpose >= minVal and purpose <= maxVal) or purpose in [allow]) AND // dppa is fine 
           ~(RNA AND is_dppa_RNA(purpose));                                      // not restricted for relatives 

  EXPORT boolean dppa_state_ok (string2 st, unsigned1 d, string2 header_source='', string2 source_code='') := FUNCTION
    isExperian := (MDR.sourceTools.SourceIsExperianVehicle (header_source) OR // old *E, but not DE or FE
                   MDR.sourceTools.SourceIsExperianVehicle(source_code) OR // old AE
                   MDR.sourceTools.SourceIsExperianDL(source_code));  // old AX
				
    strfn := IF (isExperian, 'EXPERIAN-DL-PURPOSE', 'DL-PURPOSE');

    valid_state_dppa := ~EXISTS (codes.Key_Codes_V3 (KEYED (file_name='GENERAL'), KEYED (field_name=strfn),
                                                     KEYED (field_name2=st), KEYED (code=(STRING1)d)));

    //((userPermission = constantAllowValue) OR (restrictionNotFound and userPermissionIsValid))
    RETURN (d = allow) OR (valid_state_dppa AND dppa_ok (d));
  END;

  shared dateEffective := 200106;

  shared dateOK (unsigned3 nonglb_last_seen, unsigned3 first_seen) :=
           (nonglb_last_seen <> 0 or (first_seen <= dateEffective and first_seen > 0)); 
  EXPORT SrcNeverRestricted (string2 src) := src NOT IN mdr.sourcetools.set_GLB;
  shared SrcAlwaysRestricted (string2 src) := src IN mdr.sourcetools.set_AlwaysGLB;

  EXPORT HeaderIsPreGLB (unsigned3 nonglb_last_seen, unsigned3 first_seen, string2 src, string DataRestrictionMask) := 
    MAP (SrcAlwaysRestricted (src) => FALSE,
         SrcNeverRestricted (src) => TRUE,
         DataRestrictionMask[23] = '1' => FALSE, //restrictPreGLB in AutostandardI/DataRestrictionI
         dateOK (nonglb_last_seen, first_seen));


  EXPORT MAC_FilterOutMinors (inrec, didfield = 'did', dobfield = '?', ok_to_show_minors) := FUNCTIONMACRO
      IMPORT doxie_files, ut;
      
    // need to check for minors on zero DIDs that have a valid DOB.
    // if input layout to the macro doesn't contain a DOB field, just let the 
    // zero DIDs pass through
    #IF (#TEXT(dobfield) <> '?')
      local j0 := inrec ((unsigned6)didfield = 0 and ((unsigned8)dobfield = 0 or ut.age ((unsigned4) dobfield) >= 18));
    #ELSE
      local j0 := inrec ((unsigned6)didfield = 0);
    #END
        
    local j := JOIN (inrec((unsigned6)didfield > 0), doxie_files.key_minors_hash,
                     KEYED (hash32((unsigned6)LEFT.didfield)=RIGHT.hash32_did) AND
                     KEYED ((unsigned6)LEFT.didfield = RIGHT.did) AND  //at build time, key contains only minors
                     ut.age (RIGHT.dob) < 18,            //check age since a few will turn 18 between builds
                     TRANSFORM (RECORDOF(inrec), SELF := LEFT),
                     LEFT ONLY);
        
    RETURN IF (ok_to_show_minors, inrec, j + j0);
  ENDMACRO;

  //TODO: temporarily: I don't know if it should be passed into the functions below,
  // or checked by caller instead.
  shared boolean allowAll := FALSE;


    // EXPORT FARES := (~allow and fixed_DRM[1]<>'0') OR in_mod.ignoreFares; // Fares=property data
    // EXPORT QSENT := ~allow and fixed_DRM[2]<>'0'; // QSent = realtime phones gateway
    // EXPORT EBR   := ~allow and fixed_DRM[3]<>'0'; // EBR=Experian Business Reports
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

    shared drm_type := string;
    // ECH = Experian Credit Header data
    EXPORT boolean isECHRestricted (drm_type drm) := ~allowAll AND (drm[6] <> '0');
    //EXPORT boolean ECH := isECHRestricted(drm);    
    // CY = Certegy data
    // EXPORT CY := ~allowAll and (drm[7] NOT IN ['0','']);
    // EQ = Equifax Credit Header data
    EXPORT boolean isEQCHRestricted(drm_type drm) := ~allowAll AND (drm[8] NOT IN ['0','']);  
    //EXPORT boolean EQ := isEQCHRestricted(drm);
    //Restricting CreditHeader data from being returned in the qsent gateway
    //EXPORT string1 RequestCredential := if(fixed_DRM[9] = '','0', fixed_DRM[9]);    
    // TCH = Transunion Credit Header data
    EXPORT boolean isTCHRestricted(drm_type drm) := ~allowAll AND (drm[10] NOT IN ['0','']);  
    //EXPORT boolean TCH := isTCHRestricted(drm);  

    EXPORT boolean isHeaderSourceRestricted (string src, drm_type drm) := MAP (
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



END;