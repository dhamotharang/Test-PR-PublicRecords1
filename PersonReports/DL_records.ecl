IMPORT $, iesp, doxie, DriversV2_Services;

out_rec := iesp.driverlicense2.t_DLEmbeddedReport2Record;

EXPORT out_rec DL_records (
  DATASET(doxie.layout_references) dids,
  $.IParam.dl in_params = MODULE($.IParam.dl) END, // currently, a placeholder
  BOOLEAN IsFCRA = FALSE
) := FUNCTION

	dlRaw := DriversV2_Services.DLRaw.wide_view.by_did(dids);

  RETURN iesp.transform_dl(PROJECT(dlRaw,DriversV2_Services.layouts.result_wide));
END;
