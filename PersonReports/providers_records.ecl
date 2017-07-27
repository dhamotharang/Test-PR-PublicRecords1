IMPORT iesp, doxie, Prof_LicenseV2_Services;

out_rec := iesp.proflicense.t_ProviderRecord;

EXPORT out_rec providers_records (
  DATASET(doxie.layout_references) dids,
  input.providers in_params = MODULE(input.providers) END,
  BOOLEAN IsFCRA = FALSE
) := FUNCTION

	prov_recs := doxie.ING_provider_report_recordsbyDid(dids);

  RETURN iesp.transform_medproviders(prov_recs);
END;
