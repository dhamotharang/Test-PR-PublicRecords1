EXPORT Keys := MODULE
  SHARED WatchdogNonGlbFile := DATASET ([],AppendPersonBestInfo.Layouts.WatchdogBestRec);
  
  EXPORT WatchdogNonGlbNonBlankV2Key := INDEX(WatchdogNonGlbFile,AppendPersonBestInfo.Layouts.WatchdogBestRec,
    '~thor_data400::key::watchdog_nonglb_noneq.did_nonblank_qa');

  EXPORT WatchdogNonGlbNonBlankKey := INDEX(WatchdogNonGlbFile,AppendPersonBestInfo.Layouts.WatchdogBestRec,
    '~thor_data400::key::watchdog_nonglb.did_nonblank_qa');    
    
  EXPORT WatchdogNonGlbV2Key := INDEX(WatchdogNonGlbFile,AppendPersonBestInfo.Layouts.WatchdogBestRec,
    '~thor_data400::key::watchdog_nonglb_noneq.did_qa');

  EXPORT WatchdogNonGlbKey := INDEX(WatchdogNonGlbFile,AppendPersonBestInfo.Layouts.WatchdogBestRec,
    '~thor_data400::key::watchdog_nonglb.did_qa');
    
  EXPORT MinorsHashKey := INDEX(DATASET([],AppendPersonBestInfo.Layouts.MinorsHashRec),AppendPersonBestInfo.Layouts.MinorsHashRec,
    '~thor_data400::key::header.minors_hash_qa');
END;