export mRawHandlers
 :=
  module
		import lib_StringLib, lib_FileServices, ut, lib_ThorLib, std;

		shared	lCurrentDate	:=	(STRING8)Std.Date.Today() : global;	// just to prevent the transforms from calling the function for every record in any transforms below

		/*************************************************************************************
		** Prepend UID (as field AIDWork_RecordID) to original dataset for later joining
		** Parameters
		**	pDatasetIn:		In, Required:	No sort, no dist
		**					In, Expected:	No sort, no dist
		**	pDatasetOut:	Out:			No sort, dist ((AIDWork_RecordID - 1) *
		** NOTE:  The sequencing macro inherently allows DISTRIBUTE((AIDWork_RecordID - 1) % lib_thorLib.thorlib.nodes()) to get back "home"
		**        Will need to add "% original thorlib.nodes()" if different size cluster)
		**************************************************************************************/
		export	MacSequenceOriginalDataset(pDatasetIn, pDatasetOut)
		 :=
			macro
				import ut;
				#uniquename(rInputPlusRecordID);
				#uniquename(tInputPlusRecordID);
				#uniquename(dInputPlusRecordID);
				#uniquename(tApplyActualRecordID);
				%rInputPlusRecordID%
				 :=
					record
						AID.Common.xRecordID	AIDWork_RecordID;
						pDatasetIn;
					end : onwarning(1041, ignore)
				 ;
				%rInputPlusRecordID% %tInputPlusRecordID%(pDatasetIn pInput)
				 :=
					transform
						self.AIDWork_RecordID	:=	0;
						self									:=	pInput;
					end
				 ;
				%dInputPlusRecordID%	:=	project(pDatasetIn,%tInputPlusRecordID%(left));		 
				/*************************************************************************************
				** Duplicating ut.MAC_Sequence_Records here to avoid the warnings and maintain local control
				** NOTE - Later, we use the property that these records allow DISTRIBUTE((AIDWork_RecordID - 1) % lib_ThorLib.ThorLib.nodes()) to get back to orig node
				*************************************************************************************/
				%rInputPlusRecordID% %tApplyActualRecordID%(%dInputPlusRecordID% pLeft, %dInputPlusRecordID% pRight)
				 :=
					transform
						self.AIDWork_RecordID	:=	if(pLeft.AIDWork_RecordID = 0, thorlib.node() + 1 , pLeft.AIDWork_RecordID + thorlib.nodes());
						self									:=	pRight;
					end
				 ;
				pDatasetOut	:=	iterate(distributed(%dInputPlusRecordID%,(AIDWork_RecordID - 1) % lib_ThorLib.ThorLib.nodes()),%tApplyActualRecordID%(left,right),local);
			endmacro
		 ;

		/**************************************************************************************
		** Slim the records, retaining only the raw address fields and record IDs
		** Parameters
		**	pDatasetIn:		In, Required:		No sort, no dist
		**					In, Expected:		No sort, dist ((AIDWork_RecordID-1) % thorlib.nodes())
		**	pDatasetOut:	Out:				Sort/Dist as received
		**	pLine1Field		fieldname of Line1 of raw address
		**	pLine2Field		fieldname of Line2 of raw address
		**************************************************************************************/
		export	MacRawSlimSequenced(pDatasetIn, pLine1Field, pLine2Field, pLine3Field, pLineLastField, pRawAIDField, pDatasetOut)
		 :=
			macro
				#uniquename(tRawSlimmedSeq);
				#uniquename(dRawSlimmedSeq);
				AID.Layouts.rRawSlimSeq %tRawSlimmedSeq%(pDatasetIn pInput)
				 :=
					transform
					self.AIDWork_RecordID									:=	pInput.AIDWork_RecordID;
					self.AIDWork_RawStructSameAsRecordID	:=	pInput.AIDWork_RecordID;
					self.AIDWork_OriginalRawAID						:=	pInput.pRawAIDField;
					self.rAIDWork_RawStruct.Line1					:=	pInput.pLine1Field;
					self.rAIDWork_RawStruct.Line2					:=	pInput.pLine2Field;
					self.rAIDWork_RawStruct.Line3					:=	pInput.pLine3Field;
					self.rAIDWork_RawStruct.LineLast			:=	pInput.pLineLastField;
					end
				 ;
				%dRawSlimmedSeq%			:=	project(pDatasetIn,%tRawSlimmedSeq%(left));
				pDatasetOut						:=	%dRawSlimmedSeq%;
			endmacro
		 ;

		/**************************************************************************************
		 ** Parameters
		 **	pDatasetIn				In, Required:	No sort, no dist
		 **							In, Expected:	Result of MacRawSlimSequenced, dataset(Layouts.rRawSlimSeq)), No sort, dist ((AIDWork_RecordID-1) % thorlib.nodes())
		 **							Out:			Sort(Line1,Line2,Line3,LineLast,RawAID,RecordID,LOCAL), Dist(Line1,Line2,Line3,LineLast)
		 ** Exported
		 **	fRawSlimSeqUnique		The unique Line1/Line2 combinations to pass along to mStdHandlers
		 **	fRawSlimSeqDuplicates	The duplicate Line1/Line2 combinations we'll join back after processing
		 **							Out:			Sort(Line1,Line2,RawAID,RecordID,LOCAL), Dist(Line1,Line2)
		 **************************************************************************************/
		shared	fSetSameAsRecordID(dataset(Layouts.rRawSlimSeq) pDatasetIn)
		 :=
			function
				dRawSlimSeqDist				:=	distribute(pDatasetIn,hash(	rAIDWork_RawStruct.Line1,rAIDWork_RawStruct.Line2,rAIDWork_RawStruct.Line3,rAIDWork_RawStruct.LineLast));
				dRawSlimSeqDistSort		:=	sort(dRawSlimSeqDist,		rAIDWork_RawStruct.Line1,rAIDWork_RawStruct.Line2,rAIDWork_RawStruct.Line3,rAIDWork_RawStruct.LineLast,AIDWork_OriginalRawAID,AIDWork_RecordID,local);
				recordof(Layouts.rRawSlimSeq) tRawSlimSeq_SetSameAsRecordID(dRawSlimSeqDistSort pLeft, dRawSlimSeqDistSort pRight)
				 :=
					transform
						self.AIDWork_RawStructSameAsRecordID	:=	if(pLeft.rAIDWork_RawStruct 	=	pRight.rAIDWork_RawStruct
																										 and pLeft.AIDWork_OriginalRawAID	=	pRight.AIDWork_OriginalRawAID
																										 and pLeft.AIDWork_RecordID		<>	0,
																												 pLeft.AIDWork_RawStructSameAsRecordID,	// All equal and not first record
																												 pRight.AIDWork_RawStructSameAsRecordID
																												);
						self																	:=	pRight;
					end
				 ;
				dRawSlimSeq_SetSameAsRecordID	:=	iterate(distributed(dRawSlimSeqDistSort,hash(rAIDWork_RawStruct.Line1,rAIDWork_RawStruct.Line2)),tRawSlimSeq_SetSameAsRecordID(left,right),local);
				return dRawSlimSeq_SetSameAsRecordID;
			end
		 ;

		/**************************************************************************************
		 ** Join raw cache with unique raw records, appending AID values when they exist
		 ** Parameters
		 **	pDatasetInDistSort		In, Required:	Sort(Line1,Line2,Line3,LineLast,RawAID,RecordID,LOCAL), Dist(Line1,Line2)
		 ** Datasets Used
		 **	dRawMasterDist				Sort(Line1,Line2,Line3,LineLast,AID,LOCAL, Dist(Line1,Line2,Line3,LineLast) (done here)
		 ** Returned			
		 **												Sort(Line1,Line2,Line3,LineLast,RawAID,RecordID,LOCAL)
		 ** Other             		AIDWork_IsInRawCache is FALSE if not already in Raw Cache
		 **                   		Will contain multiple records per Raw AID if previously parsed to multiple StdAID values
		 **************************************************************************************/
		shared	dataset(Layouts.rRawSlimSeqRawCache)	fAppendRawCacheFromRawInput(dataset(Layouts.rRawSlimSeq) pDatasetInDistSort)
		 :=
			function
				dRawMasterDist				:=	Files.RawCacheProdDist_RawStruct; 								// RawStruct is currently Line1, Line2
				dRawMasterDistSort		:=	sort(dRawMasterDist,Line1,Line2,Line3,LineLast,AID,local);		// if keep(1) in join, gives us only lowest AID for that Line1/Line2 combination
				Layouts.rRawSlimSeqRawCache	tAppendRawCacheFromInputRawAID(pDatasetInDistSort pRawInput, dRawMasterDistSort pRawMaster)
				 :=
					transform
						// Incoming fields
						self.AIDWork_RecordID									:=	pRawInput.AIDWork_RecordID;
						self.AIDWork_RawStructSameAsRecordID	:=	pRawInput.AIDWork_RawStructSameAsRecordID;
						self.AIDWork_OriginalRawAID						:=	pRawInput.AIDWork_OriginalRawAID;
						self.rAIDWork_RawStruct								:=	pRawInput.rAIDWork_RawStruct;
						self.rAIDWork_RawCache.AddressType		:=	Common.eAddressType.Raw;
						self.AIDWork_IsInRawCache							:=	pRawMaster.AID <> 0;	// Boolean...  if true, it was found in the cache.  Otherwise, it will be new.
						// Appended fields (everything else from master)
						self.rAIDWork_RawCache								:=	pRawMaster;
					end
				 ;
				dAppendRawCacheFromInputRawAID	:=	join(distributed(pDatasetInDistSort,hash(rAIDWork_RawStruct.Line1,rAIDWork_RawStruct.Line2,rAIDWork_RawStruct.Line3,rAIDWork_RawStruct.LineLast)),dRawMasterDistSort,
																								 left.rAIDWork_RawStruct.Line1 = right.Line1
																						 and left.rAIDWork_RawStruct.Line2 = right.Line2
																						 and left.rAIDWork_RawStruct.Line3 = right.Line3
																						 and left.rAIDWork_RawStruct.LineLast = right.LineLast
																						 and left.AIDWork_OriginalRawAID = right.AID,
																								 tAppendRawCacheFromInputRawAID(left,right),
																								 nosort,
																								 left outer,
																								 local
																								);
				dAppendRawCacheFoundInRawMaster			:=	dAppendRawCacheFromInputRawAID(rAIDWork_RawCache.AID <> 0);
				dAppendRawCacheNotFoundInRawMaster	:=	dAppendRawCacheFromInputRawAID(rAIDWork_RawCache.AID = 0);
				dRawMasterDistSortDedupStruct				:=	dedup(dRawMasterDistSort,Line1,Line2,Line3,LineLast,local);
				// Get all normalized Raw master recs, but for only one AID per Struct in case multiple of same Line1/Line2 have been added (concurrency)
				dRawMasterDistSortUse								:=	join(dRawMasterDistSort,dRawMasterDistSortDedupStruct,	
																										 left.Line1 = right.Line1
																								 and left.Line2 = right.Line2
																								 and left.Line3 = right.Line3
																								 and left.LineLast = right.LineLast
																								 and left.AID = right.AID,
																										 nosort,
																										 local
																										);
				Layouts.rRawSlimSeqRawCache	tAppendRawCacheFromRawStruct(dAppendRawCacheNotFoundInRawMaster pRawInput, dRawMasterDistSortUse pRawMaster)
				 :=
					transform
						// Incoming fields
						self.AIDWork_RecordID									:=	pRawInput.AIDWork_RecordID;
						self.AIDWork_RawStructSameAsRecordID	:=	pRawInput.AIDWork_RawStructSameAsRecordID;
						self.rAIDWork_RawCache.AddressType		:=	pRawInput.rAIDWork_RawCache.AddressType;
						self.AIDWork_OriginalRawAID						:=	pRawInput.AIDWork_OriginalRawAID;
						self.rAIDWork_RawStruct								:=	pRawInput.rAIDWork_RawStruct;
						self.AIDWork_IsInRawCache							:=	pRawMaster.AID <> 0;	// Boolean...  if true, it was found in the cache.  Otherwise, it will be new.
						// Appended fields (everything else from master)
						self.rAIDWork_RawCache								:=	pRawMaster;
					end
				 ;
				// Get all normalized Raw master recs (one each for Raw-Std pair).  dRawMasterDistSortUse provides only one AID per Line1/Line2 pair
				dAppendRawCacheFromRawStruct	:=	join(distributed(dAppendRawCacheNotFoundInRawMaster,hash(rAIDWork_RawStruct.Line1,rAIDWork_RawStruct.Line2,rAIDWork_RawStruct.Line3,rAIDWork_RawStruct.LineLast)),dRawMasterDistSortUse,
																							 left.rAIDWork_RawStruct.Line1 = right.Line1
																					 and left.rAIDWork_RawStruct.Line2 = right.Line2
																					 and left.rAIDWork_RawStruct.Line3 = right.Line3
																					 and left.rAIDWork_RawStruct.LineLast = right.LineLast,
																							 tAppendRawCacheFromRawStruct(left,right),
																							 nosort,
																							 left outer,
																							 local
																							);
				dAppendRawCacheFromRawInput		:=	sort(dAppendRawCacheFoundInRawMaster + dAppendRawCacheFromRawStruct,rAIDWork_RawStruct.Line1,rAIDWork_RawStruct.Line2,rAIDWork_RawStruct.Line3,rAIDWork_RawStruct.LineLast,AIDWork_OriginalRawAID,AIDWork_RecordID,local);;
				return dAppendRawCacheFromRawInput;
			end
		 ;

		/**************************************************************************************
		 ** For raw not found in raw cache, apply RawID
		 ** Dataset Parms		Distribution
		 **	pDatasetIn			Expected to be UNIQUEs only, locally sorted on Line1,Line2,RawAID,RecordID, distributed by Line1,Line2
		 ** Returned			Expected to be locally sorted on Line1,Line2,RawAID,RecordID, distributed by Line1,Line2
		 **************************************************************************************/
		shared	dataset(Layouts.rRawSlimSeqRawCache)	fPrepareNewRawCacheRecords(dataset(Layouts.rRawSlimSeqRawCache) pDatasetIn)
		 :=
			function
				recordof(Layouts.rRawSlimSeqRawCache) tPrepNewRawCacheRecords(pDatasetIn pInput)
				 :=
					transform
						self.rAIDWork_RawCache.AID						:=	Common.fGetNextAID();
						self.rAIDWork_RawCache.Hash32_Full		:=	hash32(pInput.rAIDWork_RawStruct.Line1,pInput.rAIDWork_RawStruct.Line2,pInput.rAIDWork_RawStruct.Line3,pInput.rAIDWork_RawStruct.LineLast);
						self.rAIDWork_RawCache.CountSeen			:=	1;
						self.rAIDWork_RawCache.DateSeenFirst	:=	lCurrentDate;
						self.rAIDWork_RawCache.DateSeenLast		:=	lCurrentDate;
						self.rAIDWork_RawCache.Line1					:=	pInput.rAIDWork_RawStruct.Line1;
						self.rAIDWork_RawCache.Line2					:=	pInput.rAIDWork_RawStruct.Line2;
						self.rAIDWork_RawCache.Line3					:=	pInput.rAIDWork_RawStruct.Line3;
						self.rAIDWork_RawCache.LineLast				:=	pInput.rAIDWork_RawStruct.LineLast;
						self.rAIDWork_RawCache.StdAID					:=	0;
						self.rAIDWork_RawCache.IsNormalized		:=	false;
						self.rAIDWork_RawCache.NormalizeFlags	:=	Common.eNormalizeFlag.None;
						self.rAIDWork_RawCache.CreatedWUID		:=	workunit;
						self																	:=	pInput;
					end
				 ;
				dPrepNewRawCacheRecords	:=	project(pDatasetIn,tPrepNewRawCacheRecords(left));
				recordof(Layouts.rRawSlimSeqRawCache) tPrepareNewRawCacheRecords(dPrepNewRawCacheRecords pInput)
				 :=
					transform
						self.rAIDWork_RawCache.ReferAID				:=	pInput.rAIDWork_RawCache.AID;	// Cannot assign to both fields above, as it will call twice and produce two different IDs.
						self																	:=	pInput;
					end
				 ;
				dPrepareNewRawCacheRecords	:=	project(dPrepNewRawCacheRecords,tPrepareNewRawCacheRecords(left));
				return	dPrepareNewRawCacheRecords;
			end
		 ;

		/**************************************************************************************/
		export	dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache)	fPropagateToDuplicates(dataset(Layouts.rRawSlimSeq) pDuplicates, dataset(Layouts.rRawSlimSeqRawCacheStdCacheACECache) pCompleted)
		 :=
			function
				dDuplicatesDist		:=	distribute(pDuplicates,(AIDWork_RawStructSameAsRecordID - 1) % lib_ThorLib.ThorLib.nodes());
				dCompletedDist		:=	distribute(pCompleted,(AIDWork_RecordID - 1) % lib_ThorLib.ThorLib.nodes());
				recordof(dCompletedDist)	tPropagateToDuplicates(dDuplicatesDist pDuplicatesIn, dCompletedDist pCompletedIn)
				 :=
					transform
						self.AIDWork_RecordID									:=	pDuplicatesIn.AIDWork_RecordID;
						self.AIDWork_RawStructSameAsRecordID	:=	pDuplicatesIn.AIDWork_RawStructSameAsRecordID;	// Probably discarding shortly, but just in case
						self.AIDWork_OriginalRawAID						:=	pDuplicatesIn.AIDWork_OriginalRawAID;
						self.rAIDWork_RawStruct								:=	pDuplicatesIn.rAIDWork_RawStruct;
						self																	:=	pCompletedIn;
					end
				 ;
				dPropagateToDuplicates	:=	join(dDuplicatesDist,dCompletedDist,
																				 left.AIDWork_RawStructSameAsRecordID = right.AIDWork_RecordID,
																				 tPropagateToDuplicates(left,right),
																				 local
																				);
				return	dPropagateToDuplicates;
			end
		 ;

		/**************************************************************************************
		 ** Full Raw process, prepped for Std Handlers
		 **************************************************************************************/
		export	mFullPrep(dataset(Layouts.rRawSlimSeq) pDatasetIn)
		 :=
			module
				shared	dDatasetIn_SetSameAsRecordID	:=	fSetSameAsRecordID(pDatasetIn);
				shared	dDatasetInDistSortUnique			:=	dDatasetIn_SetSameAsRecordID(AIDWork_RecordID = AIDWork_RawStructSameAsRecordID);
				shared	dDatasetInDistSortDuplicates	:=	dDatasetIn_SetSameAsRecordID(AIDWork_RecordID <> AIDWork_RawStructSameAsRecordID);

				shared	dRawCacheAppended							:=	fAppendRawCacheFromRawInput(dDatasetInDistSortUnique);
				shared	dRawInRawCache								:=	dRawCacheAppended(AIDWork_IsInRawCache);
				shared	dNotInRawCache								:=	dRawCacheAppended(not AIDWork_IsInRawCache);
				shared	dRawNotInRawCache							:=	fPrepareNewRawCacheRecords(dNotInRawCache);

				export	fFoundAndNew									:=	dRawInRawCache + dRawNotInRawCache;
				export	fDuplicates										:=	dDatasetInDistSortDuplicates;
			end
		 ;

  end
 ;
