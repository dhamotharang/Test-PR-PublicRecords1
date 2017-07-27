Import Gateway, IESP, lib_stringlib, Risk_Indicators,Business_Risk;

export FormatXG5_BIIDWatchlist2 (DATASET(OFAC_XG5.Layout.ResponseRec) responseXG5) 	:= FUNCTION


NonErrorRecs := responseXG5(errormessage = '');

EntityMatches := RECORD
  string ErrorMessage ;
	OFAC_XG5.Layout.EntityMatch   ;
	OFAC_XG5.Layout.AKABestMatches   -blockid -EntitySeq ;
	OFAC_XG5.Layout.AddressMatches  -blockid -EntitySeq ;
	OFAC_XG5.Layout.ResultMatchFile  -blockid -EntitySeq ;

END;


PrepEntity := project(NonErrorRecs, 
														transform(EntityMatches, 
																			self.ErrorMessage := left.ErrorMessage,
																			self := left.entityRec[1],
																			BestAKA := left.akaRec(bestId = akaID);
																			self := BestAKA[1],
																			self := [];
														));
														
														
																											
AddAddr := join(	PrepEntity, NonErrorRecs.addrRec(AddressID = 1),  //only want 1 address
									left.BlockID = right.blockid and
									left.EntitySeq = right.EntitySeq,
									transform(EntityMatches,
														self.ErrorMessage := left.ErrorMessage,
														self.BlockID := left.blockid,
														self.EntitySeq := left.EntitySeq,
														self := right,
														self := left,
														self := [];), left outer);
																											
AddFile := join(	AddAddr, NonErrorRecs.FileRec,
									left.BlockID = right.blockid and
									left.EntitySeq = right.EntitySeq,
									transform(EntityMatches,
														self.ErrorMessage := left.ErrorMessage,
														self.BlockID := left.blockid,
														self.EntitySeq := left.EntitySeq,
														self.EntityTypeDesc := if(left.EntityTypeDesc ='', 'Unknown', left.EntityTypeDesc);
														self := right,
														self := left;), left outer);		
														
	dedupRespXG5 := dedup(sort(NonErrorRecs, blockid, entityseq),blockid);
//for testing	
	// top_matchesTemp :=  group(choosen(sort(AddFile,blockid, -(unsigned)(EntityPartyKey[1..4]='OFAC'),
			// -EntityTypeDesc,-EntitymatchScore, EntityPartyKey), 7),blockid);



Business_Risk.layout_output FormatWL( dedupRespXG5 le) := transform
  
  top_matches := group(choosen(sort(AddFile(blockid = le.blockid),blockid, 
			-(unsigned)(EntityPartyKey[1..4]='OFAC'),-EntityTypeDesc,-EntitymatchScore, EntityPartyKey), 7),blockid);

  CurrentMatches := join(dedupRespXG5, top_matches,   
														left.BlockID = right.blockid, 
														transform(EntityMatches, self := right));
	watchlists_temp := project(CurrentMatches, 	
											transform(risk_indicators.layouts.layout_watchlists, 
																sourceLength := length(left.FileName);
																self.watchlist_table := if(left.errormessage <> '', 'ERR', left.FileName[1..(sourceLength - 4)]); 
																self.watchlist_program := OFAC_XG5.Program_lookup(lib_stringlib.stringlib.StringToUpperCase(trim(left.EntityReason)));
																SELF.watchlist_record_number := left.EntityPartyKey;
																SELF.watchlist_contry := left.country;
																SELF.watchlist_entity_name := left.BestName,
																SELF.watchlist_fname := If(left.BestID = 0, left.entitynamefirst,
																														left.FirstName);
																SELF.watchlist_lname := If(left.BestID = 0, left.EntityNameLast,
																														left.LastName);

																noaddr := left.StreetAddress1 = '' and left.PostalCode = '';
																clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( left.StreetAddress1, left.city, left.state, left.PostalCode );		
																SELF.watchlist_address := 	trim(left.StreetAddress1) ;
																// parsed watchlist address
																SELF.WatchlistPrimRange := if(noaddr, '', clean_a2[1..10]);	
																SELF.WatchlistPreDir := if(noaddr, '', clean_a2[11..12]);
																SELF.WatchlistPrimName := if(noaddr, '', clean_a2[13..40]);
																SELF.WatchlistAddrSuffix := if(noaddr, '', clean_a2[41..44]);
																SELF.WatchlistPostDir := if(noaddr, '', clean_a2[45..46]);
																SELF.WatchlistUnitDesignation := if(noaddr, '', clean_a2[47..56]);
																SELF.WatchlistSecRange := if(noaddr, '', clean_a2[57..64]);
																SELF.watchlist_city := trim(left.city);
																SELF.watchlist_state := if(noaddr,'' ,clean_a2[115..116]);
																SELF.watchlist_zip := if(noaddr,'', clean_a2[117..121]);
																));
	
	// keep these fields here for all of our legacy products still using them
	SELF.watchlist_table := watchlists_temp[1].watchlist_table;
	SELF.watchlist_program := watchlists_temp[1].watchlist_program;
	SELF.watchlist_record_number := watchlists_temp[1].watchlist_record_number;
	SELF.watchlist_country := watchlists_temp[1].watchlist_contry;
	SELF.watchlist_fname := watchlists_temp[1].watchlist_fname;
	SELF.watchlist_lname := watchlists_temp[1].watchlist_lname;
	SELF.watchlist_address := watchlists_temp[1].watchlist_address;
	SELF.watchlist_city := watchlists_temp[1].watchlist_city;
	SELF.watchlist_state := watchlists_temp[1].watchlist_state;
	SELF.watchlist_zip := watchlists_temp[1].watchlist_zip;
	SELF.watchlist_cmpy := watchlists_temp[1].watchlist_entity_name;

	
	SELF.watchlist_table_2 := watchlists_temp[2].watchlist_table;
	SELF.watchlist_program_2 := watchlists_temp[2].watchlist_program;
	SELF.watchlist_record_number_2 := watchlists_temp[2].watchlist_record_number;
	SELF.watchlist_country_2 := watchlists_temp[2].watchlist_contry;
	SELF.watchlist_fname_2 := watchlists_temp[2].watchlist_fname;
	SELF.watchlist_lname_2 := watchlists_temp[2].watchlist_lname;
	SELF.watchlist_address_2 := watchlists_temp[2].watchlist_address;
	SELF.watchlist_city_2 := watchlists_temp[2].watchlist_city;
	SELF.watchlist_state_2 := watchlists_temp[2].watchlist_state;
	SELF.watchlist_zip_2 := watchlists_temp[2].watchlist_zip;
	SELF.watchlist_cmpy_2 := watchlists_temp[2].watchlist_entity_name;
	
	SELF.watchlist_table_3 := watchlists_temp[3].watchlist_table;
	SELF.watchlist_program_3 := watchlists_temp[3].watchlist_program;
	SELF.watchlist_record_number_3 := watchlists_temp[3].watchlist_record_number;
	SELF.watchlist_country_3 := watchlists_temp[3].watchlist_contry;
	SELF.watchlist_fname_3 := watchlists_temp[3].watchlist_fname;
	SELF.watchlist_lname_3 := watchlists_temp[3].watchlist_lname;
	SELF.watchlist_address_3 := watchlists_temp[3].watchlist_address;
	SELF.watchlist_city_3 := watchlists_temp[3].watchlist_city;
	SELF.watchlist_state_3 := watchlists_temp[3].watchlist_state;
	SELF.watchlist_zip_3 := watchlists_temp[3].watchlist_zip;
	SELF.watchlist_cmpy_3 := watchlists_temp[3].watchlist_entity_name;
	
	SELF.watchlist_table_4 := watchlists_temp[4].watchlist_table;
	SELF.watchlist_program_4 := watchlists_temp[4].watchlist_program;
	SELF.watchlist_record_number_4 := watchlists_temp[4].watchlist_record_number;
	SELF.watchlist_country_4 := watchlists_temp[4].watchlist_contry;
	SELF.watchlist_fname_4 := watchlists_temp[4].watchlist_fname;
	SELF.watchlist_lname_4 := watchlists_temp[4].watchlist_lname;
	SELF.watchlist_address_4 := watchlists_temp[4].watchlist_address;
	SELF.watchlist_city_4 := watchlists_temp[4].watchlist_city;
	SELF.watchlist_state_4 := watchlists_temp[4].watchlist_state;
	SELF.watchlist_zip_4 := watchlists_temp[4].watchlist_zip;
	SELF.watchlist_cmpy_4 := watchlists_temp[4].watchlist_entity_name;
	
	SELF.watchlist_table_5 := watchlists_temp[5].watchlist_table;
	SELF.watchlist_program_5 := watchlists_temp[5].watchlist_program;
	SELF.watchlist_record_number_5 := watchlists_temp[5].watchlist_record_number;
	SELF.watchlist_country_5 := watchlists_temp[5].watchlist_contry;
	SELF.watchlist_fname_5 := watchlists_temp[5].watchlist_fname;
	SELF.watchlist_lname_5 := watchlists_temp[5].watchlist_lname;
	SELF.watchlist_address_5 := watchlists_temp[5].watchlist_address;
	SELF.watchlist_city_5 := watchlists_temp[5].watchlist_city;
	SELF.watchlist_state_5 := watchlists_temp[5].watchlist_state;
	SELF.watchlist_zip_5 := watchlists_temp[5].watchlist_zip;
	SELF.watchlist_cmpy_5 := watchlists_temp[5].watchlist_entity_name;
	
	SELF.watchlist_table_6 := watchlists_temp[6].watchlist_table;
	SELF.watchlist_program_6 := watchlists_temp[6].watchlist_program;
	SELF.watchlist_record_number_6 := watchlists_temp[6].watchlist_record_number;
	SELF.watchlist_country_6 := watchlists_temp[6].watchlist_contry;
	SELF.watchlist_fname_6 := watchlists_temp[6].watchlist_fname;
	SELF.watchlist_lname_6 := watchlists_temp[6].watchlist_lname;
	SELF.watchlist_address_6 := watchlists_temp[6].watchlist_address;
	SELF.watchlist_city_6 := watchlists_temp[6].watchlist_city;
	SELF.watchlist_state_6 := watchlists_temp[6].watchlist_state;
	SELF.watchlist_zip_6 := watchlists_temp[6].watchlist_zip;
	SELF.watchlist_cmpy_6 := watchlists_temp[6].watchlist_entity_name;
	
	SELF.watchlist_table_7 := watchlists_temp[7].watchlist_table;
	SELF.watchlist_program_7 := watchlists_temp[7].watchlist_program;
	SELF.watchlist_record_number_7 := watchlists_temp[7].watchlist_record_number;
	SELF.watchlist_country_7 := watchlists_temp[7].watchlist_contry;
	SELF.watchlist_fname_7 := watchlists_temp[7].watchlist_fname;
	SELF.watchlist_lname_7 := watchlists_temp[7].watchlist_lname;
	SELF.watchlist_address_7 := watchlists_temp[7].watchlist_address;
	SELF.watchlist_city_7 := watchlists_temp[7].watchlist_city;
	SELF.watchlist_state_7 := watchlists_temp[7].watchlist_state;
	SELF.watchlist_zip_7 := watchlists_temp[7].watchlist_zip;
	SELF.watchlist_cmpy_7 := watchlists_temp[7].watchlist_entity_name;
	self := le;
	self := [];
end;


FormatWLOut := project(dedupRespXG5, 														
														FormatWL(left));		
														

// output(NonErrorRecs, named('NonErrorRecsBIID'),overwrite);
// output(dedupRespXG5, named('dedupRespXG5BIID'),overwrite);
// output(AddFile, named('AddFileBIID'),overwrite);
// output(top_matchesTemp, named('top_matchesTempBIID'),overwrite);
// output(normEntityRemarks, named('normEntityRemarks'));
// output(AllRemarks, named('AllRemarks'));
// output(filled_outXG5, named('filled_outXG5'));
// output(FormatWatchlistOut, named('FormatWatchlistOutBIID'), overwrite);


RETURN FormatWLOut;
END;