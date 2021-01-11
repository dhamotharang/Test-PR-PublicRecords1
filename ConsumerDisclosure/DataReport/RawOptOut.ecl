/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, doxie, dx_common, dx_fcra_opt_out;

  layout_OptOut_raw := dx_fcra_opt_out.layouts.i_did;
  layout_OptOut_rawrec := RECORD(layout_OptOut_raw)
    $.Layouts.InternalMetadata;
  END;

EXPORT RawOptOut := MODULE

  EXPORT layout_OptOut_out := RECORD($.Layouts.Metadata)
    layout_OptOut_raw;
  END;

  // no overrides exist for this data source, only payload is disclosed
  EXPORT GetData(DATASET(doxie.layout_references) in_dids) :=
  FUNCTION

    main_recs := JOIN(in_dids, dx_fcra_opt_out.key_did,
                          KEYED(LEFT.did = RIGHT.l_did),
                          TRANSFORM(layout_OptOut_rawrec,
                                    SELF.subject_did := LEFT.did,
                                    SELF.Record_Ids.RecId1 := (STRING)RIGHT.l_did, //should we keep it blank?
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxOptOutPerDID));


    recs_out := PROJECT(main_recs, TRANSFORM(layout_OptOut_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_ids,
                                                LEFT.subject_did,
                                                '');  // no datagroup
                        SELF := LEFT;
                        ));

    // IF(ConsumerDisclosure.Debug,OUTPUT(main_recs, NAMED('OptOut_main_recs')));

    RETURN SORT(recs_out, -date_YYYYMMDD, -julian_date, RECORD);
  END;

END;
