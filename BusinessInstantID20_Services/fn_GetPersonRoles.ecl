IMPORT _Validate, BIPV2, BIPV2_Build, Business_Risk_BIP, doxie_cbrs, Risk_Indicators, STD;

// The following function finds the title for each Auth Rep at the time of the HistoryDate.
EXPORT fn_GetPersonRoles( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean) ds_CleanedInputWithLexIDs,
													DATASET(BIPV2.IDlayouts.l_xlink_ids2) ds_BIPIDs,
													Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
													BIPV2.mod_sources.iParams linkingOptions,
													SET OF STRING2 AllowedSourcesSet) := 
	FUNCTION
	
		commonTitleChars := '- ,';
		alphabeticChars := _Validate.Strings.Alpha_Upper + _Validate.Strings.Alpha_Lower + commonTitleChars;
		
		ds_contactLinkids_raw := BIPV2_Build.key_contact_linkids.kFetch(
																						 PROJECT(ds_BIPIDs, BIPV2.IDlayouts.l_xlink_ids),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																						 0, // ScoreThreshold --> 0 = Give me everything
																						 linkingOptions,
																						 Business_Risk_BIP.Constants.Limit_Default,
																						 Options.KeepLargeBusinesses
																		 );
		// 1. Add back our Seq numbers.
		ds_contactLinkids_seq_pre := 
			JOIN(
				ds_BIPIDs, ds_contactLinkids_raw, 
				LEFT.UltID  = RIGHT.UltID AND
				LEFT.OrgID  = RIGHT.OrgID AND							
				LEFT.SeleID = RIGHT.SeleID,
				TRANSFORM( {UNSIGNED4 Seq, UNSIGNED6 HistoryDate, RECORDOF(RIGHT)}, 
					SELF.Seq := LEFT.UniqueID, 
					SELF.HistoryDate := 0,
					SELF := RIGHT), 
				FEW);				


		// 2. Add back the HistoryDate.
		ds_contactLinkids_seq := 
			JOIN(
				ds_CleanedInputWithLexIDs, ds_contactLinkids_seq_pre, 
				LEFT.Seq  = RIGHT.Seq,
				TRANSFORM( {RECORDOF(RIGHT)}, 
					SELF.Seq := LEFT.Seq, 
					SELF.HistoryDate := LEFT.HistoryDate,
					SELF := RIGHT), 
				FEW);		
				
		// 3. Filter out records where HistoryDate occurs before dt_first_seen_contact, and filter
		// out sources that aren't allowed.
		ds_contactLinkids_filt := 
			ds_contactLinkids_seq(
				(Source = '' OR Source IN AllowedSourcesSet) AND // Only keep allowed Business Shell sources.
				(
					( // If running in realtime mode, still filter out any future dates, but
						// include everything up to today's date (thus the <= comparison).
						HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND 
						(INTEGER)(((STRING)dt_first_seen)[1..6]) <= (INTEGER)(StringLib.getDateYYYYMMDD()[1..6])
					) 
					OR 
					Business_Risk_BIP.Common.fn_filter_on_archive_date( (INTEGER)(((STRING)dt_first_seen_contact)[1..6]), (INTEGER)((STRING)HistoryDate)[1..6], 6 )
				)
			);
	
		// 4. Filter out any records that have no Title at all, and Titles having a length of 1.
		ds_contactLinkids_with_titles := 
			ds_contactLinkids_filt( LENGTH(TRIM(contact_job_title_raw)) > 1 OR LENGTH(TRIM(contact_job_title_derived)) > 1 );
		
		// 5. Add a supplementary order value field; set its value to a default of 100 for sorting later.
		ds_contacts_plus_order2 :=
			PROJECT(
				ds_contactLinkids_with_titles,
				TRANSFORM( { RECORDOF(ds_contactLinkids_with_titles),INTEGER8 executive_ind_order2 },
					SELF.executive_ind_order  := IF( LEFT.executive_ind_order = 0, 100, LEFT.executive_ind_order ),
					SELF.executive_ind_order2 := 100,
					SELF := LEFT
				)
			);
		
		// 6. Get alternative Title ranking.
		ds_contacts_plus_order2_vals :=
			JOIN(
				ds_contacts_plus_order2, doxie_cbrs.executive_titles,
				LEFT.contact_job_title_raw = RIGHT.stored_title,
				TRANSFORM( { RECORDOF(ds_contacts_plus_order2) },
					SELF.executive_ind_order2 := RIGHT.title_rank,
					SELF := LEFT
				),
				LEFT OUTER 
			);

		// 7. Sort and dedup to obtain the single, most recent, best record for each Contact.
		ds_contacts_ddpd :=
			DEDUP(
				SORT(
					ds_contacts_plus_order2_vals,
					seq, contact_did, contact_name.lname, contact_name.fname, -(INTEGER)dt_first_seen_contact, executive_ind_order, executive_ind_order2
				),
				seq, contact_did, contact_name.lname, contact_name.fname
			);
			
		// 8. Normalize the Auth Reps out of their child dataset so we can join them to the Contacts 
		// dataset in a sec.
		layout_temp := RECORD
			UNSIGNED Seq          := 0;
			UNSIGNED Rep_WhichOne := 0;
			STRING   FirstName    := '';
			STRING   LastName     := '';
			UNSIGNED6 LexID       := 0;
			STRING   Title        := '';
			UNSIGNED fname_score  := 0;
			UNSIGNED lname_score  := 0;
			UNSIGNED executive_ind_order  := 0;
			UNSIGNED executive_ind_order2 := 0;
			STRING15  Sequence    := '';
			UNSIGNED1 SortOrder   := 0;
		END;	
		
		layout_temp xfm_NormAuthReps( BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean le, BusinessInstantID20_Services.Layouts.InputAuthRepInfoClean ri ) := 
			TRANSFORM
				SELF.Seq          := le.Seq;
				SELF.Rep_WhichOne := ri.Rep_WhichOne;
				SELF.FirstName    := ri.FirstName;
				SELF.LastName     := ri.LastName;
				SELF.LexID        := ri.LexID;
				SELF.Sequence     := ri.Sequence;
				SELF.SortOrder    := ri.SortOrder;
				SELF := [];
			END;
			
		ds_AuthRepsNormed :=
			NORMALIZE(
				ds_CleanedInputWithLexIDs,
				LEFT.AuthReps,
				xfm_NormAuthReps(LEFT,RIGHT)
			);

		// 9. Match up the Contact names (name-only match is all that is required; or did match).
		ds_AuthReps_with_Titles :=
			JOIN(
				ds_AuthRepsNormed, ds_contacts_ddpd, 
				LEFT.seq = RIGHT.seq AND
				(
					(RIGHT.contact_did != 0 AND LEFT.LexID = RIGHT.contact_did) OR
					(
						Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(LEFT.FirstName, RIGHT.contact_name.fname)) AND
						Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(LEFT.LastName, RIGHT.contact_name.lname))
					)
				),
				TRANSFORM( layout_temp,
					SELF.Title := IF( RIGHT.contact_job_title_derived != '', RIGHT.contact_job_title_derived, RIGHT.contact_job_title_raw ),
					SELF.fname_score := Risk_Indicators.FNameScore(LEFT.FirstName, RIGHT.contact_name.fname);
					SELF.lname_score := Risk_Indicators.LNameScore(LEFT.LastName, RIGHT.contact_name.lname);
					SELF.executive_ind_order := RIGHT.executive_ind_order;
					SELF.executive_ind_order2 := RIGHT.executive_ind_order2;					
					SELF := LEFT
				),
				LEFT OUTER
			);
	
		// 10. Sort and dedup to retain best Titles.
		ds_AuthReps_with_Titles_ddpd :=
			DEDUP( 
				SORT( 
					ds_AuthReps_with_Titles, 
					seq, SortOrder, executive_ind_order, executive_ind_order2
				),
				seq, Rep_WhichOne
			);

		ds_AuthReps_with_Titles_grpd := GROUP( ds_AuthReps_with_Titles_ddpd, seq );

		// 11. Use COMBINE( ) function to transform from normalized records to denormalized, 
		// repeating fields in a single record.
		layout_seq := {UNSIGNED4 seq};

		ds_seq := PROJECT(ds_AuthReps_with_Titles_ddpd, layout_seq);
		ds_seq_grpd := GROUP(DEDUP(SORT(ds_seq, seq), seq), seq);

		BusinessInstantID20_Services.Layouts.PersonRoleLayout xfm_ToCombineAuthRepsWithTitles( layout_seq le, DATASET(layout_temp) allRows ) := 
			TRANSFORM
				SELF.seq := le.seq;
				SELF.person_role_rep1 := STD.Str.Filter( allRows(Rep_WhichOne = 1)[1].Title, alphabeticChars );
				SELF.person_role_rep2 := STD.Str.Filter( allRows(Rep_WhichOne = 2)[1].Title, alphabeticChars );
				SELF.person_role_rep3 := STD.Str.Filter( allRows(Rep_WhichOne = 3)[1].Title, alphabeticChars );
				SELF.person_role_rep4 := STD.Str.Filter( allRows(Rep_WhichOne = 4)[1].Title, alphabeticChars );
				SELF.person_role_rep5 := STD.Str.Filter( allRows(Rep_WhichOne = 5)[1].Title, alphabeticChars );
			END;
				
		ds_AuthReps_with_Titles_combined := 
			COMBINE( 
				ds_seq_grpd, ds_AuthReps_with_Titles_grpd, 
				GROUP, 
				xfm_ToCombineAuthRepsWithTitles(LEFT,ROWS(RIGHT)) 
			);

		// DEBUGs:
		// OUTPUT( ds_contactLinkids_raw, NAMED('contactLinkids_raw') );
		// OUTPUT( ds_contactLinkids_seq_pre, NAMED('contactLinkids_seq_pre') );
		// OUTPUT( ds_contactLinkids_seq, NAMED('contactLinkids_seq') );
		// OUTPUT( ds_contactLinkids_filt, NAMED('contactLinkids_filt') );
		// OUTPUT( ds_contactLinkids_with_titles, NAMED('contactLinkids_with_titles') );
		// OUTPUT( ds_contacts_plus_order2_vals, NAMED('contacts_plus_order2_vals') );
		// OUTPUT( ds_contacts_ddpd, NAMED('contacts_ddpd') );
		// OUTPUT( ds_AuthRepsNormed, NAMED('AuthRepsNormed') );
		// OUTPUT( ds_AuthReps_with_Titles, NAMED('AuthReps_with_Titles') );
		// OUTPUT( ds_AuthReps_with_Titles_ddpd, NAMED('AuthReps_with_Titles_ddpd') );
		// OUTPUT( ds_AuthReps_with_Titles_grpd, NAMED('ds_AuthReps_with_Titles_grpd') );
		// OUTPUT( ds_AuthReps_with_Titles_combined, NAMED('ds_AuthReps_with_Titles_combined') );
		
		RETURN ds_AuthReps_with_Titles_combined;
END;