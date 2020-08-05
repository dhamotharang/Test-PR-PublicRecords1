IMPORT FCRA, AutoStandardI;

EXPORT IParam := MODULE

  EXPORT report_params := INTERFACE(
    AutoStandardI.InterfaceTranslator.glb_purpose.params,
    AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
    FCRA.iRules)
    EXPORT BOOLEAN IncludeIncome := FALSE;
    EXPORT BOOLEAN IsRhodeIslandResident := FALSE;
  END;

END;
