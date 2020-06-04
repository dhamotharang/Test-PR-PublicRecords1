EXPORT macGetGlobalSid(dInFile, sdata_set, sFieldName='', sGlobalSid='global_sid') := FUNCTIONMACRO

  IMPORT _control, MDR, STD;

  // Parameters to pass to this macro:
  // dInFile = The dataset to have it's Global_SID populated by this macro (dataset)
  // sdata_set = The name of the Roxie Package the dataset refers to (must be a constant)
  // sFieldName = The name of the field on the passed dataset that contains the Source Code, it can be a substring like sfield[1..] (must be a constant)
  // sGlobalSid = The name of the field on the passed dataset that will receive the Global SID, usually 'global_sid' (must be a constant)

  dDataGlobalSid := MDR.File_Global_SID.lookupTable;

  dFilterGSidFile := dDataGlobalSid(STD.Str.ToUpperCase(data_set) = STD.Str.ToUpperCase(sdata_set));

  aCheckDatasetEntry := IF(EXISTS(dFilterGSidFile) = FALSE, FAIL(' Dataset entry not found on lookup table, check dataset name on passed parameter '))
  : FAILURE(STD.System.Email.SendEmail(_control.MyInfo.EmailAddressNotify,
      '***FAILURE:DATASET ENTRY NOT FOUND ' + sdata_set + ' - ' + WORKUNIT,
      WORKUNIT + ' has failed. DATASET ENTRY not found for the sdata_set ' + sdata_set + ' provided. Please check workunit - '+ FAILMESSAGE));

  tGlobalSrcID := SORT(TABLE(dFilterGSidFile, {source_codes, global_sid, cnt:=COUNT(GROUP)}, source_codes, global_sid),-cnt, source_codes, global_sid);
  aCheckDatasetDups := IF(tGlobalSrcID[1].cnt > 1 AND tGlobalSrcID[1].global_sid != 0, STD.System.Log.addWorkunitWarning('***WARNING:Duplicate GLB_SRCID for Dataset ' + sdata_set));

  lInRec := {RECORDOF(dInFile)};

  lInRec xGlobalSidJ(dInFile l, dFilterGSidFile r) := TRANSFORM
    SELF.#EXPAND(sGlobalSid) := r.global_sid;
    SELF := l;
  END;

  lInRec xGlobalSidP(dInFile l) := TRANSFORM
    SELF.#EXPAND(sGlobalSid) := dFilterGSidFile[1].global_sid;
    SELF := l;
  END;

  dOutFile := 
  #IF(SFieldName <> '')
    JOIN(dInFile,dFilterGSidFile,
      STD.Str.ToUpperCase((STRING)LEFT.#EXPAND(sFieldName)) = STD.Str.ToUpperCase(RIGHT.source_codes),
      xGlobalSidJ(LEFT, RIGHT), 
      ALL, LEFT OUTER);
  #ELSE
    PROJECT(dInFile,xGlobalSidP(LEFT));
  #END;

  ORDERED(aCheckDatasetEntry, aCheckDatasetDups);

  RETURN dOutFile;

ENDMACRO;