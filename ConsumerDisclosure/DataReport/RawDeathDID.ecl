/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, doxie, FCRA, FFD, Header;

layout_DeathDID_raw := RECORD
  UNSIGNED6 l_did;
  Header.Layout_Did_Death_MasterV3;
  STRING18 county_name := '';
END;

layout_DeathDID_rawrec := RECORD(layout_DeathDID_raw)
  $.Layouts.InternalMetadata;
END;

EXPORT RawDeathDID := MODULE

  EXPORT layout_DeathDID_out := RECORD($.Layouts.Metadata)
    layout_DeathDID_raw;
  END;

  EXPORT GetData(DATASET(doxie.layout_references) in_dids,
                DATASET (FFD.Layouts.flag_ext_rec) flag_file,
                DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
               $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

    pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.DID_DEATH);
    all_flags := flag_file(file_id = FCRA.FILE_ID.DID_DEATH);

    flag_recs :=
      JOIN(all_flags, FCRA.key_override_death_master.did_death,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_DeathDID_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          rec_id := TRIM(RIGHT.did) + TRIM(RIGHT.state_death_id);
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (rec_id='' OR rec_id=LEFT.record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := RIGHT.did;
          SELF.record_ids.RecId2 := RIGHT.state_death_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    override_recs := flag_recs(compliance_flags.isOverride);
    suppressed_recs := flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    override_ids := SET(override_recs, combined_record_id);
    suppressed_ids := SET(suppressed_recs, combined_record_id);

    main_recs := JOIN(in_dids, Doxie.key_death_masterV2_ssa_DID_fcra,
                          KEYED(LEFT.did = RIGHT.l_did),
                          TRANSFORM(layout_DeathDID_rawrec,
                                    rec_id := TRIM(RIGHT.did) + TRIM(RIGHT.state_death_id);
                                    SELF.compliance_flags.IsOverwritten :=
                                      (rec_id<>'' AND rec_id IN override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (rec_id<>'' AND rec_id IN suppressed_ids),
                                    SELF.subject_did := LEFT.did,
                                    SELF.record_ids.RecId1 := RIGHT.did,
                                    SELF.record_ids.RecId2 := RIGHT.state_death_id,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxDeathPerDID));


    recs_all := main_recs + override_recs;

    recs_filt:= recs_all(
      in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed
      );

    //add statementids  & add dispute indicators/remove disputed records

    layout_DeathDID_rawrec xformStatements( layout_DeathDID_rawrec l,  FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
      SKIP(~ShowDisputedRecords and r.isDisputed)

          SELF.statement_ids := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    recs_final_ds := JOIN(recs_filt, pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.record_ids.RecID1 = RIGHT.RecID1 AND
                          LEFT.record_ids.RecID2 = RIGHT.RecID2,
                          xformStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    recs_out := PROJECT(recs_final_ds, TRANSFORM(layout_DeathDID_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_IDs,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.DID_DEATH);
                        SELF := LEFT;
                        ));

    IF(ConsumerDisclosure.Debug AND in_mod.IncludeDeath,OUTPUT(suppressed_recs, NAMED('DeathDID_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeDeath,OUTPUT(override_recs, NAMED('DeathDID_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeDeath,OUTPUT(main_recs, NAMED('DeathDID_main_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeDeath,OUTPUT(recs_out, NAMED('DeathDID_recs')));

    RETURN SORT(recs_out, -dod8, -filedate, death_rec_src, -state_death_id, RECORD);
  END;

END;
