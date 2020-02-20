IMPORT $, iesp, FaaV2_Services, doxie, fcra, FFD;

EXPORT iesp.faaaircraft_fcra.t_FcraAircraftReportRecord aircraft_records (
  DATASET (doxie.layout_references) dids,
  $.IParam.aircrafts in_params = MODULE ($.IParam.aircrafts) END,
  boolean IsFCRA = FALSE,
	DATASET (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim
) := FUNCTION

  // this is new service, ESP-compliant already
	ids := project (FaaV2_Services.raw.ByDids (dids, isFCRA), FaaV2_Services.layouts.search_id);
	
	recs := FaaV2_Services.raw.getFullAircraft(ids, in_params.application_type, isFCRA, flagfile, TRUE, slim_pc_recs, in_params.FFDOptionsMask);
	aircrafts := FaaV2_Services.Functions.fnfaaReportval(recs);  //layout
	aircrafts_final := project(aircrafts, iesp.faaaircraft_fcra.t_FcraAircraftReportRecord); // FFD 
	
  RETURN aircrafts_final;
END;
