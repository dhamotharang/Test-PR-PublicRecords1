
EXPORT modFilenames(STRING inPrefix = '') := MODULE

// common module for generating file filename
EXPORT filename(STRING prefix) := MODULE
  EXPORT base         := TRIM(prefix);
 
  // superfiles
  EXPORT current      := TRIM(prefix) + 'current';
  EXPORT father       := TRIM(prefix) + 'father';
  EXPORT grandfather  := TRIM(prefix) + 'grandfather';
  EXPORT archive      := TRIM(prefix) + 'archive';
 
  // logical files
  EXPORT logical(STRING version, STRING wu = '', STRING iter = '') :=  prefix + TRIM(version) + IF(TRIM(iter) > '', '_' + TRIM(iter), '') + IF(TRIM(wu) > '', '_' + TRIM(wu), '');
END;
 

headerEnvSuffix := '';

  //Change some filename to match your data. -ZRS 4/8/2019    
  EXPORT sFilePrefix                            := if(inPrefix = '', '~thor::BizLinkFull'+headerEnvSuffix+'::ELERT::', inPrefix);
  EXPORT sPrefixFileSamples                     := sFilePrefix + 'Samples::'; 
  EXPORT sPrefixOrigFileSamples                 := sPrefixFileSamples + 'OrigRun::'; 
  EXPORT sPrefixNewFileSamples                  := sPrefixFileSamples + 'NewRun::'; 
  EXPORT sPrefixStats                           := sPrefixFileSamples + 'Stats::'; 
  EXPORT sPrefixMasterWUOutput                  := sFilePrefix + 'WUInfo::'; 
  EXPORT kSamplesSF                             := filename(sPrefixFileSamples);
  EXPORT kOrigRunResultsSF                      := filename(sPrefixOrigFileSamples);
  EXPORT kNewRunResultsSF                       := filename(sPrefixNewFileSamples);
  EXPORT kStatsSF                               := filename(sPrefixStats);
  
  EXPORT kSamplesLF(STRING sVersion)            := filename(sPrefixFileSamples).logical(sVersion);
  EXPORT kOrigRunResultLF(STRING sVersion)      := filename(sPrefixOrigFileSamples).logical(sVersion);
  EXPORT kNewRunResultsLF(STRING sVersion)      := filename(sPrefixNewFileSamples).logical(sVersion);
  EXPORT kStatsLF(STRING sVersion)              := filename(sPrefixStats).logical(sVersion);
  
  EXPORT kMasterWUOutput_SF                     := filename(sPrefixMasterWUOutput);
END;
