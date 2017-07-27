/**************************************************************************************
 ** MacAppendFromRaw(  	  RecSetIn			// Incoming dataset
						 ,Line1Field		// Fieldname of address Line1
						 ,Line2Field		// Fieldname of address Line2
						 ,Line3Field		// Fieldname of address Line3
						 ,LineLastField		// Fieldname of address LineLast (city, state, zip)
						 ,RawAIDInField		// Fieldname of incoming Raw Address ID
						 ,RecSetOut			// Resulting dataset out-reference
						[,RunFlags]			// Bitmap of options for run and returned dataset (Optional:  Default is AID.Common.eReturnValues.Default)
						[,Metrics]			// Boolean, whether to include metrics output to workunit (Optional:  Default is FALSE)
					);

 **************************************************************************************/
export MacAppendFromRaw(pDatasetIn, pLine1, pLine2, pLine3, pLineLast, pRawAID, pDatasetOut, pReturnValues=AID.Common.eReturnValues.Default, pOutputMetrics=false)
 :=
  macro
		import	lib_ThorLib;
			#uniquename(dLinesPreppedSequenced);
			#uniquename(dLinesPreppedSlim);
		// ??Use something to confirm node count, failing if hthor '** Self-Abort ** -- Source:  AID.MacAppendFromRaw -- Reason: Not to be used on hthor.'
		AID.mRawHandlers.MacSequenceOriginalDataset(pDatasetIn,%dLinesPreppedSequenced%);
		AID.mRawHandlers.MacRawSlimSequenced(%dLinesPreppedSequenced%,pLine1,pLine2,pLine3,pLineLast,pRawAID,%dLinesPreppedSlim%);

			#uniquename(dRawPrepped);
			#uniquename(dStdPrepped);
			#uniquename(dACEPrepped);
			#uniquename(dCompleted);
		%dRawPrepped%		:=	AID.mRawHandlers.mFullPrep(%dLinesPreppedSlim%).fFoundAndNew;
		%dStdPrepped%		:=	AID.mStdHandlers.mFullPrep(%dRawPrepped%).fFoundAndNew;
		%dACEPrepped%		:=	AID.mACEHandlers.mFullPrep(%dStdPrepped%).fFoundAndNew;
		
			#uniquename(dACEDuplicates);
			#uniquename(dPropagateToACEDuplicates);
		%dACEDuplicates%						:=	AID.mACEHandlers.mFullPrep(%dStdPrepped%).fDuplicates;
		%dPropagateToACEDuplicates%	:=	AID.mACEHandlers.fPropagateToACEDuplicates(%dACEDuplicates%,%dACEPrepped%);

			#uniquename(dStdDuplicates);
			#uniquename(dPropagateToStdDuplicates);
		%dStdDuplicates%						:=	AID.mStdHandlers.mFullPrep(%dRawPrepped%).fDuplicates;
		%dPropagateToStdDuplicates%	:=	AID.mStdHandlers.fPropagateToStdDuplicates(%dStdDuplicates%,%dPropagateToACEDuplicates% + %dACEPrepped%);

			#uniquename(dRawDuplicates);
			#uniquename(dPropagateToRawDuplicates);
		%dRawDuplicates%						:=	AID.mRawHandlers.mFullPrep(%dLinesPreppedSlim%).fDuplicates;
		%dPropagateToRawDuplicates%	:=	AID.mRawHandlers.fPropagateToDuplicates(%dRawDuplicates%,%dPropagateToACEDuplicates% + %dPropagateToStdDuplicates% + %dACEPrepped%);

			#uniquename(dCompletedReDist);
			#uniquename(dCompletedReSort);
			// The following function call forces the side-effect of writing the ADD and UPDATE files for Cache
		%dCompletedReDist%					:=	AID.fOutputNewCacheFiles(distribute(%dACEPrepped% + %dPropagateToRawDuplicates% + %dPropagateToStdDuplicates% + %dPropagateToACEDuplicates%, (AIDWork_RecordID - 1) % lib_ThorLib.ThorLib.nodes()), pReturnValues);
			// The following function call forces the side-effect of a SOAPCALL to WUPushEvent (internal version of NOTIFY()) to alert waiting WU to add new files to cache superfiles
		// %dCompletedReSort%					:=	AID.fNotifyNewCacheFiles(sort(%dCompletedReDist%,AIDWork_RecordID,rAIDWork_ACECache.geo_match,-rAiDWork_StdCache.ReturnCode[1],local));
		%dCompletedReSort%					:=	sort(%dCompletedReDist%,AIDWork_RecordID,rAIDWork_ACECache.geo_match,-rAiDWork_StdCache.ReturnCode[1],-rAIDWork_StdCache.Line1,local);  // Adding Std Line1 to ensure "E" consistently sorted

			#uniquename(rRawAndCompleted);
		%rRawAndCompleted%
		 :=
			record
				recordof(%dLinesPreppedSequenced%);
					#if(pReturnValues & AID.Common.eReturnValues.IsInCacheFlags <> 0)
				typeof(%dCompletedReSort%.AIDWork_IsInRawCache)	AIDWork_IsInRawCache;
				typeof(%dCompletedReSort%.AIDWork_IsInStdCache)	AIDWork_IsInStdCache;
				typeof(%dCompletedReSort%.AIDWork_IsInACECache)	AIDWork_IsInACECache;
					#end
					#if(pReturnValues & AID.Common.eReturnValues.RawAID <> 0 and pReturnValues & AID.Common.eReturnValues.RawCacheRecord = 0)
				typeof(AID.Layouts.rRawCache.AID)	AIDWork_RawAID;
					#end
					#if(pReturnValues & AID.Common.eReturnValues.RawCacheRecord <> 0)
				AID.Layouts.rRawCache				AIDWork_RawCache;
					#end
					#if(pReturnValues & AID.Common.eReturnValues.StdAIDs <> 0 and pReturnValues & AID.Common.eReturnValues.StdCacheRecords = 0)
				typeof(AID.Layouts.rStdCache.AID)	AIDWork_StdAID;
					#end
					#if(pReturnValues & AID.Common.eReturnValues.StdCacheRecords <> 0)
				AID.Layouts.rStdCache				AIDWork_StdCache;
					#end
					#if(pReturnValues & AID.Common.eReturnValues.ACEAIDs <> 0 and pReturnValues & AID.Common.eReturnValues.ACECacheRecords = 0)
				typeof(AID.Layouts.rACECache.AID)	AIDWork_ACEAID;
					#end
					#if(pReturnValues & AID.Common.eReturnValues.ACECacheRecords <> 0)
				AID.Layouts.rACECache				AIDWork_ACECache;
					#end
			end : onwarning(1041, ignore)
		 ;

		#uniquename(tRawAndCompleted);
		%rRawAndCompleted%	%tRawAndCompleted%(%dLinesPreppedSequenced% pRawSeq, %dCompletedReSort% pCompleted)
		 :=
			transform
					#if(pReturnValues & AID.Common.eReturnValues.IsInCacheFlags <> 0)
				self.AIDWork_IsInRawCache				:=	pCompleted.AIDWork_IsInRawCache;
				self.AIDWork_IsInStdCache				:=	pCompleted.AIDWork_IsInStdCache;
				self.AIDWork_IsInACECache				:=	pCompleted.AIDWork_IsInACECache;
					#end
					#if(pReturnValues & AID.Common.eReturnValues.RawAID <> 0 and pReturnValues & AID.Common.eReturnValues.RawCacheRecord = 0)
				self.AIDWork_RawAID							:=	pCompleted.rAIDWork_RawCache.AID;
					#end
					#if(pReturnValues & AID.Common.eReturnValues.RawCacheRecord <> 0)
				self.AIDWork_RawCache.StdAID		:=	if(pCompleted.rAIDWork_RawCache.StdAID = 0,
																							 pCompleted.rAIDWork_StdCache.AID,
																							 pCompleted.rAIDWork_RawCache.StdAID
																							);
				self.AIDWork_RawCache						:=	pCompleted.rAIDWork_RawCache;
					#end
					#if(pReturnValues & AID.Common.eReturnValues.StdAIDs <> 0 and pReturnValues & AID.Common.eReturnValues.StdCacheRecords = 0)
				self.AIDWork_StdAID							:=	pCompleted.rAIDWork_StdCache.AID;
					#end
					#if(pReturnValues & AID.Common.eReturnValues.StdCacheRecords <> 0)
				self.AIDWork_StdCache.CleanAID	:=	if(pCompleted.rAIDWork_StdCache.CleanAID = 0,
																							 pCompleted.rAIDWork_ACECache.AID,
																							 pCompleted.rAIDWork_StdCache.CleanAID
																							);
				self.AIDWork_StdCache						:=	pCompleted.rAIDWork_StdCache;
					#end
					#if(pReturnValues & AID.Common.eReturnValues.ACEAIDs <> 0 and pReturnValues & AID.Common.eReturnValues.ACECacheRecords = 0)
				self.AIDWork_ACEAID							:=	pCompleted.rAIDWork_AcECache.AID;
					#end
					#if(pReturnValues & AID.Common.eReturnValues.ACECacheRecords <> 0)
				self.AIDWork_ACECache.err_stat	:=	pCompleted.rAIDWork_StdCache.ReturnCode;
				self.AIDWork_ACECache						:=	pCompleted.rAIDWork_ACECache;
					#end
				self														:=	pRawSeq;
			end
		 ;

			#if(pReturnValues & AID.Common.eReturnValues.AllowMultiple <> 0)
		pDatasetOut := join(%dLinesPreppedSequenced%,%dCompletedReSort%,
												left.AIDWork_RecordID = right.AIDWork_RecordID,
												%tRawAndCompleted%(left,right),
												left outer,
												nosort,
												local
											 );
			#else
		pDatasetOut := join(%dLinesPreppedSequenced%,%dCompletedReSort%,
												left.AIDWork_RecordID = right.AIDWork_RecordID,
												%tRawAndCompleted%(left,right),
												left outer,
												nosort,
												keep(1),
												local
											 );
			#end
  endmacro
 ;
