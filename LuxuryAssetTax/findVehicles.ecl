import VehicleV2, Corp2, Business_Header, AutoStandardI, MDR;

export findVehicles(DATASET(LuxuryAssetTax.Layouts.BusinessList) NoContactBDidList, 
                    SET OF STRING2 searchStates,
										DATASET(LuxuryAssetTax.Layouts.ContactPairRec) totalFoundPairingsDid,
										DATASET(LuxuryAssetTax.Layouts.ContactPairRec) totalFoundPairingsBDid,
										DATASET(LuxuryAssetTax.Layouts.BusinessList) NoContactBusinesses,
										BOOLEAN onlyRVs, 
                    UNSIGNED minValue,
										DATASET(LuxuryAssetTax.Layouts.BusinessList) ContactBusinesses, 
										DATASET(LuxuryAssetTax.Layouts.ContactPairRec) totalFoundPairings,
										DATASET(Corp2.Layout_Corporate_Direct_Corp_Base) busLLC,
										DATASET(Business_Header.Layout_Business_Contact_Full_new) foundBHContacts, 
										DATASET(Corp2.Layout_Corporate_Direct_Cont_Base) foundCorpContacts) := FUNCTION

	VehiclePartyInit := VehicleV2.file_VehicleV2_party(orig_party_type NOT IN ['U', 'W'] AND orig_name_type IN ['1','4']);
	
  glbMod := AutoStandardI.GlobalModule();
	AllowGLB := AutoStandardI.InterfaceTranslator.glb_ok.val(PROJECT(glbMod,AutoStandardI.InterfaceTranslator.glb_ok.params));
	AllowDPPA := AutoStandardI.InterfaceTranslator.dppa_ok.val(PROJECT(glbMod,AutoStandardI.InterfaceTranslator.dppa_ok.params)); 

	VehicleV2.Layout_Base_Party filterGlbDppaVParty(VehicleV2.Layout_Base_Party L) := TRANSFORM
		STRING2 src := L.Source_Code;
		SELF.Source_Code := IF((NOT AllowGLB AND (src IN MDR.sourceTools.set_GLB)) 
														OR (NOT AllowDPPA AND (src IN MDR.sourceTools.set_DPPA_sources)),
														SKIP,
														L.Source_Code);
		SELF := L;
	END;
	VehicleParty := PROJECT(VehiclePartyInit, filterGlbDppaVParty(LEFT));
	
	VehiclePartyBDID := VehicleParty((unsigned6)append_bdid<>0);
	VehiclePartyDID := VehicleParty((unsigned6)append_did<>0);

  NoContactVehicleParty := JOIN(VehiclePartyBDID, NoContactBDidList, LEFT.append_bdid = RIGHT.bdid, TRANSFORM(LEFT), MANY LOOKUP);


	VehiclePartyInSearchState := VehicleParty((Reg_License_State in searchStates OR 
																			orig_state IN searchStates OR 
																			State_Origin IN searchStates));
	distVehiclePartyInSearchState := DISTRIBUTE(VehiclePartyInSearchState, HASH32(vehicle_key));

	//This is a list of vehcicle_key and iteration_keys that have been registered in the search states
	searchStateVechicleParty := DEDUP(SORT(distVehiclePartyInSearchState, vehicle_key, Iteration_Key, local),vehicle_key, Iteration_Key, local);

	InitContactVehicleParty := JOIN(VehiclePartyDID,
													 totalFoundPairingsDid,
													 LEFT.append_did = RIGHT.did,
													 TRANSFORM(LEFT), MANY LOOKUP) +											 
												 JOIN(VehiclePartyBDID,
													 totalFoundPairingsBDid,
													 LEFT.append_bdid = RIGHT.bdid,
													 TRANSFORM(LEFT), MANY LOOKUP);
	// This is a list of vehicle_key and iteration_key that have been registered to a contact or a contacts business
	ContactVehicleParty := DEDUP(SORT(DISTRIBUTE(InitContactVehicleParty, HASH32(vehicle_key)), vehicle_key, Iteration_Key, local), vehicle_key, Iteration_Key, local);

	LuxuryAssetTax.Layouts.IdVehicleRec extractVehicleKeys(VehicleV2.Layout_Base_Party L, LuxuryAssetTax.Layouts.BusinessList R) := TRANSFORM
		SELF.id := R.bdid;
		SELF.corp_key := R.corp_key;
		SELF.vehKey := L.vehicle_key;
		SELF.iterKey := L.Iteration_Key;
	END;

	NoContactVehicles := JOIN(NoContactVehicleParty, NoContactBusinesses, LEFT.append_bdid = RIGHT.bdid, extractVehicleKeys(LEFT, RIGHT), LIMIT(1000, SKIP));

	LuxuryAssetTax.Layouts.IdVehicleRec extractVehicleDidKeys(VehicleV2.Layout_Base_Party L, LuxuryAssetTax.Layouts.ContactPairRec R) := TRANSFORM
		SELF.id := R.bdid;
		SELF.corp_key := R.corp_key;
		SELF.vehKey := L.vehicle_key;
		SELF.iterKey := L.Iteration_Key;
	END;
	
	// Extract the vehKey/iterKey combination associated with each id.
	ContactVehicles1 := JOIN(ContactVehicleParty, 
													ContactBusinesses, 
													LEFT.append_bdid = RIGHT.bdid, 
													extractVehicleKeys(LEFT, RIGHT), 
													MANY LOOKUP, LIMIT(1000, SKIP));
	ContactVehicles2 := JOIN(ContactVehicleParty, 
													totalFoundPairings, 
													LEFT.append_did = RIGHT.did, 
													extractVehicleDidKeys(LEFT, RIGHT),
													MANY LOOKUP, LIMIT(1000, SKIP));
	ContactVehicles := ContactVehicles1 + ContactVehicles2;	
	distContactVehicles := DEDUP(SORT(DISTRIBUTE(ContactVehicles, HASH32(vehKey)), vehKey, id, iterKey, local), vehKey, id, iterKey, local);


	IdMainVehicleRec := RECORD
		unsigned6 id;
		string30  corp_key;
		string25  Orig_VIN;
	END;

	IdMainVehicleRec extractBDidVehicleVins(VehicleV2.Layout_Base_Main L, LuxuryAssetTax.Layouts.IdVehicleRec R) := TRANSFORM
		SELF.id := R.id;
		SELF.corp_key := R.corp_key;
		SELF.Orig_VIN := L.Orig_VIN;
	END;

	vehicleMainInit := IF(onlyRVs,
												VehicleV2.Files.Base.Main(length(trim(Orig_VIN)) = 17 AND
																									(stringlib.stringfind(orig_body_desc, 'MOTORIZED HOME',1) > 0 OR
																									 stringlib.stringfind(orig_body_desc, 'MOTORHOME',1) > 0 OR
																									 stringlib.stringfind(orig_body_desc, 'MOTOR HOME',1) > 0 OR
																									 stringlib.stringfind(orig_body_desc, '5TH WHEEL',1) > 0 OR
																									 stringlib.stringfind(orig_body_desc, 'COACH',1) > 0 OR
																									 stringlib.stringfind(orig_body_desc, 'FIFTH',1) > 0 OR
																									 stringlib.stringfind(orig_body_desc, 'RECREATION',1) > 0 OR 
																									 orig_body_desc = 'RV') AND NOT
																									(stringlib.stringfind(orig_body_desc, 'ALL TER',1) > 0 OR
																									 stringlib.stringfind(orig_body_desc, 'BICYCLE',1) > 0 OR
																									 stringlib.stringfind(orig_body_desc, 'SNOW MO',1) > 0)),
												VehicleV2.Files.Base.Main(length(trim(Orig_VIN)) = 17));
	VehicleV2.Layout_Base_Main filterGlbDppaVMain(VehicleV2.Layout_Base_Main L) := TRANSFORM
		STRING2 src := L.Source_Code;
		SELF.Source_Code := IF((NOT AllowGLB AND (src IN MDR.sourceTools.set_GLB)) 
														OR (NOT AllowDPPA AND (src IN MDR.sourceTools.set_DPPA_sources)),
														SKIP,
														L.Source_Code);
		SELF := L;
	END;
	vehicleMainFiltered := PROJECT(vehicleMainInit, filterGlbDppaVMain(LEFT));


	vehicleMain := IF(minValue > 0, 
	                  vehicleMainFiltered(((UNSIGNED)vina_price >= minValue) OR ((UNSIGNED)vina_price = 0)),
										vehicleMainFiltered());
	distVehicleMain := DISTRIBUTE(vehicleMain, HASH32(vehicle_key));
	
	//This is all the main Vehicle entries with a valid VIN and that have ever been registered in a search state. This should only be used for no contact path.
	ValidDistVehicleMain := JOIN(distVehicleMain, 
															 searchStateVechicleParty, 
															 LEFT.vehicle_key = RIGHT.vehicle_key AND LEFT.Iteration_Key = RIGHT.Iteration_Key, 
															 TRANSFORM(LEFT), local);

	NoContactVinList := JOIN(ValidDistVehicleMain, NoContactVehicles, LEFT.vehicle_key = RIGHT.vehKey AND LEFT.Iteration_Key = RIGHT.iterKey, extractBDidVehicleVins(LEFT, RIGHT), MANY LOOKUP);
  UniqueNoContactVinList := DEDUP(SORT(NoContactVinList, id, Orig_VIN), id, Orig_VIN);

  // use the vehKey/iterKey for each id to find the VIN
	ContactVinList := JOIN(vehicleMain, ContactVehicles, LEFT.vehicle_key = RIGHT.vehKey AND LEFT.Iteration_Key = RIGHT.iterKey, extractBDidVehicleVins(LEFT, RIGHT), MANY LOOKUP);
	UniqueContactVinList := DEDUP(SORT(ContactVinList, id, Orig_VIN), id, Orig_VIN);
	

	LuxuryAssetTax.Layouts.IdVehicleRec extractVehicleKey(VehicleV2.Layout_Base_Main L, IdMainVehicleRec R) := TRANSFORM
		SELF.id := R.id;
		SELF.corp_key := R.corp_key;
		SELF.vehKey := L.Vehicle_Key;
		SELF.iterKey := L.Iteration_Key;
	END;

	NoContactKeyList := JOIN(ValidDistVehicleMain, UniqueNoContactVinList, LEFT.Orig_VIN = RIGHT.Orig_VIN, extractVehicleKey(LEFT, RIGHT), MANY LOOKUP);

  //convert VIN to 1 or more vehKey/iterKey combinations and its associated id
	ContactKeyList := JOIN(vehicleMain, UniqueContactVinList, LEFT.Orig_VIN = RIGHT.Orig_VIN, extractVehicleKey(LEFT, RIGHT), MANY LOOKUP);

	LuxuryAssetTax.Layouts.IdVehicleRec extractSeqKey(VehicleV2.Layout_Base_Party L, LuxuryAssetTax.Layouts.IdVehicleRec R) := TRANSFORM
		SELF.id := R.id;
		SELF.corp_key := R.corp_key;
		SELF.vehKey := R.vehKey;
		SELF.iterKey := R.iterKey;
		SELF.seqKey := L.Sequence_Key;
	END;

	FullNoContactKeyList := JOIN(VehicleParty, NoContactKeyList, LEFT.Vehicle_Key = RIGHT.vehKey AND LEFT.Iteration_Key = RIGHT.iterKey, extractSeqKey(LEFT, RIGHT), MANY LOOKUP);
  sortedFullNoContactKeyList := DEDUP(SORT(FullNoContactKeyList, id, vehKey, iterKey, seqKey), id, vehKey, iterKey, seqKey);

	// expand the id, vehKey, iterKey association to also grab all the seqKeys for them
	FullContactKeyList := JOIN(VehicleParty, ContactKeyList, LEFT.Vehicle_Key = RIGHT.vehKey AND LEFT.Iteration_Key = RIGHT.iterKey, extractSeqKey(LEFT, RIGHT), MANY LOOKUP);
	sortedFullContactKeyList := DEDUP(SORT(FullContactKeyList, id, vehKey, iterKey, seqKey), id, vehKey, iterKey, seqKey);

	/* Filter Bdids that contain 1000 or more registrations */
	bdidCountRec := RECORD
		sortedFullNoContactKeyList.id;
		grpCount := COUNT(group);
	END;

  NoContactBdidCount := TABLE(sortedFullNoContactKeyList, bdidCountRec, id);
	filteredSortedFullNoContactKeyList := JOIN(sortedFullNoContactKeyList, NoContactBdidCount, LEFT.id = RIGHT.id AND RIGHT.grpCount < 1000, TRANSFORM(LEFT));

	bdidContactCountRec := RECORD
		sortedFullContactKeyList.id;
		grpCount := COUNT(group);
	END;

  ContactBdidCount := TABLE(sortedFullContactKeyList, bdidContactCountRec, id);
	filteredSortedFullContactKeyList := JOIN(sortedFullContactKeyList, ContactBdidCount, LEFT.id = RIGHT.id AND RIGHT.grpCount < 1000, TRANSFORM(LEFT));
	/* End of filter code */
	
	// NoContactOutput := LuxuryAssetTax.expandData(sortedFullNoContactKeyList, VehicleParty, distVehicleMain, busLLC);
	NoContactOutput := LuxuryAssetTax.expandData(filteredSortedFullNoContactKeyList, VehicleParty, distVehicleMain, busLLC);
	NoContactBestOutput := LuxuryAssetTax.addBestAddrInfo(NoContactOutput);

	// ContactOutput := LuxuryAssetTax.expandData(sortedFullContactKeyList, VehicleParty, distVehicleMain, busLLC, true);
	ContactOutput := LuxuryAssetTax.expandData(filteredSortedFullContactKeyList, VehicleParty, distVehicleMain, busLLC, true);
	ContactBestOutput := LuxuryAssetTax.addBestAddrInfo(ContactOutput);
	ContactOutputWithContacts := LuxuryAssetTax.expandContactInfo(ContactBestOutput, foundBHContacts, foundCorpContacts);
	
  return NoContactBestOutput 
	       + ContactOutputWithContacts;
END;