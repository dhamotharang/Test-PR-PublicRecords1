/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, LN_PropertyV2, doxie, FCRA, FFD, Suppress, BIPV2;

BOOLEAN IsFCRA := TRUE;

layout_property_search_raw := RECORD(LN_PropertyV2.layout_search_building)  //recordof(LN_PropertyV2.key_search_fid)
  //  additional columns of key_search_fid index:
    STRING1 source_code_1;
    STRING1 source_code_2;
    BIPV2.IDlayouts.l_xlink_ids;
    string2 	Addr_ind,
    string1 	Best_addr_ind,
    unsigned6 addr_tx_id,
    string1   best_addr_tx_id,
    unsigned8	Location_id,
    string1   best_locid;
END;

layout_addllegal_raw := RECORD(LN_PropertyV2.layout_addl_legal) //recordof(LN_PropertyV2.key_addl_legal_fid)
END;

layout_addlnames_raw := RECORD(LN_PropertyV2.layout_addl_names) //recordof(LN_PropertyV2.key_addl_names)
END;

layout_assessment_raw := RECORD(ln_propertyv2.layout_property_common_model_base) //recordof(LN_PropertyV2.key_assessor_fid)
  UNSIGNED6 proc_date;
END;

layout_deed_raw := RECORD(ln_propertyv2.layout_deed_mortgage_common_model_base) //recordof(LN_PropertyV2.key_deed_fid)
  UNSIGNED6 proc_date;
END;

layout_property_search_rawrec := RECORD(layout_property_search_raw)
    $.Layouts.InternalMetadata;
END;

layout_assessment_rawrec := RECORD(layout_assessment_raw)
    $.Layouts.InternalMetadata;
    layout_addllegal_raw AddlLegalDescription;
END;

layout_deed_rawrec := RECORD(layout_deed_raw)
    $.Layouts.InternalMetadata;
    DATASET(layout_addlnames_raw) AdditionalNames;
END;

layout_fareid := RECORD
  STRING50 ln_fares_id;
  UNSIGNED6 s_did := 0;
  BOOLEAN isOwnedBySubject := FALSE;
END;

layout_fareid_addr := RECORD($.Layouts.address_rec)
  layout_fareid;
  unsigned3 dt_last_seen;
END;


EXPORT RawProperty := MODULE

  EXPORT layout_property_search_out := RECORD($.Layouts.Metadata)
    layout_property_search_raw;
  END;

  EXPORT layout_assessment_out := RECORD($.Layouts.Metadata)
    layout_assessment_raw RawData;
    layout_addllegal_raw AddlLegalDescription;
    STRING4 assessed_value_year;  // for assessment sorting
  END;

  EXPORT layout_deed_out := RECORD($.Layouts.Metadata)
    layout_deed_raw RawData;
    DATASET(layout_addlnames_raw) AdditionalNames;
    STRING8 contract_date;        // for deed sorting
  END;

  EXPORT layout_property_out := RECORD
    STRING50 ln_fares_id;
    STRING8 contract_date;        // for DEED sorting
    STRING4 assessed_value_year;  // for assessment sorting
    BOOLEAN isOwnedBySubject := FALSE;
    DATASET(layout_property_search_out) Search;
    DATASET(layout_assessment_out) Assessment;
    DATASET(layout_deed_out) Deed;
  END;

  GetFareIdByDid(DATASET(doxie.layout_references) in_dids) := FUNCTION

    id_recs_prelim := JOIN(in_dids,ln_propertyv2.key_property_did(isFCRA),
                        KEYED(LEFT.did = RIGHT.s_did) AND
                        // Filter out "Care-Of" records
                        RIGHT.source_code[1] != 'C',
                        TRANSFORM(layout_fareid, SELF.isOwnedBySubject:=TRUE, SELF:=RIGHT),
                    LIMIT(0),KEEP($.Constants.Limits.MaxPropPerDID));

    id_recs_ddp := DEDUP(SORT(id_recs_prelim,s_did,ln_fares_id),s_did,ln_fares_id);
    RETURN id_recs_ddp;
  END;

  GetFareIdByAddress(DATASET($.Layouts.address_rec) in_addresses) := FUNCTION
    // expected that addresses coming from input are unique and have seq_no assigned
    by_address_recs_prelim := JOIN(in_addresses,ln_propertyv2.key_addr_fid(isFCRA),
                                   LEFT.prim_name<>'' AND
                                   KEYED (LEFT.prim_name=Right.prim_name AND
                                           LEFT.prim_range=Right.prim_range AND
                                           LEFT.zip=Right.zip AND
                                           LEFT.predir=Right.predir AND
                                           LEFT.postdir=Right.postdir AND
                                           LEFT.suffix=Right.suffix AND
                                           LEFT.sec_range=Right.sec_range AND
                                           RIGHT.source_code_2 = 'P') AND
                                    RIGHT.source_code_1 <> 'C',  // filter out "Care-Of" records
                                    TRANSFORM(layout_fareid_addr,
                                          SELF.isOwnedBySubject:=FALSE,
                                          SELF.s_did:=LEFT.subject_did,
                                          SELF.ln_fares_id:=RIGHT.ln_fares_id,
                                          SELF:=LEFT, SELF:=[]),
                                LIMIT(0),KEEP($.Constants.Limits.MaxPropPerAddress));

    by_address_recs := JOIN (by_address_recs_prelim, ln_propertyv2.key_search_fid(IsFCRA),
                                  KEYED (LEFT.ln_fares_id = RIGHT.ln_fares_id) AND
                                  RIGHT.source_code[1]='O',
                                  TRANSFORM (layout_fareid_addr,
                                            SELF.dt_last_seen := RIGHT.dt_last_seen,
                                            SELF:=LEFT),
                                  LIMIT(0), KEEP($.Constants.Limits.MaxPropPerFID));

    assmnt_fares := DEDUP(SORT(by_address_recs(ln_fares_id[2]='A'), s_did,zip,prim_name,prim_range,predir,postdir,suffix,sec_range,-dt_last_seen), s_did, zip,prim_name,prim_range,predir,postdir,suffix,sec_range);   // keep the most recent fares id per address
    deed_fares   := DEDUP(SORT(by_address_recs(ln_fares_id[2]='D'), s_did,zip,prim_name,prim_range,predir,postdir,suffix,sec_range,-dt_last_seen), s_did, zip,prim_name,prim_range,predir,postdir,suffix,sec_range); // keep the most recent fares id per address

    fareid_recs := PROJECT(assmnt_fares+deed_fares, TRANSFORM(layout_fareid, SELF:=LEFT));

    RETURN fareid_recs;
  END;

  GetPropertiesByFareId(
    DATASET(layout_fareid) id_recs,
    DATASET (FFD.Layouts.flag_ext_rec) flag_file,
    DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
    $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

    assessment_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.ASSESSMENT);
    assessment_all_flags := flag_file(file_id = FCRA.FILE_ID.ASSESSMENT);

    deed_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.DEED);
    deed_all_flags := flag_file(file_id = FCRA.FILE_ID.DEED);

    property_search_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.PROPERTY_SEARCH);
    property_search_all_flags := flag_file(file_id = FCRA.FILE_ID.SEARCH);

      //-------assessment-------------
    assessment_flag_recs :=
      JOIN(assessment_all_flags, FCRA.key_override_property.assessment,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_assessment_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.ln_fares_id='' OR RIGHT.ln_fares_id=LEFT.record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.ln_fares_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    assessment_suppressed_recs := assessment_flag_recs(compliance_flags.isSuppressed ANd ~compliance_flags.isOverride);
    assessment_override_recs_prelim := assessment_flag_recs(compliance_flags.isOverride);

    //we only want to keep the overrides that were in the original id_recs
    assessment_override_recs := JOIN(assessment_override_recs_prelim, id_recs,
                                      LEFT.ln_fares_id = RIGHT.ln_fares_id AND
                                      LEFT.subject_did = RIGHT.s_did,
                                      TRANSFORM(LEFT), LIMIT(0), KEEP(1));

    assessment_override_ids := SET(assessment_override_recs, combined_record_id);
    assessment_suppressed_ids := SET(assessment_suppressed_recs, combined_record_id);

    assessment_payload_recs := JOIN(id_recs, LN_PropertyV2.key_assessor_fid(isFCRA),
                  KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id),
                  TRANSFORM(layout_assessment_rawrec,
                    SELF.compliance_flags.IsOverwritten := (RIGHT.ln_fares_id<>'' AND RIGHT.ln_fares_id IN assessment_override_ids),
                    SELF.compliance_flags.IsSuppressed := (RIGHT.ln_fares_id<>'' AND RIGHT.ln_fares_id IN assessment_suppressed_ids),
                    SELF.subject_did := LEFT.s_did,
                    SELF.record_ids.RecId1 := (STRING) RIGHT.ln_fares_id,
                    SELF := RIGHT,
                    SELF := LEFT,
                    SELF := []), // recid2, recid3, recid4
                  LIMIT(0), KEEP($.Constants.Limits.MaxPropPerFID));

    assessment_recs_all := assessment_payload_recs + assessment_override_recs;

    assessment_recs_filt:= assessment_recs_all(
      in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed
      );

    layout_assessment_rawrec xformAssessmentStatements(layout_assessment_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_IDs := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    assessment_with_pc := JOIN(assessment_recs_filt, assessment_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.ln_fares_id = RIGHT.RecID1,
                          xformAssessmentStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    assessment_final_ds := JOIN(assessment_with_pc, LN_PropertyV2.key_addl_legal_fid(isFCRA),
                              KEYED(left.ln_fares_id = right.ln_fares_id),
                              TRANSFORM(layout_assessment_rawrec,
                                        SELF.AddlLegalDescription:=RIGHT,
                                        SELF:=LEFT),
                              LIMIT(0), KEEP(1),
                              LEFT OUTER);

    assessment_recs_out := PROJECT(assessment_final_ds,
                                  TRANSFORM(layout_assessment_out,
                                    SELF.Metadata := $.Functions.GetMetadataESDL(
                                        LEFT.compliance_flags,
                                        LEFT.record_ids,
                                        LEFT.statement_IDs,
                                        LEFT.subject_did,
                                        FFD.Constants.DataGroups.ASSESSMENT),
                                    SELF.AddlLegalDescription := LEFT.AddlLegalDescription,
                                    SELF.assessed_value_year := LEFT.assessed_value_year,
                                    SELF.RawData := LEFT
                                  ));

  //-------deed-----------
    deed_flag_recs :=
      JOIN(deed_all_flags, FCRA.key_override_property.deed,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_deed_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.ln_fares_id='' OR RIGHT.ln_fares_id=LEFT.record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.ln_fares_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    deed_suppressed_recs := deed_flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);
    deed_override_recs_prelim := deed_flag_recs(compliance_flags.isOverride);

    //we only want to keep the overrides that were in the original id_recs
    deed_override_recs := JOIN(deed_override_recs_prelim, id_recs,
                              LEFT.ln_fares_id = RIGHT.ln_fares_id AND
                              LEFT.subject_did = RIGHT.s_did,
                              TRANSFORM(LEFT), LIMIT(0), KEEP(1));

    deed_override_ids := SET(deed_override_recs, combined_record_id);
    deed_suppressed_ids := SET(deed_suppressed_recs, combined_record_id);

    deed_payload_recs := JOIN(id_recs, LN_PropertyV2.key_deed_fid(isFCRA),
                  KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id),
                  TRANSFORM(layout_deed_rawrec,
                    SELF.compliance_flags.IsOverwritten := (RIGHT.ln_fares_id<>'' AND RIGHT.ln_fares_id IN deed_override_ids);
                    SELF.compliance_flags.IsSuppressed := (RIGHT.ln_fares_id<>'' AND RIGHT.ln_fares_id IN deed_suppressed_ids);
                    SELF.subject_did := LEFT.s_did;
                    SELF.record_ids.RecId1 := (STRING) RIGHT.ln_fares_id;
                    SELF := RIGHT;
                    SELF := LEFT;
                    SELF := []), // recid2, recid3, recid4
                  LIMIT(0), KEEP($.Constants.Limits.MaxPropPerFID));

    deed_recs_all := deed_payload_recs + deed_override_recs;

    deed_recs_filt:= deed_recs_all(
      in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed
      );

    layout_deed_rawrec xformDeedStatements(layout_deed_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_IDs := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    deed_with_pc := JOIN(deed_recs_filt, deed_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.ln_fares_id = RIGHT.RecID1,
                          xformDeedStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    addl_names	:= JOIN(id_recs, LN_PropertyV2.key_addl_names(isFCRA),
                        KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id),
                        TRANSFORM(layout_addlnames_raw, SELF:=RIGHT),
                        KEEP($.Constants.Limits.MaxPropPartiesPerFID), LIMIT(0));

    layout_deed_rawrec xfAddNames(layout_deed_rawrec le, DATASET(layout_addlnames_raw) ri) := TRANSFORM
      SELF.AdditionalNames := ri;
      SELF := le;
    END;

    deed_final_ds := DENORMALIZE(deed_with_pc, addl_names,
                                  LEFT.ln_fares_id = RIGHT.ln_fares_id,
                                  GROUP,
                                  xfAddNames(LEFT, ROWS(RIGHT)));

    deed_recs_out := PROJECT(deed_final_ds,
                                  TRANSFORM(layout_deed_out,
                                    SELF.Metadata := $.Functions.GetMetadataESDL(
                                        LEFT.compliance_flags,
                                        LEFT.record_ids,
                                        LEFT.statement_IDs,
                                        LEFT.subject_did,
                                        FFD.Constants.DataGroups.DEED
                                      ),
                                    SELF.AdditionalNames := LEFT.AdditionalNames,
                                    SELF.contract_date := LEFT.contract_date,
                                    SELF.RawData := LEFT
                                    ));

    //------------property search-------------------
    property_search_flag_recs :=
      JOIN(property_search_all_flags, FCRA.key_override_property.search,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_property_search_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed ANd (RIGHT.persistent_record_id=0 OR LEFT.record_id = (STRING) RIGHT.persistent_record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    property_search_suppressed_recs := property_search_flag_recs(compliance_flags.isSuppressed ANd ~compliance_flags.isOverride);
    property_search_override_recs_prelim := property_search_flag_recs(compliance_flags.isOverride);

    //we only want to keep the overrides that were in the original id_recs
    property_search_override_recs := JOIN(property_search_override_recs_prelim, id_recs,
                              LEFT.ln_fares_id = RIGHT.ln_fares_id AND
                              LEFT.subject_did = RIGHT.s_did,
                              TRANSFORM(LEFT), LIMIT(0), KEEP(1));

    property_search_override_ids := SET(property_search_override_recs, combined_record_id);
    property_search_suppressed_ids := SET(property_search_suppressed_recs, combined_record_id);

    suppressed_fares_ids := assessment_suppressed_ids + deed_suppressed_ids;

    property_search_payload_recs := JOIN(id_recs, LN_PropertyV2.key_search_fid(isFCRA),
                KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id),
                TRANSFORM(layout_property_search_rawrec,
                  SELF.compliance_flags.IsOverwritten := (RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN property_search_override_ids);
                  SELF.compliance_flags.IsSuppressed := (RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN property_search_suppressed_ids)
                                                        OR (RIGHT.ln_fares_id IN suppressed_fares_ids);
                  SELF.subject_did := LEFT.s_did;
                  SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id;
                  SELF := RIGHT;
                  SELF := LEFT;
                  SELF := []), // recid2, recid3, recid4
                LIMIT(0), KEEP($.Constants.Limits.MaxPropPerFID));

    property_search_recs_all := property_search_payload_recs + property_search_override_recs;

    property_search_recs_filt := property_search_recs_all(
      in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed,
      in_mod.nss <> Suppress.Constants.NonSubjectSuppression.returnBlank OR subject_did=did
      );

    layout_property_search_rawrec xformAddStatements(layout_property_search_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_IDs := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    property_search_recs_final_ds := JOIN(property_search_recs_filt, property_search_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
                          xformAddStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    //apply non-subject suppression for restricted
    layout_property_search_rawrec xformNSS(layout_property_search_rawrec L) := TRANSFORM
      IsSubject := (L.subject_did = L.did);
      NotAPerson := (L.did = 0) AND ((L.bdid != 0) OR (L.cname != ''));
      isRestricted := ~(IsSubject OR NotAPerson);

      SELF.subject_did := L.subject_did;
      SELF.compliance_flags := L.compliance_flags;
      SELF.record_ids := L.record_ids;

      SELF.ln_fares_id := L.ln_fares_id;
      SELF.persistent_record_id := L.persistent_record_id;

      SELF.lname := IF (isRestricted, FCRA.Constants.FCRA_Restricted, L.lname);
      SELF := IF (~isRestricted, L);
      SELF := [];
    END;

    property_search_nss := PROJECT(property_search_recs_final_ds, xformNSS(LEFT));

    property_search_final_ds := IF(in_mod.nss = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription,
                        property_search_nss, property_search_recs_final_ds);

    property_search_recs_out := PROJECT(property_search_final_ds,
                                      TRANSFORM(layout_property_search_out,
                                        SELF.Metadata := $.Functions.GetMetadataESDL(
                                                          LEFT.compliance_flags,
                                                          LEFT.record_ids,
                                                          LEFT.statement_IDs,
                                                          LEFT.subject_did,
                                                          FFD.Constants.DataGroups.PROPERTY_SEARCH),
                                        SELF := LEFT
                                        ));


    // --------Now combining data sets for final output
    ids := PROJECT(id_recs, TRANSFORM(layout_property_out,
                                      SELF.ln_fares_id:=LEFT.ln_fares_id,
                                      SELF.isOwnedBySubject:=LEFT.isOwnedBySubject,
                                      SELF:=[]));

    layout_property_out xfAddSearch(layout_property_out le,
                        DATASET(layout_property_search_out) ri) :=
    TRANSFORM
      SELF.Search := SORT(ri, -dt_last_seen, -dt_first_seen);
      SELF := le;
    END;

    search_recs_rolled := DENORMALIZE(ids,property_search_recs_out,
                                      LEFT.ln_fares_id = RIGHT.ln_fares_id,
                                      GROUP,
                                      xfAddSearch(LEFT, ROWS(RIGHT)));

    layout_property_out xfAddAssessment(layout_property_out le, DATASET(layout_assessment_out) ri) :=
    TRANSFORM
      SELF.Assessment := SORT(ri, -assessed_value_year);
      SELF.assessed_value_year := MAX(ri, ri.assessed_value_year);  // for sorting assessment records
      SELF := le;
    END;

    search_assesmnt_recs := DENORMALIZE(search_recs_rolled, assessment_recs_out,
                                        LEFT.ln_fares_id = RIGHT.RawData.ln_fares_id,
                                        GROUP,
                                        xfAddAssessment(LEFT, ROWS(RIGHT)));

    layout_property_out xfAddDeed(layout_property_out le, DATASET(layout_deed_out) ri) :=
    TRANSFORM
      SELF.Deed := SORT(ri, -contract_date);
      SELF.contract_date := MAX(ri, ri.contract_date);  // for sorting deed records
      SELF := le;
    END;

    prelim_recs_out := DENORMALIZE(search_assesmnt_recs, deed_recs_out,
                                    LEFT.ln_fares_id = RIGHT.RawData.ln_fares_id,
                                    GROUP,
                                    xfAddDeed(LEFT, ROWS(RIGHT)));


    recs_out := prelim_recs_out(EXISTS(Deed) OR EXISTS(Assessment));


    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(id_recs, NAMED('property_search_ids')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(property_search_suppressed_recs, NAMED('property_search_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(property_search_override_recs, NAMED('property_search_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(property_search_payload_recs, NAMED('property_search_payload_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(property_search_recs_out, NAMED('property_search_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(assessment_suppressed_recs, NAMED('assessment_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(assessment_override_recs, NAMED('assessment_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(assessment_payload_recs, NAMED('assessment_payload_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(assessment_recs_out, NAMED('assessment_recs_out')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(deed_suppressed_recs, NAMED('deed_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(deed_override_recs, NAMED('deed_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(deed_payload_recs, NAMED('deed_payload_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(deed_recs_out, NAMED('deed_recs_out')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(recs_out, NAMED('property_combined_recs')));

    RETURN recs_out;
  END;

  EXPORT GetData(
    DATASET(doxie.layout_references) in_dids,
    DATASET($.Layouts.address_rec) in_addresses,
    DATASET (FFD.Layouts.flag_ext_rec) flag_file,
    DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
    $.IParams.IParam in_mod) :=
  FUNCTION

    owner_id_recs := GetFareIdByDid(in_dids);  // fare ids for subject owned properties
    residence_id_recs := GetFareIdByAddress(in_addresses);  // fare ids by subject residence
    combined_id_recs := DEDUP(SORT(owner_id_recs+residence_id_recs,ln_fares_id,s_did,-isOwnedBySubject),ln_fares_id,s_did);  // if duplicates keep fares id owned by subject
    all_properties := GetPropertiesByFareId(combined_id_recs,flag_file,slim_pc_recs,in_mod);

    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(owner_id_recs, NAMED('property_owner_id_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(residence_id_recs, NAMED('property_residence_id_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProperties, OUTPUT(combined_id_recs, NAMED('property_combined_id_recs')));

    RETURN all_properties;
  END;
END;
