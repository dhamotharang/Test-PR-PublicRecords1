EXPORT fBuild_History := MODULE;

// EXPORT BuildVersionRecord := RECORD
  // STRING8 VersionNumber;
// END;

// SHARED FlagFileName := '~wwtm::out::TMX_build_flag';

//------------------------------------------------------------------------------------------------------------
EXPORT getLastVersion (string pversion = '', boolean pUseProd = false, boolean pIsFull = false) := FUNCTION

    ds_BuildVersion := 
      dataset
      (
          INQL_TMX.Filenames(pversion, pUseProd, pIsFull).buildFlagFile, 
          INQL_TMX.layouts.BuildVersionRecord, 
          flat, opt
      );
      
    lastBuildInfo := ds_BuildVersion[1];
    
    return lastBuildInfo;

END;

EXPORT updateVersionHistoryFile
(
    DATASET(INQL_TMX.layouts.BuildVersionRecord) pBuildVersionHistory,
    string   pNewProdVer, 
    boolean  pUseProd = false, 
    boolean  pIsFull = false

) := FUNCTION

    return OUTPUT(pBuildVersionHistory,, INQL_TMX.Filenames(pNewProdVer, pUseProd, pIsFull).buildHistoryFlagFile, OVERWRITE);

END;

//------------------------------------------------------------------------------------------------------------
EXPORT updateVersion 
(
    string   pNewProdVer, 
    boolean  pUseProd = false, 
    boolean  pIsFull = false,
    string   pLatestRowDateTime,
    string   pLatestRowRecID

) := FUNCTION

  SHARED ds_NextBuildVersion := 
    DATASET
    (
        [{
            INQL_TMX.fDate_Time.fGetDateTimeString(), 
            pNewProdVer, 
            pUseProd, 
            pIsFull, 
            pLatestRowDateTime, 
            pLatestRowRecID
        }], 
        INQL_TMX.layouts.BuildVersionRecord
    );

    OUTPUT(ds_NextBuildVersion,, INQL_TMX.Filenames(pNewProdVer, pUseProd, pIsFull).buildFlagFile, OVERWRITE);

    // KJE - 2019_01_31 Stopped here whilst trying to "append" the new build version row to the "history" file.
    
    // ds_BuildVersionHistory := ds_NextBuildVersion + INQL_TMX.Files(pNewProdVer, pUseProd, pIsFull).flagFileHistory;
    // OUTPUT(ds_BuildVersionHistory,, INQL_TMX.Filenames(pNewProdVer, pUseProd, pIsFull).buildHistoryFlagFile);
    
    return ds_NextBuildVersion;

END;



END;