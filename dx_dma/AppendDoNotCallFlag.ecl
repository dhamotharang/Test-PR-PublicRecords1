  /*
    **
    ** Macro to flag input records with Do Not Call.
    ** This automatically applies the necessary incremental rollups to the DNC key.
    **
    ** @param inf                    Input dataset, must contain phone number field.
    ** @param inf_phone_field        Field to use as phone number for input. OPTIONAL, defaults to 'phonenumber'
    ** @param flag_empty             Boolean, if TRUE will flag empty strings with 'Y'. OPTIONAL, defaults to FALSE.
    **  flag_empty was implemented to preserve existing behavior in execathomev2.eah_batch_service that was flagging empty strings. RQ-23051
    ** @returns                      Input records with `do_not_call_flag` appended. Will populate with 'Y' if flagged.
    **
  */

EXPORT AppendDoNotCallFlag(inf, inf_phone_field = 'phonenumber', flag_empty = 'FALSE') := FUNCTIONMACRO
  IMPORT dx_common, DMA;

  // Add flag field to return layout if it doesn't exist.
  LOCAL rec_flagged := RECORD STRING1 do_not_call_flag; END;
  LOCAL return_layout := RECORDOF(inf) OR rec_flagged;

  LOCAL ddinf := DEDUP(SORT(inf(inf_phone_field != ''), inf_phone_field), inf_phone_field);

  LOCAL key_recs := JOIN(ddinf, DMA.key_DNC_Phone,
    KEYED(LEFT.inf_phone_field = RIGHT.PhoneNumber),
    TRANSFORM(RIGHT), ATMOST(100)); // Allows up to 100 changes per phone number prior to each full file build.

  LOCAL rolled_key_recs := dx_common.Incrementals.mac_Rollup(key_recs, rid_field := phonenumber);
  LOCAL flagged_input := JOIN(inf, rolled_key_recs,
    LEFT.inf_phone_field = RIGHT.phonenumber,
    TRANSFORM(return_layout,
      should_flag := RIGHT.phonenumber != '' OR (flag_empty AND LEFT.inf_phone_field = '');
      SELF.do_not_call_flag := IF(should_flag, 'Y', '');
      SELF := LEFT),
    LEFT OUTER, KEEP(1));

  RETURN flagged_input;
ENDMACRO;
