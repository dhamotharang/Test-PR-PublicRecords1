import _Control, ut, fcra, riskwise, SexOffender, SexOffender_Services, Risk_Indicators;
onThor := _Control.Environment.OnThor;
 
export Boca_Shell_SO_FCRAHist (integer bsVersion, unsigned8 BSOptions=0,
	GROUPED DATASET(Risk_Indicators.Layouts_Derog_Info.layout_extended) w_BankLiensCrim) := FUNCTION

	insurance_fcra_filter := (BSOptions & iid_constants.BSOptions.InsuranceFCRAMode) > 0;
	//Adding Sex Offenders
	fcra_sex_offender_did_key := SexOffender.Key_SexOffender_DID(true);
	fcra_sex_offender_spk_key := SexOffender.Key_SexOffender_SPK(true);

	//get the SO ids
	spk_ids_roxie := join(w_BankLiensCrim, fcra_sex_offender_did_key, 
		keyed(left.did = right.did), atmost(SexOffender_Services.Constants.MAX_RECS_PERDID));

	spk_ids_thor := join(distribute(w_BankLiensCrim, hash64(did)), 
		distribute(pull(fcra_sex_offender_did_key), hash64(did)), 
		(left.did = right.did), atmost(SexOffender_Services.Constants.MAX_RECS_PERDID), LOCAL);
		
	#IF(onThor)
		spk_ids := group(sort(distribute(spk_ids_thor, hash64(seq)), seq, LOCAL), seq, LOCAL);
	#ELSE
		spk_ids := spk_ids_roxie;
	#END
  
	Risk_Indicators.Layouts_Derog_Info.layout_extended add_doc_FCRA_SO(spk_ids le, fcra_sex_offender_spk_key ri) := TRANSFORM
		// only need 1 of the offense records for that offender key to be "dismissed" to throw this record out
		// dismissed := false; //there are no ct_disp_desc fields for SO (was blank for SO records in prior combined FCRA key)
		self.sor_number := ri.sor_number;
		criminal_count := (INTEGER)((unsigned6)ri.did<>0);//and not dismissed;
		SELF.BJL.criminal_count := criminal_count;
		SELF := le;
	END;

	doc_added_soff_roxie := JOIN (spk_ids, fcra_sex_offender_spk_key, 
										 keyed(LEFT.seisint_primary_key=RIGHT.sspk) AND
										(unsigned3)(RIGHT.fcra_date[1..6]) < left.historydate AND
										FCRA.crim_is_ok(iid_constants.myGetDate(left.historydate),RIGHT.fcra_date,RIGHT.fcra_conviction_flag,RIGHT.fcra_traffic_flag),
										add_doc_FCRA_SO(LEFT,RIGHT),
										KEEP(10), ATMOST(keyed(LEFT.seisint_primary_key=RIGHT.sspk), 
										riskwise.max_atmost));
	
	doc_added_soff_thor := JOIN (distribute(spk_ids, hash64(seisint_primary_key)), 
										distribute(pull(fcra_sex_offender_spk_key), hash64(sspk)), 
										LEFT.seisint_primary_key=RIGHT.sspk AND
										(unsigned3)(RIGHT.fcra_date[1..6]) < left.historydate AND
										FCRA.crim_is_ok(iid_constants.myGetDate(left.historydate),RIGHT.fcra_date,RIGHT.fcra_conviction_flag,RIGHT.fcra_traffic_flag),
										add_doc_FCRA_SO(LEFT,RIGHT),
										KEEP(10), ATMOST(LEFT.seisint_primary_key=RIGHT.sspk, 
										riskwise.max_atmost), LOCAL);

	#IF(onThor)
		doc_added_soff := group(sort(distribute(doc_added_soff_thor, hash64(seq)), seq, LOCAL), seq, LOCAL);
	#ELSE
		doc_added_soff := doc_added_soff_roxie;
	#END
  
	Risk_Indicators.Layouts_Derog_Info.layout_extended roll_doc(Risk_Indicators.Layouts_Derog_Info.layout_extended le, Risk_Indicators.Layouts_Derog_Info.layout_extended ri) :=
	TRANSFORM
		sameCrim := le.crim_case_num=ri.crim_case_num;

		SELF.BJL.criminal_count := le.BJL.criminal_count+IF(sameCrim,0,ri.BJL.criminal_count);
		SELF.BJL.last_criminal_date := max(le.bjl.last_criminal_date,ri.bjl.last_criminal_date);
		
		// these criminal_counts are now felonies only
		SELF.BJL.criminal_count30 := le.BJL.criminal_count30+IF(sameCrim,0,ri.BJL.criminal_count30);
		SELF.BJL.criminal_count90 := le.BJL.criminal_count90+IF(sameCrim,0,ri.BJL.criminal_count90);
		SELF.BJL.criminal_count180 := le.BJL.criminal_count180+IF(sameCrim,0,ri.BJL.criminal_count180);
		SELF.BJL.criminal_count12 := le.BJL.criminal_count12+IF(sameCrim,0,ri.BJL.criminal_count12);
		SELF.BJL.criminal_count24 := le.BJL.criminal_count24+IF(sameCrim,0,ri.BJL.criminal_count24);
		SELF.BJL.criminal_count36 := le.BJL.criminal_count36+IF(sameCrim,0,ri.BJL.criminal_count36);
		SELF.BJL.criminal_count60 := le.BJL.criminal_count60+IF(sameCrim,0,ri.BJL.criminal_count60);
		
		SELF.BJL.last_felony_date := max(le.bjl.last_felony_date,ri.bjl.last_felony_date);
		SELF.BJL.felony_count := le.BJL.felony_count+IF(sameCrim,0,ri.BJL.felony_count);
		
		SELF.BJL.nonfelony_criminal_count12 := le.BJL.nonfelony_criminal_count12+IF(sameCrim,0,ri.BJL.nonfelony_criminal_count12);
		SELF.BJL.last_nonfelony_criminal_date := max(le.bjl.last_nonfelony_criminal_date,ri.bjl.last_nonfelony_criminal_date);

		SELF.BJL.criminal_count12_6mos  := if(le.archive_date_6mo = '99999999', 0, le.BJL.criminal_count12_6mos+IF(sameCrim,0,ri.BJL.criminal_count12_6mos));
		SELF.BJL.criminal_count12_12mos := if(le.archive_date_12mo = '99999999', 0, le.BJL.criminal_count12_12mos+IF(sameCrim,0,ri.BJL.criminal_count12_12mos));
		SELF.BJL.criminal_count12_24mos := if(le.archive_date_24mo = '99999999', 0, le.BJL.criminal_count12_24mos+IF(sameCrim,0,ri.BJL.criminal_count12_24mos));	
		// if the right rec is an offset hit, the only fields populated are the 6/12/24 mo counts so keep everything from the left except case num
		SELF.crim_case_num	:= ri.crim_case_num;
		SELF := if(ri.BJL.criminal_count12_6mos > 0 or ri.BJL.criminal_count12_12mos > 0 or ri.BJL.criminal_count12_24mos > 0, le, ri);
	END;

	doc_rolled := ROLLUP(SORT(w_BankLiensCrim,did,crim_case_num, -bjl.felony_count,
										-bjl.last_felony_date, -bjl.criminal_count, -bjl.last_criminal_date),
											LEFT.did=RIGHT.did, 
											roll_doc(LEFT,RIGHT));

	sex_offenders_rolled := rollup(sort(doc_added_soff, seq, did, sor_number), 
			left.seq=right.seq,
			transform(Risk_Indicators.Layouts_Derog_Info.layout_extended, 
				self.bjl.criminal_count := left.bjl.criminal_count + if(left.sor_number<>right.sor_number, 1, 0);
				self := right));

	with_sex_offenders := join(doc_rolled, sex_offenders_rolled, left.seq=right.seq,
		transform(Risk_Indicators.Layouts_Derog_Info.layout_extended,
			self.BJL.criminal_count :=  if(insurance_fcra_filter, left.BJL.criminal_count,//can't return a SO count for insurance
				left.BJL.criminal_count + right.BJL.criminal_count);
			self := left), left outer, keep(1));

	SO_final := PROJECT(with_sex_offenders, 
		TRANSFORM(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus, 
			SELF := LEFT;
			SELF := []));

	// output(w_BankLiensCrim, named('SO_w_BankLiensCrim'));
	// output(spk_ids, named('SO_spk_ids'));
	// output(doc_added_soff, named('SO_doc_added_soff'));
	// output(doc_sorted, named('SO_doc_sorted'));
	// output(doc_rolled, named('SO_doc_rolled'));
	// output(sex_offenders_rolled, named('SO_sex_offenders_rolled'));
	// output(with_sex_offenders, named('SO_with_sex_offenders'));
	// output(SO_final, named('SO_final'));

		
	RETURN GROUP(SO_final, seq);
END;