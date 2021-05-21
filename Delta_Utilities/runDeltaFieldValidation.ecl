//////////////////////////////////////////////////////////////////////////////////////
//	
//	Attribute				:	Delta_Utilities.runDeltaFieldValidation
//	Parameters			:	Key attribute name, Key superfile name, debug boolen value.
//	Function macro	:	Returns multiple outputs based on boolean debug value passed.
//										if debug is true, then it ouputs the following 6 results along with DELTA_Cnt and CHECKRESULT
//										1) output 20 records from the key file passed.
//										2) output 10 duplicate record_sid records found in the key if exists.
//										3) output 10 blank record_sid records found in the key if exists.
//										4) output 10 blank dt_effective_first records found in the key if exists.
//										5) output 10 invalid delta_ind (delta_ind > 3) records found in the key if exists.
//										6) output 10 inconsistent delete (dt_effective_last>0, delta_ind<>3) records found in the key if exists.
//										if debug is false then ONLY DELTA_Cnt and CHECKRESULT are returned by the function.
//										
//	Usage						: Delta_Utilities.runDeltaFieldValidation(dx_Cortera.Key_LinkIds.key, '~thor_data400::key::cortera_tradeline::qa::LinkIds', TRUE);
//					
//
//////////////////////////////////////////////////////////////////////////////////////

import STD;

EXPORT runDeltaFieldValidation(k, sf_kname, DEBUG = false) := FUNCTIONMACRO

		layout_delta_check := RECORD
			STRING check;
			BOOLEAN passed;
		END;
		
		FileSubCnt := if(sf_kname <> '', nothor(fileservices.GetSuperFileSubCount(sf_kname)), 0);
		
		//*** if FileSub count is greater than 1 (means one full and one or more deltas) then substract 1 from the count to get the correct delta count.		
		Local DELTA_Cnt := if(FileSubCnt > 1, FileSubCnt - 1, 0); 
		
		LOCAL kname := STD.STR.FindReplace(STD.STR.FindReplace(#TEXT(k), '.', '_'), ' ', '');
		max_count_unique_sids := (DELTA_Cnt * 2) + 1;

		R := RECORD
			K.record_sid;
		END;

		KS := project(pull(K), R);

		S := RECORD
			KS.record_sid;
			N := COUNT(GROUP);
		END;

		LOCAL eyeball := CHOOSEN(k, 20);
		LOCAL dupes := CHOOSEN(SORT(TABLE(KS,S,KS.record_sid), -N), 10)(N > max_count_unique_sids);
		LOCAL blank_rids := CHOOSEN(k(record_sid=0), 10);
		LOCAL blank_dt_first := CHOOSEN(k(dt_effective_first=0), 10);
		LOCAL invalid_delta_ind := CHOOSEN(k(delta_ind>3), 10);
		LOCAL inconsistent_deletes := CHOOSEN(k(dt_effective_last>0, delta_ind<>3), 10);
		
		output(DELTA_Cnt, named('DELTA_Cnt'));
		IF (DEBUG, OUTPUT(eyeball, named(kname)));
		IF (DEBUG, OUTPUT(dupes, named('dupes_'+kname)));
		IF (DEBUG, OUTPUT(blank_rids, named('blank_rids_'+kname)));
		IF (DEBUG, OUTPUT(blank_dt_first, named('blank_dt_eff_first_'+kname)));
		IF (DEBUG, OUTPUT(invalid_delta_ind, named('invalid_delta_ind_'+kname)));
		IF (DEBUG, OUTPUT(inconsistent_deletes, named('inconsistent_deletes_'+kname)));

		LOCAL count_recs := 
			DATASET([
				 {'1. Duplicate RECORD_SID', ~EXISTS(dupes)}
				,{'2. Blank RECORD_SID', ~EXISTS(blank_rids)}
				,{'3. Blank DATE_EFFECTIVE_FIRST', ~EXISTS(blank_dt_first)}
				,{'4. Invalid DELTA_IND', ~EXISTS(invalid_delta_ind)}
				,{'5. Inconsistent delete record', ~EXISTS(inconsistent_deletes)}
			], layout_delta_check);
		OUTPUT(count_recs, NAMED('CHECKRESULT_'+kname));

		RETURN (COUNT(count_recs(~passed))=0);

ENDMACRO;