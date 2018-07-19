IMPORT BIPV2, Business_Risk, Business_Risk_BIP, MDR, UT;

emptyRecord := dataset([{1}], {unsigned a});

EXPORT getWatchlists(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// Project our shell input into the appropriate layout, only the Company Name and Alt Company Name fields are used in watchlist searching
	watchlistInputPrep := PROJECT(Shell, TRANSFORM(Business_Risk.Layout_Output,
																				SELF.Seq := LEFT.Seq;
																				SELF.Company_Name := LEFT.Clean_Input.CompanyName;
																				SELF.Alt_Company_Name := LEFT.Clean_Input.AltCompanyName;
																				SELF := []));
	
	// getWatshlists2 expects grouped input
	watchlistInput := GROUP(SORT(watchlistInputPrep, Seq), Seq);
	
	// Get the watchlist results.  To simplify watchlist searching we are only supporting the custom watchlist set (Could include 'ALL', 'OFA', 'OFC', 'OSC', 'BES', 'CFT', etc etc) - See Patriot.WL_Include_Keys for the full list.
	// By doing this it eliminates all of the extra OFAC_Only/Include_OFAC/Include_Additional_Watchlists input options that really can be accomplished with the Watchlists_Requested input dataset
  OFAC_Only := FALSE;
  Include_OFAC_Temp := if(options.OFAC_Version = 1, false, true);
  Include_OFAC := Include_OFAC_Temp;
	Include_Additional_Watchlists := FALSE;
  From_BIID := FALSE; // Interestingly this field doesn't do anything in getWatchlists2...
	// Don't attempt to grab watchlists unless we actually have some in the list...
	watchlistResults := IF(COUNT(Options.Watchlists_Requested) <= 0, DATASET([], Business_Risk.Layout_Output),
																																	 UNGROUP(Business_Risk.getWatchLists2(watchlistInput, OFAC_Only, From_BIID, Options.OFAC_Version, Include_OFAC, Include_Additional_Watchlists, Options.Global_Watchlist_Threshold, Options.Watchlists_Requested, options.gateways)));

	Business_Risk_BIP.Layouts.Shell combineResults(Business_Risk_BIP.Layouts.Shell le, Business_Risk.Layout_Output ri) := TRANSFORM
		// Rather than keeping the funky flat layout - move it all into a dataset structure
		watchlist1 := PROJECT(emptyRecord, TRANSFORM(Business_Risk_BIP.Layouts.LayoutWatchlist,
													SELF.Watchlist_Seq := 1;
													SELF.Watchlist_Table := ri.Watchlist_Table;
													SELF.Watchlist_Record_Number := ri.Watchlist_Record_Number;
													SELF.Watchlist_Program := ri.Watchlist_Program;
													SELF.Watchlist_Cmpy := ri.Watchlist_Cmpy;
													SELF.Watchlist_Address := ri.Watchlist_Address;
													SELF.Watchlist_City := ri.Watchlist_City;
													SELF.Watchlist_State := ri.Watchlist_State;
													SELF.Watchlist_Zip := ri.Watchlist_Zip;
													SELF.Watchlist_Country := ri.Watchlist_Country;
													SELF.Watchlist_FName := ri.Watchlist_FName;
													SELF.Watchlist_LName := ri.Watchlist_LName;
													SELF := []));
		watchlist2 := PROJECT(emptyRecord, TRANSFORM(Business_Risk_BIP.Layouts.LayoutWatchlist,
													SELF.Watchlist_Seq := 2;
													SELF.Watchlist_Table := ri.Watchlist_Table_2;
													SELF.Watchlist_Record_Number := ri.Watchlist_Record_Number_2;
													SELF.Watchlist_Program := ri.Watchlist_Program_2;
													SELF.Watchlist_Cmpy := ri.Watchlist_Cmpy_2;
													SELF.Watchlist_Address := ri.Watchlist_Address_2;
													SELF.Watchlist_City := ri.Watchlist_City_2;
													SELF.Watchlist_State := ri.Watchlist_State_2;
													SELF.Watchlist_Zip := ri.Watchlist_Zip_2;
													SELF.Watchlist_Country := ri.Watchlist_Country_2;
													SELF.Watchlist_FName := ri.Watchlist_FName_2;
													SELF.Watchlist_LName := ri.Watchlist_LName_2;
													SELF := []));
		watchlist3 := PROJECT(emptyRecord, TRANSFORM(Business_Risk_BIP.Layouts.LayoutWatchlist,
													SELF.Watchlist_Seq := 3;
													SELF.Watchlist_Table := ri.Watchlist_Table_3;
													SELF.Watchlist_Record_Number := ri.Watchlist_Record_Number_3;
													SELF.Watchlist_Program := ri.Watchlist_Program_3;
													SELF.Watchlist_Cmpy := ri.Watchlist_Cmpy_3;
													SELF.Watchlist_Address := ri.Watchlist_Address_3;
													SELF.Watchlist_City := ri.Watchlist_City_3;
													SELF.Watchlist_State := ri.Watchlist_State_3;
													SELF.Watchlist_Zip := ri.Watchlist_Zip_3;
													SELF.Watchlist_Country := ri.Watchlist_Country_3;
													SELF.Watchlist_FName := ri.Watchlist_FName_3;
													SELF.Watchlist_LName := ri.Watchlist_LName_3;
													SELF := []));
		watchlist4 := PROJECT(emptyRecord, TRANSFORM(Business_Risk_BIP.Layouts.LayoutWatchlist,
													SELF.Watchlist_Seq := 4;
													SELF.Watchlist_Table := ri.Watchlist_Table_4;
													SELF.Watchlist_Record_Number := ri.Watchlist_Record_Number_4;
													SELF.Watchlist_Program := ri.Watchlist_Program_4;
													SELF.Watchlist_Cmpy := ri.Watchlist_Cmpy_4;
													SELF.Watchlist_Address := ri.Watchlist_Address_4;
													SELF.Watchlist_City := ri.Watchlist_City_4;
													SELF.Watchlist_State := ri.Watchlist_State_4;
													SELF.Watchlist_Zip := ri.Watchlist_Zip_4;
													SELF.Watchlist_Country := ri.Watchlist_Country_4;
													SELF.Watchlist_FName := ri.Watchlist_FName_4;
													SELF.Watchlist_LName := ri.Watchlist_LName_4;
													SELF := []));
		watchlist5 := PROJECT(emptyRecord, TRANSFORM(Business_Risk_BIP.Layouts.LayoutWatchlist,
													SELF.Watchlist_Seq := 5;
													SELF.Watchlist_Table := ri.Watchlist_Table_5;
													SELF.Watchlist_Record_Number := ri.Watchlist_Record_Number_5;
													SELF.Watchlist_Program := ri.Watchlist_Program_5;
													SELF.Watchlist_Cmpy := ri.Watchlist_Cmpy_5;
													SELF.Watchlist_Address := ri.Watchlist_Address_5;
													SELF.Watchlist_City := ri.Watchlist_City_5;
													SELF.Watchlist_State := ri.Watchlist_State_5;
													SELF.Watchlist_Zip := ri.Watchlist_Zip_5;
													SELF.Watchlist_Country := ri.Watchlist_Country_5;
													SELF.Watchlist_FName := ri.Watchlist_FName_5;
													SELF.Watchlist_LName := ri.Watchlist_LName_5;
													SELF := []));
		watchlist6 := PROJECT(emptyRecord, TRANSFORM(Business_Risk_BIP.Layouts.LayoutWatchlist,
													SELF.Watchlist_Seq := 6;
													SELF.Watchlist_Table := ri.Watchlist_Table_6;
													SELF.Watchlist_Record_Number := ri.Watchlist_Record_Number_6;
													SELF.Watchlist_Program := ri.Watchlist_Program_6;
													SELF.Watchlist_Cmpy := ri.Watchlist_Cmpy_6;
													SELF.Watchlist_Address := ri.Watchlist_Address_6;
													SELF.Watchlist_City := ri.Watchlist_City_6;
													SELF.Watchlist_State := ri.Watchlist_State_6;
													SELF.Watchlist_Zip := ri.Watchlist_Zip_6;
													SELF.Watchlist_Country := ri.Watchlist_Country_6;
													SELF.Watchlist_FName := ri.Watchlist_FName_6;
													SELF.Watchlist_LName := ri.Watchlist_LName_6;
													SELF := []));
		watchlist7 := PROJECT(emptyRecord, TRANSFORM(Business_Risk_BIP.Layouts.LayoutWatchlist,
													SELF.Watchlist_Seq := 7;
													SELF.Watchlist_Table := ri.Watchlist_Table_7;
													SELF.Watchlist_Record_Number := ri.Watchlist_Record_Number_7;
													SELF.Watchlist_Program := ri.Watchlist_Program_7;
													SELF.Watchlist_Cmpy := ri.Watchlist_Cmpy_7;
													SELF.Watchlist_Address := ri.Watchlist_Address_7;
													SELF.Watchlist_City := ri.Watchlist_City_7;
													SELF.Watchlist_State := ri.Watchlist_State_7;
													SELF.Watchlist_Zip := ri.Watchlist_Zip_7;
													SELF.Watchlist_Country := ri.Watchlist_Country_7;
													SELF.Watchlist_FName := ri.Watchlist_FName_7;
													SELF.Watchlist_LName := ri.Watchlist_LName_7;
													SELF := []));
		WatchlistHits := (watchlist1 + watchlist2 + watchlist3 + watchlist4 + watchlist5 + watchlist6 + watchlist7) (TRIM(Watchlist_Record_Number) <> '');
		SELF.WatchlistHits := WatchlistHits;
		OFACHit := EXISTS(WatchlistHits((Watchlist_Table <> '' AND watchlist_record_number[1..4] IN ['OFAC', 'OFC']) OR watchlist_table='OFC'));
		OtherHit := EXISTS(WatchlistHits(Watchlist_Table <> '' AND watchlist_record_number[1..4] NOT IN ['OFAC', 'OFC'] AND watchlist_table<>'OFC'));
		SELF.Verification.VerWatchlistNameMatch := MAP(TRIM(le.Clean_Input.CompanyName) = '' AND TRIM(le.Clean_Input.AltCompanyName) = '' => '-1',
																									 NOT OFACHit AND NOT OtherHit 																											=> '0',
																									 OtherHit AND NOT OFACHit 																													=> '1',
																									 OFACHit AND NOT OtherHit 																													=> '2',
																									 OFACHit AND OtherHit 																															=> '3',
																																																																				 '0');
		SELF := le;
	END;
	finalResults := JOIN(Shell, watchlistResults, LEFT.Seq = RIGHT.Seq, 
												combineResults(LEFT, RIGHT), KEEP(1), ATMOST(100), FEW);
	
	RETURN(finalResults);
END;