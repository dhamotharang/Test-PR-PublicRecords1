import DriversV2, ut, AutoStandardI, Autokey, NID, STD;

export DLRaw := module

	// ------------------------------------------
	// Key & layout abbreviations
	// ------------------------------------------
	shared k_did		:= DriversV2.Key_DL_DID;
	shared k_num		:= DriversV2.Key_DL_Number;
	shared k_ind		:= DriversV2.Key_DL_Indicatives;
	shared l_did		:= DriversV2_Services.layouts.did;
	shared l_seq		:= DriversV2_Services.layouts.seq;
	shared l_num		:= DriversV2_Services.layouts.num;
	shared l_snum		:= DriversV2_Services.layouts.snum;
	shared l_wide		:= DriversV2_Services.layouts.result_wide_tmp;
	shared l_narrow	:= DriversV2_Services.layouts.result_narrow;
	shared l_rolled	:= DriversV2_Services.layouts.result_rolled;
	shared l_moxie	:= DriversV2_Services.layouts.Layout_drivers_license2_1;
	shared l_moxieTmp	:= DriversV2_Services.layouts.moxie_tmp;
	
	shared l_dl					:= DriversV2_Services.layouts.result_wide;
	shared l_conviction	:= DriversV2_Services.layouts.cp.conviction;
	shared l_suspension	:= DriversV2_Services.layouts.cp.suspension;
	shared l_drinfo			:= DriversV2_Services.layouts.cp.drinfo;
	shared l_accident		:= DriversV2_Services.layouts.cp.accident;
	shared l_insurance	:= DriversV2_Services.layouts.cp.insurance;

	shared k_conviction	:= DriversV2_Services.layouts.key_conviction;
	shared k_suspension	:= DriversV2_Services.layouts.key_suspension;
	shared k_drinfo			:= DriversV2_Services.layouts.key_drinfo;
	shared k_accident		:= DriversV2_Services.layouts.key_accident;
	shared k_insurance	:= DriversV2_Services.layouts.key_insurance;
	

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
	
	export boolean histOK(string1 hist) := map(
		DriversV2_Services.input.IncludeHistory=DriversV2.Constants.IncludeHistory.current and hist<>'' => false,
		DriversV2_Services.input.IncludeHistory=DriversV2.Constants.IncludeHistory.history and hist='' => false,
		true);
	
	export boolean ageOK(unsigned8 dob, unsigned8 asOfDate, unsigned1 in_agelow, unsigned1 in_agehigh) := function
		age := ut.age(dob, asOfDate);
		return (age <= in_agehigh AND age >= in_agelow);
	end;
	
	export get_seq_from_ind(string2 in_DLState, unsigned1 in_agelow, unsigned1 in_agehigh, string1 in_race, string1 in_gender) := function
		// get DLs matching the indicatives
		raw := k_ind(
			keyed(race = in_race), 
			keyed(sex_flag = in_gender), 
			keyed(age <= in_agehigh AND age >= in_agelow),
			keyed(orig_state = in_DLState));
		
		// reduce to no more than 10K distinct records
		raw2 := dedup( sort( project(raw, transform(l_snum, self:=left)), record), record);
		ut.MAC_Pick_Random(raw2,snums,10000);
		
		// convert to seqs
		seqs := join(
			snums, k_num,
			keyed(left.dl_number=right.s_dl) and
				left.orig_state=right.orig_state and
				histOK(right.history) and
				ageOK(right.dob, right.lic_issue_date, in_agelow, in_agehigh),
			transform({l_seq; k_num.dl_number; k_num.orig_state; k_num.lic_issue_date;}, self := right),
			limit(max_raw_DLs,skip));
		
		// keep only the most recent seq per dl_number
		seqs_d := project(dedup(sort(seqs, dl_number, orig_state, -lic_issue_date), dl_number, orig_state), l_seq);
		
		// pick some at random, getting more than we think we'll need because of reductions later
		scale := case(
			DriversV2_Services.input.IncludeHistory,
			DriversV2.Constants.IncludeHistory.current => 10,
			DriversV2.Constants.IncludeHistory.history => 10,
			3);
		ut.MAC_Pick_Random(seqs_d,seqs_r,DriversV2_Services.input.maxResults*scale);
		
		// NOTE: after the rest of the processing is done, we'll still need to
		//       randomly pare the results down to input.maxThisTime records
		
		return seqs_r;
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
	
		shared dataset(l_wide) applyFilter(
			dataset(l_wide) wide_recs
		) := function
		
			sort_recs	:= sort(wide_recs,
          -if(lic_issue_date=0,dt_first_seen,lic_issue_date),-if(lic_issue_date =0,dt_last_seen,expiration_date), record, 
          except dl_seq, sex_flag, history, eye_color, hair_color, attention_flag,
					license_type, license_class, restrictions_delimited, lic_endorsement);
		  results		:= dedup(sort_recs,
        lic_issue_date, expiration_date, record,
				except dl_seq, sex_flag, history, eye_color, hair_color, attention_flag,
					license_type, license_class, restrictions_delimited, lic_endorsement
			);
			dmv := results(source_code not in DriversV2.Constants.nonDMVSources);
			non_dmv := results(source_code in DriversV2.Constants.nonDMVSources);
			res := dmv & sort(non_dmv, -dt_last_seen, record); 
		  return res;
		end;		

	  // ...using source to generate report
		export dataset(l_wide) by_src(
			dataset(DriversV2_Services.layouts.src) dl_src
		) := function
		  recs			:= DriversV2_Services.fn_getDL_report(,dl_src);
			wide_recs := applyFilter(project(recs, l_wide));
			return wide_recs;
		end;
		
	  // ...using seq as the lookup mechanism
		export dataset(l_wide) by_seq(
			dataset(l_seq) in_seqs
		) := function
		  recs			:= DriversV2_Services.fn_getDL_report(in_seqs);
			wide_recs := applyFilter(project(recs, l_wide));
			return wide_recs;
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
			DriversV2_Services.GetDLParams.params gdlParams = DriversV2_Services.GetDLParams.getDefault()
		) := function
		  recs				:= DriversV2_Services.fn_getDL_report(in_seqs,,gdlParams);
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

		// Function for perfomance improvement of Batch Services(DriversV2_Services.Batch_Service).
export dataset(l_narrow) by_DL_src(
		dataset(DriversV2_Services.layouts.src) in_dl_src,
    DriversV2_Services.GetDLParams.params gdlParams = DriversV2_Services.GetDLParams.getDefault(),
		BOOLEAN IsBatch = FALSE
    ) := function
	recs        := DriversV2_Services.fn_getDL_report(,in_dl_src,gdlParams,IsBatch);
  narrow_recs := project(recs, l_narrow);
  sort_recs   := sort(narrow_recs, -lic_issue_date, -expiration_date, record);
  results     := dedup(sort_recs,
											except dl_seq, sex_flag, history, eye_color, hair_color, attention_flag,
														 license_type, restrictions_delimited, lic_endorsement);
  return results;
end;
	
	// ------------------------------------------
	// Convert wide DL report to DLCP report format
	// ------------------------------------------
	export dataset(l_rolled) wideToDLCP(
		dataset(l_wide)	in_recs,
		boolean					incAll = false
	) := function
		
		// we shouldn't roll records with a blank DLCP_key
		dl_blank := project(
			in_recs(DLCP_key=''),
			transform(
				l_rolled,
				self.dl := project(left, transform(l_dl, self := LEFT)),
				self := []
			)
		);
		
		// group by DLCP_key
		dl_srt := sort(in_recs(DLCP_key<>''), DLCP_key, -lic_issue_date, -expiration_date, record);
		dl_grp := group(dl_srt, DLCP_key);
		
		//Accident Transform to fix CountyName decode
		DriversV2_Services.layouts.cp.accident accident_xrf(DriversV2_Services.layouts.cp.accident childRow) := transform
			tmp := DriversV2_Services.Functions.getCensusCountyDecode(childRow.jurisdiction,childRow.county);
			self.county_name := if(length(tmp)>0,tmp,'');
			self	:= childRow;
		end;
		DriversV2_Services.layouts.cp.conviction conviction_xrf(DriversV2_Services.layouts.cp.conviction childRow) := transform
			tmp := DriversV2_Services.Functions.getStateSpecificCountyDecode(childRow.court_county);
			self.court_name_desc := if(length(tmp)>0,tmp,childRow.court_name_desc);
			self	:= childRow;
		end;
		DriversV2_Services.layouts.cp.suspension suspension_xrf(DriversV2_Services.layouts.cp.suspension childRow) := transform
			tmp := DriversV2_Services.Functions.getStateSpecificCountyDecode(childRow.court_county);
			self.court_name_desc := if(length(tmp)>0,tmp,childRow.court_name_desc);
			self	:= childRow;
		end;
		
		
		// rollup by DLCP_key and add to output layout
		l_rolled doRollup(l_wide L, dataset(l_wide) allRows) := transform
			self.DLCP_key	:= L.DLCP_key;
			self.dl				:= choosen( dedup( project(allRows, transform(l_dl, self := LEFT)), except dl_seq ), DriversV2_Services.layouts.max_dl );
			self					:= [];
		end;
		dl_rolled := nofold( rollup(dl_grp, group, doRollup(LEFT, rows(LEFT))) );
		
		recs := dl_blank + dl_rolled;
		dmv := recs(dl[1].source_code not in DriversV2.Constants.nonDMVSources);
		non_dmv := recs(dl[1].source_code in DriversV2.Constants.nonDMVSources);
		dl_sorted := sort(dmv, -dl[1].lic_issue_date, -dl[1].expiration_date, record) & 
								 sort(non_dmv, -dl[1].dt_last_seen, record);
		
		
		// and add CP data to the results
		l_rolled addCP(l_rolled L) := transform
			key := L.DLCP_key;
			
			conviction		:= project( limit( k_conviction(	keyed(dlcp_key=key) ), DriversV2_Services.layouts.max_dlcp_raw, skip), l_conviction	);
			suspension		:= project( limit( k_suspension(	keyed(dlcp_key=key) ), DriversV2_Services.layouts.max_dlcp_raw, skip), l_suspension	);
			drinfo				:= project( limit( k_drinfo(			keyed(dlcp_key=key) ), DriversV2_Services.layouts.max_dlcp_raw, skip), l_drinfo			);
			accident			:= project( limit( k_accident(		keyed(dlcp_key=key) ), DriversV2_Services.layouts.max_dlcp_raw, skip), l_accident		);
			insurance			:= project( limit( k_insurance(		keyed(dlcp_key=key) ), DriversV2_Services.layouts.max_dlcp_raw, skip), l_insurance		);

			conviction_d	:= dedup( sort( conviction,	-violation_date,	-conviction_date,			record), record);
			suspension_d	:= dedup( sort( suspension,	-violation_date,	-clear_date,					record), record);
			drinfo_d			:= dedup( sort( drinfo,			-action_date,			-clear_date,					record), record);
			accident_d		:= dedup( sort( accident,		-accident_date,		-create_date,					record), record);
			insurance_d		:= dedup( sort( insurance,	-create_date,			-cancel_posted_date,	record), record);
			
			//Add choosen logic and add decodes for Accidents
			accident_cn 	:= if(incAll or DriversV2_Services.input.incAccidents,			choosen( accident_d,		DriversV2_Services.layouts.max_accidents		) );
			accident_f 		:= Project(accident_cn,accident_xrf(left));
			conviction_cn	:= if(incAll or DriversV2_Services.input.incConvictions,		choosen( conviction_d,	DriversV2_Services.layouts.max_convictions	) );
			conviction_f	:= Project(conviction_cn,conviction_xrf(left));	
			suspension_cn	:= if(incAll or DriversV2_Services.input.incSuspensions,		choosen( suspension_d,	DriversV2_Services.layouts.max_suspensions	) );
			suspension_f	:= Project(suspension_cn,suspension_xrf(left));

			self.Convictions		:= conviction_f;
			self.Suspensions		:= suspension_f;
			self.DR_Info				:= if(incAll or DriversV2_Services.input.incDRInfo,				choosen( drinfo_d,			DriversV2_Services.layouts.max_drinfo			) );
			self.Accidents			:= accident_f;
			self.FRA_Insurance	:= if(incAll or DriversV2_Services.input.incFRAInsurance,	choosen( insurance_d,		DriversV2_Services.layouts.max_insurance		) );
			
			self := L;
		end;
		dl_cp := project(dl_sorted, addCP(left));
		
		return dl_cp;
		
	end;
	
	
		export uber_view := module
		 
		 shared in_mod := AutoStandardI.GlobalModule();
		 export get_words():= FUNCTION
		  format_word(string wrd) := STD.Str.ToUpperCase(wrd);
      boolean nicknames := AutoStandardI.InterfaceTranslator.nicknames.val(project(in_mod,AutoStandardI.InterfaceTranslator.nicknames.params));
		  boolean phonetics := AutoStandardI.InterfaceTranslator.phonetics.val(project(in_mod,AutoStandardI.InterfaceTranslator.phonetics.params));
		  string fname_val := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
		  string fname := if(~nicknames, fname_val,'');
		  string lname_val := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
			string lname := if(~phonetics, lname_val,'');
		  string mname := AutoStandardI.InterfaceTranslator.mname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.mname_value.params));
      string addr_val := AutoStandardI.InterfaceTranslator.addr_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_value.params));
      string prange_val := AutoStandardI.InterfaceTranslator.prange_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_value.params));
			//can't use AutoStandardI.InterfaceTranslator.pname_value since it removes street ordinals (ut.StripOrdinal)
		  string pname_val := in_mod.prim_name;
			string addr := format_word(IF(prange_val ='' AND pname_val='',addr_val,'')); 
			string prange := IF(addr_val ='',prange_val,''); 
			string pname := IF(addr_val ='',pname_val,''); 
		  string city := AutoStandardI.InterfaceTranslator.city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
		  string state := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
		  string zip := (string)AutoStandardI.InterfaceTranslator.zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params))[1];
		  string dob := (string)AutoStandardI.InterfaceTranslator.dob_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.dob_val.params));
      string pfname := if(nicknames,NID.PreferredFirstNew(fname_val),'');
		  string dph_lname := if(phonetics,metaphonelib.DMetaPhone1(lname_val)[1..6],'');
			
			addr_Rec := record
				string30 word; 
			end;
	    addr_ds := dataset([{addr}],addr_rec); // Parameter into dataset to allow normalize

      addr_rec split(addr_ds le,unsigned2 c) := transform
				self.word := ut.Word(le.word,c);
			end;
      norm_addr := normalize(addr_ds,ut.NoWords(left.word),split(left,counter));
			fld_cnst(string fld) := Autokey.UBER_Constants.Uber_FieldData(FieldName=fld)[1].FieldID;
		  WDS := DATASET([{FNAME,FLD_CNST('FNAME')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
		         + DATASET([{PFNAME,FLD_CNST('PFNAME')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
		         + DATASET([{MNAME,FLD_CNST('MNAME')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
		         + DATASET([{LNAME,FLD_CNST('LNAME')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
		         + DATASET([{DPH_LNAME,FLD_CNST('DPH_LNAME')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
		         + DATASET([{PRANGE,FLD_CNST('PRANGE')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
		         + DATASET([{PNAME,FLD_CNST('PNAME')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
		         + DATASET([{CITY,FLD_CNST('CITY')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
		         + DATASET([{STATE,FLD_CNST('STATE')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
		         + DATASET([{ZIP,FLD_CNST('ZIP')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
		         + DATASET([{DOB,FLD_CNST('DOB')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
		         + PROJECT(NORM_ADDR,TRANSFORM(AUTOKEY.LAYOUT_UBER.WORD_PARAMS
						                    ,SELF.FIELD :=FLD_CNST('ADDR'),SELF := LEFT));
		
		RETURN wds(~word in ['','0']);	

		end;
	
	end;

end;