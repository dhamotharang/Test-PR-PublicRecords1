export Files
 :=
  module
		/**************************************************************************************
		** Raw Cache
		**************************************************************************************/
		shared	dataset(Layouts.rRawCache)	fRawDataset(string pActivity, string pVersion)
		 :=	dataset('~' + Common.eFileName.fConstruct(Common.eAddressType.Raw, pActivity, pVersion),Layouts.rRawCache,thor,opt);

		export	RawCacheDiscard							:=	fRawDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Discard);
		export	RawCacheGrandFather					:=	fRawDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.GrandFather);
		export	RawCacheFather							:=	fRawDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Father);
		export	RawCacheProd								:=	fRawDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Prod);
		export	RawCacheQA									:=	fRawDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.QA);
		// Centralizing the distributed references for possible future enhancements to produce, persist, or provide otherwise
		export	RawCacheProdDist_AID				:=	distribute(RawCacheProd,hash(AID));
		export	RawCacheProdDist_StdAID			:=	distribute(RawCacheProd,hash(StdAID));
		export	RawCacheProdDist_RawStruct	:=	distribute(RawCacheProd,hash(Line1,Line2,Line3,LineLast));

		/**************************************************************************************
		** Std Cache
		**************************************************************************************/
		shared	dataset(Layouts.rStdCache)	fStdDataset(string pActivity, string pVersion)
		 :=	dataset('~' + Common.eFileName.fConstruct(Common.eAddressType.Std, pActivity, pVersion),Layouts.rStdCache,thor,opt);
			
		export	StdCacheDiscard							:=	fStdDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Discard);
		export	StdCacheGrandFather					:=	fStdDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.GrandFather);
		export	StdCacheFather							:=	fStdDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Father);
		export	StdCacheProd								:=	fStdDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Prod);
		export	StdCacheQA									:=	fStdDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.QA);
		// Centralizing the distributed references for possible future enhancements to produce, persist, or provide otherwise
		export	StdCacheProdDist_AID				:=	distribute(StdCacheProd,hash(AID));
		export	StdCacheProdDist_CleanAID		:=	distribute(StdCacheProd,hash(CleanAID));
		export	StdCacheProdDist_StdStruct	:=	distribute(StdCacheProd,hash(Line1,LineLast));

		/**************************************************************************************
		** ACE Cache
		**************************************************************************************/
		shared	dataset(Layouts.rACECache)	fACEDataset(string pActivity, string pVersion)
		 :=	dataset('~' + Common.eFileName.fConstruct(Common.eAddressType.ACE, pActivity, pVersion),Layouts.rACECache,thor,opt);

		export	ACECacheDiscard							:=	fACEDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Discard);
		export	ACECacheGrandFather					:=	fACEDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.GrandFather);
		export	ACECacheFather							:=	fACEDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Father);
		export	ACECacheProd								:=	fACEDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Prod);
		export	ACECacheQA									:=	fACEDataset(Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.QA);
		// Centralizing the distributed references for possible future enhancements to produce, persist, or provide otherwise
		export	ACECacheProdDist_AID				:=	distribute(ACECacheProd,hash(AID));
  end
 ;