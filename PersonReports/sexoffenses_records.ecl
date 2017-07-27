IMPORT iesp, doxie, SexOffender_Services;

out_rec := iesp.sexualoffender.t_SexOffReportRecord;

EXPORT out_rec SexOffenses_records (
  DATASET(doxie.layout_references) dids,
  input.sexoffenses in_params = MODULE(input.sexoffenses) END,
  BOOLEAN IsFCRA = FALSE
) := FUNCTION

	tmpMod := MODULE(PROJECT(in_params,SexOffender_Services.IParam.report, opt))
		EXPORT STRING14 did := (STRING)dids[1].did;
    export string6 ssnmask := in_params.ssn_mask;
	END;

	RETURN SexOffender_Services.ReportRecords.val(tmpMod);
END;
