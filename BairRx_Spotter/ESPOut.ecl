import iesp,BairRx_Spotter;

EXPORT iesp.bair_shotspotter.t_BAIRShotSpotterSearchRecord ESPOut(BairRx_Spotter.Layouts.SearchPayload L) := TRANSFORM
	SELF.EntityID := L.eid,
	SELF.UCRGroup := IF(L.shot_incident_type in [1,2], '0', '')+(STRING)L.shot_incident_type,
	SELF.Class := IF(L.shot_incident_type in [1,2], '0', '')+(STRING)L.shot_incident_type,
	SELF.RaidsID := (STRING) L.raids_record_id,	
	SELF.Shots := (STRING) L.shots,	
	SELF.ShotID := L.shot_id,	
	SELF.Address := L.address,	
	SELF.Beat := L.beat,	
	SELF.District := L.district,	
	SELF.Source := L.shot_source,	
	SELF.ShotType := IF(L.shot_incident_type in [1,2], '0', '')+(STRING)L.shot_incident_type,
	SELF.ShotStatus := L.shot_incident_status,	
	SELF.XCoordinate := (STRING) L.x_coordinate,	
	SELF.YCoordinate := (STRING) L.y_coordinate,	
	SELF.DateTime := L.shot_datetime,
	SELF.Agency := L.data_provider_name,
	SELF.ORI := (STRING) L.data_provider_id,
	SELF := []
END;
