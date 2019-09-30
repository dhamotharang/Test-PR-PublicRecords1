IMPORT $, iesp, doxie;

out_rec := iesp.proflicense.t_ProviderRecord;

EXPORT out_rec providers_records (
  DATASET(doxie.layout_references) dids,
  $.IParam.providers in_params = MODULE($.IParam.providers) END, //currently, a placeholder
  BOOLEAN IsFCRA = FALSE
) := FUNCTION

	prov_recs := doxie.ING_provider_report_recordsbyDid(dids);

  RETURN iesp.transform_medproviders(prov_recs);
END;
