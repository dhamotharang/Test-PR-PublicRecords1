IMPORT iesp, doxie, SexOffender_Services;

out_rec := iesp.sexualoffender.t_SexOffReportRecord;

EXPORT out_rec SexOffenses_records (
  DATASET(doxie.layout_references) dids,
  $.IParam.sexoffenses in_params = MODULE($.IParam.sexoffenses) END,
  BOOLEAN IsFCRA = FALSE
) := FUNCTION

	tmpMod := MODULE(PROJECT(in_params,SexOffender_Services.IParam.report, opt))
		EXPORT STRING14 did := (STRING)dids[1].did;
	END;

	RETURN SexOffender_Services.ReportRecords.val(tmpMod);
END;
