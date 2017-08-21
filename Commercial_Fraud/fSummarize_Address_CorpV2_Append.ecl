import corp2;

export fSummarize_Address_CorpV2_Append(

	 dataset(Corp2.Layout_Corporate_Direct_Corp_Base	) pCorp						= Prep_CorpV2.fCorp()
	,dataset(Corp2.Layout_Corporate_Direct_Cont_Base	) pCorpCont				= Prep_CorpV2.fCont()
	,dataset(Corp2.Layout_Corporate_Direct_Event_Base	) pCorpEvent			= Prep_CorpV2.fEvent()
	,string																							pPersistname		= Persistnames().fSummarizeAddressCorpV2Append

) :=
function

	// give me rolled up biz file on vendor_id, has latest_status in it
	dRollupCorpV2Info		:= fSummarize_Business_CorpV2_rollup	(pCorp	,pCorpCont);
	
	// get me derog events per vendor_id
	devent_derog_rollup := Aggregate_CorpV2_Events(pCorpEvent,true	,persistnames().AggregateCorpV2EventsDerog);

	dcorp_join2eventderog := join(
		 distribute(dRollupCorpV2Info		,hash64(vendor_id))
		,distribute(devent_derog_rollup	,hash64(vendor_id))
		,left.vendor_id = right.vendor_id
		,transform(
			layouts.temporary.BusinessSummary
			,self.Date_Last_Derog_Event	:= right.Date_Filing_Last_Seen;
			 self.count_Derog_Events		:= right.count_derog_events;
			 self												:= left;
		)
		,local
		,left outer
	);
	
	//still rolled up by vendor_id

	dcorp_standard := project(dcorp_join2eventderog,transform(layouts.temporary.BusinessSummary,self := left))
			: persist(pPersistname);
	
	return dcorp_standard;

	
end;
