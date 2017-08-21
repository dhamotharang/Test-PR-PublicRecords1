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
	
	
	
	
	sortByKey := SORT(noInquiredBus, uniqueid, DueDiligence.Constants.mac_ListTop3Linkids());
	dedupByKey := DEDUP(sortByKey, uniqueid, DueDiligence.Constants.mac_ListTop3Linkids());
	
		
	Business_Risk_BIP.Layouts.Shell toBestAppend(dedupByKey le) := TRANSFORM
			SELF.Seq := le.uniqueID;
			SELF.Clean_Input.Seq := le.uniqueID;
			
			SELF.BIP_IDs.seq := le.uniqueID;
			SELF.BIP_IDs.UltID.LinkID := le.ultid;
			SELF.BIP_IDs.OrgID.LinkID := le.orgid;
			SELF.BIP_IDs.SeleID.LinkID := le.seleid;
			
			
			SELF.Clean_Input.CompanyName := le.company_Name;
			SELF.Clean_Input.FEIN := le.company_fein;
			SELF.Clean_Input.Phone10 := le.company_phone;
			
			SELF.Clean_Input.Prim_Range := le.prim_range;
			SELF.Clean_Input.Predir := le.predir;
			SELF.Clean_Input.Prim_Name := le.prim_name;
			SELF.Clean_Input.Addr_Suffix := le.addr_suffix;
			SELF.Clean_Input.Postdir := le.postdir;
			SELF.Clean_Input.Unit_Desig := le.unit_desig;
			SELF.Clean_Input.Sec_Range := le.sec_range;
			SELF.Clean_Input.City := le.v_city_name;  // use v_city_name 90..114 to match all other scoring products
			SELF.Clean_Input.State := le.st;
			SELF.Clean_Input.Zip := le.zip + le.zip4;
			SELF.Clean_Input.Zip5 := le.zip;
			SELF.Clean_Input.Zip4 := le.zip4;
			SELF.Clean_Input.Lat := le.geo_lat;
			SELF.Clean_Input.Long := le.geo_long;
			SELF.Clean_Input.Addr_Type := le.rec_type;
			SELF.Clean_Input.Addr_Status := le.err_stat;
			SELF.Clean_Input.Geo_Block := le.geo_blk;
		
			SELF.Clean_Input.HistoryDate := le.historyDate; // If HistoryDate no populated run in "realtime" mode

			SELF.Clean_Input := le; // Fill out the remaining fields with what was passed in

			SELF := [];
	END;
	
	convertedToShell := PROJECT(dedupByKey, toBestAppend(LEFT));



	allowedSourcesSet := SET(DATASET([], Business_Risk_BIP.Layout_AllowedSources), Source); //as of 5/26/17 not used in BIP_Best_Append
	
	bestAppend := Business_Risk_BIP.BIP_Best_Append(convertedToShell, options, linkingOptions, allowedSourcesSet);
	bestCleanAppend := bestAppend.Clean_Input;
	
	//keep top 100 linked business - has best fein, best phone
	SortLinked := sort(bestAppend(Clean_Input.StreetAddress1 <> ''), seq, DueDiligence.Constants.mac_ListTop3Linkids(), if(Clean_Input.FEIN ='', '999999999', Clean_Input.FEIN), if(Clean_Input.Phone10 = '', '9999999999', Clean_Input.Phone10));
	TopLinked := dedup(SortLinked, seq, DueDiligence.Constants.mac_ListTop3Linkids(), keep(100));		

				
	DueDiligence.Layouts.Busn_Internal fromAppend(Business_Risk_BIP.Layouts.Shell le) := TRANSFORM
		SELF.busn_info.BIP_IDs := le.BIP_IDs;
		SELF.historyDate := le.Clean_Input.HistoryDate;
		SELF.relatedDegree := DueDiligence.Constants.LINKED_BUSINESS_DEGREE;
		
		SELF.busn_info.companyName := le.clean_input.companyName;
		SELF.busn_info.altCompanyName := le.clean_input.altCompanyName;
		SELF.busn_info.fein := le.clean_input.fein;
		SELF.busn_info.phone := le.clean_input.phone10;
		
		SELF.busn_info.address := le.clean_input;
		SELF.busn_info.address.geo_lat := le.clean_input.lat;
		SELF.busn_info.address.geo_long := le.clean_input.long;
		SELF.busn_info.address.rec_type := le.clean_input.addr_type;
		SELF.busn_info.address.err_stat := le.clean_input.addr_status;
		SELF.busn_info.address.geo_blk := le.clean_input.geo_block;
		
		//since we are getting the best data anyway just grab it from clean_input again
		SELF.bestCompanyName := le.clean_input.companyName;
		SELF.bestAddr := le.clean_input.streetAddress1;
		SELF.bestCity := le.clean_input.city;
		SELF.bestState := le.clean_input.state;
		SELF.bestZip := le.clean_input.zip5;
		SELF.bestZip4 := le.clean_input.zip4;
		SELF.bestFEIN := le.clean_input.fein;
		SELF.bestPhone := le.clean_input.phone10;

		SELF := le.clean_input;
		SELF := [];		
	END;

	linkedBus := JOIN(inData, TopLinked,
										LEFT.seq = RIGHT.seq AND
										LEFT.Busn_Info.BIP_IDs.UltID.LinkID = RIGHT.BIP_IDs.UltID.LinkID AND
										LEFT.Busn_Info.BIP_IDs.SeleID.LinkID <> RIGHT.BIP_IDs.SeleID.LinkID,
										fromAppend(RIGHT));

	
		
	
	// OUTPUT(indata, NAMED('indata'));
	// OUTPUT(linkedBusRaw, NAMED('linkedBusRaw'));
	// OUTPUT(noInquiredBus, NAMED('noInquiredBus'));
	// OUTPUT(convertedToShell, NAMED('convertedToShell'));
	// OUTPUT(bestAppend, NAMED('bestAppend'));
	// OUTPUT(SortLinked, NAMED('SortLinked'));
	// OUTPUT(TopLinked, NAMED('TopLinked'));


		
	RETURN linkedBus;
END;