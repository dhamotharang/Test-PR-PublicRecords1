IMPORT $, iesp, doxie, fcra, CCW_Services, AutoStandardI;

EXPORT iesp.concealedweapon.t_WeaponRecord CCW_records (
  dataset (doxie.layout_references) dids,
  $.IParam.ccw in_params = module ($.IParam.ccw) end,
  boolean IsFCRA = false,
	dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile
) := FUNCTION

  // CCW single-source implementation uses legacy-style input, i.e. global module, etc.,
  // so we need to copy all meaningful input options
  ccw_mod := module (project (AutoStandardI.GlobalModule (isFCRA), CCW_Services.SearchService_Records.params, opt))
    export unsigned1 GLB_Purpose := in_params.glb;
    export unsigned1 DPPA_Purpose := in_params.dppa;
    export string6 ssnmask := in_params.ssn_mask;
    export unsigned1 dlmask := in_params.dl_mask;
    EXPORT STRING5 IndustryClass := in_params.industry_class;
    // export string DataRestrictionMask := '000000000000000000000000';
    // export boolean IncludeMinors := false;
    // export string6 dobmask
    // export unsigned3 dateval := 0; // unsigned3 of 'YYYYMM';
    // export integer1 non_subject_suppression := suppress.Constants.NonSubjectSuppression.doNothing;
  end;

  // this call is:
  // -- not FCRA-safe: missing Dempcy features (freeze, etc.)
  // -- applies suppressions and masking
  ccw := PROJECT(CCW_Services.SearchService_Records.report (dids, ccw_mod, IsFCRA := FALSE), iesp.concealedweapon.t_WeaponRecord);
  return ccw;
end;
