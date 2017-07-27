IMPORT iesp, FaaV2_Services, doxie, fcra, FFD; 

EXPORT iesp.faaaircraft_fcra.t_FcraAircraftReportRecord aircraft_records (
  dataset (doxie.layout_references) dids,
  input.aircrafts in_params = module (input.aircrafts) end,
  boolean IsFCRA = false,
	dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim
) := FUNCTION

  // this is new service, ESP-compliant already
	ids := project (FaaV2_Services.raw.ByDids (dids, isFCRA), FaaV2_Services.layouts.search_id);
	
	recs := FaaV2_Services.raw.getFullAircraft(ids, in_params.applicationType, isFCRA, flagfile, true, slim_pc_recs, in_params.FFDOptionsMask);
	aircrafts := FaaV2_Services.Functions.fnfaaReportval(recs);  //layout
	aircrafts_final := project(aircrafts, iesp.faaaircraft_fcra.t_FcraAircraftReportRecord); // FFD 
	
  return aircrafts_final;
END;
