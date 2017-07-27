import DriversVTSA;

export DLRaw := module

	// ------------------------------------------
	// Key & layout abbreviations
	// ------------------------------------------
	shared k_did		:= DriversVTSA.Key_DL_DID;  
	shared k_num		:= DriversVTSA.Key_DL_Number; 
	shared k_seq		:= DriversVTSA.Key_DL_Seq;
	shared l_did		:= layouts.did;
	shared l_seq		:= layouts.seq;
	shared l_num		:= layouts.num;
	shared l_snum		:= layouts.snum;
	shared l_wide		:= layouts.result_wide_tmp;
	shared l_narrow	:= layouts.result_narrow;
	shared l_moxie	:= layouts.Layout_drivers_license2_1;
	shared l_moxieTmp	:= layouts.moxie_tmp;
	
	shared l_dl					:= layouts.result_wide;
	

	// ------------------------------------------
	// Constants
	// ------------------------------------------
	shared max_raw_DLs		:= 1000;
	shared moxie_pThresh	:= 10;
	
	
	// ------------------------------------------
	// Key conversions
	// ------------------------------------------
	export get_seq_from_dids(dataset(l_did) in_dids) := function
		res := join(dedup(sort(in_dids,did),did), k_did,
		            keyed(left.did = right.did),
								transform(l_seq, self := right),
								limit(max_raw_DLs));
		return dedup(sort(res,dl_seq),record);
	end;
	
	export get_seq_from_num(dataset(l_num) in_nums) := function
		res := join(dedup(sort(in_nums,dl_number),dl_number), k_num,
		            keyed(left.dl_number = right.s_dl),
								transform(l_seq, self := right),
								limit(max_raw_DLs));
		return dedup(sort(res,dl_seq),dl_seq);
	end;
	
	export get_seq_from_snum(dataset(l_snum) in_snums) := function
		res := join(dedup(sort(in_snums,dl_number,orig_state),dl_number,orig_state), k_num,
		            keyed(left.dl_number = right.s_dl) and left.orig_state = right.orig_state, 
								transform(l_seq, self := right),
								limit(max_raw_DLs,skip));
		return dedup(sort(res,dl_seq),dl_seq);
	end;
	
	export get_did_from_num(dataset(l_num) in_nums) := function
		res := join(dedup(sort(in_nums,dl_number),dl_number), k_num,
		            keyed(left.dl_number = right.s_dl),
								transform(l_did, self := right),
								limit(max_raw_DLs));
		return dedup(sort(res(did<>0),did),did);
	end;
	
	export get_did_from_snum(dataset(l_snum) in_snums) := function
		res := join(dedup(sort(in_snums,dl_number,orig_state),dl_number,orig_state), k_num,
		            keyed(left.dl_number = right.s_dl) and left.orig_state = right.orig_state, 
								transform(l_did, self := right),
								limit(max_raw_DLs,skip));
		return dedup(sort(res(did<>0),did),did);
	end;
	
	// ------------------------------------------
  // Return DL data in the wide report format
	// ------------------------------------------
  export wide_view := module
	
	  // ...using seq as the lookup mechanism
		export dataset(l_wide) by_seq(
			dataset(l_seq) in_seqs
		) := function
		  recs			:= fn_getDL_report(in_seqs);
		  wide_recs	:= project(recs, l_wide);
			sort_recs	:= sort(wide_recs,
          -lic_issue_date, -expiration_date, record, 
          except dl_seq, sex_flag, history, eye_color, hair_color, attention_flag,
					license_type, license_class, restrictions_delimited, lic_endorsement);
		  results		:= dedup(sort_recs,
        lic_issue_date, expiration_date, record,
				except dl_seq, sex_flag, history, eye_color, hair_color, attention_flag,
					license_type, license_class, restrictions_delimited, lic_endorsement
			);
		  return results;
		end;
		
	  // ...using DID as the lookup mechanism
	  export dataset(l_wide) by_did(
			dataset(l_did) in_dids
		) := function
		  return by_seq(get_seq_from_dids(in_dids));
		end;
		
		// ...using dl_number as the lookup mechanism
		export dataset(l_wide) by_num(
			dataset(l_num) in_nums
		) := function
		  return by_seq(get_seq_from_num(in_nums));
		end;

		// ...using dl_number as the lookup mechanism
		export dataset(l_wide) by_snum(
			dataset(l_snum) in_snums
		) := function
		  return by_seq(get_seq_from_snum(in_snums));
		end;
	end; // wide_view
	
	
	// ------------------------------------------
  // Return DL data in the narrow report format
	// ------------------------------------------
  export narrow_view := module
	
	  // ...using seq as the lookup mechanism
		export dataset(l_narrow) by_seq(
			dataset(l_seq) in_seqs,
			GetDLParams.params gdlParams = GetDLParams.getDefault()
		) := function
		  recs				:= fn_getDL_report(in_seqs, gdlParams);
		  narrow_recs	:= project(recs, l_narrow);
			sort_recs		:= sort(narrow_recs, -lic_issue_date, -expiration_date, record);
		  results			:= dedup(
				sort_recs,
				except dl_seq, sex_flag, history, eye_color, hair_color, attention_flag,
					license_type, restrictions_delimited, lic_endorsement
			);
		  return results;
		end;
		
	  // ...using DID as the lookup mechanism
	  export dataset(l_narrow) by_did(
			dataset(l_did) in_dids
		) := function
		  return by_seq(get_seq_from_dids(in_dids));
		end;
		
		// ...using dl_number as the lookup mechanism
		export dataset(l_narrow) by_num(
			dataset(l_num) in_nums
		) := function
		  return by_seq(get_seq_from_num(in_nums));
		end;		
	end; // narrow_view
	
end;