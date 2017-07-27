EXPORT fn_postautokey_joins(DATASET(FDN_Services.Layouts.batch_search_rec) ds_in = DATASET([],FDN_Services.Layouts.batch_search_rec)) := FUNCTION

	ds_auto_id	:= FDN_Services.AutoKey_IDs(ds_in((zip5 <> '' OR st <> '' OR v_city_name <> '' ) OR phone10 <> '' OR ssn <> ''));
	
	ds_ssn := JOIN(ds_in, ds_auto_id,
								  (LEFT.ssn = RIGHT.ssn AND 
									LEFT.SSN <> '' AND 
									RIGHT.classification_Entity.Entity_type_id = FDN_Services.Constants.EntityTypes_Enum.SSN),
								  TRANSFORM(FDN_Services.Layouts.RecidUid_rec, 
									Self.acctno := RIGHT.acctno,
									Self.record_id := RIGHT.record_id,
									Self.entity_type_id := RIGHT.classification_Entity.Entity_type_id,
									Self.entity_sub_type_id := RIGHT.classification_Entity.entity_sub_type_id,
									SELF := LEFT),
									LIMIT(FDN_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
	
	ds_address := JOIN(ds_in, ds_auto_id, 
                  left.zip5 = right.zip AND
                  left.st = right.state AND
                  left.v_city_name = right.city AND
                  left.prim_range = right.clean_address.prim_range AND
									left.prim_name = right.clean_address.prim_name AND
									RIGHT.classification_Entity.Entity_type_id = FDN_Services.Constants.EntityTypes_Enum.ADDRESS,
                  TRANSFORM(FDN_Services.Layouts.RecidUid_rec,
									Self.acctno := RIGHT.acctno,
									Self.record_id := RIGHT.record_id,
									Self.entity_type_id := RIGHT.classification_Entity.Entity_type_id,
									Self.entity_sub_type_id := RIGHT.classification_Entity.entity_sub_type_id,
									SELF := LEFT),
									LIMIT(FDN_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
									
	ds_phone := JOIN(ds_in, ds_auto_id,
								  (LEFT.phone10 = RIGHT.clean_phones.phone_number AND RIGHT.clean_phones.phone_number <> '' AND
									RIGHT.classification_Entity.Entity_type_id = FDN_Services.Constants.EntityTypes_Enum.PHONE),
								  TRANSFORM(FDN_Services.Layouts.RecidUid_rec, 
									Self.acctno := RIGHT.acctno,
									Self.record_id := RIGHT.record_id,
									Self.entity_type_id := RIGHT.classification_Entity.Entity_type_id,
									Self.entity_sub_type_id := RIGHT.classification_Entity.entity_sub_type_id,
									SELF := LEFT),
									LIMIT(FDN_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
	
	ds_auto :=	(ds_ssn + ds_address + ds_phone); 					
	
	// OUTPUT(ds_in ,NAMED('ds_in'));								
	// OUTPUT(ds_auto_id ,NAMED('ds_auto_id'));								
	// OUTPUT(ds_ssn ,NAMED('ds_ssn'));								
	// OUTPUT(ds_address ,NAMED('ds_address'));								
	// OUTPUT(ds_phone ,NAMED('ds_phone'));								
	RETURN ds_auto;		
	
	END;