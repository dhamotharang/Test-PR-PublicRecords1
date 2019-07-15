//MATCHSET should be set of char1's indicating matchfields
/*
   matchset   -    should be set of char1's indicating the indicatives in infile
                          'A' = Address
                          'D' = DOB
                          'S' = ssn
                          'P' = phone
    ***                   'Q' = Address match excluding the fuzzy logic.  Equivalent to setting use_fuzzy = false in previous versions.  Acts the same regardless of whether matchset contains 'A'.
					 '4' = ssn4 matching (last 4 digits of ssn)
					 'G' = age matching
					 'Z' = zip code matching
*/
/*

	In order for this macro to return specific information about how the DID was matched the following
	fields should be in the ouput layout.
		unsigned2 xadl2_weight
		unsigned2 xadl2_score 
		unsigned4  xadl2_keys_used // A bitmap of the keys used
		unsigned2  xadl2_distance 
		string20   xadl2_matches // Indicator of what fields contributed to the DID match.

*/
/*
	The last parameter bool_switch_priority when true follows xadl2 and source
	match.  If false it performs source and then xadl2.
*/



EXPORT Mac_Match_Flex_V2
	(infile, matchset,	//see above
	 ssn_field, dob_field, fname_field, mname_field,lname_field, suffix_field, 
	 prange_field, pname_field, srange_field,zip_field, state_field, phone_field,
	 DID_field,  //these will be set to zero before the linking 			
	 outrec, 
	 bool_outrec_has_score, DID_Score_field,	//these should default to zero in definition
	 low_score_threshold,	//dids with a score below here will be dropped 
	 outfile,
	 bool_infile_has_name_source = 'false', src_field = '',	 
	 bool_outrec_has_indiv_scores='false', score_n_field = 'score_n',// appENDs individual match scores
	 bool_clean_addr = 'false', // re-cleans addresses before trying match. 
	 predir_field = 'predir',addr_suffix_field = 'addr_suffix',postdir_field = 'postdir',
	 udesig_field = 'unit_desig',city_field = 'p_city_name', zip4_field = 'zip4', bool_switch_priority = 'false', weight_threshold=30, distance=3, segmentation=true) 
	:= MACRO	
 import InsuranceHeader_xLink, IDLExternalLinking, Did_Add;
 
	#UNIQUENAME(inf) 	
	#IF (bool_clean_addr)
		#UNIQUENAME(pre_clean_rec)
		#UNIQUENAME(addr1)
		#UNIQUENAME(addr2)
		%pre_clean_rec% := RECORD
			infile;
			STRING120	%addr1%;
			STRING120	%addr2%;
		END;

		#UNIQUENAME(into_clean)
		%pre_clean_rec% %into_clean%(infile L) := TRANSFORM
				SELF.%addr1% := address.Addr1FromComponents(L.prange_field,L.predir_field,
									L.pname_field,L.addr_suffix_field,L.postdir_field,
									L.udesig_field,L.srange_field);
				SELF.%addr2% := address.Addr2FromComponents(l.city_field,L.state_field,L.zip_field+L.zip4_field);
			SELF := L;
		END;

		#UNIQUENAME(file_pre_clean)
		%file_pre_clean% := PROJECT(infile,%into_clean%(LEFT));

		#UNIQUENAME(file_cleaned)
		address.MAC_Address_Clean(%file_pre_clean%,%addr1%,%addr2%,true,%file_cleaned%)

		#UNIQUENAME(clean_fill)
		infile %clean_fill%(%file_cleaned% L) := TRANSFORM
			SELF.prange_field := l.clean[1..10];
			SELF.Predir_field := l.clean[11..12];
			SELF.pname_field := l.clean[13..40];
			SELF.addr_Suffix_field := l.clean[41..44];
			SELF.Postdir_field := l.clean[45..46];
			SELF.udesig_field := l.clean[47..56];
			SELF.SRange_field := l.clean[57..64];
			SELF.City_field := l.clean[65..89];
			SELF.State_field := l.clean[115..116];
			SELF.Zip_field := l.clean[117..121];
			SELF.Zip4_field := l.clean[122..125];
			SELF := L;
		END;

		%inf% := GROUP(PROJECT(%file_cleaned%,%clean_fill%(LEFT)));
	#ELSE
		%inf% := GROUP(infile);
	#END

	#UNIQUENAME(did_score)
	#UNIQUENAME(id_layout)
	%id_layout% := RECORD
		unsigned6 temp_ID;
		unsigned1 %did_score% := 0;	//i will use my scoring fields regardless, and then assign at the END.  Bug 90729 depENDing on this default being assigned as it is today.
		#IF(bool_infile_has_name_source)
			#UNIQUENAME(score_n)
			unsigned1 %score_n% := 0;
		#END
		outrec;
	END;

	#UNIQUENAME(make_id_layout)
	%id_layout% %make_id_layout%(%inf% l) := TRANSFORM
		SELF.temp_ID := 0;
		SELF := l;
	END;

	#UNIQUENAME(infile_pre_id_forEmailWarning)
	#UNIQUENAME(infile_pre_id)
	#UNIQUENAME(pre_infile_id)

	//bug 90729 - warning is now turned off.  future changes:
	// 1 - delete infile_pre_id_forEmailWarning definition and supporting UNIQUENAME
	// 2 - in %infile_pre_id%, PROJECT(%inf%... (rather than %infile_pre_id_forEmailWarning%)
	// 3 - add self.temp_ID := 0; to TRANSFORM for %infile_pre_id%
	// 4 - delete %make_id_layout% and supporting UNIQUENAME
	%infile_pre_id_forEmailWarning% := PROJECT(%inf%, %make_id_layout%(left));			

	//second, i will TRANSFORM again and explicitly set DID_Field to zero
	%infile_pre_id% := PROJECT(%infile_pre_id_forEmailWarning%, TRANSFORM(%id_layout%, SELF.DID_field := 0, SELF := left));	//default in layout handles %did_score% to zero
		
	ut.MAC_Sequence_RECORDs(%infile_pre_id%,temp_ID,%pre_infile_id%)	

	#UNIQUENAME(infile_seq)	
	%infile_seq% := %pre_infile_id%(~(fname_field = '' and lname_field = ''));
		
	#uniquename(hasCity_field)
	ut.hasField(%pre_infile_id%, city_field, %hasCity_field%);			
	#UNIQUENAME(hasWeight_field)
	#UNIQUENAME(hasScore_field)
	#UNIQUENAME(hasKeys_field)
	#UNIQUENAME(hasDistance_field)
	#UNIQUENAME(hasMatches_field)
	#UNIQUENAME(hasAppInd_field)
	ut.hasField(%pre_infile_id%, xadl2_weight, %hasWeight_field%);
	ut.hasField(%pre_infile_id%, xadl2_score, %hasScore_field%);
	ut.hasField(%pre_infile_id%, xadl2_keys_used, %hasKeys_field%);
	ut.hasField(%pre_infile_id%, xadl2_distance, %hasDistance_field%);
	ut.hasField(%pre_infile_id%, xadl2_matches, %hasMatches_field%);
	ut.hasField(%pre_infile_id%, appInd, %hasAppInd_field%);
	
	executeSourceMatch(DATASET(%id_layout%) inSourceData) := FUNCTION
		#UNIQUENAME(infile_id)
		#UNIQUENAME(infile_dist)
    %infile_dist% := distribute(inSourceData, hash(
			#if('S' in matchset or '4' in matchset)
				ssn_field, 
			#end
			#if('D' in matchset or 'G' in matchset)
				dob_field, 
			#end
			fname_field, mname_field,lname_field, suffix_field,
			#if('A' in matchset or 'Q' in matchset)
				prange_field, pname_field, srange_field,  
			#end
			#if('A' in matchset or 'Q' in matchset or 'D' in matchset or 'Z' in matchset)
				state_field,zip_field, 
			#end
			#if('P' in matchset)
				phone_field,
			#end
      #if(bool_infile_has_name_source)
				src_field,
			#end
			1));	//the one just keeps the commas from messing it up
		#UNIQUENAME(infile_srtd)
    %infile_srtd% := sort(%infile_dist%, 
			#if('S' in matchset or '4' in matchset)
				ssn_field, 
			#end
			#if('D' in matchset or 'G' in matchset)
				dob_field, 
			#end
			fname_field, mname_field,lname_field, suffix_field,
			#if('A' in matchset or 'Q' in matchset)
				prange_field, pname_field, srange_field,
			#end
			#if('A' in matchset or 'Q' in matchset or 'D' in matchset or 'Z' in matchset)
				state_field,zip_field, 
			#end
			#if('P' in matchset)
				phone_field, 
			#end
			#if(bool_infile_has_name_source)
				src_field,
			#end
			local);	
		#UNIQUENAME(infile_grpd)
		%infile_grpd% := group(%infile_srtd%, 
			#if('S' in matchset or '4' in matchset)
				ssn_field, 
			#end
			#if('D' in matchset or 'G' in matchset)
				dob_field, 
			#end
			fname_field, mname_field,lname_field, suffix_field,
			#if('A' in matchset or 'Q' in matchset)
				prange_field, pname_field, srange_field, 
			#end
			#if('A' in matchset or 'Q' in matchset or 'D' in matchset or 'Z' in matchset)
				state_field,zip_field, 
			#end
			#if('P' in matchset)
				phone_field, 
			#end
			#if(bool_infile_has_name_source)
				src_field,
			#end
			local);
		#UNIQUENAME(rid_em)
		%id_layout% %rid_em%(%id_layout% l, %id_layout% r) := transform
			SELF.temp_id := if (l.temp_id = 0, r.temp_id, l.temp_id);
			SELF := r;
		end;
		#UNIQUENAME(infile_iter)
		%infile_iter% := iterate(%infile_grpd%, %rid_em%(left, right));
		
		#UNIQUENAME(need_source_match2)
		%need_source_match2% := %infile_iter%(did_field = 0);	

		#UNIQUENAME(infile_slim_rec)
		#UNIQUENAME(infile_slim)
		#UNIQUENAME(infile_id)

		%infile_slim_rec% := RECORD
			%need_source_match2%.temp_id;
			%need_source_match2%.did_field;
			%need_source_match2%.%did_score%;
			%need_source_match2%.fname_field; 
			%need_source_match2%.mname_field;
			%need_source_match2%.lname_field;
			%need_source_match2%.suffix_field; 
			#IF('S' in matchset or '4' in matchset)
				%need_source_match2%.ssn_field; 
			#END
			#IF('D' in matchset or 'G' in matchset)
				%need_source_match2%.dob_field; 
			#END
			#IF('A' in matchset or 'Q' in matchset)
				%need_source_match2%.prange_field; 
				%need_source_match2%.pname_field;
				%need_source_match2%.srange_field;
			#END				
			#IF('A' in matchset or 'Q' in matchset or 'D' in matchset or 'Z' in matchset)
			%need_source_match2%.state_field;
			%need_source_match2%.zip_field; 
			#END
			#IF('P' in matchset)
				%need_source_match2%.phone_field;
			#END
			#IF(bool_infile_has_name_source)
				%need_source_match2%.src_field;
				%need_source_match2%.%score_n%;
			#END
		END;
	
		%infile_slim% := table(%need_source_match2%, %infile_slim_rec%);
		%infile_id% := dedup(%infile_slim%, temp_id);  // not sure if this is necessary.
		
		// if Source match wanted
		#UNIQUENAME(fname)
		#UNIQUENAME(mname)
		#UNIQUENAME(lname)
		#UNIQUENAME(ssn)
		#UNIQUENAME(dob)
		#UNIQUENAME(prange)
		#UNIQUENAME(pname)
		#UNIQUENAME(srange)
		#UNIQUENAME(zip)
		#UNIQUENAME(state)
		#UNIQUENAME(pre_nmsource_rec)
		#UNIQUENAME(make_expand)

		%pre_nmsource_rec% := RECORD
			%infile_id%.temp_id;
			%infile_id%.did_field;
			%infile_id%.%did_score%;
			#IF(bool_infile_has_name_source)
				%infile_id%.src_field;
				%infile_id%.%score_n%;
			#END
			%infile_id%.suffix_field;
			STRING20  %fname%;
			STRING20  %mname%;
			STRING20  %lname%;	    
			STRING10  %prange%; 
			STRING28  %pname%;
			STRING8   %srange%;
			STRING5   %zip%;
			STRING9   %ssn%; 
			unsigned4 %dob%; 
		END;

		%pre_nmsource_rec% %make_expand%(%infile_slim_rec% l) := TRANSFORM	
			#IF('S' in matchset or '4' in matchset)
				SELF.%ssn% := l.ssn_field; 
			#ELSE
				SELF.%ssn% := ''; 
			#END
			#IF('D' in matchset or 'G' in matchset)
				SELF.%dob% := (unsigned4)l.dob_field; 
			#ELSE
				SELF.%dob% := 0; 
			#END
			#IF('A' in matchset or 'Q' in matchset)
				SELF.%prange% := l.prange_field; 
				SELF.%pname% := l.pname_field;
				SELF.%srange% := l.srange_field;
			#ELSE
				SELF.%prange% := ''; 
				SELF.%pname%  := '';
				SELF.%srange% := '';
			#END
			#IF('A' in matchset or 'Q' in matchset or 'D' in matchset or 'Z' in matchset)
				SELF.%zip%  := l.zip_field;
			#ELSE
				SELF.%zip%  := '';
			#END
			SELF.%fname% := l.fname_field;
			SELF.%mname% := l.mname_field;
			SELF.%lname% := l.lname_field;
			SELF := l;
		END;

		#UNIQUENAME(infile_pre_nmsource)

		%infile_pre_nmsource% := PROJECT(%infile_id%, %make_expand%(left));
		
		#UNIQUENAME(pre_all_recs_clean)
		DID_Add.MAC_Dedup_DIDs(%infile_pre_nmsource%, temp_id, did_field, %did_score%,
					   %pre_all_recs_clean%)
		
		#UNIQUENAME(outfile_source)
		#IF(bool_infile_has_name_source and ('A' in matchset or 'Q' in matchset))

			DID_Add.MAC_Match_NmSource(%pre_all_recs_clean%,%outfile_source%,
															temp_id,did_field,%did_score%,low_score_threshold,src_field,
														%fname%,%mname%,%lname%,suffix_field,
								%prange%,%pname%,%srange%,%zip%,%ssn%,%dob%,true,%score_n%)
		#ELSEif(bool_infile_has_name_source and 'S' in matchset)
			DID_Add.MAC_Match_NmSource_NoAddr(%pre_all_recs_clean%,%outfile_source%,
															temp_id,did_field,%did_score%,low_score_threshold,src_field,
														%fname%,%mname%,%lname%,suffix_field,
								%prange%,%pname%,%srange%,%zip%,%ssn%,%dob%,true,%score_n%)
		#ELSE
			%outfile_source% := %pre_all_recs_clean%;
		#END

		#UNIQUENAME(arc_dist)
		%arc_dist% := distribute(%outfile_source%, HASH(temp_id));	

		#UNIQUENAME(putemback)
    %id_layout% %putemback%(%id_layout% l, %arc_dist% r) := TRANSFORM
			SELF.did_field := if(l.did_field > 0, l.did_field, r.did_field);
			SELF.%did_score% := if(l.did_field > 0, l.%did_score%, r.%did_score%);
			#IF(%hasWeight_field%)		
				self.xadl2_weight  := if(r.did_field > 0, 0, l.xadl2_weight);
			#END
			#IF(%hasScore_field%)		
				self.xadl2_score := if(r.did_field > 0, 0, l.xadl2_score);
			#END
			#IF(%hasKeys_field%)		
				self.xadl2_keys_used := if(r.did_field > 0, 0, l.xadl2_keys_used);
			#END
			#IF(%hasDistance_field%)		
				self.xadl2_distance := if(r.did_field > 0, 0, l.xadl2_distance);
			#END
			#IF(%hasMatches_field%)		
				self.xadl2_matches := if(r.did_field > 0, '', l.xadl2_matches);
			#END
			#IF(%hasAppInd_field%)
				self.appInd := if(r.did_field > 0, 'SRC', l.appInd); 
			#END;
			#IF(bool_infile_has_name_source)
				SELF.%score_n% := r.%score_n%;
			#END			
			SELF := l;
		END;	
		#UNIQUENAME(all_recs_clean);
		%all_recs_clean% := join(distribute(%infile_iter%,HASH(temp_id)), %arc_dist%, //outfile_need_ADL2_dedup, below, is depENDing on this distribution and local sort (as a result of join) to do a dedup.
						   left.temp_id = right.temp_id,
							 %putemback%(left, right), left outer, local);		
		RETURN %all_recs_clean%;
	END;
	
	executeXADL2(dataset(%id_layout%) all_recs_clean1) := FUNCTION
		#UNIQUENAME(outfile_no_need_ADL2)
		#UNIQUENAME(outfile_need_ADL2)
		#UNIQUENAME(outfile_need_ADL2_dedup)
		// output(all_recs_clean1);
		%outfile_no_need_ADL2%    := all_recs_clean1(did_field > 0 or (fname_field = '' and lname_field = ''));
		%outfile_need_ADL2% := all_recs_clean1(~(did_field > 0 or (fname_field = '' and lname_field = '')));	//outfile_need_ADL2_dedup is depENDing on this distribution and local sort inherited here from all_recs_clean

		//technically, that dist and sort depENDs on the name filters keeping out the RECORDs from pre_infile_id, as well
		%outfile_need_ADL2_dedup% := dedup(%outfile_need_ADL2%, temp_id, local);															//depENDs on distribution of outfile_need_ADL2 to eliminate dups and save effort. can be re-sorted here, instead, if needed.

		//*********************
		//****** 		ROXIE route
		//*********************				
		#UNIQUENAME(roxprep)
		didville.Layout_DID_InBatch %roxprep%(%pre_infile_id% l) := TRANSFORM
			#IF('S' in matchset or '4' in matchset)
				SELF.ssn := (qSTRING9)l.ssn_field;
			#ELSE
				SELF.ssn := '';
			#END
			#IF('D' in matchset or 'G' in matchset)
				SELF.dob:= (qSTRING8)l.dob_field;
			#ELSE
				SELF.dob := '';
			#END			
			#IF('A' in matchset)
				SELF.prim_range := (qSTRING10)l.prange_field;
				SELF.predir := '';
				SELF.prim_name := (qSTRING28)l.pname_field;
				SELF.addr_suffix := '';
				SELF.postdir := '';
				SELF.unit_desig := '';
				SELF.sec_range := (qSTRING8)l.srange_field; 
				SELF.st := (qSTRING2)l.state_field;
				#if(%hasCity_field%)
					SELF.p_city_name := l.city_field;
				#else
					SELF.p_city_name := '';
				#end	
			#else
				SELF.prim_range := '';
				SELF.predir := '';
				SELF.prim_name := '';
				SELF.addr_suffix := '';
				SELF.postdir := '';
				SELF.unit_desig := '';
				SELF.sec_range := '';
				SELF.st := '';
				SELF.p_city_name := '';
			#end
			#if('A' in matchset or 'D' in matchset or 'Z' in matchset)
				SELF.z5 := (qSTRING5)l.zip_field;
			#else
				SELF.z5 := '';
			#end		
			#IF('P' in matchset)
				SELF.phone10 := (qSTRING10)l.phone_field;
			#ELSE
				SELF.phone10 := '';
			#END
			SELF.seq := l.temp_id;
			SELF.fname := (qSTRING20)l.fname_field;
			SELF.mname := (qSTRING20)l.mname_field;
			SELF.lname := (qSTRING20)l.lname_field;
			SELF.suffix := (qSTRING5)l.suffix_field; 
			SELF.title := '';			
			SELF.zip4 := '';
		END;

		#UNIQUENAME(roxin)
		%roxin% := distribute(PROJECT(%outfile_need_ADL2_dedup%, %roxprep%(left)),HASH(random()));

		#UNIQUENAME(opts)
		%opts% := 
			#IF('Z' in matchset)
				'ZIP,' + 
			#END
			#IF('G' in matchset)
				'AGE,' + 
			#END
			#IF('4' in matchset)
				'SSN' + 
			#END
			'';
		#UNIQUENAME(roxout)
		did_add.MAC_Match_Roxie(%roxin%, %roxout%, %opts%)


		//** ReappEND the full rec
		#UNIQUENAME(postrox)
		typeof(%pre_infile_id%) %postrox%(%pre_infile_id% l, %roxout% r) := TRANSFORM
				SELF.did_field := if (r.score >= low_score_threshold,r.did,0);
				SELF.%did_score% := if (r.score >= low_score_threshold, r.score,0);
				SELF := l;
		END;

		#UNIQUENAME(roxplus)
		%roxplus% := 
		join(%outfile_need_ADL2%, 
			%roxout%,
			left.temp_id = right.seq,
			%postrox%(left, right),
			HASH,
			keep(1) //xadl2 occasionally will return dups, since this macro gives dups the same uniqueid
		);

		#UNIQUENAME(roxplus_ADL2)
		%roxplus_ADL2% := %roxplus% + %outfile_no_need_ADL2%;

		//prepare the layout and call ADL2 macro
		#UNIQUENAME(infile_xadl2)
		%infile_xadl2% := PROJECT(%outfile_need_ADL2_dedup%, 
		TRANSFORM({InsuranceHeader_xLink.Layout_Person_xLink, InsuranceHeader_xLink.DebugFields}, 		
					SELF.uniqueid := left.temp_id,
					#IF('S' in matchset or '4' in matchset)
						SELF.ssn := left.ssn_field,
					#ELSE
						SELF.ssn := '',						
					#END
						SELF.fname := left.fname_field,
						SELF.mname := left.mname_field,
						SELF.lname := left.lname_field,
						SELF.name_suffix := left.suffix_field,
					#if('A' in matchset)
						SELF.prim_range := left.prange_field,
						SELF.prim_name  := left.pname_field,
						SELF.sec_range  := left.srange_field, 											 
					 #if(%hasCity_field%)
						 SELF.city := left.city_field,
					 #else
						 SELF.city := '',
					 #end
						SELF.state := left.state_field,
					#else
					 SELF.prim_range := '',
					 SELF.prim_name  := '',
					 SELF.sec_range  := '', 											 
					 SELF.city := '',
					 SELF.state := '',
					#end
					#if('A' in matchset or 'D' in matchset or 'Z' in matchset)
					SELF.zip := left.zip_field,
					#else
					SELF.zip := '',
					#end   											
					#IF('P' in matchset)
					 SELF.phone := left.phone_field,
					#ELSE
					 SELF.phone := '',
					#END
					#IF('D' in matchset or 'G' in matchset)
						SELF.dob:= (STRING8)left.dob_field;
					#ELSE
						SELF.dob := '';
					#END
					SELF.did    := 0,
					SELF := left,  
					SELF := []));
						 

		#UNIQUENAME(outfile_ADL2)
		#UNIQUENAME(all_recs_clean_ADL2)
		
	IDLExternalLinking.mac_xlinking_on_thor_Boca(%infile_xadl2%, 	
	did, name_suffix, fname, mname, lname, , 
															 , prim_name, prim_range, sec_range, city, 
															 state, zip, ssn, dob, phone, ,, 
														%outfile_ADL2%, weight_threshold, distance, segmentation);
		
		// DID_Add.mac_match_flex_ADL2(%infile_xadl2%, %outfile_ADL2%)
		//-------------		
		// output(%outfile_ADL2%);
		//-------------

		//combine all RECORDs from xADL2 and source matching
                                                                                                               
		//****** ReappEND the full rec
		#UNIQUENAME(putemback_ADL2)
    %id_layout% %putemback_ADL2%(%outfile_need_ADL2% l, %outfile_ADL2% r) := TRANSFORM 
			self.did_field := if (r.new_score >= low_score_threshold,r.did,0);
	    self.%did_score% := if (r.new_score >= low_score_threshold, r.new_score,0);			
			#if(bool_outrec_has_score)
				self.DID_Score_field := self.%did_score%;
			#end
			#IF(%hasWeight_field%)		
				SELF.xadl2_weight  := r.xlink_weight;
			#END
			#IF(%hasScore_field%)		
				SELF.xadl2_score := r.xlink_score;
			#END
			#IF(%hasKeys_field%)		
				SELF.xadl2_keys_used := r.xlink_keys;
			#END
			#IF(%hasDistance_field%)		
				SELF.xadl2_distance := r.xlink_distance;
			#END
			#IF(%hasMatches_field%)		
				SELF.xadl2_matches := DID_Add.matches('').xLinkToxADL2Matches(r.xlink_matches);
			#END		
			#IF(%hasAppInd_field%)
				self.appInd := 'XLINK'; 
			#END;
			SELF := l;
		END;
		
		%all_recs_clean_ADL2% := join(distribute(%outfile_need_ADL2%,HASH(temp_id)),
	                // distribute(%outfile_ADL2%,HASH(reference)),
	                distribute(%outfile_ADL2%,HASH(uniqueid)),
				    left.temp_id = right.uniqueid,
					%putemback_ADL2%(left, right), left outer, local) + %outfile_no_need_ADL2%;
		//-------------
		// output(%all_recs_clean_ADL2%);
		//-------------
		#UNIQUENAME(force)
		STRING4 %force% := '' : STORED('did_add_force');

		//********* Pick which route to go
		/***************************************************************************
			combine name source matching with other hitting thor conditions, name source
		   matching need expand one source field and join source matching file after join with
   		other slimsort files.
		***************************************************************************/
		#uniquename(use_xADL2)
		%use_xADL2% := _Control.mod_xADLversion.constant_usexADL2;
		
		#UNIQUENAME(hit_thor)
		%hit_thor% := (bool_infile_has_name_source  and ~%use_xADL2%) or %force%='thor' or (count(infile) > 15000000 and %force% <> 'roxi' and thorlib.nodes() >= 400);
		#UNIQUENAME(preclean)
		%preclean% := if(%hit_thor%, 
			  %all_recs_clean_ADL2%, 
			  %roxplus_ADL2%);
				
		// output(%infile_xadl2%);
		// output(%outfile_ADL2%);
		return %preclean%;
	END;

	#UNIQUENAME(sourceResultsFirst);
	#UNIQUENAME(xADLResultsSecond);
	#UNIQUENAME(xADL2ResultsFirst);
	#UNIQUENAME(sourceResultsSecond);

	%sourceResultsFirst% := executeSourceMatch(%infile_seq%);
	%xADLResultsSecond% := executeXADL2(%sourceResultsFirst%);
	%xADL2ResultsFirst% := executeXADL2(%infile_seq%);
	%sourceResultsSecond% := executeSourceMatch(%xADL2ResultsFirst%);

	#UNIQUENAME(sourceXADL2Result)

	#IF (bool_switch_priority)
		#IF (bool_infile_has_name_source)
			%sourceXADL2Result% := %sourceResultsSecond%;
		#ELSE 
			%sourceXADL2Result% := %xADL2ResultsFirst%;
		#END
	#ELSE 
		#IF (bool_infile_has_name_source)
			%sourceXADL2Result% := %xADLResultsSecond%;
		#ELSE
			%sourceXADL2Result% := %xADL2ResultsFirst%;
		#END
	#END

	#UNIQUENAME(toOutRec)
	outrec %toOutRec%(%sourceXADL2Result% l) := TRANSFORM
		#if(bool_outrec_has_score)
			SELF.DID_Score_field := l.%did_score%;
		#end
		#if(bool_outrec_has_indiv_scores and bool_infile_has_name_source)
			SELF.score_n_field := l.%score_n%;
		#end	
		SELF := l;
		SELF := [];
	END;
// output(%infile_seq%, named('infile_seq'));	
// output(%xADL2ResultsFirst%, named('xADL2ResultsFirst'));
// output(%sourceResultsSecond%, named('sourceResultsSecond'));
// output(%sourceXADL2Result%, named('sourceXADL2Result' ));
// output(DID_Score_field, named('DID_Score_field' ));
	outfile := PROJECT(%sourceXADL2Result% + %pre_infile_id%(fname_field = '' and lname_field= ''), %toOutRec%(LEFT));
ENDMACRO;

/*
//just some test code that may come in handy

copy_RECORD :=
  RECORD
    varstring name_suffix;
    varstring fname;
    varstring mname;
    varstring lname;
    varstring prim_range;
    varstring prim_name;
    varstring sec_range;
    varstring city;
    varstring state;
    varstring zip;
    varstring zip4;
  END;
outrec := RECORD(copy_RECORD)
		unsigned6 DID := 0;
		unsigned4 score := 0;
END;

dstest :=
  dataset([
    {'     ', 'AMY                 ', 'J                   ', 'PLAMBECK            ', '3114      ', 'JOANN                       ', '        ', '                         ', 'NE', '68123', '1352'}, 
    {'     ', 'BEVERLY             ', 'K                   ', 'HERNANDEZ           ', '702       ', '6TH                         ', '        ', '                         ', 'WY', '82007', '    '}, 
    {'     ', 'CHARLES             ', 'J                   ', 'WHITMAN             ', '1802      ', 'TARALI                      ', '        ', '                         ', 'UT', '84095', '2774'}, 
    {'     ', 'CHARLES             ', 'J                   ', 'WHITMAN             ', '1802      ', 'TARALI                      ', '        ', '                         ', 'UT', '84095', '2774'}, 
    {'     ', 'GAIL                ', 'A                   ', 'HALE                ', '7719      ', 'BENT BRANCH                 ', '        ', '                         ', 'TX', '78250', '3023'}, 
    {'     ', 'GAIL                ', 'A                   ', 'HALE                ', '7719      ', 'BENT BRANCH                 ', '        ', '                         ', 'TX', '78250', '3023'}, 
    {'     ', 'GREGORY             ', 'E                   ', 'HALE                ', '7719      ', 'BENT BRANCH                 ', '        ', '                         ', 'TX', '78250', '3023'}, 
    {'SR   ', 'GREGORY             ', 'E                   ', 'HALE                ', '7719      ', 'BENT BRANCH                 ', '        ', '                         ', 'TX', '78250', '3023'}, 
    {'SR   ', 'GREGORY             ', 'E                   ', 'HALE                ', '7719      ', 'BENT BRANCH                 ', '        ', '                         ', 'TX', '78250', '3023'}, 
    {'     ', 'HAZEL               ', '                    ', 'SULLIVAN            ', '305       ', 'HILLCREST                   ', '        ', '                         ', 'MS', '38860', '    '}, 
    {'     ', 'JAMES               ', 'R                   ', 'RADTKE              ', '1904      ', 'MENLO                       ', '        ', '                         ', 'WI', '53211', '    '}, 
    {'     ', 'JANICE              ', 'M                   ', 'PLAMBECK            ', '10002     ', '25TH                        ', '        ', '                         ', 'NE', '68123', '5007'}, 
    {'     ', 'JESSICA             ', '                    ', 'BOND                ', '16731     ', 'LILLY CREST                 ', '        ', '                         ', 'TX', '78232', '    '}, 
    {'     ', 'JESSICA             ', '                    ', 'BOND                ', '16731     ', 'LILLY CREST                 ', '        ', '                         ', 'TX', '78232', '2303'}, 
    {'     ', 'JOHN                ', '                    ', 'HARDCASTLE          ', '1607      ', 'BALSAM                      ', '        ', '                         ', 'CO', '80232', '6725'}, 
    {'     ', 'JOHN                ', '                    ', 'SHALLER             ', '15085     ', 'MARSHALL                    ', '        ', '                         ', 'TX', '79014', '    '}, 
    {'     ', 'JOHN                ', 'A                   ', 'SHALLER             ', '15085     ', 'MARSHALL                    ', '        ', '                         ', 'TX', '79014', '    '}, 
    {'     ', 'JOHN                ', 'C                   ', 'HARDCASTLE          ', '1607      ', 'BALSAM                      ', '        ', '                         ', 'CO', '80232', '    '}, 
    {'     ', 'JOHN                ', 'W                   ', 'ALF                 ', '401       ', 'BILLY CREEK                 ', '        ', '                         ', 'TX', '76053', '6363'}, 
    {'     ', 'JOHN                ', 'WILFRED             ', 'ALF                 ', '690       ', 'BOON DOCK                   ', '        ', '                         ', 'TX', '75630', '    '}], copy_RECORD);
mset := ['A'];
DID_Add.MAC_Match_Flex_V2(dstest, mset,	nossn , nodob , fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range,zip, state, nophone,
	 DID,   			
	 outrec, 
	 true, score,	//these should default to zero in definition
	 75,	//dids with a score below here will be dropped 
	 outfile)

strforce :=
// 'thor';
'roxi';

	 
#workunit('name','MAC_Match_Flex_V2' + strforce)
#stored('did_add_force',strforce)
output(outfile)

*/
