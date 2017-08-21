import FAA, Corp2, Business_Header;

export findAircraft(DATASET(LuxuryAssetTax.Layouts.BusinessList) NoContactBDidList, 
                    SET OF STRING2 searchStates,
										DATASET(LuxuryAssetTax.Layouts.ContactPairRec) totalFoundPairingsDid,
										DATASET(LuxuryAssetTax.Layouts.ContactPairRec) totalFoundPairingsBDid,
										DATASET(LuxuryAssetTax.Layouts.BusinessList) NoContactBusinesses,
										DATASET(LuxuryAssetTax.Layouts.BusinessList) ContactBusinesses, 
										DATASET(LuxuryAssetTax.Layouts.ContactPairRec) totalFoundPairings,
										DATASET(Corp2.Layout_Corporate_Direct_Corp_Base) busLLC,
										DATASET(Business_Header.Layout_Business_Contact_Full_new) foundBHContacts, 
										DATASET(Corp2.Layout_Corporate_Direct_Cont_Base) foundCorpContacts) := FUNCTION

	allAircraft := PROJECT(faa.file_aircraft_registration_out(), faa.layout_aircraft_registration_out);
	validAircraftNNum := DEDUP(SORT(allAircraft(st IN searchStates), n_number), n_number);
	bdidAircraft := allAircraft(bdid_out != '');
	didAircraft := allAircraft(did_out != '');

	//All AC registered to businesses in no tax states without a contact
	InitNoContactAircraft := JOIN(bdidAircraft, NoContactBDidList, (unsigned6) LEFT.bdid_out = RIGHT.bdid, TRANSFORM(LEFT), MANY LOOKUP);
	// Limit initial to those AC ever registered in search states
	ValidNoContactAircraft := JOIN(InitNoContactAircraft, validAircraftNNum, LEFT.n_number = RIGHT.n_number, TRANSFORM(LEFT));
	InitNoContactAircraftKeyList := DEDUP(SORT(ValidNoContactAircraft, bdid_out, n_number), bdid_out, n_number);

	InitContactAircraftList := JOIN(didAircraft, 
																totalFoundPairingsDid,
																(unsigned6) LEFT.did_out = RIGHT.did,
																TRANSFORM(LEFT), MANY LOOKUP) + 
															JOIN(bdidAircraft, 
																totalFoundPairingsBDid,
																(unsigned6) LEFT.bdid_out = RIGHT.bdid,
																TRANSFORM(LEFT), MANY LOOKUP);

	ContactAircraftKeyList := DEDUP(SORT(InitContactAircraftList, n_number), n_number);

	LuxuryAssetTax.Layouts.IdVehicleRec extractAircraftKeys(LuxuryAssetTax.Layouts.BusinessList L, faa.layout_aircraft_registration_out R) := TRANSFORM
		SELF.id := L.bdid;
		SELF.corp_key := L.corp_key;
		SELF.vehKey := R.n_number;
	END;

	NoContactAircraftInit := JOIN(NoContactBDidList, InitNoContactAircraftKeyList, LEFT.bdid = (unsigned6) RIGHT.bdid_out, extractAircraftKeys(LEFT, RIGHT), LIMIT(1000, SKIP));
	NoContactAircraft := DEDUP(SORT(NoContactAircraftInit, id, vehKey), id, vehKey);
	NoContactAircraftOutput := LuxuryAssetTax.expandAircraftData(NoContactAircraft, allAircraft, busLLC);
	NoContactAircraftBestOutput := LuxuryAssetTax.addBestAddrInfo(NoContactAircraftOutput);

	LuxuryAssetTax.Layouts.IdVehicleRec extractAircraftDidKeys(LuxuryAssetTax.Layouts.ContactPairRec L, faa.layout_aircraft_registration_out R) := TRANSFORM
		SELF.id := L.bdid;
		SELF.corp_key := L.corp_key;
		SELF.vehKey := R.n_number;
	END;

	ContactAircraftInit := JOIN(ContactBusinesses, 
													 ContactAircraftKeyList, 
													 LEFT.bdid = (unsigned6) RIGHT.bdid_out, 
													 extractAircraftKeys(LEFT, RIGHT), 
													 LIMIT(1000, SKIP)) + 
													JOIN(totalFoundPairings, 
													 ContactAircraftKeyList,
													 LEFT.did = (unsigned6) RIGHT.did_out,
													 extractAircraftDidKeys(LEFT, RIGHT),
													 LIMIT(1000, SKIP));
	ContactAircraft := DEDUP(SORT(ContactAircraftInit, id, vehKey), id, vehKey);
	ContactAircraftOutput := LuxuryAssetTax.expandAircraftData(ContactAircraft, allAircraft, busLLC, true);
	ContactAircraftBestOutput := LuxuryAssetTax.addBestAddrInfo(ContactAircraftOutput);
	ContactAircraftWithContacts := LuxuryAssetTax.expandContactInfo(ContactAircraftBestOutput, foundBHContacts, foundCorpContacts);

  return NoContactAircraftBestOutput 
	       + ContactAircraftWithContacts;
END;