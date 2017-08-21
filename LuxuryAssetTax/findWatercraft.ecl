import Watercraft, Corp2, Business_Header, AutoStandardI, MDR;

export findWatercraft(DATASET(LuxuryAssetTax.Layouts.BusinessList) NoContactBDidList, 
                    SET OF STRING2 searchStates,
										DATASET(LuxuryAssetTax.Layouts.ContactPairRec) totalFoundPairingsDid,
										DATASET(LuxuryAssetTax.Layouts.ContactPairRec) totalFoundPairingsBDid,
										DATASET(LuxuryAssetTax.Layouts.BusinessList) NoContactBusinesses,
										UNSIGNED minValue,
										DATASET(LuxuryAssetTax.Layouts.BusinessList) ContactBusinesses, 
										DATASET(LuxuryAssetTax.Layouts.ContactPairRec) totalFoundPairings,
										DATASET(Corp2.Layout_Corporate_Direct_Corp_Base) busLLC,
										DATASET(Business_Header.Layout_Business_Contact_Full_new) foundBHContacts, 
										DATASET(Corp2.Layout_Corporate_Direct_Cont_Base) foundCorpContacts) := FUNCTION


  glbMod := AutoStandardI.GlobalModule();
	AllowGLB := AutoStandardI.InterfaceTranslator.glb_ok.val(PROJECT(glbMod,AutoStandardI.InterfaceTranslator.glb_ok.params));
	AllowDPPA := AutoStandardI.InterfaceTranslator.dppa_ok.val(PROJECT(glbMod,AutoStandardI.InterfaceTranslator.dppa_ok.params)); 

	WatercraftSearchInit := watercraft.file_base_search_prod();
	watercraft.Layout_Watercraft_Search_Base filterGlbDppaWatSearch(watercraft.Layout_Watercraft_Search_Base L) := TRANSFORM
		STRING2 src := L.Source_Code;
		SELF.Source_Code := IF((NOT AllowGLB AND (src IN MDR.sourceTools.set_GLB)) 
														OR (NOT AllowDPPA AND (src IN MDR.sourceTools.set_DPPA_sources)),
														SKIP,
														L.Source_Code);
		SELF := L;
	END;
	WatercraftSearch := PROJECT(WatercraftSearchInit, filterGlbDppaWatSearch(LEFT));

	WatercraftMainInit := watercraft.file_base_main_prod();
	watercraft.Layout_Watercraft_Main_Base filterGlbDppaWatMain(watercraft.Layout_Watercraft_Main_Base L) := TRANSFORM
		STRING2 src := L.Source_Code;
		SELF.Source_Code := IF((NOT AllowGLB AND (src IN MDR.sourceTools.set_GLB)) 
														OR (NOT AllowDPPA AND (src IN MDR.sourceTools.set_DPPA_sources)),
														SKIP,
														L.Source_Code);
		SELF := L;
	END;
	WatercraftMainFiltered := PROJECT(WatercraftMainInit, filterGlbDppaWatMain(LEFT));

	// Limit main files by price, this will filter low value watercraft in the expandWatercraftData step
	WatercraftMain := IF(minValue > 0, 
	                     WatercraftMainFiltered(((UNSIGNED)purchase_price >= minValue) OR ((UNSIGNED)purchase_price = 0)),
										   WatercraftMainFiltered());	
	
	validWatercraftKeys := DEDUP(SORT(WatercraftMain(st_registration IN searchStates), watercraft_key), watercraft_key);
	didWatercraftSearch := WatercraftSearch((unsigned6) did <> 0);
	bdidWatercraftSearch := WatercraftSearch((unsigned6) bdid <> 0);

	//All WC registered to businesses in search states without a contact
  InitNoContactWatercraftSearch := JOIN(bdidWatercraftSearch, NoContactBDidList, (unsigned6) LEFT.bdid = RIGHT.bdid, TRANSFORM(LEFT), MANY LOOKUP);

	// Limit initial to those WC ever registered in search states
	ValidNoContactWatercraftSearch := JOIN(InitNoContactWatercraftSearch, validWatercraftKeys, LEFT.watercraft_key = RIGHT.watercraft_key, TRANSFORM(LEFT));
	NoContactWatercraftKeyList := DEDUP(SORT(ValidNoContactWatercraftSearch, bdid, watercraft_key), bdid, watercraft_key);

	InitContactWatercraftList := JOIN(didWatercraftSearch, 
																totalFoundPairingsDid,
																(unsigned6) LEFT.did = RIGHT.did,
																TRANSFORM(LEFT), MANY LOOKUP) + 
															JOIN(bdidWatercraftSearch, 
																totalFoundPairingsBDid,
																(unsigned6) LEFT.bdid = RIGHT.bdid,
																TRANSFORM(LEFT), MANY LOOKUP);
	ContactWatercraftKeyList := DEDUP(SORT(InitContactWatercraftList, bdid, watercraft_key), bdid, watercraft_key);

	LuxuryAssetTax.Layouts.IdVehicleRec extractWatercraftKeys(LuxuryAssetTax.Layouts.BusinessList L, watercraft.Layout_Watercraft_Search_Base R) := TRANSFORM
		SELF.id := L.bdid;
		SELF.corp_key := L.corp_key;
		SELF.vehKey := R.watercraft_key;
	END;

	NoContactWatercraftInit := JOIN(NoContactBDidList, NoContactWatercraftKeyList, LEFT.bdid = (unsigned6) RIGHT.bdid, extractWatercraftKeys(LEFT, RIGHT), LIMIT(1000, SKIP));
	NoContactWatercraft := DEDUP(SORT(NoContactWatercraftInit, id, vehKey), id, vehKey);
	NoContactWatercraftOutput := LuxuryAssetTax.expandWatercraftData(NoContactWatercraft, WatercraftSearch, WatercraftMain, busLLC);
	NoContactWatercraftBestOutput := LuxuryAssetTax.addBestAddrInfo(NoContactWatercraftOutput);

	LuxuryAssetTax.Layouts.IdVehicleRec extractWatercraftDidKeys(LuxuryAssetTax.Layouts.ContactPairRec L, watercraft.Layout_Watercraft_Search_Base R) := TRANSFORM
		SELF.id := L.bdid;
		SELF.corp_key := L.corp_key;
		SELF.vehKey := R.watercraft_key;
	END;

	ContactWatercraftInit := JOIN(ContactBusinesses, 
													 ContactWatercraftKeyList, 
													 LEFT.bdid = (unsigned6) RIGHT.bdid, 
													 extractWatercraftKeys(LEFT, RIGHT), 
													 LIMIT(1000, SKIP)) + 
													JOIN(totalFoundPairings, 
													 ContactWatercraftKeyList,
													 LEFT.did = (unsigned6) RIGHT.did,
													 extractWatercraftDidKeys(LEFT, RIGHT),
													 LIMIT(1000, SKIP));
	ContactWatercraft := DEDUP(SORT(ContactWatercraftInit, id, vehKey), id, vehKey);
	ContactWatercraftOutput := LuxuryAssetTax.expandWatercraftData(ContactWatercraft, WatercraftSearch, WatercraftMain, busLLC, true);
	ContactWatercraftBestOutput := LuxuryAssetTax.addBestAddrInfo(ContactWatercraftOutput);
	ContactWatercraftWithContacts := LuxuryAssetTax.expandContactInfo(ContactWatercraftBestOutput, foundBHContacts, foundCorpContacts);

  return NoContactWatercraftBestOutput 
	       + ContactWatercraftWithContacts;
END;