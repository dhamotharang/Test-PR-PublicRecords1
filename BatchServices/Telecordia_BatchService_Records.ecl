
IMPORT BatchServices, CellPhone, Risk_Indicators;

EXPORT Telecordia_BatchService_Records := 
	MODULE

		EXPORT rec_input := RECORD
			STRING30 acctno       := '';
			STRING16 phone_number := '';
		END;

		SHARED rec_input_atomic := RECORD
			rec_input;
			STRING3 npa     := '';
			STRING3 nxx     := '';
			STRING1 tb      := '';
		END;
			
		SHARED rec_Telcordia := RECORD
			rec_input_atomic;       // i.e. acctno, phone_number, npa, nxx, tb
			STRING50 city            := '';
			STRING2  st              := '';
			STRING30 ocn             := '';
			STRING1  company_type    := '';
			STRING3  coctype         := '';
			STRING4  ssc             := '';
			STRING2  nxx_type        := '';
			STRING1  phone_type_code := '';			
			STRING1  dial_ind        := '';
		END;
				
		EXPORT ds_sample := DATASET([
					{'Jersey City_NJ_Sprint 1','2012042000'},
					{'Jersey City_NJ_Sprint 2','2012042001'},
					{'Ported to cell','4787816750'},
					{'POTS_1','9372567420'},
					{'TOLLFREE_1','8009633556'},
					{'CELL_1','2533509709'},
					{'CELL_2','9376719200'},
					{'PAGER_1','(937) 201-4400'},
					{'PUERTO_RICO_1','787.230-3000'},
					{'VIRG_ISL_1','340 692 5000'},
					{'UNK_TYPE_1','1995146000'},
					{'VOIP_1','(201)753-2000'},
					{'TOO_SHORT','8545835'},
					{'ACTUALLY_AN_SSN','536-89-0872'},
					{'TOO_LONG','253854583592'},
					{'JUST_JUNK','937!$_^%@'}
			], rec_input);	
				
				
		SET OF STRING3 Toll_Free_Area_Codes := ['800','811','822','833','844','855','866','877','888','899'];

		STRING1 POTS                       := 'P'; // "Plain Old Telephone Service"
		STRING1 PAGER                      := 'G';
		STRING1 CELL_PHONE                 := 'C';
		STRING1 PUERTO_RICO_VIRGIN_ISLANDS := 'I';
		STRING1 TIME                       := 'T';
		STRING1 VOIP                       := 'V';
		STRING1 WEATHER                    := 'W';
		STRING1 TOLL_FREE                  := '8';
		STRING1 UNKNOWN_TYPE               := 'U';

		fn_GetPhoneTypeCode(rec_input_atomic inRec, STRING3 COCType, STRING4 SSC) :=
			FUNCTION
				phone_type_code := IF( inRec.npa IN Toll_Free_Area_Codes OR REGEXFIND('I',SSC), 
															 TOLL_FREE,
															 MAP(COCType IN ['EOC','PMC','RCC','SP1','SP2'] AND 
																	 REGEXFIND('(C|R|S)',SSC)                       => CELL_PHONE,
																	 REGEXFIND('B',      SSC)                       => PAGER,
																	 REGEXFIND('N',      SSC)                       => POTS,
																	 REGEXFIND('V',      SSC)                       => VOIP,
																	 REGEXFIND('T',      SSC)                       => TIME,
																	 REGEXFIND('W',      SSC)                       => WEATHER,
																	 REGEXFIND('8',      SSC)                       => PUERTO_RICO_VIRGIN_ISLANDS,
																	 /* ELSE.....................................*/ UNKNOWN_TYPE)
															);
				RETURN phone_type_code;
			END;
			
		EXPORT BatchView(DATASET(rec_input) ds_batch_in = DATASET([],rec_input), BOOLEAN ExpandUnknown = false) := 
			FUNCTION					
				// 2. Clean off non-alphanumeric characters.
				rec_input xfm_clean_phone_number(rec_input l) :=
					TRANSFORM
						SELF.acctno := l.acctno;
						SELF.phone_number := Stringlib.StringFilterOut(l.phone_number, '( .)-');
					END;
					
				ds_valid_input_cleaned := PROJECT(ds_batch_in, xfm_clean_phone_number(LEFT))(LENGTH(TRIM(phone_number)) = 10);
				
				// 3. Split the valid phone numbers into their atomic pieces, save for the last three digits.
				rec_input_atomic xfm_split_phone_number(rec_input l) := 
					TRANSFORM     
						SELF.npa          := l.phone_number[1..3]; // area code
						SELF.nxx          := l.phone_number[4..6]; // switch
						SELF.tb           := l.phone_number[7];
						SELF              := l;
					END;             
				
				ds_valid_input_atomic := PROJECT(ds_valid_input_cleaned, xfm_split_phone_number(LEFT));
				
				// 4. Join against Telecordia keys for matching records.				
				key_tds := Risk_Indicators.key_Telcordia_tds;
				key_tpm := Risk_Indicators.key_Telcordia_tpm; 		
				
				// 5. Join to get SSCs and mappings.		
				rec_Telcordia xfm_join_for_SSCs(ds_valid_input_atomic l, key_tds r) :=
					TRANSFORM
						SELF.st              := r.state;
						SELF.phone_type_code := fn_GetPhoneTypeCode(l, r.COCType, r.SSC);
						SELF                 := l;
						SELF                 := r;
					END;

				ds_Telecordia_SSCs := JOIN(ds_valid_input_atomic, key_tds,
																	 KEYED(RIGHT.npa = LEFT.npa) AND
																	 KEYED(RIGHT.nxx = LEFT.nxx) AND
																	 RIGHT.tb = LEFT.tb,
																	 xfm_join_for_SSCs(LEFT, RIGHT),
																	 LEFT OUTER, KEEP(1));

				// 6. Join to get nxx_types and mappings.		
				rec_Telcordia xfm_join_for_NXXs(ds_Telecordia_SSCs l, key_tpm r) :=
					TRANSFORM
						SELF.city            := r.city;
						SELF.st              := IF( TRIM(r.st) = '', l.st, r.st );
						SELF.ocn             := r.ocn;
						SELF.company_type    := r.company_type;
						SELF.nxx_type        := r.nxx_type;
						SELF.dial_ind        := r.dial_ind;	
						SELF                 := l;
						SELF                 := r;
					END;
					
				ds_Telecordia_NXXs := JOIN(ds_Telecordia_SSCs, key_tpm,
																	 KEYED(RIGHT.npa = LEFT.npa) AND
																	 KEYED(RIGHT.nxx = LEFT.nxx) AND 
																	 KEYED(RIGHT.tb  = LEFT.tb OR LEFT.tb = 'A'),
																	 xfm_join_for_NXXs(LEFT, RIGHT),
																	 LEFT OUTER, KEEP(1));
																	 
				// Check Neustar file for phones that have been ported to cell.
				ds_add_neustar := JOIN(ds_Telecordia_NXXs, CellPhone.key_neustar_phone,
															 KEYED(RIGHT.cellphone = LEFT.phone_number),
															 TRANSFORM(rec_Telcordia,
																				 SELF.phone_type_code := IF(RIGHT.cellphone = LEFT.phone_number,
																																		CELL_PHONE,
																																		LEFT.phone_type_code); 
																				 SELF := LEFT),
															 LEFT OUTER);
															 
							
				// 7. Reattach the input records. Return the original phone number, not the cleaned one.
				rec_Telcordia xfm_rejoin_input_recs(ds_batch_in l, ds_add_neustar r) :=
					TRANSFORM
						SELF.acctno          := l.acctno;
						SELF.phone_number    := l.phone_number;
						SELF                 := r;
					END;
					
				ds_rejoined_input_recs := JOIN(ds_batch_in, ds_add_neustar,
																			 LEFT.acctno = RIGHT.acctno,
																			 xfm_rejoin_input_recs(LEFT, RIGHT),
																			 LEFT OUTER);
				
				// 8. Finally, mark all reattached, invalid phone numbers as "unknown." Include TIME and WEATHER also as UNKNOWN.
				UnknownPhoneTypeSet := IF(ExpandUnknown = true, [TIME, WEATHER, UNKNOWN_TYPE,''], [UNKNOWN_TYPE,'']);
				rec_Telcordia xfm_mark_invalid_numbers_as_unknown(rec_Telcordia l) :=
					TRANSFORM
						SELF.phone_type_code := IF(l.phone_type_code IN UnknownPhoneTypeSet, UNKNOWN_TYPE, l.phone_type_code );
						SELF                 := l;
					END;		
				
				ds_results := PROJECT(ds_rejoined_input_recs, xfm_mark_invalid_numbers_as_unknown(LEFT));
						
				// Debugs...:
				// OUTPUT(ds_Telecordia_recs, NAMED('ds_Telecordia_recs'));
				// OUTPUT(ds_add_neustar, NAMED('ds_add_neustar'));
				// OUTPUT(ds_rejoined_input_recs, NAMED('ds_rejoined_input_recs'));
				
				RETURN SORT(ds_results, acctno);
		
			END;
		
	END;
	

/*

*** See YellowPages.NPA_PhoneType in Prod environment. Not Dataland. ***
1. Check TDS file for phone type. (join on npa, nxx, tb) 
2. Check Neustar file for phones that have been ported from landline to wireless (join on 10 digit phone) 
3. Check Current Gong file for "POTS" not flagged by item 1 (join on 10 digit phone) 
4. Check TPM to validate npa, nxx, and tb.  (join on npa, nxx, tb) 
 
The order matters because in some case you want one checkpoint result to overwrite the other.

*/
