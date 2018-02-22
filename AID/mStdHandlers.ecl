export mStdHandlers
 :=
  module
		import lib_StringLib, lib_FileServices, ut, lib_ThorLib, std;

		shared	lCurrentDate	:=	(STRING8)Std.Date.Today() : global;	// just to prevent the transforms from calling the function for every record in any transforms below

		/**************************************************************************************
		 ** Append Std Cache record from records in RawCache with StdAID
		 **************************************************************************************/
		shared	dataset(Layouts.rRawSlimSeqRawCacheStdCache)	fAppendStdCacheFromRawStdAID(dataset(Layouts.rRawSlimSeqRawCache) pDatasetIn)
		 :=
			function
				dStdMasterDist					:=	Files.StdCacheProdDist_AID;
				dStdMasterDistSort			:=	sort(dStdMasterDist,AID,local);

				Layouts.rRawSlimSeqRawCacheStdCache tRawCacheInAddedStdCache(pDatasetIn pInput)
				 :=
					transform
						self.rAIDWork_StdCache								:=	[];
						self.AIDWork_IsInStdCache							:=	false;
						self.AIDWork_StdStructSameAsRecordID	:=	pInput.AIDWork_RecordID;
						self																	:=	pInput;
					end
				 ;
				dRawCacheInAddedStdCache									:=	project(pDatasetIn,tRawCacheInAddedStdCache(left));				// to allow for splitting and re-concat later

				dRawCacheInAddedStdCacheNoStdAID					:=	dRawCacheInAddedStdCache(rAIDWork_RawCache.StdAID = 0);			// to concat after join
				dRawCacheInAddedStdCacheStdAID						:=	dRawCacheInAddedStdCache(rAIDWork_RawCache.StdAID <> 0);
				dRawCacheInAddedStdCacheStdAIDDist				:=	distribute(dRawCacheInAddedStdCacheStdAID,hash(	rAIDWork_RawCache.StdAID));
				dRawCacheInAddedStdCacheStdAIDDistSort		:=	sort(dRawCacheInAddedStdCacheStdAIDDist,		rAIDWork_RawCache.StdAID,local);
				Layouts.rRawSlimSeqRawCacheStdCache tRawCacheInStdAIDAppended(dRawCacheInAddedStdCacheStdAIDDistSort pRawCacheIn, dStdMasterDistSort pStdMaster)
				 :=
					transform
						boolean	lIsInStdCache									:=	pStdMaster.AID <> 0;	// Boolean...  if true, it was found in the cache.  Otherwise, it will be new.
						self.AIDWork_IsInStdCache							:=	lIsInStdCache;
						self.AIDWork_StdStructSameAsRecordID	:=	pRawCacheIn.AIDWork_RecordID;
						self.rAIDWork_StdCache.AddressType		:=	Common.eAddressType.Std;
						self.rAIDWork_StdCache.AID						:=	pStdMaster.AID;
						self.rAIDWork_StdCache.DateSeenFirst	:=	pStdMaster.DateSeenFirst;
						self.rAIDWork_StdCache.DateSeenLast		:=	pStdMaster.DateSeenLast;
						self.rAIDWork_StdCache.CleanAID				:=	pStdMaster.CleanAID;
						self.rAIDWork_StdCache.ReturnCode			:=	pStdMaster.ReturnCode;
						self.rAIDWork_StdCache.DateValidFirst	:=	pStdMaster.DateValidFirst;
						self.rAIDWork_StdCache.DateValidLast	:=	pStdMaster.DateValidLast;
						self.rAIDWork_StdCache.DateErrorFirst	:=	pStdMaster.DateErrorFirst;
						self.rAIDWork_StdCache.DateErrorLast	:=	pStdMaster.DateErrorLast;
						self.rAIDWork_StdCache.DateCleanLast	:=	pStdMaster.DateCleanLast;
						self.rAIDWork_StdCache.Line1					:=	pStdMaster.Line1;
						self.rAIDWork_StdCache.LineLast				:=	pStdMaster.LineLast;
						self.rAIDWork_StdCache.Hash32_Full		:=	pStdMaster.Hash32_Full;
						self.rAIDWORK_StdCache.CountSeen			:=	1;
						self.rAIDWork_StdCache.ReferAID				:=	pStdMaster.ReferAID;
						self.rAIDWork_StdCache.Cleaner				:=	pStdMaster.Cleaner;
						self       														:=	pRawCacheIn;
					end
				 ;
				dRawCacheInStdAIDAppended	:=	join(dRawCacheInAddedStdCacheStdAIDDistSort,dStdMasterDistSort,
																					 left.rAIDWork_RawCache.StdAID = right.AID,
																					 tRawCacheInStdAIDAppended(left,right),
																					 left outer,	// defend against lost Raw.StdAID -> Std.AID links;
																					 nosort,
																					 local
																					);
				dAppendStdCacheFromRawStdAID	:=	dRawCacheInStdAIDAppended + dRawCacheInAddedStdCacheNoStdAID;
				return	dAppendStdCacheFromRawStdAID;
			end
		 ;

		/**************************************************************************************
		 ** Append Std Cache record with Standardized version of Raw Line1,Line2 (unknown StdAID at this point)
		 **************************************************************************************/
		shared	dataset(Layouts.rRawSlimSeqRawCacheStdCache)	fPrimeStdAddressFromRawStruct(dataset(Layouts.rRawSlimSeqRawCacheStdCache) pDatasetIn)
		 :=
			function
				Layouts.rRawSlimSeqRawCacheStdCache tPrimeStdAddressFromRawStruct(pDatasetIn pInput, integer pCounter)
				 :=
					transform
						typeof(Layouts.rStdCache.Line1)						lPrePOBPart			:=	mRawStructToStd(pInput.rAIDWork_RawStruct.Line1, pInput.rAIDWork_RawStruct.Line2, pInput.rAIDWork_RawStruct.Line3, pInput.rAIDWork_RawStruct.LineLast).fPrePOBPart;
						typeof(Layouts.rStdCache.Line1)						lPOBPart				:=	mRawStructToStd(pInput.rAIDWork_RawStruct.Line1, pInput.rAIDWork_RawStruct.Line2, pInput.rAIDWork_RawStruct.Line3, pInput.rAIDWork_RawStruct.LineLast).fPOBPart;
						typeof(Layouts.rStdCache.Line1)						lPostPOBPart		:=	mRawStructToStd(pInput.rAIDWork_RawStruct.Line1, pInput.rAIDWork_RawStruct.Line2, pInput.rAIDWork_RawStruct.Line3, pInput.rAIDWork_RawStruct.LineLast).fPostPOBPart;
						typeof(Layouts.rStdCache.LineLast)				lLineLast				:=	mRawStructToStd(pInput.rAIDWork_RawStruct.Line1, pInput.rAIDWork_RawStruct.Line2, pInput.rAIDWork_RawStruct.Line3, pInput.rAIDWork_RawStruct.LineLast).fLineLast;
						typeof(Layouts.rRawCache.NormalizeFlags)	lNormalizeFlags	:=	mRawStructToStd(pInput.rAIDWork_RawStruct.Line1, pInput.rAIDWork_RawStruct.Line2, pInput.rAIDWork_RawStruct.Line3, pInput.rAIDWork_RawStruct.LineLast).fNormalizeFlags;
						typeof(Layouts.rRawCache.StdVersion)			lStdVersion			:=	mRawStructToStd(pInput.rAIDWork_RawStruct.Line1, pInput.rAIDWork_RawStruct.Line2, pInput.rAIDWork_RawStruct.Line3, pInput.rAIDWork_RawStruct.LineLast).fStdVersion;

						unsigned1							lIsPrePOBPart		:=	if(lPrePOBPart <> '' or (lPOBPart = '' and lPostPOBPart = ''), 1, 0);
						unsigned1							lIsPOBPart			:=	if(lPOBPart <> '', 1, 0);
						unsigned1							lIsPostPOBPart	:=	if(lPostPOBPart <> '', 1, 0);

						unsigned1							lLine1Parts			:=	lIsPrePOBPart + lIsPOBPart + lIsPostPOBPart;
						self.AIDWork_IsInStdCache							:=	case(pCounter,
																													 1	=>	if(lIsPrePOBPart <> 0,false,skip),
																													 2	=>	if(lIsPOBPart <> 0,false,skip),
																													 3	=>	if(lIsPostPOBPart <> 0,if(lPrePOBPart = lPostPOBPart or lPOBPart = lPostPOBPart,skip,false),skip),
																													 false
																													);
						self.rAIDWork_StdCache.Line1					:=	case(pCounter,
																													 1	=>	if(lIsPrePOBPart <> 0,lPrePOBPart,''),
																													 2	=>	if(lIsPOBPart <> 0,lPOBPart,''),
																													 3	=>	if(lIsPostPOBPart <> 0,lPostPOBPart,''),
																													 /* ** 0225 - Going to avoid doing concatenation here.  Will add test later to create them if nothing cleans
																													 4	=>	if(lLine1Parts <> 1,trim(trim(lPrePOBPart) + trim(' ' + lPOBPart) + trim(' ' + lPostPOBPart),left),''),
																													 ** */
																													 ''
																													);
						self.rAIDWork_StdCache.LineLast				:=	lLineLast;
						self.rAIDWork_RawCache.IsNormalized		:=	lLine1Parts > 1;
						self.rAIDWork_RawCache.NormalizeFlags	:=	case(pCounter,
																													 1	=>	if(lIsPrePOBPart <> 0,
																																		 if(lLine1Parts > 1,
																																				Common.eNormalizeFlag.PrePOBPart,
																																				Common.eNormalizeFlag.None
																																			 ),
																																		 Common.eNormalizeFlag.Unknown
																																		),
																													 2	=>	if(lIsPOBPart <> 0,
																																		 if(lLine1Parts > 1,
																																				Common.eNormalizeFlag.POBPart,
																																				Common.eNormalizeFlag.None
																																			 ),
																																		 Common.eNormalizeFlag.Unknown
																																		),
																													 3	=>	Common.eNormalizeFlag.PostPOBPart,
																													 Common.eNormalizeFlag.Unknown
																													);
						self.rAIDWork_RawCache.Flags					:=	0;
						self.rAIDWork_RawCache.StdVersion			:=	Common.eStdVersion;
						self       														:=	pInput;
					end                                   			
				 ;                                      			
				dPrimeStdAddressFromRawStruct	:=	normalize(pDatasetIn,3,tPrimeStdAddressFromRawStruct(left,counter));
				return	dPrimeStdAddressFromRawStruct;
			end
		 ;

		/**************************************************************************************
		 ** Append Std Cache record from Standardized Lines
		 **************************************************************************************/
		shared	dataset(Layouts.rRawSlimSeqRawCacheStdCache)	fAppendStdCacheFromStdStruct(dataset(Layouts.rRawSlimSeqRawCacheStdCache) pDatasetIn)
		 :=
			function
				dStdMasterDist		:=	distribute(Files.StdCacheProd,hash(	Line1,LineLast));
				dStdMasterDistSort	:=	sort(dStdMasterDist,				Line1,LineLast,AID,local);
				Layouts.rRawSlimSeqRawCacheStdCache tAppendStdCacheFromStdStruct(pDatasetIn pStdCacheIn, dStdMasterDistSort pStdMaster)
				 :=
					transform
						boolean	lIsInStdCache									:=	pStdMaster.AID <> 0;	// Boolean...  if true, it was found in the cache.  Otherwise, it will be new.
						self.AIDWork_IsInStdCache							:=	lIsInStdCache;
						self.rAIDWork_RawCache.StdAID					:=	if(lIsInStdCache, pStdMaster.AID, pStdCacheIn.rAIDWork_StdCache.AID);
						self.rAIDWork_StdCache.AID						:=	if(lIsInStdCache, pStdMaster.AID, pStdCacheIn.rAIDWork_StdCache.AID);
						self.rAIDWork_RawCache.IsNormalized		:=	pStdCacheIn.rAIDWork_RawCache.IsNormalized;
						self.rAIDWork_RawCache.NormalizeFlags	:=	pStdCacheIn.rAIDWork_RawCache.NormalizeFlags;
						self.rAIDWork_StdCache.CleanAID				:=	pStdMaster.CleanAID;
						self.rAIDWork_StdCache.ReturnCode			:=	pStdMaster.ReturnCode;
						self.rAIDWork_StdCache.DateValidFirst	:=	pStdMaster.DateValidFirst;
						self.rAIDWork_StdCache.DateValidLast	:=	pStdMaster.DateValidLast;
						self.rAIDWork_StdCache.DateErrorFirst	:=	pStdMaster.DateErrorFirst;
						self.rAIDWork_StdCache.DateErrorLast	:=	pStdMaster.DateErrorLast;
						self.rAIDWork_StdCache.DateCleanLast	:=	pStdMaster.DateCleanLast;
						self.rAIDWork_StdCache.DateSeenFirst	:=	pStdMaster.DateSeenFirst;
						self.rAIDWork_StdCache.DateSeenLast		:=	pStdMaster.DateSeenLast;
						self.rAIDWork_StdCache.AddressType		:=	pStdMaster.AddressType;
						self.rAIDWork_StdCache.ReferAID				:=	pStdMaster.ReferAID;
						self.rAIDWork_StdCache.Cleaner				:=	pStdMaster.Cleaner;
						self.rAIDWork_StdCache.Hash32_Full		:=	pStdMaster.Hash32_Full;
						self.rAIDWork_StdCache.CountSeen			:=	1;
						self       														:=	pStdCacheIn;
					end
				 ;
				dStdCacheInDist								:=	distribute(pDatasetIn,hash(	rAIDWork_StdCache.Line1,rAIDWork_StdCache.LineLast));
				dStdCacheInDistSort						:=	sort(dStdCacheInDist,		rAIDWork_StdCache.Line1,rAIDWork_StdCache.LineLast,local);
				dAppendStdCacheFromStdStruct	:=	join(dStdCacheInDistSort,dStdMasterDistSort,
																							 left.rAIDWork_StdCache.Line1 = right.Line1
																					 and left.rAIDWork_StdCache.LineLast = right.LineLast,
																							 tAppendStdCacheFromStdStruct(left,right),
																							 left outer,	// just in case it's not there for some reason (clean-up in limbo?)
																							 nosort,
																							 keep(1),		// just in case there are more than one (shouldn't be after clean-up)
																							 local
																							);
				return	dAppendStdCacheFromStdStruct;
			end
		 ;

		/**************************************************************************************
		 ** For Std not found in Std cache, apply StdID for return and adding to Std cache
		 **************************************************************************************/
		shared	dataset(Layouts.rRawSlimSeqRawCacheStdCache)	fPrepareNewStdRecords(dataset(Layouts.rRawSlimSeqRawCacheStdCache) pDatasetIn)
		 :=
			function
				dDatasetInDist		:=	distribute(pDatasetIn,hash(	rAIDWork_StdCache.Line1,rAIDWork_StdCache.LineLast));
				dDatasetInDistSort	:=	sort(dDatasetInDist,		rAIDWork_StdCache.Line1,rAIDWork_StdCache.LineLast,AIDWork_RecordID,local);
				recordof(Layouts.rRawSlimSeqRawCacheStdCache) tPreparedNewStdCacheRecord(Layouts.rRawSlimSeqRawCacheStdCache pLeft, Layouts.rRawSlimSeqRawCacheStdCache pRight)
				 :=
					transform
						lIsSameStdStruct											:=	pLeft.rAIDWork_StdCache.Line1 = pRight.rAIDWork_StdCache.Line1
																									and pLeft.rAIDWork_StdCache.LineLast = pRight.rAIDWork_StdCache.LineLast
																									and pLeft.AIDWork_RecordID <> 0;
						self.rAIDWork_StdCache.AID						:=	if(lIsSameStdStruct,
																												 0,
																												 Common.fGetNextAID()
																												);
						self.AIDWork_StdStructSameAsRecordID	:=	if(lIsSameStdStruct,
																												 pLeft.AIDWork_StdStructSameAsRecordID,
																												 pRight.AIDWork_StdStructSameAsRecordID
																												);
						self																	:=	pRight;
					end
				 ;
				dPreparedNewStdCacheRecord	:=	iterate(dDatasetInDistSort,tPreparedNewStdCacheRecord(left,right),local);

				recordof(Layouts.rRawSlimSeqRawCacheStdCache) tPrepareNewStdRecords(Layouts.rRawSlimSeqRawCacheStdCache pInput)
				 :=
					transform
						self.rAIDWork_RawCache.StdAID					:=	pInput.rAIDWork_StdCache.AID;
						self.rAIDWork_StdCache.AddressType		:=	Common.eAddressType.Std;
						self.rAIDWork_StdCache.DateSeenFirst	:=	lCurrentDate;
						self.rAIDWork_StdCache.DateSeenLast		:=	lCurrentDate;
						self.AIDWork_IsInStdCache							:=	false;
						self.rAIDWork_StdCache.CleanAID				:=	0;// Blank here.  Later will add necessary IDs 
						self.rAIDWork_StdCache.ReturnCode			:=	'';
						self.rAIDWork_StdCache.DateValidFirst	:=	'';
						self.rAIDWork_StdCache.DateValidLast	:=	'';
						self.rAIDWork_StdCache.DateErrorFirst	:=	'';
						self.rAIDWork_StdCache.DateErrorLast	:=	'';
						self.rAIDWork_StdCache.DateCleanLast	:=	'';
						self.rAIDWork_StdCache.Hash32_Full		:=	hash32(pInput.rAIDWork_StdCache.Line1,pInput.rAIDWork_StdCache.LineLast);
						self.rAIDWork_StdCache.CountSeen			:=	1;
						self.rAIDWork_StdCache.ReferAID				:=	pInput.rAIDWork_StdCache.AID;
						self.rAIDWork_StdCache.Cleaner				:=	'';
						self.rAIDWork_StdCache.CreatedWUID		:=	workunit;
						self																	:=	pInput;
					end
				 ;
				dPrepareNewStdRecords	:=	project(dPreparedNewStdCacheRecord,tPrepareNewStdRecords(left));
				return	dPrepareNewStdRecords;
			end
		 ;

		/**************************************************************************************
		 ** Module to force common-up, just in case
		 ** Parameters
		 **	pDatasetIn				Expected to be result of fPrepareNewStdRecords, dataset(Layouts.rRawSlimSeqRawCacheStdCache), locally sorted on Line1,Line2,IsLine1Split,Line1Type
		 ** Exported
		 **	fUniqueNewStdCache		The unique StdStruct combinations to pass along to mACEHandlers
		 **	fDuplicateNewStdCache	The duplicate StdStruct combinations we'll join back after processing
		 **   NOTE:  Both datasets returned are distributed on Line1,Line2 and sorted locally on Line1,Line2,IsLine1Split,Line1Type,RecordID
		 **************************************************************************************/
		export	mDedupNewStdCache(dataset(Layouts.rRawSlimSeqRawCacheStdCache) pDatasetIn)
		 :=
			module
				shared	dDatasetInDist			:=	distribute(pDatasetIn,hash(	rAIDWork_StdCache.Line1,rAIDWork_StdCache.LineLast));
				shared	dDatasetInDistSort	:=	sort(dDatasetInDist,		rAIDWork_StdCache.Line1,rAIDWork_StdCache.LineLast,AIDWork_RecordID,local);
				recordof(Layouts.rRawSlimSeqRawCacheStdCache) tPreparedNewStdCacheRecord(Layouts.rRawSlimSeqRawCacheStdCache pLeft, Layouts.rRawSlimSeqRawCacheStdCache pRight)
				 :=
					transform
						lIsSameStdStruct											:=	pLeft.rAIDWork_StdCache.Line1 = pRight.rAIDWork_StdCache.Line1
																									and pLeft.rAIDWork_StdCache.LineLast = pRight.rAIDWork_StdCache.LineLast
																									and pLeft.AIDWork_RecordID <> 0;
						lStdNormalizedToDuplicate							:=	lIsSameStdStruct
																									and pLeft.AIDWork_RecordID = pRight.AIDWork_RecordID;
						self.AIDWork_StdStructSameAsRecordID	:=	if(lIsSameStdStruct,
																												 pLeft.AIDWork_StdStructSameAsRecordID,
																												 pRight.AIDWork_StdStructSameAsRecordID
																												);
						self.rAIDWork_RawCache.Flags					:=	if(lStdNormalizedToDuplicate,
																												 pRight.rAIDWork_RawCache.Flags | Common.eFlags.StdNormalized,
																												 pRight.rAIDWork_RawCache.Flags
																												);
						self																	:=	pRight;
					end
				 ;
				shared	dDatasetOut							:=	iterate(dDatasetInDistSort,tPreparedNewStdCacheRecord(left,right),local);
				export	fNewStdCacheUnique			:=	dDatasetOut(AIDWork_RecordID = AIDWork_StdStructSameAsRecordID and rAIDWork_RawCache.Flags & Common.eFlags.StdNormalized = 0);
				export	fNewStdCacheDuplicates	:=	dDatasetOut(AIDWork_RecordID <> AIDWork_StdStructSameAsRecordID or rAIDWork_RawCache.Flags & Common.eFlags.StdNormalized <> 0);
			end
		 ;

		/**************************************************************************************/
		export	dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache)	fPropagateToStdDuplicates(dataset(Layouts.rRawSlimSeqRawCacheStdCache) pDuplicates, dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache) pCompleted)
		 :=
			function
				Layouts.rRawSlimSeqRawCacheStdCacheACECache	tStdDuplicatesToFull(pDuplicates pInput)
				 :=
					transform
						self.rAIDWork_ACECache								:=	[];
						self.AIDWork_IsInACECache							:=	false;
						self.AIDWork_ACEStructSameAsRecordID	:=	pInput.AIDWork_RecordID;
						self																	:=	pInput;
					end
				 ;
				dStdDuplicatesToFull	:=	project(pDuplicates,tStdDuplicatesToFull(left));
				dDuplicatesDist				:=	distribute(dStdDuplicatesToFull,(AIDWork_StdStructSameAsRecordID - 1) % lib_ThorLib.ThorLib.nodes());
				dCompletedDist				:=	distribute(pCompleted,(AIDWork_RecordID - 1) % lib_ThorLib.ThorLib.nodes());
				dCombinedDistSort			:=	sort(dCompletedDist + dDuplicatesDist,AIDWork_StdStructSameAsRecordID,abs(AIDWork_RecordID - AIDWork_StdStructSameAsRecordID),(rAIDWork_RawCache.Flags & Common.eFlags.StdNormalized),local);
				recordof(dCompletedDist)	tPropagateToStdDuplicates(recordof(dCombinedDistSort) pLeft, recordof(dCombinedDistSort) pRight)
				 :=
					transform
						boolean	lShouldPropagate							:=	pRight.AIDWork_StdStructSameAsRecordID = pLeft.AIDWork_StdStructSameAsRecordID
																									or	pRight.rAIDWork_RawCache.Flags & Common.eFlags.StdNormalized <> 0;
						self.AIDWork_RecordID									:=	pRight.AIDWork_RecordID;
						self.AIDWork_RawStructSameAsRecordID	:=	pRight.AIDWork_RawStructSameAsRecordID;
						self.AIDWork_OriginalRawAID						:=	pRight.AIDWork_OriginalRawAID;
						self.rAIDWork_RawStruct								:=	pRight.rAIDWork_RawStruct;
						self.AIDWork_IsInRawCache							:=	pRight.AIDWork_IsInRawCache;
						self.rAIDWork_RawCache.StdAID					:=	if(lShouldPropagate, pLeft.rAIDWork_StdCache.AID,			pRight.rAIDWork_StdCache.AID);
						self.rAIDWork_RawCache								:=	pRight.rAIDWork_RawCache;
						self.AIDWork_IsInStdCache							:=	if(lShouldPropagate, pLeft.AIDWork_IsInStdCache,			pRight.AIDWork_IsInStdCache);
						self.rAIDWork_StdCache								:=	if(lShouldPropagate, pLeft.rAIDWork_StdCache,				pRight.rAIDWork_StdCache);
						self.AIDWork_IsInACECache							:=	if(lShouldPropagate, pLeft.AIDWork_IsInACECache,			pRight.AIDWork_IsInACECache);
						self.AIDWork_ACEStructSameAsRecordID	:=	if(lShouldPropagate, pLeft.AIDWork_ACEStructSameAsRecordID, pRight.AIDWork_ACEStructSameAsRecordID);
						self.rAIDWork_ACECache								:=	if(lShouldPropagate, pLeft.rAIdWork_ACECache,				pRight.rAIDWork_ACECache);
						self.AIDWork_StdStructSameAsRecordID	:=	pRight.AIDWork_StdStructSameAsRecordID;
					end
				 ;
				dPropagateToStdDuplicatesAll	:=	iterate(dCombinedDistSort,
																									tPropagateToStdDuplicates(left,right),
																									local
																								 );
				dPropagateToStdDuplicates			:=	dPropagateToStdDuplicatesAll(AIDWork_RecordID <> AIDWork_StdStructSameAsRecordID or rAIDWork_RawCache.Flags & Common.eFlags.StdNormalized <> 0);
				return	dPropagateToStdDuplicates;
			end
		 ;

		/**************************************************************************************
		 ** Full Std process, prepped for Clean Handlers
		 **************************************************************************************/
		export	mFullPrep(dataset(Layouts.rRawSlimSeqRawCache) pDatasetIn)
		 :=
			module
				shared	dFoundRawStdCacheAppended					:=	fAppendStdCacheFromRawStdAID(pDatasetIn);
				shared	dFoundRawStdCacheAppendedFound		:=	dFoundRawStdCacheAppended(rAIDWork_StdCache.AID <> 0);

				shared	dFoundRawStdCacheAppendedNotFound	:=	dFoundRawStdCacheAppended(rAIDWork_StdCache.AID = 0);
				shared	dNewRawPrimeStdCache							:=	fPrimeStdAddressFromRawStruct(dFoundRawStdCacheAppendedNotFound);
				shared	dNewRawStdCacheAppended						:=	fAppendStdCacheFromStdStruct(dNewRawPrimeStdCache);
				shared	dNewRawStdCacheFound							:=	dNewRawStdCacheAppended(AIDWork_IsInStdCache);

				shared	dFoundRawStdCacheFoundUnique			:=	mDedupNewStdCache(dFoundRawStdCacheAppendedFound + dNewRawStdCacheFound).fNewStdCacheUnique;
				shared	dFoundRawStdCacheFoundDuplicates	:=	mDedupNewStdCache(dFoundRawStdCacheAppendedFound + dNewRawStdCacheFound).fNewStdCacheDuplicates;
				
				shared	dNewRawStdCacheNew								:=	dNewRawStdCacheAppended(not AIDWork_IsInStdCache);
				shared	dNewRawStdCacheNewReady						:=	fPrepareNewStdRecords(dNewRawStdCacheNew);
				shared	dNewRawStdCacheNewReadyUnique			:=	mDedupNewStdCache(dNewRawStdCacheNewReady).fNewStdCacheUnique;
				shared	dNewRawStdCacheNewReadyDuplicates	:=	mDedupNewStdCache(dNewRawStdCacheNewReady).fNewStdCacheDuplicates;

				export	fFoundAndNew											:=	dFoundRawStdCacheFoundUnique + dNewRawStdCacheNewReadyUnique;
				export	fDuplicates												:=	dFoundRawStdCacheFoundDuplicates + dNewRawStdCacheNewReadyDuplicates;
			end
		 ;

  end
 ;
