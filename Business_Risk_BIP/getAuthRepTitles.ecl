IMPORT _Validate, BIPV2, Business_Risk_BIP, doxie_cbrs, Risk_Indicators, STD, doxie, BIPV2_Contacts;

// The following function finds the title for each Auth Rep at the time of the HistoryDate.
EXPORT getAuthRepTitles( DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
													Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
													BIPV2.mod_sources.iParams linkingOptions,
													SET OF STRING2 AllowedSourcesSet) :=
	FUNCTION

		mod_access := PROJECT(Options, doxie.IDataAccess);

		commonTitleChars := '- ,';
		alphabeticChars := _Validate.Strings.Alpha_Upper + _Validate.Strings.Alpha_Lower + commonTitleChars;

  ds_BIPIDs := Business_Risk_BIP.Common.GetLinkIDs(Shell);

  include_DMI := false;
  ds_contactLinkids_raw := BIPV2_Contacts.key_contact_linkids.kFetch2(PROJECT(ds_BIPIDs, BIPV2.IDlayouts.l_xlink_ids2),
                                           Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
                                           0, // ScoreThreshold --> 0 = Give me everything
                                           linkingOptions,
                                           Business_Risk_BIP.Constants.Limit_Default,
                                           include_DMI,
                                           mod_access,
                                           Options.KeepLargeBusinesses);

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
				Shell, ds_contactLinkids_seq_pre,
				LEFT.Seq  = RIGHT.Seq,
				TRANSFORM( {RECORDOF(RIGHT)},
					SELF.Seq := LEFT.Seq,
					SELF.HistoryDate := LEFT.Clean_Input.HistoryDate,
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
						(INTEGER)(((STRING)dt_first_seen)[1..6]) <= (integer)((STRING8)Std.Date.Today())[1..6]
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
		END;

		layout_temp xfm_NormAuthReps( Business_Risk_BIP.Layouts.Shell le, INTEGER whichAuthRep ) :=
			TRANSFORM
				SELF.Seq          := le.Seq;
				SELF.Rep_WhichOne := CHOOSE( whichAuthRep, 1, 2, 3, 4, 5, 0);
				SELF.FirstName    := CHOOSE( whichAuthRep, le.Clean_Input.Rep_FirstName, le.Clean_Input.Rep2_FirstName,le.Clean_Input.Rep3_FirstName,le.Clean_Input.Rep4_FirstName,le.Clean_Input.Rep5_FirstName, '' );
				SELF.LastName     := CHOOSE( whichAuthRep, le.Clean_Input.Rep_LastName , le.Clean_Input.Rep2_LastName ,le.Clean_Input.Rep3_LastName ,le.Clean_Input.Rep4_LastName ,le.Clean_Input.Rep5_LastName , '' );
				SELF.LexID        := (INTEGER)(CHOOSE( whichAuthRep, le.Business_To_Executive_Link.BusExecLinkAuthRepLexID, le.Business_To_Executive_Link.BusExecLinkAuthRep2LexID, le.Business_To_Executive_Link.BusExecLinkAuthRep3LexID, le.Business_To_Executive_Link.BusExecLinkAuthRep4LexID, le.Business_To_Executive_Link.BusExecLinkAuthRep5LexID ));
				SELF := [];
			END;

		ds_AuthRepsNormed :=	NORMALIZE( Shell, 5,	xfm_NormAuthReps(LEFT,COUNTER)	);

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
					seq, Rep_WhichOne, executive_ind_order, executive_ind_order2
				),
				seq, Rep_WhichOne
			);

		// 11. Use COMBINE( ) function to transform from normalized records to denormalized,
		// repeating fields in a single record.

  // Define left Group.
		layout_seq := {UNSIGNED4 seq};

		ds_seq := PROJECT(ds_AuthReps_with_Titles_ddpd, layout_seq);
		ds_seq_grpd := GROUP(DEDUP(SORT(ds_seq, seq), seq), seq);

  // Define right Group.
		ds_AuthReps_with_Titles_grpd := GROUP( ds_AuthReps_with_Titles_ddpd, seq );

  // Combine:
  layout_authRepTitles_temp := RECORD
    UNSIGNED4 seq;
    STRING30 BusExecLinkAuthRepTitle;
    STRING30 BusExecLinkAuthRep2Title;
    STRING30 BusExecLinkAuthRep3Title;
    STRING30 BusExecLinkAuthRep4Title;
    STRING30 BusExecLinkAuthRep5Title;
  END;

		layout_authRepTitles_temp xfm_ToCombineAuthRepsWithTitles( layout_seq le, DATASET(layout_temp) allRows ) :=
			TRANSFORM
				SELF.seq := le.seq;
				SELF.BusExecLinkAuthRepTitle  := STD.Str.Filter( allRows(Rep_WhichOne = 1)[1].Title, alphabeticChars );
				SELF.BusExecLinkAuthRep2Title := STD.Str.Filter( allRows(Rep_WhichOne = 2)[1].Title, alphabeticChars );
				SELF.BusExecLinkAuthRep3Title := STD.Str.Filter( allRows(Rep_WhichOne = 3)[1].Title, alphabeticChars );
				SELF.BusExecLinkAuthRep4Title := STD.Str.Filter( allRows(Rep_WhichOne = 4)[1].Title, alphabeticChars );
				SELF.BusExecLinkAuthRep5Title := STD.Str.Filter( allRows(Rep_WhichOne = 5)[1].Title, alphabeticChars );
			END;

		ds_AuthReps_with_Titles_combined :=
			COMBINE(
				ds_seq_grpd, ds_AuthReps_with_Titles_grpd,
				GROUP,
				xfm_ToCombineAuthRepsWithTitles(LEFT,ROWS(RIGHT))
			);

			Shell_withAuthRepTitles :=
				JOIN(
					Shell, ds_AuthReps_with_Titles_combined,
					LEFT.Seq = RIGHT.Seq,
					TRANSFORM( Business_Risk_BIP.Layouts.Shell,
						SELF.Seq := LEFT.Seq,
      SELF.Business_To_Executive_Link.BusExecLinkAuthRepTitle  := RIGHT.BusExecLinkAuthRepTitle,
      SELF.Business_To_Executive_Link.BusExecLinkAuthRep2Title := RIGHT.BusExecLinkAuthRep2Title,
      SELF.Business_To_Executive_Link.BusExecLinkAuthRep3Title := RIGHT.BusExecLinkAuthRep3Title,
      SELF.Business_To_Executive_Link.BusExecLinkAuthRep4Title := RIGHT.BusExecLinkAuthRep4Title,
      SELF.Business_To_Executive_Link.BusExecLinkAuthRep5Title := RIGHT.BusExecLinkAuthRep5Title,
      SELF := LEFT,
						SELF := []
					),
					LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

		// DEBUGs:


		RETURN Shell_withAuthRepTitles;
END;
