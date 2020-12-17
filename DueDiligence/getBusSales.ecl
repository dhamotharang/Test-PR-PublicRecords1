IMPORT BIPV2, Business_Risk_BIP, DueDiligence, EBR, Doxie;

/*
	Following Keys being used:
			EBR.Key_5600_Demographic_Data_linkids.kFetch2
*/

EXPORT getBusSales(DATASET(DueDiligence.Layouts.Busn_Internal) busInfo,
											Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
											BIPV2.mod_sources.iParams linkingOptions,
                                            doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

	linkIDs := DueDiligence.CommonBusiness.GetLinkIDs(busInfo);
		
	// ---------------- EBR - Experian Business Records ------------------
	ebr5600Raw := EBR.Key_5600_Demographic_Data_linkids.kFetch2(linkIDs, mod_access,
																															 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																															 0, //ScoreThreshold --> 0 = Give me everything
																															 linkingOptions,
																															 Business_Risk_BIP.Constants.Limit_Default,
																															 Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	ebr5600RawSeq := DueDiligence.CommonBusiness.AppendSeq(ebr5600Raw, busInfo, TRUE);

	// Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	ebrDateClean := DueDiligence.Common.CleanDatasetDateFields(ebr5600RawSeq, 'date_last_seen, date_first_seen');
	
	// Filter out records after our history date.
	ebrFilt := DueDiligence.CommonDate.FilterRecordsSingleDate(ebrDateClean, date_first_seen);
	
  // Sort the records by record_type (to get current first) and then by date_last_seen desc (to get last reported) and then by sales_actual desc (to get largest)
	ebrSorted := SORT(ebrFilt, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), record_type, -date_last_seen, -sales_actual);
	
	//grab unique sales and dates
	dedupEBR := DEDUP(ebrSorted, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	
	// Because the data team botched the conversion process Sales_Actual contains characters, and rather than fix the data they created a function to translate the characters to the correct numbers  
	withEBR5600Stats := JOIN(busInfo, dedupEBR, 
																	#EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
																	TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.sales := (INTEGER8)IF(EBR.fFix_amount_codes(RIGHT.Sales_Actual) = '', 0,(INTEGER)EBR.fFix_amount_codes(RIGHT.Sales_Actual)*100);
																		SELF.salesYearReported := (STRING4)(((STRING)RIGHT.date_last_seen)[1..4]);
																		SELF := LEFT),
																	LEFT OUTER, KEEP(DueDiligence.Constants.MAX_ATMOST_1), ATMOST(DueDiligence.Constants.MAX_ATMOST_100), FEW);
																	

		
	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(busInfo, 100), NAMED('Sample_busInfo'));
	// OUTPUT(CHOOSEN(EBR5600Raw, 100), NAMED('Sample_EBR5600Raw'));
	// OUTPUT(CHOOSEN(ebr5600RawSeq, 100), NAMED('Sample_ebr5600RawSeq'));
	// OUTPUT(CHOOSEN(ebrDateClean, 100), NAMED('Sample_ebrDateClean'));
	// OUTPUT(CHOOSEN(ebrFilt, 100), NAMED('Sample_ebrFilt'));
	// OUTPUT(CHOOSEN(ebrSorted, 100), NAMED('Sample_ebrSorted'));
	// OUTPUT(CHOOSEN(dedupEBR, 100), NAMED('Sample_dedupEBR'));
	// OUTPUT(CHOOSEN(withEBR5600Stats, 100), NAMED('Sample_withEBR5600Stats'));
 

	RETURN withEBR5600Stats;
END;