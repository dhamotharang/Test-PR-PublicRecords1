EXPORT MAC_AttributeFileDiffs(af_prev, af_new, basis_csv, dt_first, dt_last, dt_resolution, did_field, out_payloaddiff, af_specprev = '', af_specnew = '', out_specdiff = '') := MACRO
  IMPORT SALT311;
  #UNIQUENAME(diffPayloadRecs)
  %diffPayloadRecs% := SALT311.MAC_PoisonRecords(af_prev, af_new, basis_csv + ',' + TRIM(#TEXT(did_field)), dt_first, dt_last, dt_resolution);
  SHARED out_payloaddiff := %diffPayloadRecs%;
 
  #UNIQUENAME(joinToPrevSpec)
  #UNIQUENAME(joinToNewSpec)
  #UNIQUENAME(joinCondition)
  #UNIQUENAME(recJoinSpec)
  #IF (TRIM(#TEXT(af_specprev)) > '' AND TRIM(#TEXT(af_specnew)) > '' AND TRIM(#TEXT(out_specdiff)) > '')
    %joinCondition% := SALT311.fn_CSVToJoinCondition(basis_csv + ',' + TRIM(#TEXT(did_field)));
    %recJoinSpec% := RECORD
      RECORDOF(af_specprev);
      af_prev.dt_first;
      af_prev.dt_last;
    END;
    %joinToPrevSpec% := JOIN(out_payloaddiff(dt_last <> 0), PULL(af_specprev), #EXPAND(%joinCondition%), TRANSFORM(%recJoinSpec%, SELF := RIGHT, SELF := LEFT));
    %joinToNewSpec% := JOIN(out_payloaddiff(dt_last = 0), PULL(af_specnew), #EXPAND(%joinCondition%), TRANSFORM(%recJoinSpec%, SELF := RIGHT, SELF := LEFT));
    SHARED out_specdiff := %joinToPrevSpec% & %joinToNewSpec%;
  #END;
ENDMACRO;
