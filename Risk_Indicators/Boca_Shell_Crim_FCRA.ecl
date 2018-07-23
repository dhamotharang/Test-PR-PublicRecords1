import _Control, doxie_files, ut, doxie, fcra, riskwise, Risk_Indicators, STD;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Crim_FCRA (integer bsVersion, unsigned8 BSOptions=0,
	GROUPED DATASET(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus) w_BankLiens) := FUNCTION

  todaysdate := (string) risk_indicators.iid_constants.todaydate;
	insurance_fcra_filter :=  (BSOptions & Risk_Indicators.iid_constants.BSOptions.InsuranceFCRAMode) > 0;	
	
  // Get crim corrections, filtering by fcra-date and deleting those which are not in override
	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus get_crim(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus le, 
			doxie_files.Key_BocaShell_Crim_FCRA ri) := transform
	
		// for riskview attributes v5 requirements, modify version 3,4,5 attributes to calculate the age of crim attributes based upon build dates instead of today's date.
		crim_build_dt := Risk_Indicators.get_Build_date('doc_build_version');
		crim_today_patch := if(bsversion >=3, crim_build_dt, todaysdate);
		
	  criminal_records := ri.criminal_count(FCRA.crim_is_ok(crim_today_patch,(STRING8)date,fcra_conviction_flag,fcra_traffic_flag)  AND (offender_key NOT IN le.crim_correct_ofk) and
				// for shell version 3 or higher, only allow criminal records with offense_score = M or F
			((offense_score in risk_indicators.iid_constants.set_valid_offense_scores and bsversion>=3) or bsversion<3 )
			);

		SELF.BJL.criminal_count := COUNT(criminal_records);
		SELF.BJL.last_criminal_date := if(self.bjl.criminal_count > 0, 
											max(ri.criminal_count(FCRA.crim_is_ok(crim_today_patch,(STRING8)date,fcra_conviction_flag,fcra_traffic_flag) AND 
											(offender_key NOT IN le.crim_correct_ofk) AND offense_score <> 'S'), date), 0);							
		
		felony_records := criminal_records(offense_score='F');							
		felony_count := COUNT(felony_records);
		
		SELF.BJL.felony_count := felony_count;	
		SELF.BJL.last_felony_date := if(felony_count>0, max(felony_records, date), 0);
		// these criminal_counts are now felonies only
		SELF.BJL.criminal_count30 := COUNT(felony_records(Risk_Indicators.iid_constants.checkingDays(crim_today_patch,(STRING8)date,30)) );
		SELF.BJL.criminal_count90 := COUNT(felony_records(Risk_Indicators.iid_constants.checkingDays(crim_today_patch,(STRING8)date,90)) );
		SELF.BJL.criminal_count180 := COUNT(felony_records(Risk_Indicators.iid_constants.checkingDays(crim_today_patch,(STRING8)date,180)) );
		SELF.BJL.criminal_count12 := COUNT(felony_records(Risk_Indicators.iid_constants.checkingDays(crim_today_patch,(STRING8)date,ut.DaysInNYears(1))) );
		SELF.BJL.criminal_count24 := COUNT(felony_records(Risk_Indicators.iid_constants.checkingDays(crim_today_patch,(STRING8)date,ut.DaysInNYears(2))) );
		SELF.BJL.criminal_count36 := COUNT(felony_records(Risk_Indicators.iid_constants.checkingDays(crim_today_patch,(STRING8)date,ut.DaysInNYears(3))) );
		SELF.BJL.criminal_count60 := COUNT(felony_records(Risk_Indicators.iid_constants.checkingDays(crim_today_patch,(STRING8)date,ut.DaysInNYears(5))) );

		nonfelony_records := criminal_records(offense_score not in ['F', 'S', 'I']);
		SELF.BJL.last_nonfelony_criminal_date := if(count(nonfelony_records)>0, max(nonfelony_records, date), 0);
		SELF.BJL.nonfelony_criminal_count12 := COUNT(nonfelony_records(Risk_Indicators.iid_constants.checkingDays(crim_today_patch,(STRING8)date,ut.DaysInNYears(1))) );
		
		self := le;
	end;
	
	w_crim_roxie := JOIN(w_BankLiens, doxie_files.Key_BocaShell_Crim_FCRA,
								keyed(LEFT.did=RIGHT.did),
								get_crim(LEFT,RIGHT), LEFT OUTER, KEEP(1));

	w_crim_thor := JOIN(distribute(w_BankLiens, hash64(did)), 
								distribute(pull(doxie_files.Key_BocaShell_Crim_FCRA), hash64(did)),
								(LEFT.did=RIGHT.did),
								get_crim(LEFT,RIGHT), LEFT OUTER, KEEP(1), LOCAL);
								
	#IF(onThor)
		w_crim := group(sort(distribute(w_crim_thor, hash64(seq)), seq, LOCAL), seq, LOCAL);
	#ELSE
		w_crim := w_crim_roxie;
	#END
  
	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus correct_crim (Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus le) :=	TRANSFORM
		SELF.BJL.criminal_count := le.BJL.criminal_count + COUNT (le.crim_corrections);
		SELF := le;
	END;
	w_crim_correct := PROJECT (w_crim, correct_crim (LEFT));

	RETURN w_crim_correct;
END;