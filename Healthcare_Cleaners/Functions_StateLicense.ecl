import std,Healthcare_Cleaners;
EXPORT Functions_StateLicense := module
	shared isValidLicState(STRING2 state_in) := function
					states_ds := DATASET([{'AL'},{'AK'},{'AR'},{'AS'},{'AZ'},{'CA'},{'CO'},{'CT'},{'DC'},{'DE'},{'FL'},{'FL'},{'GA'},{'GS'},{'GU'},{'HI'},{'IA'},{'ID'},{'IL'},
																{'IN'},{'KS'},{'KY'},{'LA'},{'MA'},{'MD'},{'ME'},{'MI'},{'MN'},{'MO'},{'MS'},{'MT'},{'NC'},{'ND'},{'NE'},{'NH'},{'NJ'},{'NM'},{'NV'},
																{'NU'},{'NY'},{'OH'},{'OK'},{'OR'},{'PA'},{'PR'},{'RI'},{'RN'},{'SC'},{'SD'},{'TN'},{'TX'},{'UT'},{'VA'},{'VI'},{'VT'},{'WA'},{'WI'},
																{'WV'},{'WY'},{'AZ'},{'RR'},{'WV'},{'PR'},{'EE'}],{STRING state});
					isValidLicState := IF(state_in in set(states_ds,state),TRUE,FALSE);
				return isValidLicState;
	end;
	export getCleanLicense(string InLicense, string InState, string InType) := FUNCTION
		
							license_inRecs := DATASET([{InLicense,InState,InType}],{string InLicense, string InState, string InType});
							PATTERN number := PATTERN('[0-9]+');
							PATTERN letter := PATTERN('[a-zA-Z][a-zA-Z]');

									license_num_rec:= RECORD
										STRING num := MATCHTEXT(number);
										UNSIGNED numlength := LENGTH(MATCHTEXT(number));
									END;

									license_state_rec:= RECORD
										STRING state := MATCHTEXT(letter);
									END;

							lic_parse_digits := SORT(PARSE(license_inRecs,license_inRecs[1].InLicense,number,license_num_rec,MAX,MANY),-numlength);
							lic_parse_letters := PARSE(license_inRecs,license_inRecs[1].InLicense,letter,license_state_rec,SCAN ALL);
							lic_parse_letters_valid := lic_parse_letters(isValidLicState(state[..2]));
							lic_num_raw := REGEXREPLACE('[^0-9A-Za-z]',license_inRecs[1].InLicense,'');
							
						//find the longest number
							lic_longest_num := lic_parse_digits[1].num;
							
						//longest number without leading zeroes
							lic_longest_num_nozero := REGEXREPLACE('^[0]*',lic_parse_digits[1].num,'');
							
						//tokenize numbers, separated by :.  leading and trailing : are used to match 2 character states more easily
							lic_nums_tok := ':' + REGEXREPLACE(' +',TRIM(REGEXREPLACE('[^0-9]',lic_num_raw,' '),LEFT,RIGHT),':') + ':';
							
						//how many sets of numbers are on input?
							count_nums_tok := IF(lic_nums_tok <> '::',LENGTH(REGEXREPLACE('[^:]',lic_nums_tok,'')) - 1,0);
							
						//tokenize letters, separated by :.  leading and trailing : are used to match 2 character states more easily
							lic_alphas_tok := ':' + REGEXREPLACE(' +',TRIM(REGEXREPLACE('[^a-zA-Z]',lic_num_raw,' '),LEFT,RIGHT),':') + ':';
							
						// how many sets of letters are on input?
							count_alphas_tok := IF(lic_alphas_tok <> '::',LENGTH(REGEXREPLACE('[^:]',lic_alphas_tok,'')) - 1,0);
						
						//isolate any 2 character tokens to see if they could be the state.  Support up to 2 for now - add more if needed
							two_letter_tok_1 := REGEXREPLACE('[^a-zA-Z]',REGEXFIND(':[a-zA-Z][a-zA-Z]:',lic_alphas_tok,0),''); 
							two_letter_tok_2 := REGEXREPLACE('[^a-zA-Z]',REGEXFIND(':[a-zA-Z][a-zA-Z]:',REGEXREPLACE(':' + two_letter_tok_1 + ':',lic_alphas_tok,':'),0),''); 
							
						//if there are multiple 2 letter tokens, pick the first valid state if available				
							best_lic_state := MAP(TRIM(license_inRecs[1].InState) <> '' => license_inRecs[1].InState,
																		isValidLicState(two_letter_tok_1) = TRUE 					=> two_letter_tok_1, 
																		isValidLicState(two_letter_tok_2) = TRUE					  => two_letter_tok_2,
																		TRIM(license_inRecs[1].InState));
							
						//leftovers to use as potential lic1_type.  Do not replace valid state abbreviations if an input state is forced.
							// however, if the forced input state is ALSO in the license string, remove it from the leftovers string.
							p_lic_type := IF(TRIM(license_inRecs[1].InType) <> '', license_inRecs[1].InType,
																REGEXREPLACE( '' + lic_longest_num + '|' + best_lic_state ,lic_num_raw,''));
	
							parsed_input_license_num := TRIM(lic_longest_num_nozero);
							parsed_input_license_state := TRIM(best_lic_state);
							parsed_input_license_type := TRIM(p_lic_type);
							
							
							results_ds := DATASET([	{parsed_input_license_num,
																			 parsed_input_license_state,
																			 parsed_input_license_type}],	Healthcare_Cleaners.Layouts_StateLicense.LayoutLicenseClean);
						RETURN results_ds[1];
		END;	
End;
