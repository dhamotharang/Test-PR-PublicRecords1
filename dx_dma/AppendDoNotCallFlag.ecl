  /*
    **
    ** Macro to flag input records with Do Not Call.
    ** This automatically applies the necessary incremental rollups to the DNC key.
    **
    ** @param inf                    Input dataset, must contain phone number field.
    ** @param inf_phone_field        Field to use as phone number for input. OPTIONAL, defaults to 'phonenumber'
    ** @returns                      Input records with `do_not_call_flag` appended. Will populate with 'Y' if flagged.
    **
  */

EXPORT AppendDoNotCallFlag(inf, inf_phone_field = 'phonenumber') := FUNCTIONMACRO
  IMPORT dx_common, DMA;

  // Add flag field to return layout if it doesn't exist.
  rec_flagged := RECORD STRING1 do_not_call_flag; END;
  LOCAL return_layout := RECORDOF(inf) OR rec_flagged;

  key_recs := JOIN(inf, DMA.key_DNC_Phone,
    KEYED(LEFT.inf_phone_field = RIGHT.PhoneNumber),
    TRANSFORM(RIGHT), ATMOST(100)); // Allows up to 100 changes per phone number prior to each full file build.

  rolled_key_recs := dx_common.Incrementals.mac_Rollup(key_recs, rid_field := phonenumber);
  flagged_input := JOIN(inf, rolled_key_recs,
    LEFT.inf_phone_field = RIGHT.phonenumber,
    TRANSFORM(return_layout,
      SELF.do_not_call_flag := IF(RIGHT.phonenumber = '', '', 'Y'),
      SELF := LEFT),
    LEFT OUTER, KEEP(1));

  RETURN flagged_input;
ENDMACRO;
