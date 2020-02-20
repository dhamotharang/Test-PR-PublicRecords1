EXPORT macGetGlobalSid(dInFile, sdata_set, sFieldName='', sGlobalSid='global_sid') := FUNCTIONMACRO

IMPORT _control, MDR, STD;

  // Parameters to pass to this macro:
  // dInFile = The dataset to have it's Global_SID populated by this macro (dataset)
  // sdata_set = The name of the Roxie Package the dataset refers to (must be a constant)
  // sFieldName = The name of the field on the passed dataset that contains the Source Code, it can be a substring like sfield[1..] (must be a constant)
  // sGlobalSid = The name of the field on the passed dataset that will receive the Global SID, usually 'global_sid' (must be a constant)

  dDataGlobalSid := MDR.File_Global_SID.lookupTable;

  dFilterGSidFile := dDataGlobalSid(STD.Str.ToUpperCase(data_set) = STD.Str.ToUpperCase(sdata_set));

  aCheckDatasetEntry := IF(EXISTS(dFilterGSidFile) = FALSE, FAIL(' DATASET ENTRY NOT FOUND '))
    : FAILURE(STD.System.Email.SendEmail(_control.MyInfo.EmailAddressNotify,
      '***FAILURE:DATASET ENTRY NOT FOUND ' + sdata_set + ' - ' + WORKUNIT,
      WORKUNIT + ' has failed. DATASET ENTRY not found for the sdata_set ' + sdata_set + ' provided. Please check workunit - '+ FAILMESSAGE));

  lInRec := {RECORDOF(dInFile)};

  #DECLARE(sFilter);
  #SET(sFilter, '');   
  #IF(sFieldName <> '')
    #APPEND(sFilter, '(source_codes = (STRING)l.' + #TEXT(#EXPAND(sFieldName)) + ')')
  #END

  fFilterGlbSrcid (lInRec l) := FUNCTION
    sGlbSrcid := dFilterGSidFile #IF(SFieldName <> '')#EXPAND(#TEXT(%sFilter%))#END;
    tGlobalSrcID := TABLE(sGlbSrcid, {global_sid, cnt:=COUNT(GROUP)},global_sid);

    aCheckDatasetDups := IF(tGlobalSrcID[1].cnt > 1 AND tGlobalSrcID[1].global_sid != 0, STD.System.Log.addWorkunitWarning('***WARNING:Duplicate GLB_SRCID for Dataset ' + sdata_set));
    aCheckGlobalSRCID := IF(tGlobalSrcID[1].cnt = 1 AND tGlobalSrcID[1].global_sid = 0, STD.System.Log.addWorkunitWarning('***WARNING:GLB_SRCID IS BLANK for Dataset ' + sdata_set)); 

    ORDERED(aCheckDatasetDups,aCheckGlobalSRCID);

    RETURN tGlobalSrcID[1].global_sid;
  END;

  lInRec xGlobalSid(dInFile l) := TRANSFORM
    SELF.#EXPAND(sGlobalSid) := (UNSIGNED4)fFilterGlbSrcid(l);
    SELF := l;
  END;

  dOutFile := PROJECT(dInFile,xGlobalSid(LEFT));

  ORDERED(aCheckDatasetEntry);

  RETURN dOutFile;

ENDMACRO;
