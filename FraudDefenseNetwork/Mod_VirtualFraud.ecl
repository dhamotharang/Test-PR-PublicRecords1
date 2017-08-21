IMPORT did_add, Doxie, Inquiry_AccLogs, Risk_Indicators, RiskWise;

EXPORT Mod_VirtualFraud := MODULE
	
	// See Risk_indicators.Boca_Shell_Inquiries
	
	EXPORT layout_input := RECORD
		UNSIGNED4 seq;
		UNSIGNED6 did;	
		STRING10 phone10;
		STRING10 prim_range;
		STRING2  predir;
		STRING28 prim_name;
		STRING4  addr_suffix;
		STRING2  postdir;
		STRING10 unit_desig;
		STRING8  sec_range;
		STRING25 p_city_name;
		STRING2  st;
		STRING5  z5;
		STRING9  ssn;
		STRING historydateTimeStamp;
		UNSIGNED3 historydate;
	END;
	
	EXPORT layout_temp := RECORD
		UNSIGNED4 seq;
		UNSIGNED6 did;
		STRING10 phone10;
		STRING10 prim_range;
		STRING2  predir;
		STRING28 prim_name;
		STRING4  addr_suffix;
		STRING2  postdir;
		STRING10 unit_desig;
		STRING8  sec_range;
		STRING25 p_city_name;
		STRING2  st;
		STRING5  z5;
		STRING9  ssn;
		STRING historydateTimeStamp;
		UNSIGNED3 historydate;
		STRING	Transaction_ID := '';
		STRING	Sequence_Number := '';
		STRING8 first_log_date;
		UNSIGNED6 inquiryADLsFromPhone := 0;
		UNSIGNED6 inquiryADLsFromAddr := 0;
		UNSIGNED6 inquirySSNsFromADL := 0;
		UNSIGNED6 inquiryADLsFromSSN := 0;
		Risk_Indicators.layouts.layout_virtual_fraud;
	END;

	EXPORT layout_virtualfraud := RECORD
		UNSIGNED4 seq;
		UNSIGNED6 did;
		Risk_Indicators.layouts.layout_virtual_fraud;
	END;
	
	// For testing purposes only: simply retrieve records from the Inquiry key, keyed on DID.
	EXPORT getDataRaw( DATASET(Doxie.layout_references) dids ) :=
		FUNCTION
			recs := 
				join(
					dids, Inquiry_AccLogs.Key_Inquiry_DID, 
					left.did <> 0 and keyed(left.did = right.s_did),	
					transform(right),
					atmost(5000)
				);	
			
			RETURN recs;
		END;
	
	// The following function is the logic used to determin virtual_fraud value, extracted from 
	// Risk_Indicators.Boca_Shell_Inquiries.
	EXPORT getData( DATASET(layout_input) ds_input, BOOLEAN isFCRA = FALSE, INTEGER BocaShellVersion = 50 ) := 
		FUNCTION
			UCase := StringLib.StringToUpperCase;
			high_risk_fraud_cutoff  := 575;  // b)	High Risk = 575 and below
			low_risk_fraud_cutoff   := 725;  // a)	Low Risk = 725 and above 
			cap125(UNSIGNED _count) := MIN(_count, 125);

			// 1. Obtain LexID-based counts from both the cumulative and update keys. 
			MAC_raw_did_transform (trans_name, key_did) := MACRO
					layout_temp trans_name(layout_input le, key_did rt) := TRANSFORM
						industry     := TRIM(UCase(rt.bus_intel.industry));
						vertical     := TRIM(UCase(rt.bus_intel.vertical));
						sub_market   := TRIM(UCase(rt.bus_intel.sub_market));
						func         := TRIM(UCase(rt.search_info.function_description));
						product_code := TRIM(rt.search_info.product_code);
						logdate      := rt.search_info.datetime[1..8];
						good_inquiry := TRUE;	// Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(vertical, industry, func, logdate, le.historydate, sub_market, rt.bus_intel.use, rt.search_info.product_code, rt.permissions.fcra_purpose, isFCRA, BocaShellVersion);
						fd_score     := (UNSIGNED)rt.fraudpoint_score;

						inquiry_hit := TRUE; // I'm hard-coding this. See Risk_Indicators.Boca_Shell_Inquiries, lines 108-112.

						addrmatchscore := 
								Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, rt.person_q.prim_range, rt.person_q.prim_name, rt.person_q.sec_range);																			
						addrmatch := risk_indicators.iid_constants.ga(addrmatchscore);
						
						hphonematchscore := risk_indicators.PhoneScore(le.phone10, rt.person_q.personal_phone);
						hphonematch := risk_indicators.iid_constants.gn(hphonematchscore);
						
						socsmatchscore := did_add.ssn_match_score(le.ssn, rt.person_q.ssn, LENGTH(TRIM(le.ssn))=4);
						socsmatch := risk_indicators.iid_constants.gn(socsmatchscore);

						self.seq := le.seq;
						self.did := le.did;
					
						self.hi_risk_ct                := if(good_inquiry and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);	
						self.lo_risk_ct                := if(good_inquiry and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);
						self.LexID_phone_hi_risk_ct    := if(good_inquiry and hphonematch and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);	
						self.LexID_phone_lo_risk_ct    := if(good_inquiry and hphonematch and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);
						self.AltLexID_Phone_hi_risk_ct := 0;  // will be set in the phone join
						self.AltLexID_Phone_lo_risk_ct := 0;  // will be set in the phone join
						self.LexID_addr_hi_risk_ct     := if(good_inquiry and addrmatch and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);	
						self.LexID_addr_lo_risk_ct     := if(good_inquiry and addrmatch and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);
						self.AltLexID_addr_hi_risk_ct  := 0; // will be set in the addr join
						self.AltLexID_addr_lo_risk_ct  := 0; // will be set in the addr join
						self.LexID_ssn_hi_risk_ct      := if(good_inquiry and socsmatch and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);	
						self.LexID_ssn_lo_risk_ct      := if(good_inquiry and socsmatch and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);
						self.AltLexID_ssn_hi_risk_ct   := 0; // will be set in the ssn join
						self.AltLexID_ssn_lo_risk_ct   := 0; // will be set in the ssn join
						self.first_log_date            := if(inquiry_hit, logdate, '');
						self.Transaction_ID            := if(rt.search_info.Transaction_ID <> '' or BocaShellVersion < 50,rt.search_info.Transaction_ID, rt.search_info.Sequence_Number);
						self.Sequence_Number           := rt.search_info.Sequence_Number;					
						self := le;
						self := [];
					END;			
			ENDMACRO;

			MAC_raw_did_transform (add_inquiry_raw, Inquiry_AccLogs.Key_Inquiry_DID);
			MAC_raw_did_transform (add_inquiry_raw_update, Inquiry_AccLogs.Key_Inquiry_DID_Update);
			
			// 1.a. Join to cumulative or historical key.
			j_raw_nonfcra_full := 
				join(
					ds_input, Inquiry_AccLogs.Key_Inquiry_DID, 
					left.did <> 0 and keyed(left.did = right.s_did) and
					Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BocaShellVersion),	
					add_inquiry_raw(left, right),
					left outer, atmost(5000));	

			// 1.b. Join to update key. Update keys are only built for non-fcra.						
			j_raw_nonfcra_update := 
				join(
					ds_input, Inquiry_AccLogs.Key_Inquiry_DID_Update, 
					left.did<>0 and keyed(left.did=right.s_did) and
					Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BocaShellVersion),	
					add_inquiry_raw_update(left, right),
					atmost(5000));

			// 1.c. Union, sort, and dedup the results.
			j_raw := 
				dedup(
					sort(
						ungroup(j_raw_nonfcra_full + j_raw_nonfcra_update), 
						seq, transaction_id, -(unsigned3)first_log_date, Sequence_Number
					), 
					seq, transaction_id
				);
			
			// 1.d. Rollup results so far.
			layout_temp roll( layout_temp le, layout_temp rt ) := TRANSFORM	
				self.hi_risk_ct             := cap125(le.hi_risk_ct + rt.hi_risk_ct);	
				self.lo_risk_ct             := cap125(le.lo_risk_ct + rt.lo_risk_ct);
				self.LexID_phone_hi_risk_ct := cap125(le.LexID_phone_hi_risk_ct + rt.LexID_phone_hi_risk_ct);
				self.LexID_phone_lo_risk_ct := cap125(le.LexID_phone_lo_risk_ct + rt.LexID_phone_lo_risk_ct);
				self.LexID_addr_hi_risk_ct  := cap125(le.LexID_addr_hi_risk_ct + rt.LexID_addr_hi_risk_ct);	
				self.LexID_addr_lo_risk_ct  := cap125(le.LexID_addr_lo_risk_ct + rt.LexID_addr_lo_risk_ct);
				self.LexID_ssn_hi_risk_ct   := cap125(le.LexID_ssn_hi_risk_ct + rt.LexID_ssn_hi_risk_ct);	
				self.LexID_ssn_lo_risk_ct   := cap125(le.LexID_ssn_lo_risk_ct + rt.LexID_ssn_lo_risk_ct);
				self := rt;
			end;
	
			grouped_raw := group(sort(j_raw, seq, -inquirySSNsFromADL), seq);
			rolled_raw  := rollup(grouped_raw, roll(left,right), true);

			// 2. Obtain Phone-based counts from both the cumulative and update keys.. 
			MAC_raw_phone_transform (trans_name, phone_key) := MACRO
					layout_temp trans_name(layout_temp le, phone_key rt) := transform
						industry     := TRIM(UCase(rt.bus_intel.industry));
						vertical     := TRIM(UCase(rt.bus_intel.vertical));
						sub_market   := TRIM(UCase(rt.bus_intel.sub_market));
						func         := TRIM(UCase(rt.search_info.function_description));
						product_code := TRIM(rt.search_info.product_code);
						logdate      := rt.search_info.datetime[1..8];
						good_inquiry := TRUE; // Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(vertical, industry, func, logdate, le.historydate, sub_market, rt.bus_intel.use, rt.search_info.product_code, rt.permissions.fcra_purpose, isFCRA, BocaShellVersion);
						fd_score     := (UNSIGNED)rt.fraudpoint_score;
						alt_lexid    := le.did <> rt.person_q.appended_adl;

						self.seq := le.seq;
						self.did := le.did;
					
						self.inquiryADLsFromPhone      := if(good_inquiry and rt.person_q.appended_adl<>0, rt.person_q.appended_adl, 0);  						
						self.AltLexID_Phone_hi_risk_ct := if(good_inquiry and alt_lexid and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);
						self.AltLexID_Phone_lo_risk_ct := if(good_inquiry and alt_lexid and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);
						self.Transaction_ID := if(rt.search_info.Transaction_ID <> '' or BocaShellVersion < 50,rt.search_info.Transaction_ID, rt.search_info.Sequence_Number);
						self.Sequence_Number := rt.search_info.Sequence_Number;					
						self := le;
					end;
			ENDMACRO;

			MAC_raw_phone_transform(add_Phone_raw, Inquiry_AccLogs.Key_Inquiry_Phone);
			MAC_raw_phone_transform(add_Phone_raw_update, Inquiry_AccLogs.Key_Inquiry_Phone_update);

			// 2.a. Join results of step 1 to cumulative or historical key.
			Phone_raw_base := 
				join(
					rolled_raw, Inquiry_AccLogs.Key_Inquiry_Phone,
					left.phone10 <> '' and 
					keyed(left.phone10 = right.phone10) and 
					Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BocaShellVersion),	
					add_Phone_raw(left, right), left outer, atmost(riskwise.max_atmost));
											
			// 2.b. Join to update key. Update keys are only built for non-fcra.
			Phone_raw_updates := 
				join(
					rolled_raw, Inquiry_AccLogs.Key_Inquiry_Phone_update,
					left.phone10 <> '' and 
					keyed(left.phone10 = right.phone10) and
					Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BocaShellVersion),	
					add_Phone_raw_update(left, right), atmost(riskwise.max_atmost));			
			
			// 2.c. Union, sort, and dedup the phone results.
			Phone_raw := 
				DEDUP(
					SORT(
						UNGROUP( phone_raw_base + phone_raw_updates ), 
						seq, transaction_id, -(unsigned3) first_log_date, Sequence_Number
					), 
					seq, transaction_id
				);
			
			grouped_Phone_raw := group(sort(Phone_raw, seq, -inquiryADLsFromPhone), seq);
			
			layout_temp roll_Phone( layout_temp le, layout_temp rt ) := TRANSFORM	
				self.AltLexID_Phone_hi_risk_ct := cap125(le.AltLexID_Phone_hi_risk_ct + rt.AltLexID_Phone_hi_risk_ct);
				self.AltLexID_Phone_lo_risk_ct := cap125(le.AltLexID_Phone_lo_risk_ct + rt.AltLexID_Phone_lo_risk_ct);				
				self := rt;							
			end;

			// 2.d. Rollup results so far.
			with_phone_velocities := rollup( grouped_Phone_raw, roll_Phone(left,right), true);			

			// 3. Obtain Address-based counts from both the cumulative and update keys. 
			MAC_raw_addr_transform (trans_name, addr_key) := MACRO
					layout_temp trans_name(layout_temp le, addr_key rt) := transform
						industry     := TRIM(UCase(rt.bus_intel.industry));
						vertical     := TRIM(UCase(rt.bus_intel.vertical));
						sub_market   := TRIM(UCase(rt.bus_intel.sub_market));
						func         := TRIM(UCase(rt.search_info.function_description));
						product_code := TRIM(rt.search_info.product_code);
						logdate      := rt.search_info.datetime[1..8];
						good_inquiry := TRUE; // Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(vertical, industry, func, logdate, le.historydate, sub_market, rt.bus_intel.use, rt.search_info.product_code, rt.permissions.fcra_purpose, isFCRA, BocaShellVersion);
						fd_score     := (UNSIGNED)rt.fraudpoint_score;
						alt_lexid    := le.did <> rt.person_q.appended_adl;
						
						self.seq := le.seq;
						self.did := le.did;
						
						self.inquiryADLsFromAddr := if(good_inquiry and rt.person_q.appended_adl<>0, rt.person_q.appended_adl, 0);  
						self.AltLexID_addr_hi_risk_ct := if(good_inquiry and alt_lexid and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);
						self.AltLexID_addr_lo_risk_ct := if(good_inquiry and alt_lexid and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);					
						self.Transaction_ID := if(rt.search_info.Transaction_ID <> '' or BocaShellVersion < 50,rt.search_info.Transaction_ID, rt.search_info.Sequence_Number);
						self.Sequence_Number := rt.search_info.Sequence_Number;					
						self := le;
					end;
			ENDMACRO;

			MAC_raw_addr_transform(add_Addr_raw, Inquiry_AccLogs.Key_Inquiry_Address);
			MAC_raw_addr_transform(add_Addr_raw_Update, Inquiry_AccLogs.Key_Inquiry_Address_update);

			// 3.a. Join results of step 2 to cumulative or historical key.
			Addr_raw_base := join(with_phone_velocities, Inquiry_AccLogs.Key_Inquiry_Address,
											left.prim_name<>'' and 
											left.z5<>'' and
											keyed(left.z5=right.zip) and 
											keyed(left.prim_name=right.prim_name) and 
											keyed(left.prim_range=right.prim_range) and 
											keyed(left.sec_range=right.sec_range) and
											left.predir=right.person_q.predir and
											left.addr_suffix=right.person_q.addr_suffix and
											Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BocaShellVersion),	
											add_Addr_raw(left, right), left outer, atmost(riskwise.max_atmost));
											
			// 3.b. Join to update key. Update keys are only built for non-fcra.
			Addr_raw_updates := join(with_phone_velocities, Inquiry_AccLogs.Key_Inquiry_Address_update,
											left.prim_name<>'' and 
											left.z5<>'' and
											keyed(left.z5=right.zip) and 
											keyed(left.prim_name=right.prim_name) and 
											keyed(left.prim_range=right.prim_range) and 
											keyed(left.sec_range=right.sec_range) and
											left.predir=right.person_q.predir and
											left.addr_suffix=right.person_q.addr_suffix and
											Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BocaShellVersion),	
											add_Addr_raw_Update(left, right), atmost(riskwise.max_atmost));

			// 3.c. Union, sort, and dedup the address results.
			Addr_raw := 
				dedup(
					sort(
						ungroup(addr_raw_base + addr_raw_updates), 
						seq, transaction_id, -(unsigned3) first_log_date, Sequence_Number
					), 
					seq, transaction_id
				);
			
			grouped_addr_raw := group(sort(Addr_raw, seq, -inquiryADLsFromAddr), seq);

			layout_temp roll_Addr( layout_temp le, layout_temp rt ) := TRANSFORM	
				self.AltLexID_addr_hi_risk_ct := cap125(le.AltLexID_addr_hi_risk_ct + rt.AltLexID_addr_hi_risk_ct);
				self.AltLexID_addr_lo_risk_ct := cap125(le.AltLexID_addr_lo_risk_ct + rt.AltLexID_addr_lo_risk_ct);					
				self := rt;							
			end;

			// 3.d. Rollup results so far.
			with_addr_velocities := rollup( grouped_addr_raw, roll_addr(left,right), true);

			// 4. Obtain SSN-based counts from both the cumulative and update keys.
			MAC_raw_ssn_transform (trans_name, ssn_key) := MACRO
					layout_temp trans_name(layout_temp le, ssn_key rt) := transform
						industry     := TRIM(UCase(rt.bus_intel.industry));
						vertical     := TRIM(UCase(rt.bus_intel.vertical));
						sub_market   := TRIM(UCase(rt.bus_intel.sub_market));
						func         := TRIM(UCase(rt.search_info.function_description));
						product_code := TRIM(rt.search_info.product_code);
						logdate      := rt.search_info.datetime[1..8];
						good_inquiry := TRUE; // Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(vertical, industry, func, logdate, le.historydate, sub_market, rt.bus_intel.use, rt.search_info.product_code, rt.permissions.fcra_purpose, isFCRA, BocaShellVersion);
						fd_score     := (UNSIGNED)rt.fraudpoint_score;
						alt_lexid    := le.did <> rt.person_q.appended_adl;
						
						self.seq := le.seq;
						self.did := le.did;

						self.inquiryADLsFromSSN      := if(good_inquiry and rt.person_q.appended_adl<>0, rt.person_q.appended_adl, 0);  
						self.AltLexID_ssn_hi_risk_ct := if(good_inquiry and alt_lexid and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);
						self.AltLexID_ssn_lo_risk_ct := if(good_inquiry and alt_lexid and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);
						self.Transaction_ID          := if(rt.search_info.Transaction_ID <> '' or BocaShellVersion < 50,rt.search_info.Transaction_ID, rt.search_info.Sequence_Number);
						self.Sequence_Number         := rt.search_info.Sequence_Number;				
						self := le;
					end;
			ENDMACRO;

			MAC_raw_ssn_transform(add_ssn_raw, Inquiry_AccLogs.Key_Inquiry_SSN);
			MAC_raw_ssn_transform(add_ssn_raw_update, Inquiry_AccLogs.Key_Inquiry_SSN_update);

			// 4.a. Join results of step 3 to cumulative or historical key.
			ssn_raw_base := join(with_addr_velocities, Inquiry_AccLogs.Key_Inquiry_SSN,
											left.ssn<>'' and 
											keyed(left.ssn=right.ssn) and
											Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BocaShellVersion),	
											add_ssn_raw(left, right), left outer, atmost(riskwise.max_atmost));

			// 4.b. Join to update key. Update keys are only built for non-fcra.
			ssn_raw_updates := join(with_addr_velocities, Inquiry_AccLogs.Key_Inquiry_SSN_update,
											left.ssn<>'' and 
											keyed(left.ssn=right.ssn) and	
											Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BocaShellVersion),	
											add_ssn_raw_update(left, right), atmost(riskwise.max_atmost));
			
			// 4.c. Union, sort, and dedup the address results.
			ssn_raw := 
				dedup(
					sort(
						ungroup(ssn_raw_base + ssn_raw_updates), 
						seq, transaction_id, -(unsigned3)first_log_date, Sequence_Number
					), 
					seq, transaction_id
				);

			grouped_ssn_raw := group(sort( ssn_raw, seq, -inquiryADLsFromSSN), seq);

			layout_temp roll_ssn( layout_temp le, layout_temp rt ) := TRANSFORM	
				self.AltLexID_ssn_hi_risk_ct := cap125(le.AltLexID_ssn_hi_risk_ct + rt.AltLexID_ssn_hi_risk_ct);
				self.AltLexID_ssn_lo_risk_ct := cap125(le.AltLexID_ssn_lo_risk_ct + rt.AltLexID_ssn_lo_risk_ct);				
				self := rt;							
			end;

			// 4.d. Rollup results. Return.
			rolled_ssn_raw := rollup( grouped_ssn_raw, roll_ssn(left,right), true);

			with_all_velocities := rolled_ssn_raw;
			
			results := 
				JOIN(
					ds_input, with_all_velocities, 
					left.seq = right.seq,
					transform(layout_virtualfraud,
						self := right,
						self := left
					)
				);			
			
			RETURN results;
		END;
		
END;
