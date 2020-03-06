IMPORT  STD, versioncontrol, tools, Data_Services, HealthcareNoMatchHeader_InternalLinking;
EXPORT  Filenames(  STRING	  pSrc        = '',
                    STRING    pVersion    = '',
                    BOOLEAN	  pUseProd    = FALSE) :=  MODULE

  EXPORT  pThreshold  :=  HealthcareNoMatchHeader_InternalLinking.Config.MatchThreshold;

  //  Prefix
	EXPORT  IsBocaProd          :=  tools._Constants.IsBocaProd;
	EXPORT  foreign_environment :=  IF(pUseProd,IF(IsBocaProd,'~',Data_Services.foreign_prod),'~');
  EXPORT  cluster_name        :=  'ushc::';
	EXPORT  prefix              :=  foreign_environment + cluster_name;

	EXPORT	lInputTemplate        :=  prefix	+	'CRK::temp::' + pSrc  + '::'  + pVersion  + '::';
	EXPORT	lBaseTemplate         :=  prefix	+	'RID::HealthCareNoMatchHeader::base::' +	pSrc	+	'::@version@::';
	EXPORT	lLinkingTemplate      :=  prefix	+	'CRK::HealthCareNoMatchHeader::linking::' +	pSrc  +	'::@version@::';
	EXPORT	lPersistTemplate      :=  prefix  + 'persist::HealthCareNoMatchHeader::nomatch_id::'  + pSrc  + '::';
	EXPORT	lKeyTemplate          :=  prefix  + 'key::HealthcareNoMatchHeader::nomatch_id::' + pSrc	+	'::@version@::';
	EXPORT	lCRKTemplate          :=  prefix  + 'CRK::HealthcareNoMatchHeader::base::' + pSrc	+	'::@version@::';

	EXPORT	IngestCache           :=  lPersistTemplate+'Ingest_Cache';
  
  EXPORT  Input  :=  MODULE
    EXPORT  AsHeaderTemp  :=  lInputTemplate+'AsHeaderTemp';
    EXPORT  BaseTemp      :=  lInputTemplate+'BaseTemp';
  END;
  
  EXPORT  Base  :=  MODULE
    EXPORT  allRecords    :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate + 'AllRecords'  , pVersion);
    EXPORT  history       :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate + 'History'  , pVersion);
		EXPORT	dAll_filenames	:=
      allRecords.dAll_filenames +
      history.dAll_filenames
    ;
  END;
  
  EXPORT  append  :=  MODULE
    EXPORT  CRK    :=  versioncontrol.mBuildFilenameVersions(lCRKTemplate + 'CustomerRecordKey'  , pVersion);
		EXPORT	dAll_filenames	:=
      CRK.dAll_filenames
    ;
  END;

  EXPORT  Linking(STRING it='0') :=  MODULE
    EXPORT  getVersion  :=  pVersion + '::it' + it;
    EXPORT	Iteration   :=  versioncontrol.mBuildFilenameVersions(lLinkingTemplate  + 'iterations', getVersion);
    EXPORT	Changes     :=  versioncontrol.mBuildFilenameVersions(lLinkingTemplate  + 'changes_it', getVersion);
		EXPORT	dAll_filenames	:=
      Iteration.dAll_filenames  +
      Changes.dAll_filenames
    ;
  END;
  
  EXPORT  Keys  :=  MODULE
    EXPORT  Word_SSN        :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::SSN'  , pVersion);
    EXPORT  Word_DOB_year   :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::DOB_year'  , pVersion);
    EXPORT  Word_DOB_month  :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::DOB_month'  , pVersion);
    EXPORT  Word_DOB_day    :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::DOB_day'  , pVersion);
    EXPORT  Word_LEXID      :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::LEXID'  , pVersion);
    EXPORT  Word_SUFFIX     :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::SUFFIX'  , pVersion);
    EXPORT  Word_FNAME      :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::FNAME'  , pVersion);
    EXPORT  Word_MNAME      :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::MNAME'  , pVersion);
    EXPORT  Word_LNAME      :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::LNAME'  , pVersion);
    EXPORT  Word_GENDER     :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::GENDER'  , pVersion);
    EXPORT  Word_PRIM_NAME  :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::PRIM_NAME'  , pVersion);
    EXPORT  Word_PRIM_RANGE :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::PRIM_RANGE'  , pVersion);
    EXPORT  Word_SEC_RANGE  :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::SEC_RANGE'  , pVersion);
    EXPORT  Word_CITY_NAME  :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::CITY_NAME'  , pVersion);
    EXPORT  Word_ST         :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::ST'  , pVersion);
    EXPORT  Word_ZIP        :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::ZIP'  , pVersion);
    EXPORT  Word_DT_FIRST_SEEN  :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::DT_FIRST_SEEN'  , pVersion);
    EXPORT  Word_DT_LAST_SEEN   :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::DT_LAST_SEEN'  , pVersion);
    EXPORT  Word_MAINNAME   :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::MAINNAME'  , pVersion);
    EXPORT  Word_ADDR1      :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::ADDR1'  , pVersion);
    EXPORT  Word_LOCALE     :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::LOCALE'  , pVersion);
    EXPORT  Word_ADDRESS    :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::ADDRESS'  , pVersion);
    EXPORT  Word_FULLNAME   :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::FULLNAME'  , pVersion);
    EXPORT  Word_Uber       :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Word::Uber'  , pVersion);
    EXPORT  Specificities   :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Specificities'  , pVersion);
		EXPORT	dAll_filenames	:=
      Word_SSN.dAll_filenames  +
      Word_DOB_year.dAll_filenames  +
      Word_DOB_month.dAll_filenames  +
      Word_DOB_day.dAll_filenames  +
      Word_LexID.dAll_filenames  +
      Word_Suffix.dAll_filenames  +
      Word_FName.dAll_filenames  +
      Word_MName.dAll_filenames  +
      Word_LName.dAll_filenames  +
      Word_Gender.dAll_filenames  +
      Word_PRIM_NAME.dAll_filenames  +
      Word_PRIM_RANGE.dAll_filenames  +
      Word_SEC_RANGE.dAll_filenames  +
      Word_CITY_NAME.dAll_filenames  +
      Word_ST.dAll_filenames  +
      Word_ZIP.dAll_filenames  +
      Word_DT_FIRST_SEEN.dAll_filenames  +
      Word_DT_LAST_SEEN.dAll_filenames  +
      Word_MAINNAME.dAll_filenames  +
      Word_ADDR1.dAll_filenames  +
      Word_LOCALE.dAll_filenames  +
      Word_ADDRESS.dAll_filenames  +
      Word_FULLNAME.dAll_filenames  +
      Word_Uber.dAll_filenames  +
      Specificities.dAll_filenames
    ;
  END;
  
  EXPORT  DebugKeys  :=  MODULE
    EXPORT  Debug_specificities_debug   :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Debug::specificities_debug'  , pVersion);
    EXPORT  Debug_match_sample_debug   :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Debug::match_sample_debug'  , pVersion);
    EXPORT  Datafile_patched_candidates   :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Datafile::patched_candidates'  , pVersion);
    EXPORT  Debug_match_candidates_debug   :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Debug::match_candidates_debug'  , pVersion);
    EXPORT  Debug_match_candidatesforslice_debug   :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Debug::match_candidatesforslice_debug'  , pVersion);
    EXPORT  History_Match   :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'History::Match'  , pVersion);
		EXPORT	dAll_filenames	:=
      Debug_specificities_debug.dAll_filenames  +
      Debug_match_sample_debug.dAll_filenames  +
      Datafile_patched_candidates.dAll_filenames  +
      Debug_match_candidates_debug.dAll_filenames  +
      Debug_match_candidatesforslice_debug.dAll_filenames  +
      History_Match.dAll_filenames
    ;
  END;
  
  EXPORT  ExternalKeys  :=  MODULE
    EXPORT  Meow            :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Meow'  , pVersion);
    EXPORT  Sup_RID         :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'sup::RID'  , pVersion);
    EXPORT  Refs            :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Refs'  , pVersion);
    EXPORT  Refs_NoMatch    :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Refs::NOMATCH'  , pVersion);
    EXPORT  Words           :=  versioncontrol.mBuildFilenameVersions(lKeyTemplate + 'Words'  , pVersion);
		EXPORT	dAll_filenames	:=
      Meow.dAll_filenames  +
      Sup_RID.dAll_filenames  +
      Refs.dAll_filenames  +
      Refs_NoMatch.dAll_filenames  +
      Words.dAll_filenames
    ;
  END;

	EXPORT	dAll_filenames	:=
		Base.dAll_filenames +
		Keys.dAll_filenames +
		append.dAll_filenames
	;
 
  // workman files
  EXPORT  WUPrefix              :=  prefix    + pSrc  + '::' + pVersion + '::';
  EXPORT  WUIterations          :=  'workunit_history::HealthcareNotMatchHeader.iterations.';
  EXPORT  MasterWUOutput_SF     :=  WUPrefix  + 'HealthcareNotMatchHeader::qa::workunit_history';
  EXPORT  MasterWUOutput_AF     :=  PROJECT(ROW({MasterWUOutput_SF},tools.Layout_Names),
                                      TRANSFORM(tools.Layout_FilenameVersions.builds,
                                      SELF.dsuperfiles  :=  LEFT;
                                      SELF  :=  [];
                                    ));
  
  // For Cleanup
  EXPORT  dAllSuperFiles    :=  
            dAll_filenames+
            Linking().dAll_filenames+
            DebugKeys.dAll_filenames+
            ExternalKeys.dAll_filenames+
            MasterWUOutput_AF;
            
  EXPORT  dAllLogicalFiles  :=  
            PROJECT(
              STD.File.LogicalFileList(Input.AsHeaderTemp[2..])+
              STD.File.LogicalFileList(Input.BaseTemp[2..])+
              STD.File.LogicalFileList(lPersistTemplate[2..]+pVersion+'*')+
              STD.File.LogicalFileList(IngestCache[2..])+
              //  Linking files may be hanging around after removing from multiple Superfiles
              STD.File.LogicalFileList(Linking('*').Iteration.New[2..])+
              STD.File.LogicalFileList(Linking('*').Changes.New[2..])+
              //  Workman files
              STD.File.LogicalFileList(WUPrefix[2..] + WUIterations + '*')+
              //  Add logical file names from Superfiles because not all files are added to Superfiles in SALT generated code
              PROJECT(dAllSuperFiles(logicalname<>''),TRANSFORM(STD.File.FsLogicalFileInfoRecord,SELF.name:=LEFT.logicalname;SELF:=[])),
              //  Add tilde(~) to name field because the Tools require it
              TRANSFORM(
                STD.File.FsLogicalFileInfoRecord,
                SELF.name :=  IF(LEFT.name[1]<>'~','~','')+LEFT.name;
                SELF      :=  LEFT
              )
            );
            
END;
