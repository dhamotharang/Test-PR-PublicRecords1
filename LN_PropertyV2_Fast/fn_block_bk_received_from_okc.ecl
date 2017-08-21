export fn_block_bk_received_from_okc 
	
												(dataset(recordof(LN_PropertyV2_Fast.Layout_prep_assessment)) in_assessmnt,
                         dataset(recordof(LN_PropertyV2_Fast.Layout_prep_deed_mortg)) in_deedMortg   ) := MODULE

shared match := module 

				export  assessments(dataset(recordof(LN_PropertyV2_Fast.files.prep.assessment)) a,
								     			  dataset(recordof(LN_PropertyV2_Fast.files.prep.assessment)) b ) := function

					pairs := join(distribute(a,hash64(fips_code,state_code,county_name,recording_date,assessed_value_year,edition_number,apna_or_pin_number,Append_ReplRecordInd)),
												distribute(b,hash64(fips_code,state_code,county_name,recording_date,assessed_value_year,edition_number,apna_or_pin_number,Append_ReplRecordInd)),

												LEFT.fips_code							=	RIGHT.fips_code 						AND
												LEFT.state_code				  		=	RIGHT.state_code						AND
												LEFT.county_name						=	RIGHT.county_name						AND
												LEFT.recording_date					=	RIGHT.recording_date				AND
												LEFT.assessed_value_year		=	RIGHT.assessed_value_year		AND
												LEFT.edition_number					=	RIGHT.edition_number				AND
												LEFT.apna_or_pin_number			=	RIGHT.apna_or_pin_number	  AND
												LEFT.Append_ReplRecordInd   = RIGHT.Append_ReplRecordInd
												
												,transform({string8 ln_fares_id1, string8 ln_fares_id2
																												,dataset(recordof(a)) chld1,dataset(recordof(a)) chld2} 
																								,SELF.ln_fares_id1 := LEFT.ln_fares_id
																								,SELF.ln_fares_id2 := RIGHT.ln_fares_id
																								,SELF.chld1 := LEFT
																								,SELF.chld2 := RIGHT)
							,local);
							
							{dataset(recordof(a)) recs} makeSets(recordof(pairs) L, integer C) := TRANSFORM

										SELF.recs := choose(C,L.chld1,L.chld2);

							END;

							report := normalize(pairs,2,makeSets(LEFT,COUNTER));
							return report;
					end;
			  export deeds(dataset(recordof(LN_PropertyV2_Fast.files.prep.deed_mortg)) a,
				     			   dataset(recordof(LN_PropertyV2_Fast.files.prep.deed_mortg)) b ) := function

					pairs := join(distribute(a,hash64(fips_code,state,county_name,recording_date,recorder_book_number,
																						recorder_page_number,document_number,apnt_or_pin_number,Append_ReplRecordInd)),
												distribute(b,hash64(fips_code,state,county_name,recording_date,recorder_book_number,
																						recorder_page_number,document_number,apnt_or_pin_number,Append_ReplRecordInd)),

												LEFT.fips_code							= 	RIGHT.fips_code 						AND
												LEFT.state									= 	RIGHT.state									AND
												LEFT.county_name						= 	RIGHT.county_name						AND
												LEFT.recording_date					= 	RIGHT.recording_date				AND
												LEFT.recorder_book_number		= 	RIGHT.recorder_book_number	AND
												LEFT.recorder_page_number		= 	RIGHT.recorder_page_number	AND
												LEFT.document_number				= 	RIGHT.document_number				AND
												LEFT.apnt_or_pin_number			= 	RIGHT.apnt_or_pin_number    AND
												LEFT.Append_ReplRecordInd   = 	RIGHT.Append_ReplRecordInd
												
												,transform({string8 ln_fares_id1, string8 ln_fares_id2
																												,dataset(recordof(a)) chld1,dataset(recordof(a)) chld2} 
																								,SELF.ln_fares_id1 := LEFT.ln_fares_id
																								,SELF.ln_fares_id2 := RIGHT.ln_fares_id
																								,SELF.chld1 := LEFT
																								,SELF.chld2 := RIGHT)
							,local);
							
							{dataset(recordof(a)) recs} makeSets(recordof(pairs) L, integer C) := TRANSFORM

										SELF.recs := choose(C,L.chld1,L.chld2);

							END;

							report := normalize(pairs,2,makeSets(LEFT,COUNTER));
							return report;
					end;
			 end;
											  
			 export filtered_assessmnt := function
			 
							okc_prep_assessments := ln_propertyV2_fast.files.prep.assessment(ln_fares_id[1] = 'O');
							filtered := join (distribute(in_assessmnt,hash64(fips_code,state_code,county_name,recording_date,assessed_value_year,
																												  			edition_number,apna_or_pin_number,Append_ReplRecordInd)),
																distribute(okc_prep_assessments,hash64(fips_code,state_code,county_name,recording_date,assessed_value_year,
																																edition_number,apna_or_pin_number,Append_ReplRecordInd)),
																
																LEFT.fips_code							=	RIGHT.fips_code 						AND
																LEFT.state_code				  		=	RIGHT.state_code						AND
																LEFT.county_name						=	RIGHT.county_name						AND
																LEFT.recording_date					=	RIGHT.recording_date				AND
																LEFT.assessed_value_year		=	RIGHT.assessed_value_year		AND
																LEFT.edition_number					=	RIGHT.edition_number				AND
																LEFT.apna_or_pin_number			=	RIGHT.apna_or_pin_number    AND
												LEFT.Append_ReplRecordInd   				= RIGHT.Append_ReplRecordInd
																
																,transform(LEFT), LEFT ONLY
															 ,local) :independent;
							 
							return when (filtered, sequential(output(count(in_assessmnt)
																				              -count(filtered),named('count_dropped_dup_bk_okc_assessments')),
																								output(choosen(match.assessments(in_assessmnt,okc_prep_assessments),500),
																												named('dropped_assessment_sample'))
																							 ));
			 end;
			 
			 export filtered_deedMortg := function
			 
							okc_prep_deedMortg := ln_propertyV2_fast.files.prep.deed_mortg(ln_fares_id[1] = 'O');
							filtered := join (distribute(in_deedMortg,hash64(fips_code,state,county_name,recording_date,recorder_book_number,
																						recorder_page_number,document_number,apnt_or_pin_number,Append_ReplRecordInd)),
																distribute(okc_prep_deedMortg,hash64(fips_code,state,county_name,recording_date,recorder_book_number,
																						recorder_page_number,document_number,apnt_or_pin_number,Append_ReplRecordInd)),
																
																LEFT.fips_code							= 	RIGHT.fips_code 						AND
																LEFT.state									= 	RIGHT.state									AND
																LEFT.county_name						= 	RIGHT.county_name						AND
																LEFT.recording_date					= 	RIGHT.recording_date				AND
																LEFT.recorder_book_number		= 	RIGHT.recorder_book_number	AND
																LEFT.recorder_page_number		= 	RIGHT.recorder_page_number	AND
																LEFT.document_number				= 	RIGHT.document_number				AND
																LEFT.apnt_or_pin_number			= 	RIGHT.apnt_or_pin_number    AND
																LEFT.Append_ReplRecordInd   = 	RIGHT.Append_ReplRecordInd
																
																,transform(LEFT), LEFT ONLY
															 ,local) :independent;
							return when (filtered, sequential(output(count(in_deedMortg)
																											-count(filtered),named('count_dropped_dup_bk_okc_deeds')),
																					      output(choosen(match.deeds(in_deedMortg,okc_prep_deedMortg),500)
																								       ,named('dropped_deeds_sample'))
																					 ));
			 end;

			 // For the derived files, just run them through the filter

			 SHARED filtered_ln_fares_ids := table(filtered_assessmnt,{ln_fares_id})
																			+table(filtered_deedMortg,{ln_fares_id}) :independent;
			 
			 export filtered_addlNames (dataset(recordof(LN_PropertyV2_Fast.Layout_prep_addl_names)) addlNames) :=
							join( distribute(addlNames						,hash64(ln_fares_id)),
										distribute(filtered_ln_fares_ids,hash64(ln_fares_id)),
										
										left.ln_fares_id=RIGHT.ln_fares_id,transform(left),local);
			 
			 export filtered_addlLegal (dataset(recordof(LN_PropertyV2_Fast.Layout_prep_addl_legal)) addlLegal) :=
							join( distribute(addlLegal						,hash64(ln_fares_id)),
										distribute(filtered_ln_fares_ids,hash64(ln_fares_id)),
										
										left.ln_fares_id=RIGHT.ln_fares_id,transform(left),local);

       export filtered_searchPrp (dataset(recordof(LN_PropertyV2_Fast.Layout_prep_search_prp)) searchPrp) :=
							join( distribute(searchPrp						,hash64(ln_fares_id)),
										distribute(filtered_ln_fares_ids,hash64(ln_fares_id)),
										
										left.ln_fares_id=RIGHT.ln_fares_id,transform(left),local);
end;