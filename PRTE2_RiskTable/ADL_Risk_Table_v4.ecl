IMPORT fcra, header, prte2_gong, ut, doxie_build, header_quick, ADVO, mdr,risk_indicators,PRTE2_Header, prte2;

todays_date := (string) risk_indicators.iid_constants.todaydate;

EXPORT ADL_Risk_Table_v4(BOOLEAN isFCRA) := FUNCTION

	hf1 := if(isFCRA,PRTE2_Header.files.File_FCRA_header_building,PRTE2_Header.files.file_header_building)(did!=0 AND ~risk_indicators.iid_constants.filtered_source(src, st));
	headerprod_building := UNGROUP(hf1);

	hf := PROJECT(headerprod_building(dt_last_seen<>0),TRANSFORM(Header.Layout_Header, SELF := LEFT));

	base_hf_uncorrected := IF(	isFCRA, 
							hf(~fcra.Restricted_Header_Src(src, vendor_id[1]) AND
								((src='BA' AND FCRA.bankrupt_is_ok(todays_date,(string)dt_first_seen)) OR
								(src='L2' AND FCRA.lien_is_ok(todays_date,(string)dt_first_seen)) OR src NOT IN ['BA','L2'])),
							hf);
	equifax_base := base_hf_uncorrected(src NOT IN [mdr.sourceTools.src_Experian_Credit_Header, mdr.sourceTools.src_TU_CreditHeader]);
	experian_base := base_hf_uncorrected(src NOT IN [mdr.sourceTools.src_Equifax, mdr.sourceTools.src_TU_CreditHeader]);
	transunion_base := base_hf_uncorrected(src NOT IN [mdr.sourceTools.src_Equifax, mdr.sourceTools.src_Experian_Credit_Header]);
	all_bureaus := Risk_Indicators.adl_risk_table(base_hf_uncorrected);
	equifax_recs := Risk_Indicators.adl_risk_table(equifax_base);
	experian_recs := Risk_Indicators.adl_risk_table(experian_base);
	transunion_recs := Risk_Indicators.adl_risk_table(transunion_base);

	common_adl_risk := RECORD
		RECORDOF(all_bureaus) - did;  
	END;

	layout_adl_risk_v4 := RECORD
		UNSIGNED did;
		STRING15 adl_category := '';
		BOOLEAN college_address_in_history := FALSE;
		UNSIGNED1 phone_ct;
		UNSIGNED1 phone_ct_c6;
		common_adl_risk combo;  // combination of both bureaus, no bureau data restricted
		common_adl_risk eq;  		// equifax table
		common_adl_risk en;			// experian table
		common_adl_risk tn;			// transunion table
		PRTE2.Layouts.DEFLT_CPA;
	END;

	j := JOIN(all_bureaus, 
			equifax_recs, 
			LEFT.did=RIGHT.did, 
			TRANSFORM(layout_adl_risk_v4,
				SELF.did := LEFT.did,
				SELF.combo := LEFT,
				SELF.eq := RIGHT,
				SELF := []), 
			LEFT OUTER);

	j2 := JOIN(j, experian_recs, LEFT.did=RIGHT.did,
					TRANSFORM(layout_adl_risk_v4,
										SELF.en := RIGHT,
										SELF := LEFT), LEFT OUTER);

	j3 := JOIN(j2, transunion_recs, LEFT.did=RIGHT.did,
					TRANSFORM(layout_adl_risk_v4,
										SELF.tn := RIGHT,
										SELF := LEFT), LEFT OUTER);

	// now append the phones per DID 
	sysdate := todays_date[1..6] + '01';
	gh1 := prte2_gong.files.File_History_Full_Prepped_for_Keys(did<>0 AND (current_RECORD_flag='Y' OR ut.DaysApart(sysdate, deletion_date[1..6]+'31') < 365) );
	
	phone_slim := RECORD
		gh1.did;
		phone := gh1.phone10;
		dt_first_seen := MIN(GROUP,IF((UNSIGNED)gh1.dt_first_seen=0,999999,(UNSIGNED)gh1.dt_first_seen));
		dt_last_seen := MAX(GROUP,(UNSIGNED)gh1.dt_last_seen);
	END;
	d_phone := TABLE(gh1((INTEGER)phone10<>0), phone_slim, did, phone10);

	phone_stats := RECORD
		did := d_phone.did;
		phone_ct := COUNT(GROUP);
		phone_ct_c6 := COUNT(GROUP, ut.DaysApart(sysdate, ((string)d_phone.dt_first_seen)[1..6]+'31') < 183);
	END;
	phone_counts := TABLE(d_phone, phone_stats, did);

															 
	// append the phone counts
	with_phone_counts := JOIN(j3, phone_counts, LEFT.did=RIGHT.did, 
					TRANSFORM(layout_adl_risk_v4, 
						SELF.phone_ct := RIGHT.phone_ct,
						SELF.phone_ct_c6 := RIGHT.phone_ct_c6;
						SELF := LEFT), 
					LEFT OUTER);
				
	advo_college_base := Dataset([], advo.Layouts.Layout_Common_Out);//advo.Files().Base.built(active_flag = 'Y' AND college_indicator='Y');

	crec_temp := RECORD
		UNSIGNED did;
		BOOLEAN college_address_in_history;
	END;

	// Must be exact match on all parts -- including sec range being blank.
	with_advo_college_raw  := JOIN(	base_hf_uncorrected, 
								advo_college_base, 
								(LEFT.zip = RIGHT.zip) AND
								(LEFT.prim_range = RIGHT.prim_range) AND
								(LEFT.prim_name = RIGHT.prim_name) AND
								(LEFT.suffix = RIGHT.addr_suffix) AND
								(LEFT.predir = RIGHT.predir) AND
								(LEFT.postdir = RIGHT.postdir) AND
								(LEFT.sec_range = RIGHT.sec_range),
								TRANSFORM(crec_temp,
										SELF.college_address_in_history := RIGHT.college_indicator='Y',
										SELF := LEFT), 
								LEFT OUTER, LOOKUP);

	advo_college_flag := DEDUP(SORT(with_advo_college_raw,did, -college_address_in_history ),did);

	layout_adl_risk_v4 addCollegeFlag(layout_adl_risk_v4 le, advo_college_flag ri) := TRANSFORM
		SELF.college_address_in_history := ri.college_address_in_history;
		SELF := le;
	END;

	with_college_history_flag := JOIN(	with_phone_counts,	
								advo_college_flag,
								LEFT.did=RIGHT.did,
								addCollegeFlag(LEFT,RIGHT), 
								LEFT OUTER, KEEP(1));

	ADL_Category := ADL_Segmentation(PRTE2_Header.files.file_headers, isFCRA).core_check;		

	layout_adl_risk_v4 addCategory(layout_adl_risk_v4 le, adl_category ri) := TRANSFORM
		SELF.adl_category := ri.ind;
		SELF := le;
	END;

	full_adl_risk_wCat := JOIN(	with_college_history_flag, 
							adl_category(did<>0), 
							LEFT.did=RIGHT.did, 
							addCategory(left,right), 
							LEFT OUTER, KEEP(1)) ;									
		
	RETURN full_adl_risk_wCat;

END;
