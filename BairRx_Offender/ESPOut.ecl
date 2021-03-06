import BairRx_Offender, BairRx_Common, iesp, SALT32;

EXPORT iesp.bair_offender.t_BAIROffenderSearchRecord ESPOut(BairRx_Offender.Layouts.SearchPayload L, boolean calculate_distance, REAL geo_lat=0.0, REAL geo_lon=0.0) := TRANSFORM
	_distance := IF(L.distance=0 AND L.y_coordinate<>0 AND L.x_coordinate<>0, 
			(SALT32.MOD_LL.Distance((REAL)L.y_coordinate,(REAL)L.x_coordinate,geo_lat,geo_lon)), 
			(L.distance/BairRx_Common.Constants.REAL_TO_INT_SCALE));	
	SELF.EntityID := L.eid,
	SELF.UCRGroup := (STRING) L.class_code,
	SELF.Class := L.classification,
	SELF.Classification := BairRx_Common.ClassificationCode.GetClassification(L.class_code),	
	SELF.OffenderID := L.agency_offender_id,
	SELF.PhotoURL := L.picture,
	SELF.Address := L.address,
	SELF.Distance := IF(calculate_distance,REALFORMAT(_distance,10,2),''),
	SELF.FirstName := L.first_name,
	SELF.MiddleName := L.middle_name,
	SELF.LastName := L.last_name,
	SELF.Moniker := L.moniker,
	SELF.NameType := L.name_type,
	SELF.DOB := L.dob,
	SELF.Race := L.race,
	SELF.Sex := L.sex,
	SELF.Hair := L.hair,
	SELF.HairLength := L.hair_length,
	SELF.Eyes := L.eyes,
	SELF.HandUse := L.hand_use,
	SELF.Speech := L.speech,
	SELF.Teeth := L.teeth,
	SELF.PhysicalCondition := L.physical_condition,
	SELF.Build := L.build,
	SELF.Complexion := L.complexion,
	SELF.FacialHair := L.facial_hair,
	SELF.Hat := L.hat,
	SELF.Mask := L.mask,
	SELF.Glasses := L.glasses,
	SELF.Appearance := L.Appearance,
	SELF.Shirt := L.shirt,
	SELF.Pants := L.pants,
	SELF.Shoes := L.shoes,
	SELF.Jacket := L.jacket,
	SELF.Weight1 := (STRING)L.weight_1,
	SELF.Weight2 := (STRING)L.weight_2,
	SELF.Height1 := (STRING)L.height_1,
	SELF.Height2 := (STRING)L.height_2,
	SELF.Age1 := (STRING)L.age_1,
	SELF.Age2 := (STRING)L.age_2,
	SELF.Accuracy := BairRx_Common.Constants.AccuracyLabel(L.accuracy), 
	SELF.Agency := L.data_provider_name, 
	SELF.AgencyName := L.agency_name, // not the same as agency name
	SELF.UserText1 := L.user_text_1,
	SELF.UserText2 := L.user_text_2,	
	SELF.SID := L.offenders_sid,
	SELF.DLNumber := L.dl_number,
	SELF.DLState := L.dl_state,
	SELF.FBINumber := L.fbi_number,
	SELF.OffenderNotes := '', //L.offendernotes,
	SELF.EditDate := L.edit_date,
	SELF.Quarantined := L.quarantined,
	SELF.AdminState := L.admin_state,
	SELF.Category := L.agency_category,
	SELF.Level := L.agency_level,
	SELF.Score := L.agency_score,
	SELF.BAIRScore := (STRING) L.bair_score,
	SELF.CaseReferenceNumber := L.case_reference_number,
	SELF.ChargeOffense := L.charge_offense,
	SELF.ProbationType := L.probation_type,
	SELF.ProbationOfficer := L.probation_officer,
	SELF.WarrantType := L.warrant_type,
	SELF.WarrantNumber := L.warrant_number,
	SELF.GangName := L.gang_name,
	SELF.GangRole := L.gang_role,
	SELF.ClassificationDate := L.classification_date,
	SELF.ExpirationDate := L.expiration_date,
	SELF.Expired := '', //L.expired
	SELF.XCoordinate := (STRING) L.x_coordinate,
	SELF.YCoordinate := (STRING) L.y_coordinate,
	SELF.ProviderId := (STRING)L.data_provider_id,
	SELF.UserInteger := (STRING) L.user_integer,
	SELF.UserFloat := (STRING) L.user_float,
	SELF.UserDateTime := L.user_datetime,
	SELF.OffenderPK := L.id, 
	SELF.ORI := (STRING) L.data_provider_id,
	SELF.LexID := (STRING) L.lexid,
	SELF.ImageAvailable := L.has_image,
	SELF.AddressClean :=[]
END;

