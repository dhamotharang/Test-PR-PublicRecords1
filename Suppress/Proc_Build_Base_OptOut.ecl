IMPORT PromoteSupers, InsuranceHeader_Incremental;
EXPORT Proc_Build_Base_OptOut(STRING pVersion) := FUNCTION

		// the complete list of opted out California residents is exported daily.
		$.Layout_OptOut_Base tInputC(Suppress.Layout_OptOut_In L) := TRANSFORM
			SELF.src						:= 'C';			//record from consumer center
			SELF.date_added					:= L.DATE_OF_REQUEST;																		
			SELF							:= L;
			SELF							:= [];
		END;
		input_raw 				:= Suppress.Files.OptOut.Input_Raw(ENTRY_TYPE NOT IN ['','ROWCOUNT']);
		input_0					:= PROJECT(input_raw, tInputC(LEFT));
		
		// Minor file from header build
		$.Layout_OptOut_Base tInputM(InsuranceHeader_Incremental.Layout_Minors L) := TRANSFORM
			SELF.src						:= 'M';			//record from minor file
			SELF.date_added					:= L.Date;
			SELF.domain_id					:= $.Constants.Exemptions().Domain_Id_PR;
			SELF.state_act					:= L.state;																		
			SELF							:= L;
			SELF							:= [];
		END;
		minor_file 				:= InsuranceHeader_Incremental.Files.Minors_Current_DS; 
		minor_0					:= PROJECT(minor_file, tInputM(LEFT));

		// Create opt out records for Public Records, Health Care, and Insurance
		opt_out_pr_recs			:= PROJECT(input_0 + minor_0, 
		                                   TRANSFORM($.Layout_OptOut_Base,SELF.domain_id:=$.Constants.Exemptions().Domain_Id_PR,SELF:=LEFT));
		opt_out_ins_recs		:= PROJECT(input_0 + minor_0, 
		                                   TRANSFORM($.Layout_OptOut_Base,SELF.domain_id:=$.Constants.Exemptions().Domain_Id_INS,SELF:=LEFT));
		opt_out_hc_recs			:= PROJECT(input_0(prof_data='Y') + minor_0(prof_data='Y'), 
		                                   TRANSFORM($.Layout_OptOut_Base,SELF.domain_id:=$.Constants.Exemptions().Domain_Id_HC,SELF:=LEFT));
		opt_out_recs			:= opt_out_pr_recs + opt_out_ins_recs + opt_out_hc_recs;

		//process optout entry
		$.Layout_OptOut_Base tInputRaw(Suppress.Layout_OptOut_Base L) := TRANSFORM
			SELF.dt_first_seen				:= (UNSIGNED4) pVersion;
			SELF.dt_last_seen				:= (UNSIGNED4) pVersion;
			SELF.dt_vendor_first_reported	:= (UNSIGNED4) pVersion;
			SELF.dt_vendor_last_reported	:= (UNSIGNED4) pVersion;
			SELF.process_date				:= (UNSIGNED4) thorlib.WUID()[2..9];
			SELF.history_flag				:= '';									// current
			SELF.act_id						:= CASE(TRIM(L.STATE_ACT),
			                                    	'CA'=> 'CACCPA',
			                                    	'');
			SELF							:= L;
		END;
		dNewInput				:= PROJECT(opt_out_recs,tInputRaw(LEFT));

		// create records for health care
		dCurrBase 				:= Suppress.Files.OptOut.Basefile;
		
		// Use SALT generated Ingest function to create new base file
		// These fields together uniquely identify a record - lexid, state_act 
		dNewBase_0				:= $.Ingest_OptOut(FALSE,,dCurrBase,dNewInput).AllRecords;
		doStats					:= $.Ingest_OptOut(FALSE,,dCurrBase,dNewInput).DoStats;
		vStats					:= $.Ingest_OptOut(FALSE,,dCurrBase,dNewInput).ValidityStats;
		stdStats 				:= OUTPUT($.Ingest_OptOut(FALSE,,dCurrBase,dNewInput).StandardStats(), ALL, NAMED('StandardStats_OptOut'));

		//Get Global SID set from active records in Global_Sid base file
		//For phase I, combine PR and INS global sids
		global_sid_pr_pd		:= Suppress.Files.Global_Sid.Basefile(history_flag='' and domain_id=$.Constants.Exemptions().Domain_Id_PR and prof_data_only='Y')[1].global_sids;
		global_sid_pr_npd		:= Suppress.Files.Global_Sid.Basefile(history_flag='' and domain_id=$.Constants.Exemptions().Domain_Id_PR and prof_data_only='N')[1].global_sids;
		global_sid_ins			:= Suppress.Files.Global_Sid.Basefile(history_flag='' and domain_id=$.Constants.Exemptions().Domain_Id_INS)[1].global_sids;
		global_sid_hc			:= Suppress.Files.Global_Sid.Basefile(history_flag='' and domain_id=$.Constants.Exemptions().Domain_Id_HC)[1].global_sids;

		$.Layout_OptOut_Base  tPostProcess(dNewBase_0 L) := TRANSFORM
			SELF.history_flag			:= IF(L.__Tpe=$.Ingest_OptOut().RecordType.Old,'H','');
			SELF.exemptions				:= 0x00000040;
			// The CD Tool OPT OUT file will include a professional flag  (formerly the HC Professional flag)
			// The OPT OUT base file build will include professional sources in the list for the lexid 
			// when the CD Tool indicates professional data is opted out.  If the CD Tool indicates 
			// professional data is not opted out, sources defined as professional are excluded from 
			// the opt out source list. This rule applies to PR only.
			SELF.global_sids			:= CASE(L.domain_id,
												$.Constants.Exemptions().Domain_Id_HC	=> global_sid_hc,
			                                    $.Constants.Exemptions().Domain_Id_INS	=> global_sid_ins,
												$.Constants.Exemptions().Domain_Id_PR	=> 
			                                      IF(L.prof_data='Y', global_sid_pr_pd, global_sid_pr_npd),
												[]
											 );
			// SELF.global_sids			:= suppress.fExtractGlobalSids('PR');
			SELF						:= L;
		END;
		
		dNewBase				:= PROJECT(dNewBase_0, tpostProcess(LEFT));
		
		PromoteSupers.Mac_SF_BuildProcess(dNewBase,Filenames().OptOut.base,build_base,,,true);
		
		RETURN SEQUENTIAL(
								// OUTPUT(input_raw,named('input_raw'));
								// output(dNewInput,named('dNewInput'));
								// output(dNewBase_0,named('dNewBase_0'));
								build_base,
								doStats,
								vStats,
								stdStats);
		
END;
