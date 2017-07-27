
IMPORT Business_Header, Business_Header_SS, Doxie, ut;

EXPORT Functions := MODULE
				
		// The following function loads into a dataset all the pertinent values found
		// in doxie.mac_header_field_declare. The field 'acctno' is used primarily for
		// batch operations; but we'll simply populate it with a semi-meaningful value.	
		// This is used only to convert a single, online transaction into a one-record
		// dataset to prepare it for running against the batch autokeys.
		EXPORT Fn_LoadDoxieMacHeaderFieldValues() := 
			FUNCTION
					
				business_header.doxie_MAC_Field_Declare()
					
				rec_acctno :=
					RECORD
						STRING30 acctno := '';
					END;
					
				AutokeyB2_batch.Layouts.rec_BDID_InBatch xfm_Load_Values(rec_acctno le) :=
					TRANSFORM
						SELF.bdid_value            := bdid_value; 			
						SELF.acctno                := le.acctno;
						SELF.fein                  := IF( fein_value = 0, '', TRIM(Stringlib.StringFilterOut(fein_val,'-')) );
						SELF.phone10               := phone_value;
						SELF.company_name          := comp_name_value;
						SELF.comp_name_indic_value := comp_name_indic_value;
						SELF.comp_name_sec_value   := comp_name_sec_value;
						SELF.prim_range            := prange_value;
						SELF.predir                := predir_value;
						SELF.prim_name             := pname_value;
						SELF.addr_suffix           := addr_suffix_value;
						SELF.postdir               := postdir_value;
						SELF.sec_range             := sec_range_value;
						SELF.p_city_name           := city_value;
						SELF.st                    := state_value;
						SELF.z5                    := zip_val;
						SELF.zipradius             := zipradius_value;
						SELF.zip_value             := zip_value;
						SELF.isCRS                 := isCRS;  
						SELF.addr_error_value      := addr_error_value;   																					
						SELF.addr_loose            := addr_loose;       
						SELF.lookup_value          := lookup_value;            
					END;
				
				ds_acctno := DATASET( [{'online'}], {rec_acctno} );
								 
				ds := PROJECT( ds_acctno, xfm_Load_Values(LEFT) );

				RETURN ds;
				
			END;
			
		// ***** WE MAY ATROPHY THIS NEXT FUNCTION *****
		//
		// The following function creates a set of single-char values based on a set of boolean values. The output
		// set therefore contains the codes dictating which autokeys must be run to fulfill the user's input criteria.
		// We create the output set by concatenating subsets of applicable codes.
		EXPORT GetSetOfRequiredAutokeys(SET OF BOOLEAN searchType_flags) :=
			FUNCTION
			
				_Autokeys := AutokeyB2_batch.Constants;

				MatchName := 1; MatchAddress := 2; MatchPhone := 3; MatchFEIN := 4; MatchSSN := 5;
							
				SET OF STRING1 required_autokeys := 
							 IF( searchType_flags[MatchName],    [ _Autokeys.NAME ,_Autokeys.NAME_WORDS ], [] ) + 																												
							 IF( searchType_flags[MatchAddress], [ _Autokeys.ADDRESS, 
							                                       _Autokeys.STNAME, 
							                                       _Autokeys.CITYSTFLNAME, 
							                                       _Autokeys.ZIP ],        [] ) + 							 
							 IF( searchType_flags[MatchPhone],   [ _Autokeys.PHONE ],      [] ) + 							 
							 IF( searchType_flags[MatchFEIN],    [ _Autokeys.FEIN],       [] ) +							 
							 IF( searchType_flags[MatchSSN],     [ _Autokeys.SSN ],        [] ); 
				
				RETURN required_autokeys;
				
			END;		
			
			
	// Apply each record in cnvf_for_words (param name: ds_prepped_for_MakeCNameWords) against 
	// the function that will actually do the work of converting the company names.		
	SHARED AddCompNameValFilt(STRING comp_name, STRING state) :=
		FUNCTION
		
			ds_infile := DATASET( [{comp_name, state, 0, 0, 0}], Business_Header_SS.layout_MakeCNameWords );				
			cnvf_words := Business_Header_SS.Fn_MakeCNameWords(ds_infile);
			valid_cnvf_words := cnvf_words( LENGTH(TRIM(word)) > 1 );
			bestwords := valid_cnvf_words(seq = 1)[1].word;
			
			RETURN bestwords;
			
		END;
		
		
		// The following function accepts a dataset having type AutokeyB2_batch.Layouts.rec_BDID_InBatch 
		// and returns a dataset expanded by company_name_val_filt and company_name_val_filt2.
		// BTW, 'cnvf' = 'company name value filtered.' I think. Note that this is a two step process,
		// the first being to get company_name_val_filt, and the second to get company_name_val_filt2.
	EXPORT Add_Comp_Name_Val_Filt( GROUPED DATASET(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_input ) := 
		FUNCTION

			// Step 1: parse the input company name into val_filt only.	
			Layouts.rec_BDID_InBatch_wParsed_CN_Val_Filt xfm_parse_cnvf(AutokeyB2_batch.Layouts.rec_BDID_InBatch l) := 					
				TRANSFORM
					SELF.company_name_val_filt := IF( l.company_name != '', AddCompNameValFilt(l.company_name, l.st), '' );
					SELF := l;
				END;

			ds_with_cnvf := PROJECT( ds_input, xfm_parse_cnvf(LEFT) );	
			
			// Step 2: use the company_name and parsed cnvf to obtain the cnvf2.	
			Layouts.rec_BDID_InBatch_wParsed_CN_Val_Filt xfm_parse_cnvf2(Layouts.rec_BDID_InBatch_wParsed_CN_Val_Filt l) := 					
				TRANSFORM
					SELF.company_name_val_filt2 := IF( l.company_name != '', 
																						 Business_Header_SS.Fn_SubstituteForAndString( l.company_name, l.company_name_val_filt ),
																						 '' 
																						);
					SELF := l;
				END;

			ds_with_cnvf_and_cnvf2 := PROJECT( ds_with_cnvf, xfm_parse_cnvf2(LEFT) );				
			
			RETURN ds_with_cnvf_and_cnvf2;
			
		END;		
		

	// ***** For test harness only. The reason for this function at all is to assist a test harness--it 
	// will display the left and right datasets combined. That is, the original input records along with 
	// their corresponding BDIDs, match codes, and search statuses. Should be useful for debugging.
	EXPORT Display_Matched_Input_And_Output( GROUPED DATASET(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in, 
																					 DATASET(AutokeyB2_batch.Layouts.rec_output_BDIDs_batch)   ds_results) := 
		FUNCTION		
		
			INTEGER LIMIT_VALUE := 2500; 
			
			rec_combined := RECORD
				AutokeyB2_batch.Layouts.rec_BDID_InBatch       OR
				AutokeyB2_batch.Layouts.rec_output_BDIDs_batch AND NOT [acctno];
			END;
			
			rec_combined xfm_combine_datasets(ds_in l, ds_results r) := TRANSFORM
				SELF := l;
				SELF := r;
			END;
			
			ds_out := JOIN(ds_in, 
										 ds_results, 
										 LEFT.acctno = RIGHT.acctno, 
										 xfm_combine_datasets(LEFT, RIGHT), 
										 LIMIT(LIMIT_VALUE), 
										 LEFT OUTER);	
										 
			RETURN ds_out;
			
		END;			
	
END;  // Functions module