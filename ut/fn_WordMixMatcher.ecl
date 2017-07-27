/*
Checks for characters matching in word irrelevant of order. 
Purpose is for matchcodes matching.
*/

/*---Function to check if all the characters in inword are present in any of the words in word_set independent of the original order
-----in order to match, inword and corresponding word in word_set need to have the same length.
-----Ex: instr1 'ANSCZ' word_set ['ANSC','SNACZ'] returns true-----*/

export boolean fn_WordMixMatcher(string inword, set of string word_set) := function

				in_rec_ds := record
					string matchcode;
				end;
				ds_wrd := dataset(word_set, in_rec_ds);

				out_rec := record
					boolean is_match_true;
				end;
				
				trim_word := trim(inword);
				wrd2_length := length(trim_word);
				token_ds_wrd2 := ut.WordTokenizer(trim_word);
				
				out_rec join_sets(recordof(ds_wrd) L) := transform
						wrd1_length := length(L.matchcode);
						token_ds_wrd1 := ut.WordTokenizer(L.matchcode);
						
						rec := record
							boolean is_match;
						end;
						
						rec mix_matcher_join(recordof(token_ds_wrd1) L, recordof(token_ds_wrd2) R)  := transform
							self.is_match := L.char = R.char;
						end;
						
						ds_join := join(token_ds_wrd1, token_ds_wrd2, 
																					left.char = right.char, 
																					mix_matcher_join(left, right)); 
																					
						self.is_match_true := if(wrd2_length <> wrd1_length, false, 
																							if(count(ds_join(is_match = true)) = wrd2_length, true, false));
																							
				end;

				ds_join_final := project(ds_wrd, join_sets(left));
				
				hasAMatch := count(ds_join_final(is_match_true = true)) >= 1;
				
				// output(str2_length);
				// output(token_ds_str2);
				// output(ds_str);
				// output(ds_join_final);
				
				return hasAMatch;		
				
end;