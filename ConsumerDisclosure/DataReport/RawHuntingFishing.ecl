/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, doxie, FFD, FCRA, eMerges;

layout_HuntFish_raw := RECORD(emerges.layout_hunters_out)
  UNSIGNED6 rid;
END;  //should we add mail_county_name column to the layout?

layout_HuntFish_rawrec := RECORD(layout_HuntFish_raw)
  $.Layouts.InternalMetadata;
END;


EXPORT RawHuntingFishing := MODULE

  EXPORT layout_layout_HuntFish_out := RECORD($.Layouts.Metadata)
    layout_HuntFish_raw;
  END;


  EXPORT GetData(DATASET(doxie.layout_references) in_dids,
                 DATASET (FFD.Layouts.flag_ext_rec) flagfile,
                 DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
                 $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN IsFCRA := TRUE;
    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

    pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.HUNTING_FISHING);
    all_flags := flagfile(file_id = FCRA.FILE_ID.HUNTING_FISHING);

    flag_recs :=
      JOIN(all_flags, FCRA.key_override_hunting_fishing.hunting_fishing,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_HuntFish_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.Compliance_Flags.isOverride := LEFT.isOverride AND is_override;
          SELF.Compliance_Flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.persistent_record_id=0 OR LEFT.record_id = (STRING) RIGHT.persistent_record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.Record_Ids.RecId1 := (STRING) RIGHT.persistent_record_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    override_recs := flag_recs(Compliance_Flags.isOverride);
    suppressed_recs := flag_recs(Compliance_Flags.isSuppressed AND ~Compliance_Flags.isOverride);

    override_ids := SET(override_recs, combined_record_id);
    suppressed_ids := SET(suppressed_recs, combined_record_id);

    id_recs := JOIN(in_dids,eMerges.Key_HuntFish_Did(isFCRA),
                    KEYED(LEFT.did = RIGHT.did),
                    TRANSFORM(RIGHT),
                    LIMIT(0),KEEP($.Constants.Limits.MaxHuntersPerDID));

    // join to payload key.
    main_recs := JOIN(id_recs,eMerges.Key_HuntFish_Rid(isFCRA),
                          KEYED(LEFT.rid = RIGHT.rid),
                          TRANSFORM(layout_HuntFish_rawrec,
                                    SELF.Compliance_Flags.IsOverwritten :=
                                      (RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN override_ids),
                                    SELF.Compliance_Flags.IsSuppressed :=
                                      (RIGHT.persistent_record_id>0 and (STRING) RIGHT.persistent_record_id IN suppressed_ids),
                                    SELF.subject_did := LEFT.did,
                                    SELF.Record_Ids.RecId1 := (STRING) RIGHT.persistent_record_id,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP(1));


    recs_all := main_recs + override_recs;

    recs_filt := recs_all(
      in_mod.ReturnOverwritten OR ~Compliance_Flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~Compliance_Flags.isSuppressed
      );

      //should we add mail_county_name values using Census_Data.Key_Fips2County index?

    layout_HuntFish_rawrec xformStatements( layout_HuntFish_rawrec l,  FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)

          SELF.statement_IDs := r.StatementIDs;
          SELF.compliance_flags.IsDisputed   := r.isDisputed;
          SELF := l;
    END;

    recs_final_ds := JOIN(recs_filt, pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.lexid AND
                          LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
                          xformStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    recs_out := PROJECT(recs_final_ds, TRANSFORM(layout_layout_HuntFish_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_IDs,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.HUNTING_FISHING);
                        SELF := LEFT;
                        ));

    IF(ConsumerDisclosure.Debug AND in_mod.IncludeHuntingFishing,OUTPUT(id_recs, NAMED('huntfish_ids')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeHuntingFishing,OUTPUT(suppressed_recs, NAMED('huntfish_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeHuntingFishing,OUTPUT(override_recs, NAMED('huntfish_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeHuntingFishing,OUTPUT(main_recs, NAMED('huntfish_main_recs')));

    RETURN SORT(recs_out, -date_last_seen, -date_first_seen, process_date, RECORD);
  END;

END;
