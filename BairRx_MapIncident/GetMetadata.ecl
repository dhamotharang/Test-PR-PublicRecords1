IMPORT BairRx_Common, BairRx_MapIncident, iesp;
EXPORT GetMetadata(DATASET(BairRx_Common.Layouts.MapPayload) dRecsIn) := FUNCTION

	dMetaIn := PROJECT(dRecsIn, TRANSFORM(BairRx_MapIncident.Layouts.Metadata, SELF.data_provider_ori := LEFT.ori, /*SELF.geocoded := LEFT.geocoded;*/, SELF := []));
	
	InViewMeta := table(dRecsIn,
											{ori,
											integer8 Records_Address := count(group,accuracy = BairRx_Common.Constants.ACCURACY_ADDRESS_CODE),
											integer8 Records_Intersection := count(group,accuracy = BairRx_Common.Constants.ACCURACY_INTERSECTION_CODE),
											integer8 Records_Street := count(group,accuracy = BairRx_Common.Constants.ACCURACY_STREET_CODE),
											integer8 	Records_InView := count(group),
											string25 Start_Date  := (string)min(group,date),
											string25 End_Date  := (string)max(group,date)
											},ori);
											
											
	dMeta0 := ROLLUP(SORT(dMetaIn, data_provider_ori), LEFT.data_provider_ori = RIGHT.data_provider_ori,
								TRANSFORM(BairRx_MapIncident.Layouts.Metadata,
									SELF.nrecs := LEFT.nrecs + 1,
									SELF := LEFT));
	
	// need a new key indexed by ori so we can skip this join...
	dMeta1 := JOIN(dMeta0, BairRx_Common.Keys.GroupAccessKey,
								KEYED(LEFT.data_provider_ori = RIGHT.ori),
								TRANSFORM(BairRx_MapIncident.Layouts.Metadata,
									SELF.data_provider_id := RIGHT.data_provider_id,
									SELF := LEFT),
									KEEP(1), limit(0));

	dMeta2 := JOIN(dMeta1, BairRx_Common.Keys.DataProviderKey,
								KEYED(LEFT.data_provider_id = RIGHT.data_provider_id),
								TRANSFORM(BairRx_MapIncident.Layouts.Metadata,
									SELF := RIGHT,
									SELF := LEFT),
									KEEP(1), limit(0));
	dMeta3	:= JOIN(dMeta2,InViewMeta,
									LEFT.data_provider_ori = RIGHT.ORI,
									TRANSFORM(BairRx_MapIncident.Layouts.Metadata,
									SELF := RIGHT,
									SELF := LEFT),
									KEEP(1), limit(0));
									

	
	dMeta := PROJECT(dMeta3, TRANSFORM(iesp.bair_mapincident.t_BAIRMetadata,
					SELF.Agency := LEFT.data_provider_name,
					SELF.LastUpload := LEFT.last_upload,
					SELF.AllTimeData.Uploaded := (STRING) LEFT.records_uploaded,
					SELF.AllTimeData.Approved := (STRING) BairRx_Common.Functions.RoundPercentage(LEFT.records_approved,LEFT.records_uploaded),
					SELF.AllTimeData.Flagged 	:= (STRING) BairRx_Common.Functions.RoundPercentage(LEFT.flagged_records,LEFT.records_uploaded),
					SELF.AllTimeData.StartDate 	:= BairRx_Common.ECL2ESP.toTimeStamp(LEFT.first_date),
					SELF.AllTimeData.EndDate 		:= BairRx_Common.ECL2ESP.toTimeStamp(LEFT.last_date), 
					SELF.AllTimeData.GoogleGeocode := (STRING)BairRx_Common.Functions.RoundPercentage(LEFT.geocode_google, LEFT.records_approved),
					SELF.AllTimeData.AgencyGeocode := (STRING)BairRx_Common.Functions.RoundPercentage(LEFT.geocode_provider, LEFT.records_approved),
					SELF.InViewData.AccuracyAddress	:=	(STRING)BairRx_Common.Functions.RoundPercentage(LEFT.Records_Address,LEFT.Records_InView),
					SELF.InViewData.AccuracyIntersection	:=	(STRING)BairRx_Common.Functions.RoundPercentage(LEFT.Records_Intersection,LEFT.Records_InView),
					SELF.InViewData.AccuracyStreet	:=	(STRING)BairRx_Common.Functions.RoundPercentage(LEFT.Records_Street,LEFT.Records_InView),
					SELF.InViewData.RecordsInView	:=	(STRING)LEFT.Records_InView,
					SELF.InViewData.StartDate	:=	BairRx_Common.ECL2ESP.toTimeStamp2(LEFT.Start_date),
					SELF.InViewData.EndDate	:=	BairRx_Common.ECL2ESP.toTimeStamp2(LEFT.End_date),
					SELF := []));
	
	
														
	
	// output(dMetaIn, named('dMetaIn'));
	// output(dMeta0, named('dMeta0'));
	// output(dMeta1, named('dMeta1'));
	// output(dMeta2, named('dMeta2'));
	// output(dMeta3, named('dMeta3'));
	// output(dMeta, named('dMeta'));		
	// output(inviewmeta, named('inviewmeta'));		
	
	RETURN dMeta;
END;