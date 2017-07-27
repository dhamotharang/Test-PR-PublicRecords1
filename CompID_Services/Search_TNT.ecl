/*
This common function is called by: Query_Enhancement_Service_TNTBestAddr
*/

IMPORT CompId_Services, Address, DidVille, Doxie, ut;

export Search_TNT := Module

	/* Main function to return result with name, addresses and driver's license */
	EXPORT getGenResult_V1(DATASET(DidVille.Layout_Did_OutBatch) infile,
															 BOOLEAN GLBin, UNSIGNED3 MinScore,
															 UNSIGNED4 maxrecordstoreturnIN,
															 BOOLEAN UseNoEQBest) := FUNCTION

		Dedup_these := false; appends     := 'BEST_ALL';
		ValiddSSN		:= true; NonBlankFields := true;

		DummyResult := PROJECT (infile, TRANSFORM(CompId_Services.Layouts.Layout_CompId_Result, SELF.seq := LEFT.seq, SELF := []));

		// Get the DIDs matching the inquiry
		DidVille.MAC_DidAppend(infile, DID_Hits, Dedup_these, 'Z4G');
		DID_Hits_With_Score := Mod_TNT.cleanupDIDs(DID_Hits, appends, MinScore);
		
		// Get Address History
		AddressHist := Mod_TNT.getAddressHistory(DID_Hits_With_Score, GLBin);

		// Candidates with TNT score of B and V or C.
		BVHist	:= AddressHist(tnt IN ['B', 'V']);
		CHist	:= AddressHist(tnt = 'C');

		AllScore	:= MAX(DID_Hits_With_Score, score_any_ssn) + MAX(DID_Hits_With_Score, score_any_addr) + MAX(DID_Hits_With_Score, score_any_dob);
		FzzyScore	:= MAX(DID_Hits_With_Score, score_any_fzzy);
		
		// Results
		ResultFromBV := Mod_TNT_C.getResultFromHeader(BVHist, 'B');
		ResultFromC  := Mod_TNT_C.getResultFromHeader(CHist, 'C');
		ResultFromMS := Mod_TNT.getMSNameAndAddress(DID_Hits_With_Score, AddressHist, ValiddSSN, NonBlankFields, UseNoEQBest);
		
		ResultWithNameAndAddress := MAP (COUNT(UNGROUP(DID_Hits_With_Score)) > 1 => DummyResult,
																		 AllScore = 0 AND FzzyScore <> 0 => DummyResult,
																		 EXISTS(BVHist) => ResultFromBV,
																		 EXISTS(ResultFromMS) => ResultFromMS,
																		 ResultFromC);
		
		// Get the DL info
		ResultWithDL := Mod_TNT.getDriverLicence(ResultWithNameAndAddress);

		// OUTPUT (DID_Hits, NAMED('DID_Hits'));
		// OUTPUT (DID_Hits_With_Score, NAMED('DID_Hits_With_Score'));
		// OUTPUT (AddressHist, NAMED('AddressHist'));
		// OUTPUT (BR_Or_MS_Result, NAMED('BR_Or_MS_Result'));
		// OUTPUT (ResultWithNameAndAddress, NAMED('ResultWithNameAndAddress'));

		RETURN IF (EXISTS(ResultWithDL), ResultWithDL, DummyResult);
	END;
	
	// Format input request for TNT search
	EXPORT getGenResult (unsigned4 seq_value, string11 ssn_value, string8 dob_value, string120 addr1_val, string120 addr2_val, string30 fname_val,
					string30 lname_val, string30 mname_val, string5 suffix_val, string2 state_val, string25 city_val, string6 zip_value,
					string1  gender_val, STRING2	 DLState_val, STRING25 DLNumber_val, string10 prange_value, string10 sec_range_value,
					string30 pname_value, string120 name_value, unsigned  min_score, unsigned4 maxrecordstoreturn, boolean UseNoEQBest) := FUNCTION 
					
			rec := record
				unsigned1 seq;
			end;
			d := dataset([{1}],rec);

			a2_val := if (addr2_val != '',addr2_val,city_val + ' ' + state_val + ' ' + zip_value);
			a1_val := if(addr1_val != '', addr1_val,
											Address.Addr1FromComponents(prange_value, ' ', pname_value,
																									' ', ' ', ' ', sec_range_value));

			clean_a2    := if(addr1_val<>'' or a2_val<>'', doxie.CleanAddress182(Addr1_Val,A2_Val),'');
			clean_n     := datalib.nameclean(name_value);

			didville.Layout_Did_OutBatch into(rec l) := transform
			self.seq         := seq_value;
			self.ssn         := ssn_value;
			self.dob         := dob_value;
			self.phone10     := ' ';
			self.title       := clean_n[121..130];
			self.fname       := if(fname_val='',clean_n[1..40],stringlib.stringtouppercase(fname_val));
			self.mname       := if(mname_val='',clean_n[41..80],stringlib.stringtouppercase(mname_val));
			self.lname       := if(lname_val='',clean_n[81..120],stringlib.stringtouppercase(lname_val));
			self.suffix      := if(suffix_val='',clean_n[131..140],stringlib.stringtouppercase(suffix_val));
			self.prim_range  := IF(prange_value='',clean_a2[1..10],prange_value);
			self.predir      := clean_a2[11..12];
			self.prim_name   := if(pname_value='',clean_a2[13..40],stringlib.stringtouppercase(pname_value));
			self.addr_suffix := clean_a2[41..44];
			self.postdir     := clean_a2[45..46];
			self.unit_desig  := clean_a2[47..56];
			self.sec_range   := if(sec_range_value='',clean_a2[57..65],sec_range_value);
			self.p_city_name := clean_a2[90..114];
			self.st          := clean_a2[115..116];
			self.z5          := clean_a2[117..121];
			self.zip4        := clean_a2[122..125];
			end;

			precs := project(d,into(left));	
			
			Result := getGenResult_V1 (precs, true, min_score, maxrecordstoreturn, UseNoEQBest); 
			
			return Result;
	END;
	
END;	
