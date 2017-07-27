IMPORT iesp, doxie, fcra, CCW_Services, AutoStandardI;

EXPORT iesp.concealedweapon.t_WeaponRecord CCW_records (
  dataset (doxie.layout_references) dids,
  input.ccw in_params = module (input.ccw) end,
  boolean IsFCRA = false,
	dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile
) := FUNCTION

  // CCW single-source implementation uses legacy-style input, i.e. global module, etc.,
  // so we need to copy all meaningful input options
  ccw_mod := module (project (AutoStandardI.GlobalModule (isFCRA), CCW_Services.SearchService_Records.params, opt))
    export unsigned1 GLB_Purpose := in_params.GLBPurpose;
    export unsigned1 DPPA_Purpose := in_params.DPPAPurpose;
    export string6 ssnmask := in_params.ssn_mask;
    export unsigned1 dlmask := if (in_params.mask_dl, 1, 0);
		EXPORT STRING5 IndustryClass := AutoStandardI.InterfaceTranslator.industry_class_value.val (project(in_params,AutoStandardI.InterfaceTranslator.industry_class_value.params));
    // export string DataRestrictionMask := '000000000000000000000000';
    // export boolean IncludeMinors := false;
    // export string6 dobmask
    // export unsigned3 dateval := 0; // unsigned3 of 'YYYYMM';
    // export integer1 non_subject_suppression := suppress.Constants.NonSubjectSuppression.doNothing;
  end;

  // this call is: FCRA safe, applies suppressions and masking
  ccw := PROJECT(CCW_Services.SearchService_Records.report (dids, ccw_mod, IsFCRA, flagfile), iesp.concealedweapon.t_WeaponRecord);
  return ccw;
end;
