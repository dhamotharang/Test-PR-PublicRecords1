import lib_FileServices;

export	dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache)	fOutputNewCacheFiles(dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache) pCacheCandidates, AID.Common.xFlags pReturnValues)
 :=
  function
		string	lUniqueDateTimeSignature	:=	workunit + '_' + Common.fGetDateTimeString();

		/**************************************************************************************
		** This section is to produce a single-record dataset to use for signature in filenames
		**   later, as it is apparently the only way to get a "constant" per run
		**************************************************************************************/
		rCommonUniqueSignature
		 :=
			record,maxlength(100)
				string	UniqueSignature;
			end
		 ;
		rCommonUniqueSignature	tCommonUniqueSignature(rCommonUniqueSignature pInput)
		 :=
			transform
				self.UniqueSignature	:=	lUniqueDateTimeSignature;
			end
		 ;
		dCommonUniqueSignature	:=	project(dataset([{(string)random()}],rCommonUniqueSignature),tCommonUniqueSignature(left));	// random() prevents common-up of multiples

		/**************************************************************************************/
		Layouts.rRawCache	tGetRawCache(pCacheCandidates pInput)
		 :=
			transform
				self		:=	pInput.rAidWork_RawCache;
			end
		 ;

		Layouts.rStdCache	tGetStdCache(pCacheCandidates pInput)
		 :=
			transform
				self		:=	pInput.rAidWork_StdCache;
			end
		 ;

		Layouts.rACECache	tGetACECache(pCacheCandidates pInput)
		 :=
			transform
				self		:=	pInput.rAidWork_ACECache;
			end
		 ;

		Layouts.rRawCacheUpdate	tGetRawCacheUpdate(pCacheCandidates pInput)
		 :=
			transform
				self		:=	pInput.rAidWork_RawCache;
			end
		 ;

		Layouts.rStdCacheUpdate	tGetStdCacheUpdate(pCacheCandidates pInput)
		 :=
			transform
				self		:=	pInput.rAidWork_StdCache;
			end
		 ;

		Layouts.rACECacheUpdate	tGetACECacheUpdate(pCacheCandidates pInput)
		 :=
			transform
				self		:=	pInput.rAidWork_ACECache;
			end
		 ;

		/**************************************************************************************/
		dFullNotInRawCache			:=	pCacheCandidates(not AIDWork_IsInRawCache and AIDWork_RecordID = AIDWork_RawStructSameAsRecordID and (rAIDWork_RawCache.Flags & Common.eFlags.RawNormalized = 0));
		dFullNotInStdCache			:=	pCacheCandidates(not AIDWork_IsInStdCache and AIDWork_RecordID = AIDWork_StdStructSameAsRecordID and (rAIDWork_RawCache.Flags & Common.eFlags.StdNormalized = 0));
		dFullNotInACECache			:=	pCacheCandidates(not AIDWork_IsInACECache and AIDWork_RecordID = AIDWork_ACEStructSameAsRecordID and (rAIDWork_RawCache.Flags & Common.eFlags.ACENormalized = 0));
		dFullIsInRawCache				:=	pCacheCandidates(AIDWork_IsInRawCache and AIDWork_RecordID = AIDWork_RawStructSameAsRecordID and (rAIDWork_RawCache.Flags & Common.eFlags.RawNormalized = 0));
		dFullIsInStdCache				:=	pCacheCandidates(AIDWork_IsInStdCache and AIDWork_RecordID = AIDWork_StdStructSameAsRecordID and (rAIDWork_RawCache.Flags & Common.eFlags.StdNormalized = 0));
		dFullIsInACECache				:=	pCacheCandidates(AIDWork_IsInACECache and AIDWork_RecordID = AIDWork_ACEStructSameAsRecordID and (rAIDWork_RawCache.Flags & Common.eFlags.ACENormalized = 0));
		
		/**************************************************************************************/
		dRawCacheNewRecords			:=	project(dFullNotInRawCache,tGetRawCache(left));
		dStdCacheNewRecords			:=	project(dFullNotInStdCache,tGetStdCache(left));
		dACECacheNewRecords			:=	project(dFullNotInACECache,tGetACECache(left));
		dRawCacheUpdateRecords	:=	project(dFullIsInRawCache,tGetRawCacheUpdate(left));
		dStdCacheUpdateRecords	:=	project(dFullIsInStdCache,tGetStdCacheUpdate(left));
		dACECacheUpdateRecords	:=	project(dFullIsInACECache,tGetACECacheUpdate(left));

		/**************************************************************************************/
		zOutputNewRaw						:=	output(dRawCacheNewRecords(aid<>0),	,'~' + Common.eFileName.fConstruct(Common.eAddressType.Raw,	Common.eFileName.ActivityType.New,		dCommonUniqueSignature[1].UniqueSignature),__compressed__);
		zOutputNewStd						:=	output(dStdCacheNewRecords(aid<>0),	,'~' + Common.eFileName.fConstruct(Common.eAddressType.Std,	Common.eFileName.ActivityType.New,		dCommonUniqueSignature[1].UniqueSignature),__compressed__);
		zOutputNewClean					:=	output(dACECacheNewRecords(aid<>0),	,'~' + Common.eFileName.fConstruct(Common.eAddressType.ACE,	Common.eFileName.ActivityType.New,		dCommonUniqueSignature[1].UniqueSignature),__compressed__);
		zOutputUpdateRaw				:=	output(dRawCacheUpdateRecords,				,'~' + Common.eFileName.fConstruct(Common.eAddressType.Raw,	Common.eFileName.ActivityType.Update,	dCommonUniqueSignature[1].UniqueSignature),__compressed__);
		zOutputUpdateStd				:=	output(dStdCacheUpdateRecords,				,'~' + Common.eFileName.fConstruct(Common.eAddressType.Std,	Common.eFileName.ActivityType.Update,	dCommonUniqueSignature[1].UniqueSignature),__compressed__);
		zOutputUpdateClean			:=	output(dACECacheUpdateRecords,				,'~' + Common.eFileName.fConstruct(Common.eAddressType.ACE,	Common.eFileName.ActivityType.Update,	dCommonUniqueSignature[1].UniqueSignature),__compressed__);

		/**************************************************************************************/
		zOutputNewRawCount			:=	output(count(dRawCacheNewRecords(aid<>0)), named('NewRawCount'),OVERWRITE);
		zOutputNewStdCount			:=	output(count(dStdCacheNewRecords(aid<>0)), named('NewStdCount'),OVERWRITE);
		zOutputNewCleanCount		:=	output(count(dACECacheNewRecords(aid<>0)), named('NewACECount'),OVERWRITE);

		/**************************************************************************************
		** This is the side-effect we need
		**************************************************************************************/
		zSideEffect	:=	if(pReturnValues & AID.Common.eReturnValues.NoNewCacheFiles <> 0,
											 parallel(zOutputNewRawCount, zOutputNewStdCount, zOutputNewCleanCount),
											 parallel(zOutputNewRaw,zOutputNewStd,zOutputNewClean,zOutputUpdateRaw,zOutputUpdateStd,zOutputUpdateClean)
											);
		
		return	when(pCacheCandidates, zSideEffect);
  end
 ;
