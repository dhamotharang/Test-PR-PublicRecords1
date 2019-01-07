IMPORT Text_Search,doxie,STD;
EXPORT Get_Vehicle_Records(VehicleV2_Services.IParam.searchParams aInputData, BOOLEAN returnIesp=TRUE) := MODULE

  EXPORT sorted_vehs := VehicleV2_Services.SearchRecords.getVehicleRecords(aInputData);
	EXPORT truncated := VehicleV2_Services.SearchServiceIds(aInputData).is_truncated;
	trunc_cnt_local := VehicleV2_Services.SearchServiceIds(aInputData).truncated_cnt;
	trunc_cnt_RT := COUNT(sorted_vehs(datasource = VehicleV2_Services.Constant.Realtime_val_out));
	polkMod := MODULE(PROJECT(aInputData, VehicleV2_Services.IParam.polkParams)) END;
	datasource := TRIM(STD.Str.ToUpperCase(
		VehicleV2_Services.Functions.getSearchDataSource(polkMod,aInputData.doCombinedSearch)));
	EXPORT trunc_cnt := MAP(datasource = VehicleV2_Services.constant.realtime_val => trunc_cnt_RT,
													datasource = VehicleV2_Services.constant.ALL_val => trunc_cnt_local+trunc_cnt_RT,
													trunc_cnt_local);

	nonIespOutput := IF(returnIesp,DATASET([],VehicleV2_Services.Layout_Report),sorted_vehs);

	MaxResults_val := aInputData.maxresultsVal;
	SkipRecords_val := IF(truncated,0,aInputData.skiprecordsVal);
	MaxResultsThisTime_val := aInputData.maxresultsthistimeVal;

	Text_Search.MAC_Append_ExternalKey(nonIespOutput,sorted_vehs2,l.Vehicle_Key+l.Iteration_Key+l.Sequence_Key);

	doxie.MAC_Marshall_Results_NoCount(sorted_vehs2,marshalled_recs);
	EXPORT marshalledRecs := marshalled_recs;

	recordsForIesp := IF(returnIesp,sorted_vehs,DATASET([],VehicleV2_Services.Layout_Report));
	EXPORT iespResults := VehicleV2_Services.Functions.transform_vehicles(recordsForIesp);

END;
