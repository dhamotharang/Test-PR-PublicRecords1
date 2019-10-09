IMPORT PromoteSupers;
EXPORT Proc_Build_Base_OptOut(STRING pVersion) := FUNCTION

		// the complete list of opted out California residents is exported daily.
		input_raw := Files.OptOut.Input_Raw(ENTRY_TYPE<>'');

		//process optout entry
		Suppress.Layout_OptOut_Base tInputRaw(Suppress.Layout_OptOut_In L) := TRANSFORM
			SELF.dt_first_seen									:= (UNSIGNED4) pVersion;
			SELF.dt_last_seen										:= (UNSIGNED4) pVersion;
			SELF.dt_vendor_first_reported	:= (UNSIGNED4) pVersion;
			SELF.dt_vendor_last_reported		:= (UNSIGNED4) pVersion;
			SELF.process_date										:= (UNSIGNED4) thorlib.WUID()[2..9];
			SELF.history_flag										:= '';																//current
			SELF.act_id														:= CASE(TRIM(L.STATE_ACT),
			                                    'CA'=> 'CACCPA',
			                                    '');
			SELF.date_added											:= L.DATE_OF_REQUEST;																		
			SELF																			:= L;
			SELF																			:= [];
		END;
		
		dNewInput					:= PROJECT(input_raw,tInputRaw(LEFT));
		
		dCurrBase 				:= Suppress.Files.OptOut.Basefile;
		
		// Use SALT generated Ingest function to create new base file
		// These fields together uniquely identify a record - lexid, state_act 
		dNewBase_0				:= Ingest(FALSE,,dCurrBase,dNewInput).AllRecords;
		doStats							:= Ingest(FALSE,,dCurrBase,dNewInput).DoStats;
		vStats							:= Ingest(FALSE,,dCurrBase,dNewInput).ValidityStats;
		stdStats 					:= OUTPUT(Ingest(FALSE,,dCurrBase,dNewInput).StandardStats(), ALL, NAMED('StandardStats'));

		Suppress.Layout_OptOut_Base  tPostProcess(dNewBase_0 L) := TRANSFORM
			SELF.history_flag			:= IF(L.__Tpe=Ingest().RecordType.Old,'H','');
			SELF.exemptions				:= 0x80000040;
			SELF.global_sids			:= Suppress.Constants.OptOut.CACCPA_Global_Sid	;
			SELF												:= L;
		END;
		
		dNewBase					:= PROJECT(dNewBase_0, tpostProcess(LEFT));
		
		PromoteSupers.Mac_SF_BuildProcess(dNewBase,Filenames().OptOut.base,build_base,,,true);
		
		RETURN SEQUENTIAL(
								OUTPUT(input_raw,named('input_raw'));
								output(dNewInput,named('dNewInput'));
								output(dNewBase_0,named('dNewBase_0'));
								build_base,
								doStats,
								vStats,
								stdStats);
		
END;
