IMPORT BIPV2, Business_Risk_BIP, DueDiligence;

/* 
	Following Keys being used:
			BIPV2.Key_BH_Linking_Ids.kFetch2
*/


EXPORT getBusLinkedBus(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
													Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
													BIPV2.mod_sources.iParams linkingOptions) := FUNCTION


	linkedBusRaw := BIPV2.Key_BH_Linking_Ids.kFetch2(DueDiligence.Common.GetLinkIDs(indata),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Business_Risk_BIP.Constants.LinkSearch.UltID),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_BusHeader,
																							FALSE, /* dnbFullRemove */
																							TRUE, /* bypassContactSuppression */
																							Options.KeepLargeBusinesses);		
																							
	// Add back our Seq numbers.
	DueDiligence.Common.AppendSeq(linkedBusRaw, indata, linkedBusSeq);

	// Filter out records after our history date.
	lnkBusFilt := DueDiligence.Common.FilterRecords(linkedBusSeq, dt_first_seen, dt_vendor_first_reported);

	//remove the inquired business
	noInquiredBus := JOIN(indata, lnkBusFilt,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_Info.BIP_IDs.UltID.LinkID = RIGHT.ultid AND
													(LEFT.Busn_Info.BIP_IDs.OrgID.LinkID <> RIGHT.orgid OR
													LEFT.Busn_Info.BIP_IDs.SeleID.LinkID <> RIGHT.seleid OR
													LEFT.Busn_Info.BIP_IDs.ProxID.LinkID <> RIGHT.proxid OR
													LEFT.Busn_Info.BIP_IDs.PowID.LinkID <> RIGHT.powid),
													TRANSFORM({RECORDOF(RIGHT)}, SELF := RIGHT;));
	
	
	
	
	sortByKey := SORT(noInquiredBus, uniqueid, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	dedupByKey := DEDUP(sortByKey, uniqueid, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

	convertedToShell := PROJECT(dedupByKey, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																										SELF.Seq := LEFT.uniqueID;
																										SELF.Clean_Input.Seq := LEFT.uniqueID;
																										
																										SELF.BIP_IDs.seq := LEFT.uniqueID;
																										SELF.BIP_IDs.UltID.LinkID := LEFT.ultid;
																										SELF.BIP_IDs.OrgID.LinkID := LEFT.orgid;
																										SELF.BIP_IDs.SeleID.LinkID := LEFT.seleid;
																										
																										
																										SELF.Clean_Input.CompanyName := LEFT.company_Name;
																										SELF.Clean_Input.FEIN := LEFT.company_fein;
																										SELF.Clean_Input.Phone10 := LEFT.company_phone;
																										
																										SELF.Clean_Input.Prim_Range := LEFT.prim_range;
																										SELF.Clean_Input.Predir := LEFT.predir;
																										SELF.Clean_Input.Prim_Name := LEFT.prim_name;
																										SELF.Clean_Input.Addr_Suffix := LEFT.addr_suffix;
																										SELF.Clean_Input.Postdir := LEFT.postdir;
																										SELF.Clean_Input.Unit_Desig := LEFT.unit_desig;
																										SELF.Clean_Input.Sec_Range := LEFT.sec_range;
																										SELF.Clean_Input.City := LEFT.v_city_name;  // use v_city_name 90..114 to match all other scoring products
																										SELF.Clean_Input.State := LEFT.st;
																										SELF.Clean_Input.Zip := LEFT.zip + LEFT.zip4;
																										SELF.Clean_Input.Zip5 := LEFT.zip;
																										SELF.Clean_Input.Zip4 := LEFT.zip4;
																										SELF.Clean_Input.Lat := LEFT.geo_lat;
																										SELF.Clean_Input.Long := LEFT.geo_long;
																										SELF.Clean_Input.Addr_Type := LEFT.rec_type;
																										SELF.Clean_Input.Addr_Status := LEFT.err_stat;
																										SELF.Clean_Input.Geo_Block := LEFT.geo_blk;
																									
																										SELF.Clean_Input.HistoryDate := LEFT.historyDate; // If HistoryDate no populated run in "realtime" mode

																										SELF.Clean_Input := LEFT; // Fill out the remaining fields with what was passed in

																										SELF := [];));



	allowedSourcesSet := SET(DATASET([], Business_Risk_BIP.Layout_AllowedSources), Source); //as of 5/26/17 not used in BIP_Best_Append
	
	bestAppend := Business_Risk_BIP.BIP_Best_Append(convertedToShell, options, linkingOptions, allowedSourcesSet);

	//keep top 100 linked business - has best fein, best phone
  SortLinked := sort(bestAppend(Clean_Input.StreetAddress1 <> ''), seq, BIP_IDs.UltID.LinkID, BIP_IDs.OrgID.LinkID, BIP_IDs.SeleID.LinkID, if(Clean_Input.FEIN = '', '999999999', Clean_Input.FEIN), if(Clean_Input.Phone10 = '', '9999999999', Clean_Input.Phone10));
	TopLinked := dedup(SortLinked, seq, BIP_IDs.UltID.LinkID, BIP_IDs.OrgID.LinkID, BIP_IDs.SeleID.LinkID, keep(100));		

	linkedBus := JOIN(inData, TopLinked,
										LEFT.seq = RIGHT.seq AND
										LEFT.Busn_Info.BIP_IDs.UltID.LinkID = RIGHT.BIP_IDs.UltID.LinkID AND
										LEFT.Busn_Info.BIP_IDs.SeleID.LinkID <> RIGHT.BIP_IDs.SeleID.LinkID,
										TRANSFORM(DueDiligence.Layouts.Busn_Internal,
															SELF.busn_info.BIP_IDs := RIGHT.BIP_IDs;
															SELF.historyDate := RIGHT.Clean_Input.HistoryDate;
															SELF.relatedDegree := DueDiligence.Constants.LINKED_BUSINESS_DEGREE;
															
															SELF.busn_info.companyName := RIGHT.clean_input.companyName;
															SELF.busn_info.altCompanyName := RIGHT.clean_input.altCompanyName;
															SELF.busn_info.fein := RIGHT.clean_input.fein;
															SELF.busn_info.phone := RIGHT.clean_input.phone10;
															
															SELF.busn_info.address := RIGHT.clean_input;
															SELF.busn_info.address.geo_lat := RIGHT.clean_input.lat;
															SELF.busn_info.address.geo_long := RIGHT.clean_input.long;
															SELF.busn_info.address.rec_type := RIGHT.clean_input.addr_type;
															SELF.busn_info.address.err_stat := RIGHT.clean_input.addr_status;
															SELF.busn_info.address.geo_blk := RIGHT.clean_input.geo_block;
															
															//since we are getting the best data anyway just grab it from clean_input again
															SELF.bestCompanyName := RIGHT.clean_input.companyName;
															SELF.bestAddr := RIGHT.clean_input.streetAddress1;
															SELF.bestCity := RIGHT.clean_input.city;
															SELF.bestState := RIGHT.clean_input.state;
															SELF.bestZip := RIGHT.clean_input.zip5;
															SELF.bestZip4 := RIGHT.clean_input.zip4;
															SELF.bestFEIN := RIGHT.clean_input.fein;
															SELF.bestPhone := RIGHT.clean_input.phone10;

															SELF := RIGHT.clean_input;
															SELF := [];));

	
		
	
	// OUTPUT(indata, NAMED('indata'));
	// OUTPUT(linkedBusRaw, NAMED('linkedBusRaw'));
	// OUTPUT(noInquiredBus, NAMED('noInquiredBus'));
	// OUTPUT(convertedToShell, NAMED('convertedToShell'));
	// OUTPUT(bestAppend, NAMED('bestAppend'));
	// OUTPUT(SortLinked, NAMED('SortLinked'));
	// OUTPUT(TopLinked, NAMED('TopLinked'));


		
	RETURN linkedBus;
END;