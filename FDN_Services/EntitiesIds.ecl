IMPORT FraudDefenseNetwork, FDN_Services, BIPV2;

	EXPORT EntitiesIds := MODULE
	
		EXPORT GetLexID(DATASET(FDN_Services.Layouts.batch_search_rec) ds_in = dataset([],FDN_Services.Layouts.batch_search_rec)) := FUNCTION

				// Getting UID and RecordID		
				Get_Rec_UID := JOIN(ds_in, FraudDefenseNetwork.Keys().main.did.qa, 
													KEYED(LEFT.did = RIGHT.did) AND
													RIGHT.Entity_type_id = FDN_Services.Constants.EntityTypes_Enum.PERSON,
													TRANSFORM(FDN_Services.Layouts.RecidUid_rec,
													SELF.acctno := (string)LEFT.seq,
													SELF := RIGHT,
													SELF := LEFT,
													SELF := []),
													LIMIT(FDN_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

				RETURN Get_Rec_UID;
		END;
		
		EXPORT GetIP(DATASET(FDN_Services.Layouts.batch_search_rec_flags) ds_in = dataset([],FDN_Services.Layouts.batch_search_rec_flags)) := FUNCTION
			RETURN JOIN(ds_in, FraudDefenseNetwork.Keys().main.ip.qa,
									KEYED(LEFT.ipaddress = RIGHT.ip_address) AND
									RIGHT.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.IP_ADDRESS,
									TRANSFORM(FDN_Services.Layouts.RecidUid_rec,
									SELF.acctno := (string)LEFT.seq,
									SELF := RIGHT,
									SELF := LEFT,
									SELF := []),
									LIMIT(FDN_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
		END;
		
 		EXPORT GetLinkIds(DATASET(FDN_Services.Layouts.batch_search_rec_flags) ds_in = dataset([],FDN_Services.Layouts.batch_search_rec_flags)) := FUNCTION
			fetchIn:= PROJECT(ds_in, BIPV2.IDlayouts.l_xlink_ids);
			fetchedRecs:= FraudDefenseNetwork.Key_LinkIds.kFetch(fetchIn, BIPV2.IDconstants.Fetch_Level_SELEID);
			final:= JOIN(ds_in, fetchedRecs,
										BIPV2.IDmacros.mac_JoinTop3Linkids() AND
										RIGHT.classification_entity.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.BUSINESS,
										TRANSFORM(FDN_Services.Layouts.RecidUid_rec,
										SELF.acctno := (string)LEFT.seq,
										SELF := RIGHT,
										SELF := LEFT,
										SELF := []),
										LIMIT(FDN_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
			RETURN final;																	
   	END;

 		EXPORT GetDeviceID(DATASET(FDN_Services.Layouts.batch_search_rec_flags) ds_in = dataset([],FDN_Services.Layouts.batch_search_rec_flags)) := FUNCTION
			RETURN JOIN(ds_in, FraudDefenseNetwork.Keys().main.DeviceID.qa, 
									KEYED(LEFT.deviceid = RIGHT.device_id) AND
									RIGHT.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.DEVICE_ID,
									TRANSFORM(FDN_Services.Layouts.RecidUid_rec,
									SELF.acctno := (string)LEFT.seq,
									SELF := RIGHT,
									SELF := LEFT,									
									SELF := []),
									LIMIT(FDN_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
   		END;
   
		EXPORT GetProfessionalID(DATASET(FDN_Services.Layouts.batch_search_rec_flags) ds_in = dataset([],FDN_Services.Layouts.batch_search_rec_flags)) := FUNCTION
			RETURN JOIN(ds_in, FraudDefenseNetwork.Keys().main.ProfessionalID.qa, 
												KEYED(LEFT.professionalid = RIGHT.professional_id) AND
												RIGHT.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.LICENSED_PROFESSIONAL,
												TRANSFORM(FDN_Services.Layouts.RecidUid_rec,
												SELF.acctno := (string)LEFT.seq,
												SELF := RIGHT,
												SELF := LEFT,
												SELF := []),
												LIMIT(FDN_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
		END;

		EXPORT GetTIN(DATASET(FDN_Services.Layouts.batch_search_rec_flags) ds_in = dataset([],FDN_Services.Layouts.batch_search_rec_flags)) := FUNCTION
			RETURN JOIN(ds_in, FraudDefenseNetwork.Keys().main.tin.qa, 
												KEYED(LEFT.tin = RIGHT.tin) AND
												RIGHT.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.TIN,
												TRANSFORM(FDN_Services.Layouts.RecidUid_rec,
												SELF.acctno := (string)LEFT.seq,
												SELF := RIGHT,
												SELF := LEFT,
												SELF := []),
												LIMIT(FDN_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
		END;

		EXPORT GetAppendedProviderID(DATASET(FDN_Services.Layouts.batch_search_rec_flags) ds_in = dataset([],FDN_Services.Layouts.batch_search_rec_flags)) := FUNCTION
			RETURN JOIN(ds_in, FraudDefenseNetwork.Keys().main.AppProviderID.qa, 
												KEYED(LEFT.appendedproviderid = RIGHT.appended_provider_id) AND
												RIGHT.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.PROVIDER,
												TRANSFORM(FDN_Services.Layouts.RecidUid_rec,
												SELF.acctno := (string)LEFT.seq,
												SELF := RIGHT,
												SELF := LEFT,
												SELF := []),
												LIMIT(FDN_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
		END;

		EXPORT GetNPI(DATASET(FDN_Services.Layouts.batch_search_rec_flags) ds_in = dataset([],FDN_Services.Layouts.batch_search_rec_flags)) := FUNCTION
			RETURN JOIN(ds_in, FraudDefenseNetwork.Keys().main.npi.qa, 
												KEYED(LEFT.npi = RIGHT.npi) AND
												RIGHT.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.PROVIDER,
												TRANSFORM(FDN_Services.Layouts.RecidUid_rec,
												SELF.acctno := (string)LEFT.seq,
												SELF := RIGHT,
												SELF := LEFT,
												SELF := []),
												LIMIT(FDN_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
		END;

		EXPORT GetLNPID(DATASET(FDN_Services.Layouts.batch_search_rec_flags) ds_in = dataset([],FDN_Services.Layouts.batch_search_rec_flags)) := FUNCTION
			RETURN JOIN(ds_in, FraudDefenseNetwork.Keys().main.LNPID.qa, 
												KEYED(LEFT.lnpid = RIGHT.lnpid) AND
												RIGHT.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.PROVIDER,
												TRANSFORM(FDN_Services.Layouts.RecidUid_rec,
												SELF.acctno := (string)LEFT.seq,
												SELF := RIGHT,
												SELF := LEFT,
												SELF := []),
												LIMIT(FDN_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
		END;

		EXPORT GetEmail(DATASET(FDN_Services.Layouts.batch_search_rec_flags) ds_in = dataset([],FDN_Services.Layouts.batch_search_rec_flags)) := FUNCTION
			RETURN JOIN(ds_in, FraudDefenseNetwork.Keys().main.email.qa, 
												KEYED(LEFT.emailaddress = RIGHT.email_address) AND
												RIGHT.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.EMAIL_ADDRESS,
												TRANSFORM(FDN_Services.Layouts.RecidUid_rec,
												SELF.acctno := (string)LEFT.seq,
												SELF := RIGHT,
												SELF := LEFT,
												SELF := []),
												LIMIT(FDN_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
		END;
		
				
	END;