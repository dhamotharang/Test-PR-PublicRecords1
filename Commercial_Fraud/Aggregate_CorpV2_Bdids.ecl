import corp2,mdr;

export Aggregate_CorpV2_Bdids(

	 dataset(Corp2.Layout_Corporate_Direct_Corp_Base	) pCorp	= Prep_CorpV2.fCorp()
	
) :=
function

	dcorpv2_slim := project(pCorp	,
		transform(
		 layouts.temporary.AggregateCorpV2Bdids
		,self.source		:= mdr.sourceTools.fcorpv2(left.corp_key,left.corp_state_origin);
		 self.vendor_id := left.corp_key;
		 self.bdid			:= left.bdid;
	));

	
	dcorpv2_unique := dedup(dcorpv2_slim	,hash64(source,vendor_id,bdid),all,hash)
	: persist(persistnames().AggregateCorpV2Bdids);
		
	return dcorpv2_unique;
	
end;