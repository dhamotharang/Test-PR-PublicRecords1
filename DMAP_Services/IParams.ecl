IMPORT AutoStandardI, ut, suppress;

gm:= AutoStandardI.GlobalModule();

EXPORT IParams := MODULE

EXPORT ReportParams := INTERFACE
  EXPORT UNSIGNED1 glba := 0;
  EXPORT UNSIGNED1 dppa := 0;
  EXPORT STRING dpm := AutoStandardI.Constants.DataPermissionMask_default;
  EXPORT STRING drm := AutoStandardI.Constants.DataRestrictionMask_default;
  EXPORT STRING5 industry_class := '';
  EXPORT STRING6 ssn_mask_val := 'NONE'; 
  EXPORT UNSIGNED1 dob_mask_val := suppress.constants.dateMask.NONE;
	EXPORT BOOLEAN probation_override_value := FALSE;
  EXPORT BOOLEAN IncludeModel:= TRUE; 	
	EXPORT BOOLEAN IncludeReport:= TRUE;	
	EXPORT BOOLEAN glb_ok:= FALSE;
	EXPORT BOOLEAN dppa_ok:= FALSE;
  EXPORT BOOLEAN isUtility:=  FALSE;
  
END;

  EXPORT get_Params() := FUNCTION
  
		in_mod := MODULE(ReportParams)
			EXPORT UNSIGNED1 dob_mask_val:= AutoStandardI.InterfaceTranslator.dob_mask_value.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.dob_mask_value.params));
			EXPORT STRING6 ssn_mask_val := AutoStandardI.InterfaceTranslator.ssn_mask_value.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.ssn_mask_value.params));
			EXPORT STRING drm := gm.DataRestrictionMask;
			EXPORT STRING dpm := gm.DataPermissionMask;
			EXPORT UNSIGNED1 GLBA:= AutoStandardI.InterfaceTranslator.GLB_Purpose.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.GLB_Purpose.params));	
			EXPORT UNSIGNED1 DPPA:= AutoStandardI.InterfaceTranslator.DPPA_Purpose.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.DPPA_Purpose.params));	
			EXPORT BOOLEAN probation_override_value:= AutoStandardI.InterfaceTranslator.probation_override_value.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.probation_override_value.params));
			EXPORT STRING5 industry_class:= AutoStandardI.InterfaceTranslator.industry_class_val.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.industry_class_val.params));
			EXPORT BOOLEAN isUtility:=  ut.IndustryClass.Is_Utility;
			EXPORT BOOLEAN glb_ok:= ut.glb_ok(GLBA);
			EXPORT BOOLEAN dppa_ok:= ut.dppa_ok(DPPA);
		END;	
   
   RETURN in_mod;
  END;

END;