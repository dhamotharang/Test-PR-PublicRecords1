import corp2,ut;
export Aggregate_CorpV2_Events 
(

	 dataset(Corp2.Layout_Corporate_Direct_Event_Base	) pCorpEvent		= Prep_CorpV2.fEvent()
	,boolean																						pShouldFilter	= false
	,string																							pPersistname	= persistnames().AggregateCorpV2Events
	,string 																						pDateFilter		= _Dataset().CurrentDate

) :=
function
	
	dderog_events := pCorpEvent(business_functions.fIsDerogEvent(event_filing_desc));
	
	dprep := if(pShouldFilter
		,dderog_events
		,pCorpEvent
	);

	//		unsigned8 time_between_events										;	// # of months between latest event and previous event
	devent_prep := project(dprep, transform(
		layouts.temporary.AggregateCorpV2Events
		,self.vendor_id							:= left.corp_key;
		 self.Date_Filing_Last_Seen := if((unsigned4)left.event_filing_date != 0
																			,(unsigned4)left.event_filing_date
																			,if(left.dt_last_seen <= (unsigned4)pDateFilter,left.dt_last_seen,0));
		 self.time_between_events		:= 0;
		 self.count_derog_events		:= if(pShouldFilter,1,0);
	));
	
	devent_sort := group(sort(distribute(devent_prep	,hash64(vendor_id)),vendor_id,-Date_Filing_Last_Seen,local),vendor_id,local);
	
	devent_iterate := group(iterate(devent_sort	
			,transform(
				 layouts.temporary.AggregateCorpV2Events
				,self.vendor_id							:= right.vendor_id;
				 self.Date_Filing_Last_Seen := right.Date_Filing_Last_Seen;
				 self.time_between_events		:= if(counter > 1 and left.time_between_events = 0 and left.Date_Filing_Last_Seen != 0 and right.Date_Filing_Last_Seen !=  0
																				,ut.DaysApart((string)left.Date_Filing_Last_Seen,(string)right.Date_Filing_Last_Seen) / 30
																				,left.time_between_events
																			);
				 self.count_derog_events		:= right.count_derog_events;
			)
			
	));
	
	devent_rollup := rollup(sort(distribute(devent_iterate,hash64(vendor_id)),vendor_id,local)
	,left.vendor_id = right.vendor_id
	,transform(
		 layouts.temporary.AggregateCorpV2Events
		,self.vendor_id := left.vendor_id;
		 self.Date_Filing_Last_Seen := if((unsigned4)left.Date_Filing_Last_Seen > (unsigned4)right.Date_Filing_Last_Seen
																			,(unsigned4)left.Date_Filing_Last_Seen
																			,(unsigned4)right.Date_Filing_Last_Seen
																	);
		 self.time_between_events		:= if(left.time_between_events = 0,right.time_between_events,left.time_between_events);
		 self.count_derog_events		:= left.count_derog_events + right.count_derog_events;
	)
	,local
	);
	
	dreturn := sort(devent_rollup,vendor_id)
			: persist(pPersistname);

	return dreturn;
	
end;