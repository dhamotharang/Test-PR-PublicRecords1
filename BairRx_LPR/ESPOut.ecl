import BairRx_LPR, BairRx_Common, iesp, SALT32;

EXPORT iesp.bair_lpr.t_BAIRLprSearchRecord ESPOut(BairRx_LPR.Layouts.SearchPayload L, BOOLEAN calculate_distance, REAL geo_lat=0.0, REAL geo_lon=0.0) := TRANSFORM
	_distance := IF(L.distance=0 AND L.y_coordinate<>0 AND L.x_coordinate<>0, 
			(SALT32.MOD_LL.Distance((REAL)L.y_coordinate,(REAL)L.x_coordinate,geo_lat,geo_lon)), 
			(L.distance/BairRx_Common.Constants.REAL_TO_INT_SCALE));
	SELF.EntityID := L.eid,
	SELF.UCRGroup := BairRx_Common.Constants.LPR_CLASS,
	SELF.Class := BairRx_Common.Constants.LPR_CLASS,
	SELF.LicensePlateRecordGUID := L.licenseplaterecordguid,
	SELF.EventNumber := L.eventnumber,
	SELF.PlateNumber := L.plate,
	SELF.CaptureDateTime := L.capturedatetime,
	SELF.XCoordinate := (STRING) L.x_coordinate,
	SELF.YCoordinate := (STRING) L.y_coordinate,
	SELF.Distance := IF(calculate_distance, REALFORMAT(_distance,10,2), ''),
	SELF.Agency := L.data_provider_name,
	SELF.Accuracy := L.confidence,
	SELF.ORI := (STRING) L.data_provider_id,
	SELF.ImageAvailable := L.has_image,
	SELF := []
END;

