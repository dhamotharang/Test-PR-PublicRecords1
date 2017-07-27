/*Now (plundquist)
Text In Open Window
*/
IMPORT STD,Healthcare_Shared;
EXPORT Functions_License := MODULE
			
	EXPORT isValidState(STRING2 state_in) := function
					states_ds := DATASET([{'AL'},{'AK'},{'AR'},{'AS'},{'AZ'},{'CA'},{'CO'},{'CT'},{'DC'},{'DE'},{'FL'},{'FL'},{'GA'},{'GS'},{'GU'},{'HI'},{'IA'},{'ID'},{'IL'},
																{'IN'},{'KS'},{'KY'},{'LA'},{'MA'},{'MD'},{'ME'},{'MI'},{'MN'},{'MO'},{'MS'},{'MT'},{'NC'},{'ND'},{'NE'},{'NH'},{'NJ'},{'NM'},{'NV'},
																{'NU'},{'NY'},{'OH'},{'OK'},{'OR'},{'PA'},{'PR'},{'RI'},{'RN'},{'SC'},{'SD'},{'TN'},{'TX'},{'UT'},{'VA'},{'VI'},{'VT'},{'WA'},{'WI'},
																{'WV'},{'WY'},{'AZ'},{'RR'},{'WV'},{'PR'},{'EE'}],{STRING state});
					isValidState := IF(state_in in set(states_ds,state),TRUE,FALSE);
				return isValidState;
	END;
	
	EXPORT DATASET (Healthcare_Shared.Layouts_License.parsed_license_layout) fn_ParseLicense(string lic_num_in, string lic_state_in, string lic_type_in, string prac_state, boolean subPracStateForEmptyLicState) := FUNCTION
		// inRecs.userinput.license_number
		// compare
		// inRecs.statelicenses (Child Dataset)
							license_inRecs := DATASET([{lic_num_in,lic_state_in,lic_type_in,prac_state}],{string lic_num_in, string lic_state_in, string lic_type_in, string prac_state});
							PATTERN number := PATTERN('[0-9]+');
							PATTERN letter := PATTERN('[a-zA-Z][a-zA-Z]');

									license_num_rec:= RECORD
										STRING num := MATCHTEXT(number);
										UNSIGNED numlength := LENGTH(MATCHTEXT(number));
									END;

									license_state_rec:= RECORD
										STRING state := MATCHTEXT(letter);
									END;

							lic_parse_digits := SORT(PARSE(license_inRecs,license_inRecs[1].lic_num_in,number,license_num_rec,MAX,MANY),-numlength);
							lic_parse_letters := PARSE(license_inRecs,license_inRecs[1].lic_num_in,letter,license_state_rec,SCAN ALL);
							lic_parse_letters_valid := lic_parse_letters(isValidState(state[..2]));
							lic_num_raw := REGEXREPLACE('[^0-9A-Za-z]',license_inRecs[1].lic_num_in,'');
							
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
							
						//if there are multiple 2 letter tokens, pick the first valid state if available, but use the prac state before any tokens if the config setting is set				
							best_lic_state := MAP(TRIM(license_inRecs[1].lic_state_in) <> '' => license_inRecs[1].lic_state_in,
																		license_inRecs[1].lic_num_in <> '' and TRIM(license_inRecs[1].lic_state_in) = '' and subPracStateForEmptyLicState and prac_state <> '' => prac_state, // don't write out prac state if they didn't send in any lic num
																		isValidState(two_letter_tok_1) = TRUE /*and two_letter_tok_1 not in ['DC','MD','PA']*/					=> two_letter_tok_1, 
																		isValidState(two_letter_tok_2) = TRUE	/*and two_letter_tok_2 not in ['DC','MD','PA']*/				  => two_letter_tok_2,
																		TRIM(license_inRecs[1].lic_state_in));
							
						//leftovers to use as potential lic1_type.  Do not replace valid state abbreviations if an input state is forced.
							// however, if the forced input state is ALSO in the license string, remove it from the leftovers string.
							p_lic_type := IF(TRIM(license_inRecs[1].lic_type_in) <> '', license_inRecs[1].lic_type_in,
																REGEXREPLACE( '' + lic_longest_num + '|' + best_lic_state ,lic_num_raw,''));
							
							input_lic_st := IF(license_inRecs[1].lic_num_in = '',2,0);
							
							
							
							parsed_input_license_num := TRIM(lic_longest_num_nozero);
							parsed_input_license_state := TRIM(best_lic_state);
							parsed_input_license_type := TRIM(p_lic_type);
							
							group_key := ''; //blank out group key for the match_input funtion, it is not available at this point.
							prac_state_in := license_inRecs[1].prac_state;
							
							results_ds := DATASET([	{group_key,
																			lic_num_raw, 
																			lic_state_in,
																			lic_type_in,
																			lic_nums_tok,
																			count_nums_tok,
																			lic_longest_num,
																			parsed_input_license_num,
																			lic_alphas_tok,
																			count_alphas_tok,
																			two_letter_tok_1,
																			two_letter_tok_2,
																			parsed_input_license_state,
																			prac_state_in,
																			parsed_input_license_type,
																			input_lic_st}],	Healthcare_Shared.Layouts_License.parsed_license_layout);
						RETURN results_ds;
		END;	
END;