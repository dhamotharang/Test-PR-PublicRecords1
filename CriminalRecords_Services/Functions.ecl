import iesp, codes, AutoStandardI, corrections, fcra, doxie_files, FFD, STD, CriminalRecords_Services;

MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;

todays_date := (string) STD.Date.Today();

export Functions := module

	// ------------------------
	//	Parameters
	// ------------------------
	export params := interface(AutoStandardI.LIBIN.PenaltyI_Indv.base)
		export string25	city;
		export string2	st;
	end;
	
	// ------------------------
	//	Generate search output
	// ------------------------
	export fnCrimSearchVal(dataset(CriminalRecords_Services.layouts.l_raw) in_recs, params in_mod) := function
	
		CriminalRecords_Services.layouts.t_CrimSearchRecordWithPenalty toSearch(CriminalRecords_Services.layouts.l_raw L) := transform
			self._Penalty			:= L.penalt;
			self.AlsoFound		:= L.isDeepdive;
			self.datasource		:= L.datasource;
			self.offenderid		:= L.offender_key;
			
			self.name				:= iesp.ECL2ESP.SetName(L.fname, L.mname, L.lname, L.name_suffix,'');
			
			self.address			:= iesp.ECL2ESP.SetAddress(L.prim_name, L.prim_range, L.predir, L.postdir,
															 L.addr_suffix, L.unit_desig, L.sec_range, L.v_city_name,
															 L.st, L.zip5, L.zip4, L.county_name);
			
			self.ssn				:= if(L.ssn<>'',L.ssn,L.ssn_appended);
			self.DOB				:= iesp.ECL2ESP.toDatestring8( if(L.pty_typ='2',L.dob_alias,L.dob) );
			self.stateofOrigin		:= L.orig_state;
			self.stateofBirth		:= L.place_of_birth;
			self.uniqueid			:= L.did;
			self.countyofOrigin		:= L.county_of_origin;
			self.caseNumber		:= L.case_num;
			self.docNumber			:= L.doc_num;
			self.CaseFilingDate		:= iesp.ECL2ESP.toDatestring8(L.case_date);
			self.DateLastSeen := iesp.ECL2ESP.toDatestring8(L.process_date);
			self.isDisputed := L.isDisputed;
			self.StatementIDs := L.StatementIDs;
		end;
		temp_formatted := project(in_recs, toSearch(left));
		
		formatted := dedup(sort(temp_formatted,record), record);
		return(formatted);         
	end;
	
	
	// ------------------------
	//	Generate report output
	// ------------------------
	export fnCrimReportVal(dataset(CriminalRecords_Services.layouts.l_raw) in_recs, 
												 params in_mod, 
												 boolean IsFCRA = false,
												 dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
												 dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
												 integer8 inFFDOptionsMask = 0) := function

		boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
		boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);

		// gather the raw materials for child datasets
    unique_offenders := dedup (in_recs, offender_key, all); // need to take only unique ids

    // --------------------------------------------------------------------
    // -------------------------- OFFENSE RECORDS -------------------------
    // --------------------------------------------------------------------
		offenses_ofk  := SET (flagfile (file_id=FCRA.FILE_ID.OFFENSES), record_id);
		offenses_ffid := SET (flagfile (file_id=FCRA.FILE_ID.OFFENSES), flag_file_id);
    offense_rec := corrections.layout_offense_common and not offense_category;
    offense_ds_rec := record(offense_rec OR FFD.Layouts.CommonRawRecordElements)end;
											
		offenses_key := doxie_files.key_offenses(isFCRA);
		// FCRA: remove records subject to correction; apply date restrictions; apply overrides
		offense_data := join(
			unique_offenders, offenses_key,
			keyed(left.offender_key=right.ok) and
			(~isFCRA or 
			((string)Right.offense_persistent_id NOT IN offenses_ofk) and
      FCRA.crim_is_ok (todays_date, Right.fcra_date, Right.fcra_conviction_flag, Right.fcra_traffic_flag)),
			transform(offense_rec, self:=right), // Evn though I have FFD offenders information in left, I decided not to take them. 
			keep(iesp.Constants.CRIM.MaxOffenses),limit(0)
		);

    // overrides (FCRA side only)
    offense_override := CHOOSEN (fcra.key_override_crim.offenses (keyed (flag_file_id IN offenses_ffid), 
                           (FCRA.crim_is_ok (todays_date, fcra_date, fcra_conviction_flag, fcra_traffic_flag))), MAX_OVERRIDE_LIMIT);

    off_over_st := project (offense_override, offense_rec);

    offense_fcra := offense_data + off_over_st;//project (off_over_st, GetStandardOffense (Left));
		
// ------------------------------------------------FCRA FFD ----------------------------------		
		offense_ds_rec xformDSOffense( offense_rec l, 
														 FFD.Layouts.PersonContextBatchSlim r ) := transform,
		skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
			self.StatementIDs := r.StatementIds;  
			self.IsDisputed   := r.IsDisputed;
			self := l;
		end;
		
		offense_data_fcra := join(offense_fcra, slim_pc_recs(DataGroup = FFD.Constants.DATAGROUPS.OFFENSES),
															left.offense_persistent_id = (unsigned) right.RecId1,
															xformDSOffense(left,right), 
															left outer, 
															keep(1),limit(0));
// -------------------------------------------------------------------------------------------													
													
    offense_raw := if (IsFCRA, offense_data_fcra, project(offense_data,offense_ds_rec));

    // --------------------------------------------------------------------
    // ---------------------- COURT OFFENSE RECORDS -----------------------
    // --------------------------------------------------------------------
		court_offenses_ofk  := SET (flagfile (file_id=FCRA.FILE_ID.COURT_OFFENSES), record_id);
		court_offenses_ffid := SET (flagfile (file_id=FCRA.FILE_ID.COURT_OFFENSES), flag_file_id);
		court_offenses_key := doxie_files.Key_Court_Offenses(isFCRA);
		
    court_rec := record
			Corrections.layout_CourtOffenses -[offense_category];
		end;
		court_ds_rec := record(court_rec)
			FFD.Layouts.CommonRawRecordElements;
		end;
		
    court_data := join(
      unique_offenders, court_offenses_key,
      keyed(left.offender_key=right.ofk) and
			(~isFCRA or 
			// TODO: this may be redundant in case if input is already FCRA-compliant.
      (string)right.offense_persistent_id NOT IN court_offenses_ofk),
      transform(court_rec,self:=right),
      keep(iesp.Constants.CRIM.MaxCourtOffenses),limit(0)
    );
		
    // overrides (FCRA side only)
    court_override := CHOOSEN (fcra.key_override_crim.court_offenses (keyed (flag_file_id IN court_offenses_ffid)), MAX_OVERRIDE_LIMIT);
    // combine main data and overrides; apply FCRA-filtering
    // available dates are: (process_date, off_date, arr_date, arr_disp_date, court_disp_date, appeal_date)
    court_fcra_ready := court_data + project (court_override, court_rec) (
      FCRA.crim_is_ok (todays_date, fcra_date, fcra_conviction_flag, fcra_traffic_flag));
			
// ------------------------------------------------FCRA FFD ----------------------------------
		court_ds_rec xformDSCourtOffense( court_rec l, 
																			FFD.Layouts.PersonContextBatchSlim r ) := transform,
		skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
			self.StatementIDs := r.StatementIds;
			self.IsDisputed   := r.IsDisputed; 
			self := l;
		end;
		
		court_data_fcra := join(court_fcra_ready, slim_pc_recs(DataGroup = FFD.Constants.DATAGROUPS.COURT_OFFENSES),
													left.offense_persistent_id = (unsigned)right.RecId1,
													xformDSCourtOffense(left,right), 
													left outer, 
													keep(1),limit(0));
													
// ---------------------------------------------------------------------------------------------														
    courtOffense_raw := if (IsFCRA, court_data_fcra, project(court_data, court_ds_rec));


    // --------------------------------------------------------------------
    // ------------------------ PUNISHMENT RECORDS ------------------------
    // --------------------------------------------------------------------
		punishment_ofk  := SET (flagfile (file_id=FCRA.FILE_ID.PUNISHMENT), record_id);
		punishment_ffid := SET (flagfile (file_id=FCRA.FILE_ID.PUNISHMENT), flag_file_id);
    punishment_rec := corrections.Layout_CrimPunishment;
		punishment_ds_rec := record(punishment_rec OR FFD.Layouts.CommonRawRecordElements)end;
		
		punishment_key := doxie_files.key_punishment(isFCRA);
		punishment_data := join(
			unique_offenders, punishment_key, //corrections.Layout_CrimPunishment
			keyed(left.offender_key=right.ok) and keyed(right.pt in ['I','P']) and
			(~isFCRA or
			// TODO: this may be redundant in case if input is already FCRA-compliant.
      ((string)Right.punishment_persistent_id NOT IN punishment_ofk)),
			// TODO: find out if fcra date restrictions should be applied to either of these:
         // date_first_reported, date_last_reported, parole dates, conviction override date
      // FCRA.crim_is_ok (todays_date, Right.fcra_date, Right.fcra_conviction_flag, Right.fcra_traffic_flag),
			transform(punishment_rec,self:=right),
			keep(iesp.Constants.CRIM.MaxPrisons + iesp.Constants.CRIM.MaxParoles),limit(0)
		);

    // overrides (FCRA side only)
		// TODO: check if fcra date restrictions are to be applied for overrides
    punishment_override := CHOOSEN (fcra.key_override_crim.punishment (keyed (flag_file_id IN punishment_ffid)), MAX_OVERRIDE_LIMIT);
    pun_over_st := project (punishment_override, punishment_rec);

    punishment_fcra :=  punishment_data + pun_over_st;
// ------------------------------------------------FCRA FFD ----------------------------------
		punishment_ds_rec xformDSPunishment( punishment_rec l, 
																			FFD.Layouts.PersonContextBatchSlim r ) := transform,
		skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
			self.StatementIDs := r.StatementIds; 
			self.IsDisputed   := r.IsDisputed; 
			self := l;
		end;
		
		punishment_data_fcra := join(punishment_fcra, slim_pc_recs(DataGroup = FFD.Constants.DATAGROUPS.PUNISHMENT),
													left.punishment_persistent_id = (unsigned) right.RecId1,
													xformDSPunishment(left,right), 
													left outer, 
													keep(1),limit(0));
													
// ---------------------------------------------------------------------------------------------		
    punishment_raw := if (IsFCRA, punishment_data_fcra, project(punishment_data,punishment_ds_rec));

    // --------------------------------------------------------------------
    // ------------------------- ACTIVITY RECORDS -------------------------
    // --------------------------------------------------------------------
		activity_ofk  := SET (flagfile (file_id=FCRA.FILE_ID.ACTIVITY), record_id);
		activity_ffid := SET (flagfile (file_id=FCRA.FILE_ID.ACTIVITY), flag_file_id);
    activity_rec := corrections.layout_activity;
		activity_ds_rec := record(activity_rec OR FFD.Layouts.CommonRawRecordElements)end;
		activity_data := join(
			unique_offenders, doxie_files.key_activity (IsFCRA),
			keyed(left.offender_key = right.ok) and
			// TODO: this may be redundant in case if input is already FCRA-compliant.
      (~IsFCRA or ((string)right.activity_persistent_id NOT IN activity_ofk)),
			transform(activity_rec,self:=right),
			keep(iesp.Constants.CRIM.MaxEvents),limit(0)
		);

    // overrides (FCRA side only)
    activity_override := CHOOSEN (fcra.key_override_crim.activity (keyed (flag_file_id IN activity_ffid)), MAX_OVERRIDE_LIMIT);
    // combine main data and overrides; apply FCRA-filtering
    activity_fcra := (activity_data + project (activity_override, activity_rec))
                       (FCRA.crim_is_ok (todays_date, event_date, 'Y', 'N'));
											 
		// ------------------------------------------------FCRA FFD ----------------------------------
		activity_ds_rec xformDSActivity( activity_rec l, 
																			FFD.Layouts.PersonContextBatchSlim r ) := transform,
		skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
			self.StatementIDs := r.StatementIds; 
			self.IsDisputed   := r.IsDisputed; 
			self := l;
		end;
		
		activity_data_fcra := join(activity_fcra, slim_pc_recs(DataGroup = FFD.Constants.DATAGROUPS.ACTIVITY),
															left.activity_persistent_id = (unsigned) right.RecId1,
															xformDSActivity(left,right), 
															left outer, 
															keep(1),limit(0));
													
// ---------------------------------------------------------------------------------------------										 
    activity_raw := if (IsFCRA, activity_data_fcra, project(activity_data,activity_ds_rec));

		// Census_Data.MAC_County2Fips_Keyed(in_recs, st, county_name, county,, in_recs_w_county);
		
		grp_in_tmp := group(sort(in_recs,offender_key,(unsigned)pty_typ,record),offender_key);
		
		CriminalRecords_Services.layouts.l_raw name_selection(CriminalRecords_Services.layouts.l_raw L) := transform
			//*****************************************************************************
			// Calculating the penalty in the report to overcome the issue with records
			// having same offenderID, same pty_typ and different name. The record that 
			// matches to the input name should be the primary name and the remainig records
			// should be displayed in AKAs.
			//*******************************************************************************

			tempindvmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
				export allow_wildcard := false;
				export city_field := '';
				export did_field := '';
				export fname_field := l.fname;
				export lname_field := l.lname;
				export mname_field := l.mname;
				export phone_field := '';
				export pname_field := '';
				export postdir_field := '';
				export prange_field := '';
				export predir_field := '';
				export ssn_field := '';  
				export state_field := '';
				export suffix_field := '';
				export zip_field := '';
				export city2_field := '';
				export county_field := '';
				export dob_field := '';
				export dod_field := '';
			end;

			tempPenaltName := if(isFCRA, 0, AutoStandardI.LIBCALL_PenaltyI_Indv.val_indv_name(tempindvmod));

			self.penalt := tempPenaltName;
			self.pty_typ := if((unsigned)l.pty_typ<>0,l.pty_typ,if(tempPenaltName=0,'0','2'));
			
			self:=L;
		end;
		
		grp_in_tmp_srt := sort(project(grp_in_tmp,name_selection(LEFT)),penalt,(unsigned)pty_typ,lname,fname,mname,name_suffix,record);// 52891 fix could be - infront of lname, fname,mname

		grp_in := if(count(grp_in_tmp((unsigned)pty_typ=0))>1,
					grp_in_tmp_srt,
					grp_in_tmp);
		
	
		// generate CrimReportOffense records from the Offense key
		iesp.criminal.t_CrimReportArrest toOffense_Arrest(offense_ds_rec L) := transform
			self.agency						:= '';
			self.casenumber				:= '';
			self.date							:= iesp.ECL2ESP.toDatestring8(L.arr_date);
			self.disposition			:= L.arr_disp_desc_1 + L.arr_disp_desc_2 + L.arr_disp_desc_3;
			self.DispositionDate	:= iesp.ECL2ESP.toDatestring8(L.arr_disp_date);
			self.level						:= L.off_lev; // STUB - decode?
			self.offense					:= L.off_desc_1 + L.off_desc_2;
			self.statute					:= '';
			self._Type						:= L.off_typ; // STUB - decode?
		end;
		
		iesp.criminal.t_CrimReportCourt toOffense_Court(offense_ds_rec L) := transform
			self.casenumber				:= '';
			self.Costs						:= '';
			self.Description			:= L.court_desc;
			self.Disposition			:= L.ct_disp_desc_1 + L.ct_disp_desc_2;
			self.DispositionDate	:= iesp.ECL2ESP.toDatestring8(L.ct_disp_dt);
			self.Fine							:= '';
			self.Level						:= L.ct_off_lev; // STUB - decode?
			self.Offense					:= L.ct_off_desc_1 + L.ct_off_desc_2;
			self.Plea							:= L.ct_fnl_plea;
			self.Statute					:= '';
			self.SuspendedFine		:= '';
		end;
		
		iesp.criminal_fcra.t_FcraCrimReportOffense toOffense(offense_ds_rec L, string case_type) := transform
			self.AdjudicationWithheld			:= L.adj_wthd;
			self.CaseNumber								:= L.case_num;
			self.CaseType									:= case_type;//''; // STUB
			self.CaseTypeDescription			:= ''; // STUB
			self.Count										:=  ''; // STUB
			self.County										:= L.county_of_origin;
			self.Description							:= ''; // STUB
			self.MaximumTerm							:= L.max_term_desc;
			self.MinimumTerm							:= L.min_term_desc;
			self.NumberCounts							:= L.num_of_counts;
			self.OffenseDate							:= iesp.ECL2ESP.toDatestring8(L.off_date);
			self.OffenseType							:= L.off_typ;
			self.Sentence									:= stringLib.stringcleanspaces(l.stc_desc_1 + ' ' + l.stc_desc_2 + ' ' + l.stc_desc_3 + ' ' + l.stc_desc_4);//'';
			self.SentenceLengthDescription:= L.stc_lgth_desc;
			// self.SentenceDescription1     := L.stc_desc_1;
			self.SentenceDate							:= iesp.ECL2ESP.toDatestring8(L.stc_dt);
			self.IncarcerationDate				:= iesp.ECL2ESP.toDatestring8(L.inc_adm_dt);
			self.Appeal										:= [];
			self.Arrest										:= row(toOffense_Arrest(L));
			self.Court										:= row(toOffense_Court(L));
			self.CourtSentence						:= [];
			self.isDisputed 							:= L.isDisputed;
			self.StatementIds							:= L.StatementIds;
		end;
		
		// generate CrimReportOffense records from the Court Offense key
		iesp.criminal.t_CrimReportAppeal toCourtOff_Appeal(court_ds_rec L) := transform
			self.Disposition			:= L.appeal_off_disp;
			self.FinalDisposition	:= L.appeal_final_decision;
			self.date							:= iesp.ECL2ESP.toDatestring8(L.appeal_date);
		end;
		
		iesp.criminal.t_CrimReportArrest toCourtOff_Arrest(court_ds_rec L) := transform
			self.agency						:= L.le_agency_desc;
			self.casenumber				:= L.le_agency_case_number;
			self.date							:= iesp.ECL2ESP.toDatestring8(L.arr_date);
			self.disposition			:= if(L.arr_disp_desc_1<>'', L.arr_disp_desc_1 + L.arr_disp_desc_2, L.arr_disp_desc_2);
			self.DispositionDate	:= iesp.ECL2ESP.toDatestring8(L.arr_disp_date);
			self.level						:= L.arr_off_lev_mapped;
			self.offense					:= L.arr_off_desc_1 + L.arr_off_desc_2;
			self.statute					:= if(L.arr_statute_desc<>'', L.arr_statute_desc, L.arr_statute);
			self._type						:= L.arr_off_type_desc;
		end;
		
		iesp.criminal.t_CrimReportCourt toCourtOff_Court(court_ds_rec L) := transform
			self.casenumber				:= L.court_case_number;
			self.Costs						:= L.sent_court_cost;
			self.Description			:= L.court_desc;
			self.Disposition			:= if(L.court_disp_desc_1<>'', L.court_disp_desc_1 + L.court_disp_desc_2, L.court_disp_desc_2);
			self.DispositionDate	:= iesp.ECL2ESP.toDatestring8(L.court_disp_date);
			self.Fine							:= L.sent_court_fine;
			self.Level						:= L.court_off_lev_mapped;
			self.Offense					:= L.court_off_desc_1 + L.court_off_desc_2;
			self.Plea							:= L.court_final_plea;
			self.Statute  			  := if(L.court_statute_desc<>'', L.court_statute_desc, L.court_statute);
			self.SuspendedFine		:= L.sent_susp_court_fine;
		end;
		
		iesp.criminal.t_CrimReportCourtSentence toCourtOff_Sentence(court_ds_rec L) := transform
			self.jail							:= L.sent_jail;
			self.probation				:= L.sent_probation;
			self.suspended				:= L.sent_susp_time;
		end;
		
		iesp.criminal_fcra.t_FcraCrimReportOffense toCourtOffense(court_ds_rec L) := transform
			self.AdjudicationWithheld			:= '';
			self.CaseNumber								:= '';
			self.CaseType									:= ''; // STUB
			self.CaseTypeDescription			:= ''; // STUB
			self.Count										:= L.off_comp;//''; // STUB
			self.County										:= '';
			self.Description							:= ''; // STUB
			self.MaximumTerm							:= '';
			self.MinimumTerm							:= '';
			self.NumberCounts							:= L.num_of_counts;
			self.OffenseDate							:= iesp.ECL2ESP.toDatestring8(L.off_date);
			self.OffenseType							:= '';
			self.Sentence									:= '';
			self.SentenceLengthDescription:= ''; // STUB
			// self.SentenceDescription1     := '';
			self.SentenceDate							:= iesp.ECL2ESP.toDatestring8(L.sent_date);
			self.IncarcerationDate				:= iesp.ECL2ESP.toDatestring8('');
			self.Appeal										:= row(toCourtOff_Appeal(L));
			self.Arrest										:= row(toCourtOff_Arrest(L));
			self.Court										:= row(toCourtOff_Court(L));
			self.CourtSentence						:= row(toCourtOff_Sentence(L));
			self.isDisputed 							:= L.isDisputed;
			self.StatementIds							:= L.StatementIds;
		end;
		
		iesp.criminal_fcra.t_FcraCrimReportPrison toPrison(punishment_ds_rec L) := transform
			self.AdmittedDate						:= iesp.ECL2ESP.toDatestring8(L.latest_adm_dt);
			self.CurrentStatus					:= L.cur_stat_inm_desc;
			self.CustodyType						:= L.cur_loc_sec; // STUB
			self.CustodyTypeChangeDate	:= iesp.ECL2ESP.toDatestring8(''); // STUB
			self.GainTimeGranted				:= L.gain_time;
			self.LastGainTime						:= iesp.ECL2ESP.toDatestring8(L.gain_time_eff_dt);
			self.Location								:= L.cur_loc_inm; // STUB
			self.ScheduledReleaseDate		:= iesp.ECL2ESP.toDatestring8(L.sch_rel_dt);
			self.Sentence								:= L.sent_length_desc;
			self.isDisputed 						:= L.isDisputed;
			self.StatementIds						:= L.StatementIds;
		end;

		iesp.criminal_fcra.t_FcraCrimReportParole toParole(punishment_ds_rec L) := transform
			self.ActualEndDate		:= iesp.ECL2ESP.toDatestring8(L.par_act_end_dt);
			self.County						:= L.par_cty;
			self.CurrentStatus		:= L.par_cur_stat_desc;
			self.Length						:= L.sent_length_desc;
			self.ScheduledEndDate	:= iesp.ECL2ESP.toDatestring8(L.par_sch_end_dt);
			self.StartDate				:= iesp.ECL2ESP.toDatestring8(L.par_st_dt);
			self.isDisputed 			:= L.isDisputed;
			self.StatementIds			:= L.StatementIds;
		end;
		
		iesp.criminal_fcra.t_FcraCrimReportEvent toActivity(activity_ds_rec L) := transform
			self.Date							:= iesp.ECL2ESP.toDatestring8(L.event_date);
			self.Description			:= trim(L.event_desc_1) + if(trim(L.event_desc_2)='', '', ' '+L.event_desc_2);
			self.isDisputed 			:= L.isDisputed;
			self.StatementIds			:= L.StatementIds;
		end;
		
		iesp.criminal.t_CrimReportParoleOffense toParoleOffense (offense_ds_rec L):=transform
			self.SentenceDate 		:=[];
			self.Length						:= (unsigned) L.stc_lgth;
			self.OffenseCounty 		:=l.cty_conv;
			self.CauseNo 					:= l.case_num;
			self.NCICCode 				:= l.off_code;
			self.OffenseCount 		:= (unsigned) l.num_of_counts;
			self.OffenseDate 			:= iesp.ECL2ESP.toDatestring8(L.off_date);
		end;
		
		iesp.criminal_fcra.t_FcraCrimReportParoleEx toParoleEx(CriminalRecords_Services.layouts.l_raw L, dataset(punishment_ds_rec) P, dataset(offense_ds_rec) O) := transform

			parole_row:=p[1];
			self.ActualEndDate							:= iesp.ECL2ESP.toDatestring8(parole_row.par_act_end_dt);
			self.County											:= parole_row.par_cty;
			self.CurrentStatus							:= parole_row.par_cur_stat_desc;
			self.Length											:= parole_row.sent_length_desc;
			self.ScheduledEndDate						:= iesp.ECL2ESP.toDatestring8(parole_row.par_sch_end_dt);
			self.StartDate									:= iesp.ECL2ESP.toDatestring8(parole_row.par_st_dt);
			
			self.DateReported 							:= iesp.ECL2ESP.toDatestring8(L.file_date) ;
			self.PubicSaftyId 							:= L.dle_num ;
			self.InmateId 									:= L.doc_num ;
			self.ParoleInAbsentiaId 				:= L.id_num ; 
			self.Name												:= iesp.ECL2ESP.SetName(L.fname, L.mname, L.lname, L.name_suffix,'');
			self.Race 											:= L.race ; // shoud it be l.race_desc[1] or L.race  ??????
			self.Gender 										:= L.sex ;
			self.DOB 												:= iesp.ECL2ESP.toDatestring8(L.dob) ;
			self.CountyOfBirth 							:= L.county_of_birth ;
			self.StateOfBirth 							:= L.place_of_birth ;
			self.HeightFeet 								:= ((unsigned) L.height) DIV 12 ;
			self.HeightInches 							:= ((unsigned) L.height)%12;
			self.WeightInPounds 						:= (unsigned)  L.weight ;
			self.HairColor 									:= L.hair_color ;
			self.SkinColor 									:= L.skin_color ;
			self.EyeColor 									:= L.eye_color ;

			self.CurrentStatusFlag 					:= parole_row.parole_active_flag;//parole_row.par_cur_stat_desc ;
			self.CurrentStatusEffectiveDate := iesp.ECL2ESP.toDatestring8(parole_row.par_status_dt) ;
			self.ParoleRegion 							:= parole_row.office_region ;
			self.SupervisingOffice 					:= parole_row.supv_office ; 
			self.SupervisingOfficerName 		:= parole_row.supv_officer ;
			self.SupervisingOfficerPhone 		:= parole_row.office_phone ;
			self.LastKnownResidence					:= iesp.ECL2ESP.SetAddress(L.prim_name, L.prim_range, L.predir, L.postdir,
																						 L.addr_suffix, L.unit_desig, L.sec_range,
																						 L.v_city_name, L.st, L.zip5, L.zip4, L.county_name);
			self.ReleaseArrivalDate 				:= iesp.ECL2ESP.toDatestring8(parole_row.act_rel_dt) ; 
			self.ReleaseType 								:= parole_row.release_type ;
			self.ReleaseCounty 							:= parole_row.par_cty ;
			self.LegalResidenceCounty 			:= L.legal_residence_county ;
			self.OffenseCount 							:= (unsigned) o[1].total_num_of_offenses ;
			self.Is3GOffender 							:= if(L._3G_offender<>'',true,false);
			self.IsViolentOffender 					:= if(L.violent_offender<>'',true,false) ;
			self.IsSexOffender 							:= if(L.sex_offender<>'',true,false) ;
			self.IsOnViolentOffenderProgram := if(L.vop_offender<>'',true,false) ;
			TimeToServe_val:=sort(o,-stc_lgth);
			dur:=intformat((unsigned) TimeToServe_val[1].stc_lgth,6,1);
			self.LongestTimeToServe 				:= ROW({dur[1..2],dur[3..4],dur[5..6]} ,iesp.share.t_Duration);
			self.LongestTimeToServeDescription := TimeToServe_val[1].stc_lgth_desc;
			self.DischargeDate 							:= iesp.ECL2ESP.toDatestring8(parole_row.sch_rel_dt) ; // or L.act_rel_dt?
			self.ScarsMarksTattoos 					:= dataset([{L.scars_marks_tattoos_1},
																									{L.scars_marks_tattoos_2},
																									{L.scars_marks_tattoos_3},
																									{L.scars_marks_tattoos_4},
																									{L.scars_marks_tattoos_5}] ,iesp.share.t_StringArrayItem)(value<>'');
			// self.Offenses 									:= choosen(dedup(normalize(o,count(o)/*4*/,toParoleOffense(LEFT,COUNTER)),all),iesp.Constants.crim.MaxOffenses) ;
			self.Offenses 									:= choosen(dedup(sort(project(o(vendor='TX'),toParoleOffense(LEFT)), -SentenceDate, -OffenseDate, record), record),iesp.Constants.crim.MaxParOffenses) ;
			self.LastParoleReviewDate := iesp.ECL2ESP.toDatestring8(parole_row.casepull_date) ;
			self.PrisonFacilityType := parole_row.tdcjid_unit_type ;
			self.PrisonFacilityName := parole_row.tdcjid_unit_assigned ;
			self.AdmittedDate := iesp.ECL2ESP.toDatestring8(parole_row.tdcjid_admit_date) ;
			self.PrisonStatus := parole_row.prison_status ;
			self.LastReceiveOrDepartCode := parole_row.recv_dept_code ;
			self.LastReceiveOrDepartCDate := iesp.ECL2ESP.toDatestring8(parole_row.recv_dept_date) ;
			record_setup_date:=INTFORMAT((unsigned) l.record_setup_date,14,1);
			self.RecordCreatedTimeStamp := ROW({record_setup_date[1..4],
																					record_setup_date[5..6],
																					record_setup_date[7..8],
																					record_setup_date[9..10],
																					record_setup_date[11..12],
																					record_setup_date[13..14]},
																					iesp.share.t_TimeStamp) ;
			
			//***************************************************************************************
			//data not available. Will be implemented in Phase 2
			// self.CurrentStatusFlag 					:= parole_row.parole_active_flag;
			// self.LastParoleReviewDate := iesp.ECL2ESP.toDatestring8(L.casepull_date) ; //LastParoleReviewDate')};
			// self.PrisonFacilityType := L.tdcjid_unit_type ; //PrisonFacilityType')};
			// self.PrisonFacilityName := L.tdcjid_unit_assigned ; //PrisonFacilityName')};
			// self.AdmittedDate := iesp.ECL2ESP.toDatestring8(L.tdcjid_admit_date) ; //AdmittedDate')};
			// self.PrisonStatus := L.prison_status ; //PrisonStatus')};
			// self.LastReceiveOrDepartCode := L.recv_dept_code ; //LastReceiveOrDepartCode')};
			// self.LastReceiveOrDepartCDate := iesp.ECL2ESP.toDatestring8(L.recv_dept_date) ; //LastReceiveOrDepartCDate')};
			// self.RecordCreatedTimeStamp := [];//ROW({iesp.ECL2ESP.toDatestring8(L.record_setup_date)},L.record_setup_date) ; //RecordCreatedTimeStamp')};
			//***************************************************************************************
			self.isDisputed 						:= L.isDisputed;
			self.StatementIds						:= L.StatementIds;
		end;
		
	  layout_tmp:=record
			iesp.criminal_fcra.t_FcraCrimReportRecord;
			string2 vendor;
    end;
	  layout_tmp toReport(CriminalRecords_Services.layouts.l_raw L, dataset(CriminalRecords_Services.layouts.l_raw) R) := transform

			self.datasource				:= L.datasource;
			self.offenderid				:= L.offender_key;
			
			self.name							:= iesp.ECL2ESP.SetName(L.fname, L.mname, L.lname, L.name_suffix,'');
			
			self.address					:= iesp.ECL2ESP.SetAddress(L.prim_name, L.prim_range, L.predir, L.postdir,
														   L.addr_suffix, L.unit_desig, L.sec_range,
														   L.v_city_name, L.st, L.zip5, L.zip4, L.county_name);
			
			self.ssn							:= if(L.ssn<>'',L.ssn,L.ssn_appended);
			self.DOB							:= iesp.ECL2ESP.toDatestring8( if(L.pty_typ='2',L.dob_alias,L.dob) );
			
			self.stateofOrigin		:= L.orig_state;
			self.stateofBirth			:= L.place_of_birth;
			self.uniqueid					:= L.did;
			self.countyofOrigin		:= L.county_of_origin;
			self.caseNumber				:= L.case_num;
			self.docNumber				:= L.doc_num;

			self.CaseFilingDate		:= iesp.ECL2ESP.toDatestring8(L.case_date);
			self.eyes							:= L.eye_color_desc;
			self.hair							:= L.hair_color_desc;
			self.height						:= L.height;
			self.weight						:= L.weight;
			self.race							:= L.race_desc;
			self.sex							:= Codes.General.GENDER(L.sex);
			self.skin							:= L.skin_color_desc;
			self.status						:= L.party_status_desc;
			self.CaseTypeDescription := L.case_type_desc;
			self.IsImageAvailable	:= if(L.image_link = '', false, true);

			akas_fmt							:= project(R[2..],transform(iesp.share.t_name, self:=iesp.ECL2ESP.SetName(left.fname, left.mname, left.lname, left.name_suffix,'')));
			akas_sort							:= dedup(sort(akas_fmt,last,first,middle,record),record);
			self.akas							:= choosen(akas_sort, iesp.Constants.CRIM.MaxAKAs);
	
			// NOTE: A given row will actually only have only offenses or court offenses, not both, but we
			//       don't know in advance which key to check and they wind up in a common format anyway.
			courtOffense_filt 		:= courtOffense_raw(offender_key=L.offender_key);
			coff									:= project(courtOffense_filt,toCourtOffense(left));
			courtOffense_fmt			:= dedup(sort(coff,coff.count, -OffenseDate, -SentenceDate, record),record);
			
			offense_filt 					:= offense_raw(offender_key=L.offender_key);
			offense_fmt						:= dedup(project(offense_filt,toOffense(left,l.case_type_desc)),record,all);
			ofds 									:= courtOffense_fmt&offense_fmt;
			self.offenses					:= choosen(ofds, iesp.Constants.CRIM.MaxOffenses);
			
			prison_filt						:= punishment_raw(offender_key=L.offender_key, punishment_type='I');
			prison_fmt						:= project(prison_filt,toPrison(left));
			prison_sort						:= dedup(sort(prison_fmt, -AdmittedDate, -ScheduledReleaseDate, record), record);
			self.prisonSentences	:= choosen(prison_sort, iesp.Constants.CRIM.MaxPrisons);
			
			activity_filt					:= activity_raw(offender_key=L.offender_key);
			activity_fmt					:= project(activity_filt,toActivity(left));
			activity_sort					:= dedup(sort(activity_fmt, -Date, Description, record), record);
			self.activities				:= choosen(activity_sort, iesp.Constants.CRIM.MaxEvents);

			parole_filt						:= punishment_raw(offender_key=L.offender_key, punishment_type='P');
			parole_fmt						:= project(parole_filt,toParole(left));
			parole_sort						:= dedup(sort(parole_fmt, -ActualEndDate, -ScheduledEndDate, -StartDate, record), record);
			self.paroleSentences	:= choosen(parole_sort, iesp.Constants.CRIM.MaxParoles);
			
			Parole_fmt_Ex_Tx := project(dataset (l),toParoleEx(left,parole_filt,offense_filt));
			Parole_fmt_Ex := project (choosen(parole_sort, iesp.Constants.CRIM.MaxParoles), transform (iesp.criminal_fcra.t_FcraCrimReportParoleEx, self := left, self:=[]));

			self.vendor:=l.vendor;
			self.ParoleSentencesEx := if (~IsFCRA, if (l.vendor='TX', Parole_fmt_Ex_Tx,Parole_fmt_Ex));
			self.isDisputed 			 := L.isDisputed;
			self.StatementIds			 := L.StatementIds;
		end;
		
		temp_formatted	:= rollup(grp_in, group, toReport(left,rows(left)));
		temp_sorted			:= sort(temp_formatted, -CaseFilingDate, offenderid);
		
		iesp.criminal_fcra.t_FcraCrimReportRecord final_xform(layout_tmp l):=transform
			nada:=dataset([],iesp.criminal_fcra.t_FcraCrimReportParoleEx);
			self.ParoleSentencesEx:=if(l.vendor='TX',l.ParoleSentencesEx,nada);
			self:=l;
		end;
		
		final_sorted:=project(temp_sorted,final_xform(LEFT));
		// output(grp_in, named('grp_in'));									// DEBUG
		// output(get_parole_ex_data(), named('get_parole_ex_data'));	// DEBUG
		// output(temp_formatted, named('temp_formatted'));	// DEBUG
		// output(in_mod);
		//output(courtOffense_raw,named('courtOffense_raw'));
		//output(activity_raw,named('activity_raw'));
		//output(punishment_raw,named('punishment_raw'));
		//output(offense_raw,named('offense_raw'));
		//output(final_sorted,named('final_sorted'));
		return final_sorted;
	end;
	
end;