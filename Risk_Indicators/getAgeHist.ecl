import riskwise, ut, header, doxie, Risk_indicators, MDR;

export getAgeHist(GROUPED DATASET(Risk_Indicators.iid_constants.layout_outx) iid2) := FUNCTION

default_first_seen := 999999;

dob_slim := record
		unsigned6 did;
		UNSIGNED4  seq;
		string9   ssn;
    integer4  dob;
		unsigned3 dt_first_seen;
		unsigned3 dt_last_seen;
		string2 src;
		integer year_source_code_dob;
		integer month_source_code_dob;
		integer day_source_code_dob;
		integer complete_dob;
		integer source_rank;
		// dates used for inferred age calculation
		unsigned socllowissue := default_first_seen;
		unsigned soclhighissue := 0;
		integer age_from_reported_dob := 0;
		integer age_from_src_first_seen := 0;
		integer age_from_ssn_issuance := 0;
		integer inferred_age := 0;
		
		// create a seperate copy of these attributes for users with no permissible purpose
		string2 src_no_dppa := '';
		unsigned4 dob_no_dppa := 0;
		integer age_from_reported_dob_no_DPPA := 0;
		integer age_from_src_first_seen_no_DPPA := 0;
		integer inferred_age_no_DPPA := 0;  // version for ITA which users don't have DPPA permissible purpose and take out voters
end;

p1 := project(iid2, 
	transform(dob_slim, 
				today1 := ut.GetDate[1..6];
				sysdate := today1 + '01';
	      self.did := left.h.did;
				self.seq := left.seq;
				src_temp := if(left.h.src='LT', 'TU', left.h.src);
				src := if(mdr.sourcetools.SourceIsDL(src_temp), 'DL', src_temp);
				self.src := src;
				src_no_dppa := if(src in ['DL','VO'], '', src);
				self.src_no_dppa := src_no_dppa;			
				source_rank := map(src='DL' => 1,
													 src='TS' => 2,
													 src='VO' => 3,
													 src='EM' => 4,
													 src='CY' => 5,
													 src='PL' => 6,
													 src='EB' => 7,
													 src='SL' => 8,
													 src='EN' => 9,
													 src='EQ' => 10,
													 src='TU' => 11,						 
					 50);
				self.source_rank := source_rank;
				
				dob_temp := (string)left.h.dob;
				// clean up some parts of the dob if they're invalid on file
				yy1 := (integer)dob_temp[1..4];
				mm1 := (integer)dob_temp[5..6];
				dd1 := (integer)dob_temp[7..8];
				yy2 := (string4)yy1;
				mm2 := if(mm1>12, '00', intformat(mm1, 2,1) );
				dd2 := if(dd1>31, '00', intformat(dd1, 2, 1) );
				dob := map(yy1 < 1900 => '0',
										mm1>12 or dd1>31 => yy2 + mm2 + dd2,				 
									 (string)left.h.dob);
									 
				self.dob := (unsigned)dob;
				dob_no_dppa := if(src_no_dppa='', 0, (unsigned)dob);
				self.dob_no_dppa := dob_no_dppa;
				
				year_source_code_dob := (integer)dob[1..4];
				month_source_code_dob := (integer)dob[5..6];
				day_source_code_dob := (integer)dob[7..8];
				
				complete_dob := map(day_source_code_dob > 0 and month_source_code_dob > 0 and year_source_code_dob > 0 => 3,
														month_source_code_dob > 0 and year_source_code_dob > 0 => 2,
														year_source_code_dob > 0 => 1,
														0);
				self.year_source_code_dob := year_source_code_dob;
				self.month_source_code_dob := month_source_code_dob;
				self.day_source_code_dob := day_source_code_dob;
				self.complete_dob := complete_dob;
        myGetDate := risk_indicators.iid_constants.myGetDate(left.historydate);

		
				reported_age := risk_indicators.years_apart((unsigned)myGetDate, (unsigned)dob);
				self.age_from_reported_dob := reported_age;
				
				reported_age_no_dppa := risk_indicators.years_apart((unsigned)myGetDate, (unsigned)dob_no_dppa);
				self.age_from_reported_dob_no_dppa := reported_age_no_dppa;
		
			
				first_seen_at_source := if(left.h.dt_first_seen=0, default_first_seen, left.h.dt_first_seen);
					
				years_since := risk_indicators.years_apart((unsigned)myGetDate, left.h.dt_first_seen);
				
						
				set_18plus_sources := ['EQ','EN','TU','TS',  // bureaus
																'BA','L2',  // bankruptcy and liens
																'FA','FB','FP','LA','LP'];  // property
				set_16plus_sources := ['PL'] + mdr.sourceTools.set_Utility_sources; 
				vo_source := ['VO'];	
				dl_source := ['DL'];
		
				// set_most_useful_sources := ['EQ','EN','TU','UT','VO','DL','BA','L2','PL','FA','FB','FP','LA','LP'];
				set_most_useful_sources := set_18plus_sources + vo_source + dl_source;
						
				all_18plus := set_18plus_sources + vo_source;
						
				self.age_from_src_first_seen := map(src in all_18plus and first_seen_at_source<>default_first_seen => 18 + years_since,
																src in set_16plus_sources and first_seen_at_source<>default_first_seen => 16 + years_since,
																src in dl_source and first_seen_at_source<>default_first_seen => 15 + years_since,
																src not in set_most_useful_sources and first_seen_at_source<>default_first_seen => 15 + years_since,
																0);	

				// doesn't inlude DL and voter
				self.age_from_src_first_seen_no_dppa := map(src in set_18plus_sources => 18 + years_since,
																src in set_16plus_sources and first_seen_at_source<>default_first_seen => 16 + years_since,
																src not in set_most_useful_sources and first_seen_at_source<>default_first_seen => 15 + years_since,
																0);	
				self.dt_first_seen  := left.h.dt_first_seen;
				self.dt_last_seen   := left.h.dt_last_seen;
				self := []));
				
p1_dds := dedup(sort(p1, seq, did, -complete_dob, source_rank, -dt_last_seen, -dob, src), seq, did);
// p1_dds_thor := dedup(sort(p1, seq, did, -complete_dob, source_rank, -dt_last_seen, -dob, src, if(dt_first_seen=0, 99999999, dt_first_seen)), seq, did);

	layout_age_out := RECORD
		UNSIGNED4 seq;
		UNSIGNED6 DID;
		UNSIGNED4 reported_dob_hist;
	  INTEGER inferred_age_hist;

	END;
		
	layout_age_out age_out(p1_dds le) := TRANSFORM
		SELF.reported_dob_hist := le.dob;
		SELF.inferred_age_hist := if(le.age_from_reported_dob > 0, le.age_from_reported_dob, le.age_from_src_first_seen);
		SELF := le;
	END;
	
		AgeOut :=  project(p1_dds, age_out(left));	

		return AgeOut;
		
END;
		