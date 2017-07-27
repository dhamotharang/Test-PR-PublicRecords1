IMPORT iesp, doxie, DriversV2_Services;

out_rec := iesp.driverlicense2.t_DLEmbeddedReport2Record;

EXPORT out_rec DL_records (
  DATASET(doxie.layout_references) dids,
  input.dl in_params = MODULE(input.dl) END,
  BOOLEAN IsFCRA = FALSE
) := FUNCTION

	dlRaw := DriversV2_Services.DLRaw.wide_view.by_did(dids);

  RETURN iesp.transform_dl(PROJECT(dlRaw,DriversV2_Services.layouts.result_wide));
END;
