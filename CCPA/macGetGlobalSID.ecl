IMPORT CCPA, STD;

EXPORT macGetGlobalSid(dInFile, sRoxiePackage, sFieldName='', sGlobalSid='global_sid') := FUNCTIONMACRO

  // Parameters to pass to this macro:
  // dInFile = The dataset to have it's Global_SID populated by this macro (dataset)
  // sRoxiePackage = The name of the Roxie Package the dataset refers to (must be a constant)
  // sFieldName = The name of the field on the passed dataset that contains the Source Code, it can be a substring like sfield[1..] (must be a constant)
  // sGlobalSid = The name of the field on the passed dataset that will receive the Global SID, usually 'global_sid' (must be a constant)

  dDataGlobalSid := CCPA.File_Global_SID.lookupTable;

  dFilterGSidFile := dDataGlobalSid(STD.Str.ToUpperCase(roxie_packages) = STD.Str.ToUpperCase(sRoxiePackage));

  aCheckDatasetEntry := IF(EXISTS(dFilterGSidFile) = FALSE, FAIL(' DATASET ENTRY NOT FOUND '))
    : FAILURE(STD.System.Email.SendEmail(_control.MyInfo.EmailAddressNotify,
      '***FAILURE:DATASET ENTRY NOT FOUND ' + sRoxiePackage + ' - ' + WORKUNIT,
      WORKUNIT + ' has failed. DATASET ENTRY not found for the sRoxiePackage ' + sRoxiePackage + ' provided. Please check workunit - '+ FAILMESSAGE));

  lInRec := {RECORDOF(dInFile)};

  #DECLARE(sFilter);
  #SET(sFilter, '');   
  #IF(sFieldName <> '')
    #APPEND(sFilter, '(source_codes = (STRING)l.' + #TEXT(#EXPAND(sFieldName)) + ')')
  #END

  fFilterGlbSrcid (lInRec l) := FUNCTION
    sGlbSrcid := dFilterGSidFile #IF(SFieldName <> '')#EXPAND(#TEXT(%sFilter%))#END;
    tGlobalSrcID := TABLE(sGlbSrcid, {global_sid, cnt:=COUNT(GROUP)},global_sid);

    aCheckDatasetDups := IF(tGlobalSrcID[1].cnt > 1 AND tGlobalSrcID[1].global_sid != '', STD.System.Log.addWorkunitWarning('***WARNING:Duplicate GLB_SRCID for Dataset ' + sRoxiePackage));
    aCheckGlobalSRCID := IF(tGlobalSrcID[1].cnt = 1 AND tGlobalSrcID[1].global_sid = '', STD.System.Log.addWorkunitWarning('***WARNING:GLB_SRCID IS BLANK for Dataset ' + sRoxiePackage)); 

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