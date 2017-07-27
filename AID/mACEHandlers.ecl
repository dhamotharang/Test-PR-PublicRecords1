export mACEHandlers
 :=
  module
		import lib_StringLib, lib_FileServices, lib_addrclean, ut, lib_ThorLib;

		shared	lCurrentDate	:=	ut.GetDate : global;	// just to prevent the transforms from calling the function for every record in any transforms below

		/**************************************************************************************/
		export	Layouts.rACEStruct	fACEStructRecordFromString182(string182 pACEAddress182)
		 :=
			function
				Layouts.rACEStruct	tACEStructRecordFromString182(string pInputString)
				 :=
					transform
						self.prim_range		:=	pInputString[1..10];
						self.predir				:=	pInputString[11..12];
						self.prim_name		:=	pInputString[13..40];
						self.addr_suffix	:=	pInputString[41..44];
						self.postdir			:=	pInputString[45..46];
						self.unit_desig		:=	pInputString[47..56];
						self.sec_range		:=	pInputString[57..64];
						self.p_city_name	:=	pInputString[65..89];
						self.v_city_name	:=	pInputString[90..114];
						self.st						:=	pInputString[115..116];
						self.zip5					:=	pInputString[117..121];
						self.zip4					:=	pInputString[122..125];
						self.cart					:=	pInputString[126..129];
						self.cr_sort_sz		:=	pInputString[130];
						self.lot					:=	pInputString[131..134];
						self.lot_order		:=	pInputString[135];
						self.dbpc					:=	pInputString[136..137];
						self.chk_digit		:=	pInputString[138];
						self.rec_type			:=	pInputString[139..140];
						self.county				:=	pInputString[141..145];
						self.geo_lat			:=	pInputString[146..155];
						self.geo_long			:=	pInputString[156..166];
						self.msa					:=	pInputString[167..170];
						self.geo_blk			:=	pInputString[171..177];
						self.geo_match		:=	pInputString[178];
						self.err_stat			:=	pInputString[179..182];
					end
				 ;
				return tACEStructRecordFromString182(pACEAddress182);
			end
		 ;

		/**************************************************************************************
		 ** Append ACE Cache record from ACEAID already in Std Cache
		 ** Expects only to receive those found in StdCache, and therefore, with Clean reference
		 **************************************************************************************/
		export	dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache)	fAppendACEFromStdCleanAID(dataset(Layouts.rRawSlimSeqRawCacheStdCache) pDatasetIn)
		 :=
			function
				dACEMasterDist_AID	:=	Files.ACECacheProdDist_AID;
				Layouts.rRawSlimSeqRawCacheStdCacheACECache fAppendACEFromStdCleanAID(pDatasetIn pStdCacheIn, dACEMasterDist_AID pACEMaster)
				 :=
					transform
						self.rAIDWork_ACECache 								:=	pACEMaster;
						self.AIDWork_IsInACECache							:=	pACEMaster.AID <> 0;	// Boolean...  if true, it was found in the cache.  Otherwise, it will be new.
						self.AIDWork_ACEStructSameAsRecordID	:=	pStdCacheIn.AIDWork_RecordID;
						self       														:=	pStdCacheIn;
					end
				 ;
				dStdCacheInDist						:=	distribute(pDatasetIn,hash(rAIDWork_StdCache.CleanAID));
				dAppendACEFromStdCleanAID	:=	join(dStdCacheInDist,dACEMasterDist_AID,
																					 left.rAIDWork_StdCache.CleanAID = right.AID,
																					 fAppendACEFromStdCleanAID(left,right),
																					 left outer,	// just in case it's not there for some reason (clean-up in limbo?)
																					 local
																					);
				return	dAppendACEFromStdCleanAID;
			end
		 ;

		/**************************************************************************************
		 ** Append ACE Cache record with cleaned version of Standardized Lines (unknown ACEAID so far)
		 ** Expects only to receive those found in StdCache, and therefore, with Clean reference
		 **************************************************************************************/
		export	dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache)	fPrimeACEAddressFromStdStruct(dataset(Layouts.rRawSlimSeqRawCacheStdCache) pDatasetIn)
		 :=
			function
				Layouts.rRawSlimSeqRawCacheStdCacheACECache tPrimeACEAddressFromStdStruct(pDatasetIn pInput)
				 :=
					transform
						self.AIDWork_IsInACECache							:=	false;
						self.rAIDWork_ACECache.AID						:=	0;
						self.rAIDWork_ACECache.AddressType		:=	Common.eAddressType.ACE;
						self.rAIDWork_ACECache.DateSeenFirst	:=	lCurrentDate;
						self.rAIDWork_ACECache.DateSeenLast		:=	lCurrentDate;
						self.rAIDWork_ACECache.CleanAID				:=	0;
						self.rAIDWork_ACECache.Hash32_Full		:=	0; // Calc in fAppendACECacheFromACEStruct to prevent recleaning by referencing self.rAIDWork_ACECache again
						self.rAIDWork_ACECache.CountSeen			:=	1;
						self.rAIDWork_ACECache.ReferAID				:=	0;
						self.rAIDWork_ACECache.CreatedWUID		:=	'';
						self.rAIDWork_ACECache								:=	row(fACEStructRecordFromString182(lib_addrclean.AddrCleanLib.cleanaddress182(pInput.rAIDWork_StdCache.Line1 ,pInput.rAIDWork_StdCache.LineLast)));
						self.rAIDWork_StdCache.Cleaner				:=	Common.eAddressType.ACE;
						self.rAIDWork_StdCache.CleanAID				:=	0;
						self.rAIDWork_StdCache.ReturnCode			:=	''; // Calc in fAppendACECacheFromACEStruct to prevent recleaning by referencing self.rAIDWork_ACECache again
						self.rAIDWork_StdCache.DateValidFirst	:=	''; // Calc in fAppendACECacheFromACEStruct to prevent recleaning by referencing self.rAIDWork_ACECache again
						self.rAIDWork_StdCache.DateValidLast	:=	''; // Calc in fAppendACECacheFromACEStruct to prevent recleaning by referencing self.rAIDWork_ACECache again
						self.rAIDWork_StdCache.DateErrorFirst	:=	''; // Calc in fAppendACECacheFromACEStruct to prevent recleaning by referencing self.rAIDWork_ACECache again
						self.rAIDWork_StdCache.DateErrorLast	:=	''; // Calc in fAppendACECacheFromACEStruct to prevent recleaning by referencing self.rAIDWork_ACECache again
						self.rAIDWork_StdCache.DateCleanLast	:=	lCurrentDate;
						self.AIDWork_ACEStructSameAsRecordID	:=	pInput.AIDWork_RecordID;
						self       														:=	pInput;
					end
				 ;
				dPrimeACEAddressFromStdStruct	:=	project(pDatasetIn,tPrimeACEAddressFromStdStruct(left));
				return	dPrimeACEAddressFromStdStruct;
			end
		 ;

		/**************************************************************************************
		 ** Append ACE Cache record from Clean Fields
		 **************************************************************************************/
		export	dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache)	fAppendACECacheFromACEStruct(dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache) pDatasetIn)
		 :=
			function
				dACEMaster						:=	Files.ACECacheProd;
				dACEMasterDist				:=	distribute(dACEMaster,hash(	prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip5,zip4));
				dACEMasterDistSort		:=	sort(dACEMasterDist,		prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip5,zip4,-AID,local);
				dACECacheInDist				:=	distribute(pDatasetIn,hash(	rAIDWork_ACECache.prim_range,rAIDWork_ACECache.predir,rAIDWork_ACECache.prim_name,rAIDWork_ACECache.addr_suffix,rAIDWork_ACECache.postdir,rAIDWork_ACECache.unit_desig,rAIDWork_ACECache.sec_range,rAIDWork_ACECache.v_city_name,rAIDWork_ACECache.st,rAIDWork_ACECache.zip5,rAIDWork_ACECache.zip4));
				dACECacheInDistSort		:=	sort(dACECacheInDist,		rAIDWork_ACECache.prim_range,rAIDWork_ACECache.predir,rAIDWork_ACECache.prim_name,rAIDWork_ACECache.addr_suffix,rAIDWork_ACECache.postdir,rAIDWork_ACECache.unit_desig,rAIDWork_ACECache.sec_range,rAIDWork_ACECache.v_city_name,rAIDWork_ACECache.st,rAIDWork_ACECache.zip5,rAIDWork_ACECache.zip4,local);
				
				Layouts.rRawSlimSeqRawCacheStdCacheACECache tAppendACECacheFromACEStruct(dACECacheInDistSort pACECacheIn, dACEMasterDistSort pACEMaster)
				 :=
					transform
						boolean	lIsInACECache									:=	pACEMaster.AID <> 0;
						boolean	lIsError											:=	pAceCacheIn.rAIDWork_ACECache.err_stat[1] = 'E';
						self.AIDWork_IsInACECache							:=	lIsInACECache;
						self.rAIDWork_ACECache.AID						:=	pACEMaster.AID;
						self.rAIDWork_ACECache.ReferAID				:=	pACEMaster.ReferAID;
						self.rAIDWork_ACECache.CleanAID				:=	pACEMaster.CleanAID;
						self.rAIDWork_ACECache.DateSeenFirst	:=	if(lIsInACECache,	pACEMaster.DateSeenFirst,	lCurrentDate);
						self.rAIDWork_ACECache.DateSeenLast		:=	if(lIsInACECache,	pACEMaster.DateSeenLast,	lCurrentDate);
						self.rAIDWork_ACECache.Hash32_FUll		:=	if(lIsInACECache,	pACEMaster.Hash32_Full,		hash32(pACECacheIn.rAIDWork_ACECache.prim_range,pACECacheIn.rAIDWork_ACECache.predir,pACECacheIn.rAIDWork_ACECache.prim_name,pACECacheIn.rAIDWork_ACECache.addr_suffix,pACECacheIn.rAIDWork_ACECache.postdir,pACECacheIn.rAIDWork_ACECache.unit_desig,pACECacheIn.rAIDWork_ACECache.sec_range,pACECacheIn.rAIDWork_ACECache.v_city_name,pACECacheIn.rAIDWork_ACECache.st,pACECacheIn.rAIDWork_ACECache.zip5,pACECacheIn.rAIDWork_ACECache.zip4));
						self.rAIDWork_ACECache.CreatedWUID		:=	pACEMaster.CreatedWUID;
						self.rAIDWork_StdCache.CleanAID				:=	pACEMaster.AID;
						self.rAIDWork_StdCache.ReturnCode			:=	pAceCacheIn.rAIDWork_ACECache.err_stat;
						self.rAIDWork_StdCache.DateValidFirst	:=	if(lIsError,'',lCurrentDate);
						self.rAIDWork_StdCache.DateValidLast	:=	if(lIsError,'',lCurrentDate);
						self.rAIDWork_StdCache.DateErrorFirst	:=	if(lIsError,lCurrentDate,'');
						self.rAIDWork_StdCache.DateErrorLast	:=	if(lIsError,lCurrentDate,'');
						self       														:=	pACECacheIn;
					end
				 ;
				dAppendACECacheFromACEStruct	:=	join(dACECacheInDistSort,dACEMasterDistSort,
																							 left.rAIDWork_ACECache.prim_range = right.prim_range
																					 and left.rAIDWork_ACECache.predir = right.predir
																					 and left.rAIDWork_ACECache.prim_name = right.prim_name
																					 and left.rAIDWork_ACECache.addr_suffix = right.addr_suffix
																					 and left.rAIDWork_ACECache.postdir = right.postdir
																					 and left.rAIDWork_ACECache.unit_desig = right.unit_desig
																					 and left.rAIDWork_ACECache.sec_range = right.sec_range
																					 and left.rAIDWork_ACECache.v_city_name = right.v_city_name
																					 and left.rAIDWork_ACECache.st = right.st
																					 and left.rAIDWork_ACECache.zip5 = right.zip5
																					 and left.rAIDWork_ACECache.zip4 = right.zip4,
																							 tAppendACECacheFromACEStruct(left,right),
																							 left outer,	// just in case it's not there for some reason (clean-up in limbo?)
																							 nosort,
																							 keep(1),		// there may be more than one until cleanup
																							 local
																							);
				return	dAppendACECacheFromACEStruct;
			end
		 ;

		/**************************************************************************************
		 ** For ACE not found in ACE cache...  squeezed this out, but keeping in case step added back in (optimizer will squeeze it out, too)
		 **************************************************************************************/
		export	dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache)	fPrepareNewACERecords(dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache) pDatasetIn)
		 :=
			function
				dPrepareNewACERecords	:=	pDatasetIn;
				return	dPrepareNewACERecords;
			end
		 ;

		/**************************************************************************************
		 ** Module to force common-up, just in case
		 ** Parameters
		 **	pDatasetIn				dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache)
		 ** Exported
		 **	fUniqueNewStdCache		The unique StdStruct combinations to pass along to mACEHandlers
		 **	fDuplicateNewStdCache	The duplicate StdStruct combinations we'll join back after processing
		 **   NOTE:  Both datasets returned are distributed on Line1,Line2 and sorted locally on Line1,Line2,IsLine1Split,Line1Type,RecordID
		 **************************************************************************************/
		export	mDedupNewACECache(dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache) pDatasetIn)
		 :=
			module
				shared	dDatasetInDist		:=	distribute(pDatasetIn,hash(	rAIDWork_ACECache.prim_range,rAIDWork_ACECache.predir,rAIDWork_ACECache.prim_name,rAIDWork_ACECache.addr_suffix,rAIDWork_ACECache.postdir,rAIDWork_ACECache.unit_desig,rAIDWork_ACECache.sec_range,rAIDWork_ACECache.v_city_name,rAIDWork_ACECache.st,rAIDWork_ACECache.zip5,rAIDWork_ACECache.zip4));
				shared	dDatasetInDistSort	:=	sort(dDatasetInDist,		rAIDWork_ACECache.prim_range,rAIDWork_ACECache.predir,rAIDWork_ACECache.prim_name,rAIDWork_ACECache.addr_suffix,rAIDWork_ACECache.postdir,rAIDWork_ACECache.unit_desig,rAIDWork_ACECache.sec_range,rAIDWork_ACECache.v_city_name,rAIDWork_ACECache.st,rAIDWork_ACECache.zip5,rAIDWork_ACECache.zip4,AIDWork_RecordID,local);
				recordof(Layouts.rRawSlimSeqRawCacheStdCacheACECache) tPreparedNewACECacheRecords(Layouts.rRawSlimSeqRawCacheStdCacheACECache pLeft, Layouts.rRawSlimSeqRawCacheStdCacheACECache pRight)
				 :=
					transform
						lIsSameACEStruct											:=	pLeft.rAIDWork_ACECache.prim_range  = pRight.rAIDWork_ACECache.prim_range
																									and pLeft.rAIDWork_ACECache.predir      = pRight.rAIDWork_ACECache.predir
																									and pLeft.rAIDWork_ACECache.prim_name   = pRight.rAIDWork_ACECache.prim_name
																									and pLeft.rAIDWork_ACECache.addr_suffix = pRight.rAIDWork_ACECache.addr_suffix
																									and pLeft.rAIDWork_ACECache.postdir     = pRight.rAIDWork_ACECache.postdir
																									and pLeft.rAIDWork_ACECache.unit_desig  = pRight.rAIDWork_ACECache.unit_desig
																									and pLeft.rAIDWork_ACECache.sec_range   = pRight.rAIDWork_ACECache.sec_range
																									and pLeft.rAIDWork_ACECache.v_city_name = pRight.rAIDWork_ACECache.v_city_name
																									and pLeft.rAIDWork_ACECache.st          = pRight.rAIDWork_ACECache.st
																									and pLeft.rAIDWork_ACECache.zip5        = pRight.rAIDWork_ACECache.zip5
																									and pLeft.rAIDWork_ACECache.zip4        = pRight.rAIDWork_ACECache.zip4
																									and pLeft.AIDWork_RecordID <> 0;
						lACENormalizedToDuplicate							:=	lIsSameACEStruct
																									and pLeft.AIDWork_RecordID = pRight.AIDWork_RecordID;
						self.rAIDWork_ACECache.AID						:=	if(lIsSameACEStruct,
																												 pLeft.rAIDWork_ACECache.AID,
																												 if(pRight.rAIDWork_AceCache.AID <> 0, 
																													pRight.rAIdWork_ACECache.AID,
																													Common.fGetNextAID()
																												 )
																												);
						self.AIDWork_ACEStructSameAsRecordID	:=	if(lIsSameACEStruct,	
																												 pLeft.AIDWork_ACEStructSameAsRecordID,
																												 pRight.AIDWork_ACEStructSameAsRecordID
																												);
						self.rAIDWork_RawCache.Flags					:=	if(lACENormalizedToDuplicate,
																												 pRight.rAIDWork_RawCache.Flags | Common.eFlags.ACENormalized,
																												 pRight.rAIDWork_RawCache.Flags
																												);
						self																	:=	pRight;
					end
				 ;
				shared	dPreparedNewACECacheRecords				:=	iterate(dDatasetInDistSort,tPreparedNewACECacheRecords(left,right),local);

				recordof(dPreparedNewACECacheRecords)	tPopulatedUniqueACECacheRecords(dPreparedNewACECacheRecords pInput)
				 :=
					transform
						boolean	lIsError											:=	pInput.rAIDWork_ACECache.err_stat[1] = 'E';
						self.rAIDWork_ACECache.CleanAID				:=	pInput.rAIDWork_ACECache.AID;
						self.rAIDWork_ACECache.ReferAID				:=	pInput.rAIDWork_ACECache.AID;
						self.rAIDWork_ACECache.CreatedWUID		:=	workunit;
						self.rAIDWork_StdCache.DateCleanLast	:=	lCurrentDate;
						self.rAIDWork_StdCache.DateValidFirst	:=	if(lIsError,'',lCurrentDate);
						self.rAIDWork_StdCache.DateValidLast	:=	if(lIsError,'',lCurrentDate);
						self.rAIDWork_StdCache.DateErrorFirst	:=	if(lIsError,lCurrentDate,'');
						self.rAIDWork_StdCache.DateErrorLast	:=	if(lIsError,lCurrentDate,'');
						self.rAIDWork_StdCache.CleanAID				:=	pInput.rAIDWork_ACECache.AID;
						self.rAiDWork_StdCache.ReturnCode			:=	pInput.rAIDWork_ACECache.err_stat;
						self       														:=	pInput;
					end
				 ;
				shared	dPopulatedUniqueACECacheRecords		:=	project(dPreparedNewACECacheRecords,tPopulatedUniqueACECacheRecords(left));
				export	fNewACECacheUnique								:=	dPopulatedUniqueACECacheRecords(AIDWork_RecordID = AIDWork_ACEStructSameAsRecordID and rAIDWork_RawCache.Flags & Common.eFlags.ACENormalized = 0);
				export	fNewACECacheDuplicates						:=	dPopulatedUniqueACECacheRecords(AIDWork_RecordID <> AIDWork_ACEStructSameAsRecordID or rAIDWork_RawCache.Flags & Common.eFlags.ACENormalized <> 0);
			end
		 ;

		/**************************************************************************************/
		export	dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache)	fPropagateToACEDuplicates(dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache) pDuplicates, dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache) pCompleted)
		 :=
			function
				dDuplicatesDist		:=	distribute(pDuplicates,(AIDWork_ACEStructSameAsRecordID - 1) % lib_ThorLib.ThorLib.nodes());
				dCompletedDist		:=	distribute(pCompleted,(AIDWork_RecordID - 1) % lib_ThorLib.ThorLib.nodes());
				dCombinedDistSort	:=	sort(dCompletedDist + dDuplicatesDist,AIDWork_ACEStructSameAsRecordID,abs(AIDWork_RecordID - AIDWork_ACEStructSameAsRecordID),(rAIDWork_RawCache.Flags & Common.eFlags.ACENormalized),local);
				recordof(dCombinedDistSort)	tPropagateToACEDuplicates(recordof(dCombinedDistSort) pLeft, recordof(dCombinedDistSort) pRight)
				 :=
					transform
						boolean	lShouldPropagate							:=	pRight.AIDWork_ACEStructSameAsRecordID = pLeft.AIDWork_ACEStructSameAsRecordID
																									or	pRight.rAIDWork_RawCache.Flags & Common.eFlags.ACENormalized <> 0;
						self.AIDWork_RecordID									:=	pRight.AIDWork_RecordID;
						self.AIDWork_RawStructSameAsRecordID	:=	pRight.AIDWork_RawStructSameAsRecordID;
						self.AIDWork_OriginalRawAID						:=	pRight.AIDWork_OriginalRawAID;
						self.rAIDWork_RawStruct								:=	pRight.rAIDWork_RawStruct;
						self.AIDWork_IsInRawCache							:=	pRight.AIDWork_IsInRawCache;
						self.rAIDWork_RawCache.StdAID					:=	pRight.rAIDWork_StdCache.AID;
						self.rAIDWork_RawCache								:=	pRight.rAIDWork_RawCache;
						self.AIDWork_IsInStdCache							:=	pRight.AIDWork_IsInStdCache;
						self.AIDWork_StdStructSameAsRecordID	:=	pRight.AIDWork_StdStructSameAsRecordID;
						self.rAIDWork_StdCache.CleanAID				:=	if(lShouldPropagate,
																												 pLeft.rAIDWork_StdCache.CleanAID,
																												 pRight.rAIDWork_StdCache.CleanAID
																												);
						self.rAIDWork_StdCache								:=	pRight.rAIDWork_StdCache;
						self.rAIDWork_ACECache								:=	if(lShouldPropagate,
																												 pLeft.rAIDWork_ACECache,
																												 pRight.rAIDWork_ACECache
																												);
						self.AIDWork_IsInACECache							:=	if(lShouldPropagate,
																												 pLeft.AIDWork_IsInACECache,
																												 pRight.AIDWork_IsInACECache
																												);
						self.AIDWork_ACEStructSameAsRecordID	:=	pRight.AIDWork_ACEStructSameAsRecordID;
					end
				 ;
				dPropagateToACEDuplicatesAll	:=	iterate(dCombinedDistSort,
																									tPropagateToACEDuplicates(left,right),
																									local
																								 );
				dPropagateToACEDuplicates		:=	dPropagateToACEDuplicatesAll(AIDWork_RecordID <> AIDWork_ACEStructSameAsRecordID or rAIDWork_RawCache.Flags & Common.eFlags.ACENormalized <> 0);
				return	dPropagateToACEDuplicates;
			end
		 ;

		/**************************************************************************************
		 ** Full ACE process
		 **************************************************************************************/
		export	mFullPrep(dataset(Layouts.rRawSlimSeqRawCacheStdCache) pDatasetIn)
		 :=
			module
				shared	dFoundStd														:=	pDatasetIn(AIDWork_IsInStdCache);
				shared	dFoundStdACECacheAppended						:=	fAppendACEFromStdCleanAID(dFoundStd);

				shared	dNewStd															:=	pDatasetIn(not AIDWork_IsInStdCache) + project(dFoundStdACECacheAppended(rAIDWork_ACECache.AID=0),recordof(pDatasetIn));
				shared	dNewStdPrimeACECache								:=	fPrimeACEAddressFromStdStruct(dNewStd);
				shared	dNewStdACECacheAppended							:=	fAppendACECacheFromACEStruct(dNewStdPrimeACECache);
				shared	dNewStdACECacheFound								:=	dNewStdACECacheAppended(AIDWork_IsInACECache);

				shared	dFoundStdAcECacheAppendedUnique			:=	mDedupNewACECache(dFoundStdACECacheAppended + dNewStdACECacheFound).fNewACECacheUnique;
				shared	dFoundStdAcECacheAppendedDuplicates	:=	mDedupNewACECache(dFoundStdACECacheAppended + dNewStdACECacheFound).fNewACECacheDuplicates;

				shared	dNewStdACECacheNotFound							:=	dNewStdACECacheAppended(not AIDWork_IsInACECache);
				shared	dNewStdACECacheNew									:=	fPrepareNewACERecords(dNewStdACECacheNotFound);
				shared	dNewStdAcECacheNewUnique						:=	mDedupNewACECache(dNewStdACECacheNew).fNewACECacheUnique;
				shared	dNewStdAcECacheNewDuplicates				:=	mDedupNewACECache(dNewStdACECacheNew).fNewACECacheDuplicates;

				export	fFoundAndNew												:=	dFoundStdACECacheAppendedUnique + dNewStdACECacheNewUnique;
				export	fDuplicates													:=	dFoundStdACECacheAppendedDuplicates + dNewStdACECacheNewDuplicates;
			end
		 ;

  end
 ;
