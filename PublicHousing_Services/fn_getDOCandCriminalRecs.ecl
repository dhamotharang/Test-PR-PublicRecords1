
IMPORT BatchDatasets, CriminalRecords_BatchService, Doxie, NID;

EXPORT fn_getDOCandCriminalRecs(DATASET(Layouts.batch_in) ds_batch_in, IParams.BatchParams in_mod) := 
	FUNCTION
		
		#STORED('MaxResults',50);
		
		// Per codes.File_Codes_V3_In(file_name = 'CRIM_OFFENDER2' AND field_name = 'DATA_TYPE')...:
		STRING15 DEPT_OF_CORRECTIONS := '1';  
		STRING15 CRIMINAL_COURT      := '2';  
		STRING15 ARREST_LOG          := '5'; 
		
		ds_acctno_refs := PROJECT( ds_batch_in, doxie.layout_references_acctno );
		
		// Fetch records from the Criminal Batch service for both DOC and Criminal Felony records.
		CriminalRecords_BatchService.Layouts.batch_out
				ds_criminal_recs_raw := BatchDatasets.fetch_Criminal_recs(ds_acctno_refs);

		// Join back to the batch_in to compare SSN, name and DOB data to remove false positives.
		// The YOB comparison addresses Jr./Sr. "mismatch" where "Jr" is incarcerated and is using
		// "Sr"'s SSN with the same Name, but because the YOB’s 1970 vs. 1939 we would consider this 
		//a miss. But if YOB is missing on DOC but populated on Input (or visa versa), then we should 
		// drop the YOB comparison and only perform the SSN and Name comparison
		ds_criminal_recs_filt := 
			join(
				ds_criminal_recs_raw, ds_batch_in, 
				left.acctno = right.acctno and
				left.ssn = right.ssn and
				StringLib.StringToUpperCase(left.lname) = StringLib.StringToUpperCase(right.name_last) and
				(
					StringLib.StringToUpperCase(left.fname[1]) = right.name_first[1] or
					left.fname = NID.PreferredFirstNew(right.name_first)
				) and
				(
					(left.dob[1..4] = right.dob[1..4] and left.dob != '') or 
					left.dob = '' or right.dob = ''
				),
				transform( CriminalRecords_BatchService.Layouts.batch_out, 
					self := left
				), 
				limit(0), keep(100)
			);	
			
		// ---------------[ Evaluate Dept. of Corrections records. ]---------------
		
		// 1. Of the Criminal Batch service records retrieved, retain only Dept. of 
		// Corrections (DOC) records.	
		ds_DOC_recs_raw := ds_criminal_recs_filt(data_type = DEPT_OF_CORRECTIONS);

		// 2. Perform sorting. We want the most recent date among all 6 records. Flag 
		// values function as tie-breakers. Cribbed from BatchServices.TaxRefundIS
		// _BatchService_Functions.getCriminalRecords( ) and adapted.
		unsigned2 flag_value(string1 probationFlag, string1 paroleFlag, string1 incarFlag) := 
			function
				flag_val := 
					map(
						probationFlag = 'Y' => 1,
						paroleFlag = 'Y'    => 2,
						incarFlag = 'Y'     => 3,
						probationFlag = 'U' => 4,
						paroleFlag = 'U'    => 5,
						incarFlag = 'U'     => 6,
						probationFlag = 'N' => 7,
						paroleFlag = 'N'    => 8,
						incarFlag = 'N'     => 9,
						/* default ...... */   10
					);
				return flag_val;
			end;
			
		CriminalRecordsSort := record
			CriminalRecords_BatchService.Layouts.batch_out;
			unsigned2 uFlag; 
			unsigned4 uDate1;
			unsigned4 uDate2;
			unsigned4 uDate3;
			unsigned4 uDate4;
			unsigned4 uDate5;
			unsigned4 uDate6;
			unsigned4 uDate7;
			unsigned4 uDate8;
			unsigned4 uDate9;
		end;
		
		max_dt( STRING dt_1, STRING dt_2, STRING dt_3, STRING dt_4, STRING dt_5, STRING dt_6 ) := 
			FUNCTION
				u := UNSIGNED4;
				RETURN MAX( (u)dt_1, (u)dt_2, (u)dt_3, (u)dt_4, (u)dt_5, (u)dt_6 );
			END;
		
		CriminalRecordsSort fillSortFields(CriminalRecords_BatchService.Layouts.batch_out L) := 
			transform
				self.uFlag  := flag_value(L.curr_probation_flag, L.curr_parole_flag, L.curr_incar_flag); 
				self.uDate1 := 
						max(
							max_dt( L.in_event_dt_1, L.in_event_dt_2, L.in_event_dt_3, L.in_event_dt_4, L.in_event_dt_5, L.in_event_dt_6),
							max_dt(L.par_event_dt_1,L.par_event_dt_2,L.par_event_dt_3,L.par_event_dt_4,L.par_event_dt_5,L.par_event_dt_6)
						);
				self.uDate2 := max_dt(L.par_st_dt_1,L.par_st_dt_2,L.par_st_dt_3,L.par_st_dt_4,L.par_st_dt_5,L.par_st_dt_6);
				self.uDate3 := max_dt(L.par_act_end_dt_1,L.par_act_end_dt_2,L.par_act_end_dt_3,L.par_act_end_dt_4,L.par_act_end_dt_5,L.par_act_end_dt_6);
				self.uDate4 := max_dt(L.par_sch_end_dt_1,L.par_sch_end_dt_2,L.par_sch_end_dt_3,L.par_sch_end_dt_4,L.par_sch_end_dt_5,L.par_sch_end_dt_6);
				self.uDate5 := max_dt(L.act_rel_dt_1,L.act_rel_dt_2,L.act_rel_dt_3,L.act_rel_dt_4,L.act_rel_dt_5,L.act_rel_dt_6);			
				self.uDate6 := max_dt(L.ctl_rel_dt_1,L.ctl_rel_dt_2,L.ctl_rel_dt_3,L.ctl_rel_dt_4,L.ctl_rel_dt_5,L.ctl_rel_dt_6);  
				self.uDate7 := max_dt(L.sch_rel_dt_1,L.sch_rel_dt_2,L.sch_rel_dt_3,L.sch_rel_dt_4,L.sch_rel_dt_5,L.sch_rel_dt_6);
				self.uDate8 := max_dt(L.latest_adm_dt_1,L.latest_adm_dt_2,L.latest_adm_dt_3,L.latest_adm_dt_4,L.latest_adm_dt_5,L.latest_adm_dt_6);
				self.uDate9 := max_dt(L.inc_adm_dt_1,L.inc_adm_dt_2,L.inc_adm_dt_3,L.inc_adm_dt_4,L.inc_adm_dt_5,L.inc_adm_dt_6);			 
				self := L;
			end;
			
		ds_DOC_recs_w_dates := project(ds_DOC_recs_raw, fillSortFields(LEFT));
		
		ds_DOC_recs_sorted := 
			SORT(
				ds_DOC_recs_w_dates, 
				acctno,
				-uDate1, uFlag, -uDate2, uFlag, -uDate3, uFlag, -uDate4, uFlag, 
				-uDate5, uFlag, -uDate6, uFlag, -uDate7, uFlag, -uDate8, uFlag, 
				-uDate9, uFlag, -((UNSIGNED4)process_date), uFlag
			);
																													
		ds_DOC_recs_deduped := DEDUP( ds_DOC_recs_sorted, acctno );

		Layouts.rec_dept_of_corr xfm_DOC_recs( CriminalRecordsSort le ) := 
			TRANSFORM
					latest_sch_rel_dt := max_dt(le.sch_rel_dt_1, le.sch_rel_dt_2, le.sch_rel_dt_3, le.sch_rel_dt_4, le.sch_rel_dt_5, le.sch_rel_dt_6);
				SELF.acctno              := le.acctno;
				SELF.doc_state_origin    := le.state_origin;
				SELF.doc_sdid            := le.sdid;
				SELF.doc_ssn_1           := le.ssn;
				SELF.doc_lname           := le.lname;
				SELF.doc_fname           := le.fname;
				SELF.doc_mname           := le.mname;
				SELF.doc_doc_num         := le.doc_num;
				SELF.doc_dob             := le.dob;
				SELF.curr_incar_flag     := le.curr_incar_flag;
				SELF.curr_probation_flag := le.curr_probation_flag;
				SELF.curr_parole_flag    := le.curr_parole_flag;
				SELF.sch_rel_dt          := IF( le.curr_incar_flag = 'Y', (STRING)latest_sch_rel_dt, '' );
			END;
			
		ds_DOC_recs := PROJECT( ds_DOC_recs_deduped, xfm_DOC_recs(LEFT) );
		
		// For this product, we want only those DOC records where the subject 
		// is currently incarcerated.
		ds_DOC_recs_incarcerated := ds_DOC_recs(curr_incar_flag = 'Y');
		
		// ---------------[ Evaluate Criminal Felony records. ]---------------

		UCase := StringLib.StringToUpperCase;
		Find  := StringLib.StringFind;
		
		ds_crim_felonies := 
			ds_criminal_recs_filt( // really ungainly filter:
				(data_type = CRIMINAL_COURT) AND 
				(
					Find(   UCase(off_desc_1_1), 'FELONY', 1 ) > 0 OR
					Find(   UCase(off_desc_1_2), 'FELONY', 1 ) > 0 OR
					Find(   UCase(off_desc_1_3), 'FELONY', 1 ) > 0 OR
					Find(   UCase(off_desc_1_4), 'FELONY', 1 ) > 0 OR
					Find(   UCase(off_desc_1_5), 'FELONY', 1 ) > 0 OR
					Find(   UCase(off_desc_1_6), 'FELONY', 1 ) > 0 OR
					Find( UCase(add_off_desc_1), 'FELONY', 1 ) > 0 OR
					Find( UCase(add_off_desc_2), 'FELONY', 1 ) > 0 OR
					Find( UCase(add_off_desc_3), 'FELONY', 1 ) > 0 OR
					Find( UCase(add_off_desc_4), 'FELONY', 1 ) > 0 OR
					Find( UCase(add_off_desc_5), 'FELONY', 1 ) > 0 OR
					Find( UCase(add_off_desc_6), 'FELONY', 1 ) > 0 OR
					UCase(off_typ_1[1]) = 'F' OR UCase(off_lev_1[1]) = 'F' OR    
					UCase(off_typ_2[1]) = 'F' OR UCase(off_lev_2[1]) = 'F' OR    
					UCase(off_typ_3[1]) = 'F' OR UCase(off_lev_3[1]) = 'F' OR 
					UCase(off_typ_4[1]) = 'F' OR UCase(off_lev_4[1]) = 'F' OR    
					UCase(off_typ_5[1]) = 'F' OR UCase(off_lev_5[1]) = 'F' OR    
					UCase(off_typ_6[1]) = 'F' OR UCase(off_lev_6[1]) = 'F'
				)
			);
		
		ds_crim_felonies_sorted :=
			SORT(
				ds_crim_felonies, 
				acctno, 
				-max_dt(stc_dt_1, stc_dt_2, stc_dt_3, stc_dt_4, stc_dt_5, stc_dt_6), 
				-process_date
			);
		
		ds_crim_felonies_deduped := DEDUP( ds_crim_felonies_sorted, acctno );
		
		ds_criminal_recs := 
			PROJECT( 
				ds_crim_felonies_deduped, 
				TRANSFORM( Layouts.rec_criminal,
					SELF := LEFT,
					SELF := []
				)
			);

		// ---------------[ Append Criminal records to DOC records; output. ]---------------
	
		ds_DOC_recs_only :=
			JOIN(
				ds_batch_in, ds_DOC_recs_incarcerated,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( Layouts.rec_dept_of_corr,
					SELF.acctno := LEFT.acctno,
					SELF := RIGHT,
					SELF := []
				),
				LEFT OUTER,
				KEEP(1)
			);
			
		ds_DOC_and_Crim_recs := 
			JOIN(
				ds_DOC_recs_only, ds_criminal_recs,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( Layouts.rec_DOC_and_Criminal,
					SELF.acctno := LEFT.acctno,
					SELF := RIGHT,
					SELF := LEFT
				),
				LEFT OUTER,
				KEEP(1)				
			);

		IF( in_mod.ViewDebugs, 
			OUTPUT( ds_criminal_recs_raw, NAMED('Criminal_results') ) );

		RETURN ds_DOC_and_Crim_recs;
	END;