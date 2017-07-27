
/*2016-05-18T21:28:42Z (mwalklin)
C:\Users\walkmi01\AppData\Roaming\HPCC Systems\eclide\mwalklin\DatalandDev\OFAC_XG5\OFACXG5_Response\2016-05-18T21_28_42Z.ecl
*/
Import Gateway, IESP, lib_stringlib, Risk_Indicators;

export FormatXG5_Watchlist2 (DATASET(OFAC_XG5.Layout.ResponseRec) responseXG5) 	:= FUNCTION

EntityMatches := RECORD
  string ErrorMessage ;
	OFAC_XG5.Layout.EntityMatch   ;
	OFAC_XG5.Layout.AKABestMatches   -blockid -EntitySeq ;
	OFAC_XG5.Layout.AddressMatches  -blockid -EntitySeq ;
	OFAC_XG5.Layout.ResultMatchFile  -blockid -EntitySeq ;

END;


	
PrepEntity := project(responseXG5, 
														transform(EntityMatches,
																			self.ErrorMessage := left.ErrorMessage,
																			self := left.entityRec[1],
																			BestAKA := left.akaRec(bestId = akaID);
																			self := BestAKA[1],
																			self := [];
														));
														
AddAddr := join(	PrepEntity, responseXG5.addrRec(AddressID = 1),  //only want 1 address
									left.BlockID = right.blockid and
									left.EntitySeq = right.EntitySeq,
									transform(EntityMatches,
														self.ErrorMessage := left.ErrorMessage,
														self.BlockID := left.blockid,
														self.EntitySeq := left.EntitySeq,
														self := right,
														self := left,
														self := [];), left outer);
																											
AddFile := join(	AddAddr, responseXG5.FileRec,
									left.BlockID = right.blockid and
									left.EntitySeq = right.EntitySeq,
									transform(EntityMatches,
														self.ErrorMessage := left.ErrorMessage,
														self.BlockID := left.blockid,
														self.EntitySeq := left.EntitySeq,
														self.EntityTypeDesc := if(left.EntityTypeDesc ='', 'Unknown', left.EntityTypeDesc);
														self := right,
														self := left;), left outer);		
														
	dedupRespXG5 := dedup(sort(responseXG5, blockid, entityseq),blockid);

Risk_Indicators.layout_output FormatWL( dedupRespXG5 le) := transform
  
  top_matches := group(choosen(sort(AddFile(blockid = le.blockid),blockid, -(unsigned)(EntityPartyKey[1..4]='OFAC'),-EntityTypeDesc,-EntitymatchScore, EntityPartyKey), 7),blockid);

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
	self.watchlists := watchlists_temp;	
	
	// keep these fields here for all of our legacy products still using them
	SELF.watchlist_table := if(le.errormessage <> '', 'ERR', watchlists_temp[1].watchlist_table);
	SELF.watchlist_program := watchlists_temp[1].watchlist_program;
	SELF.watchlist_record_number := watchlists_temp[1].watchlist_record_number;
	SELF.watchlist_contry := watchlists_temp[1].watchlist_contry;
	SELF.watchlist_fname := watchlists_temp[1].watchlist_fname;
	SELF.watchlist_lname := watchlists_temp[1].watchlist_lname;
	SELF.watchlist_address := watchlists_temp[1].watchlist_address;
	SELF.WatchlistPrimRange := watchlists_temp[1].WatchlistPrimRange;	
	SELF.WatchlistPreDir := watchlists_temp[1].WatchlistPreDir;
	SELF.WatchlistPrimName := watchlists_temp[1].WatchlistPrimName;
	SELF.WatchlistAddrSuffix := watchlists_temp[1].WatchlistAddrSuffix;
	SELF.WatchlistPostDir := watchlists_temp[1].WatchlistPostDir;
	SELF.WatchlistUnitDesignation := watchlists_temp[1].WatchlistUnitDesignation;
	SELF.WatchlistSecRange := watchlists_temp[1].WatchlistSecRange;
	SELF.watchlist_city := watchlists_temp[1].watchlist_city;
	SELF.watchlist_state := watchlists_temp[1].watchlist_state;
	SELF.watchlist_zip := watchlists_temp[1].watchlist_zip;
	SELF.watchlist_entity_name := watchlists_temp[1].watchlist_entity_name;
	self := le;
	self := [];
end;


FormatWatchlistOut := project(dedupRespXG5, 														
														FormatWL(left));
														

RETURN FormatWatchlistOut;
END;