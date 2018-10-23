import _Control, doxie_files, FCRA, ut, riskwise, Risk_Indicators, SexOffender, STD;
onThor := _Control.Environment.OnThor;

EXPORT Boca_Shell_SO_FCRA(integer bsVersion, unsigned8 BSOptions=0, 
		GROUPED DATASET(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus) w_BankLiesCrim) := function

	todaysdate := (string) risk_indicators.iid_constants.todaydate;
	insurance_fcra_filter := (BSOptions & iid_constants.BSOptions.InsuranceFCRAMode) > 0;

	// sex offender records aren't in the doxie_files.Key_BocaShell_Crim_FCRA key, need to add them here
	fcra_sex_offender_did_key := SexOffender.Key_SexOffender_DID(true);
	fcra_sex_offender_spk_key := SexOffender.Key_SexOffender_SPK(true);

	//get the SO ids
	spk_ids_roxie := join(w_BankLiesCrim, fcra_sex_offender_did_key, left.did<>0 and keyed(left.did = right.did), atmost(100));

	spk_ids_thor := join(distribute(w_BankLiesCrim(did <> 0), hash64(did)), 
											 distribute(pull(fcra_sex_offender_did_key), hash64(did)),
											 (left.did = right.did), atmost(100), LOCAL);

	#IF(onThor)
		spk_ids := group(sort(distribute(spk_ids_thor, hash64(seq)), seq, LOCAL), seq, LOCAL);
	#ELSE
		spk_ids := spk_ids_roxie;
	#END
  
	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus add_doc_FCRA_SO(spk_ids le, fcra_sex_offender_spk_key ri) := TRANSFORM
		criminal_count := (INTEGER)((unsigned6)ri.did<>0);
		// sex offender dates are refreshed every build, so don't trust the dates and only increment the overall criminal counts for SO records
		SELF.BJL.criminal_count := criminal_count;	
		self.sor_number := ri.sor_number;
		SELF := le;
		self := [];
	END;

	sex_offenders_roxie := JOIN (spk_ids, fcra_sex_offender_spk_key, 
										 keyed(LEFT.seisint_primary_key=RIGHT.sspk) AND
										 (right.sor_number NOT IN left.crim_correct_ofk) and
				 FCRA.crim_is_ok(Risk_Indicators.iid_constants.myGetDate(left.historydate),RIGHT.fcra_date,RIGHT.fcra_conviction_flag,RIGHT.fcra_traffic_flag),
										 add_doc_FCRA_SO(LEFT,RIGHT),
				 KEEP(10), ATMOST(keyed(LEFT.seisint_primary_key=RIGHT.sspk), riskwise.max_atmost));			 

	sex_offenders_thor := JOIN (distribute(spk_ids, hash64(seisint_primary_key)), 
										 distribute(pull(fcra_sex_offender_spk_key), hash64(sspk)), 
										 (LEFT.seisint_primary_key=RIGHT.sspk) AND
										 (right.sor_number NOT IN left.crim_correct_ofk) and
				 FCRA.crim_is_ok(Risk_Indicators.iid_constants.myGetDate(left.historydate),RIGHT.fcra_date,RIGHT.fcra_conviction_flag,RIGHT.fcra_traffic_flag),
										 add_doc_FCRA_SO(LEFT,RIGHT),
				 KEEP(10), ATMOST(LEFT.seisint_primary_key=RIGHT.sspk, riskwise.max_atmost), LOCAL);			 

	#IF(onThor)
		sex_offenders := group(sort(sex_offenders_thor, seq), seq);
	#ELSE
		sex_offenders := sex_offenders_roxie;
	#END
  
	sex_offenders_rolled := rollup(sort(sex_offenders, did, sor_number), left.seq=right.seq,
			transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus, 
				self.bjl.criminal_count := left.bjl.criminal_count + if(left.sor_number<>right.sor_number, 1, 0);
				self := right));

	with_sex_offenders := join(w_BankLiesCrim, sex_offenders_rolled, left.seq=right.seq,
		transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus,
			self.BJL.criminal_count := if(insurance_fcra_filter, left.BJL.criminal_count, //can't return a SO count for insurance
				left.BJL.criminal_count + right.BJL.criminal_count);
			self := left), left outer, keep(1));

	// output(sex_offenders, named('sex_offenders'));
	// output(sex_offenders_rolled, named('sex_offenders_rolled'));
	// output(with_sex_offenders, named('with_sex_offenders'));
	RETURN GROUP(with_sex_offenders, seq);

END;