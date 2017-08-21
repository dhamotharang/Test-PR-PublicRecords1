import property,advo,phonesplus,gong_v2,ut;
/*
rolled up on vendor_id
*/
export fSummarize_Business(

	 dataset(Layouts.laybus													)	pCorpV2						= fSummarize_Business_CorpV2()
	,dataset(Layouts.laycont												)	pContSumm					= fSummarize_Contact				()
	,dataset(layouts.temporary.AggregateCorpV2Bdids	)	pAggCorpV2Bdids		= Aggregate_CorpV2_Bdids		()
	,dataset(layouts.Temporary.counts								)	pCount_Bankruptcy	= Count_Bankruptcy().fBdid()
	,dataset(layouts.Temporary.counts								)	pCount_LJs				= Count_LJs				().fBdid()
	,dataset(layouts.Temporary.counts								)	pCount_UCC				= Count_UCC				().fBdid()
	,string 																					pDateFilter				= _Dataset().CurrentDate

) :=
function

	dCorpV2_withbdid							:= pCorpV2(bdid != 0);
	dCorpV2_withoutbdid						:= pCorpV2(bdid  = 0);

	dCount_Bankruptcy_withbdid		:= pCount_Bankruptcy(id != 0);
	dCount_Bankruptcy_withoutbdid	:= pCount_Bankruptcy(id  = 0);

	dCount_LJs_withbdid						:= pCount_LJs(id != 0);
	dCount_LJs_withoutbdid				:= pCount_LJs(id  = 0);

	dCount_UCC_withbdid						:= pCount_UCC(id != 0);
	dCount_UCC_withoutbdid				:= pCount_UCC(id  = 0);
	
	// -- Join to counts to get them per source, vendor_id,bdid
	dgetbkcounts := join(
		 distribute(pAggCorpV2Bdids							,bdid	)
		,distribute(dCount_Bankruptcy_withbdid	,id		)
		,left.bdid = right.id
		,transform(Layouts.temporary.AggregateCorpV2Bdids_extra
			,self.Count_Bankruptcies_business 		:= right.Count_filings;
			 self.Count_Liens_Judgements_business := 0;
			 self.Count_UCCs_business							:= 0;
			 self := left;
		)
		,left outer
		,local
	);
	
	dgetljcounts := join(
		 distribute(dgetbkcounts					,bdid	)
		,distribute(dCount_LJs_withbdid	,id		)
		,left.bdid = right.id
		,transform(Layouts.temporary.AggregateCorpV2Bdids_extra
			,self.Count_Liens_Judgements_business := right.Count_filings;
			 self := left;
		)
		,left outer
		,local
	);

	dgetucccounts := join(
		 distribute(dgetljcounts				,bdid	)
		,distribute(dCount_UCC_withbdid	,id		)	
		,left.bdid = right.id
		,transform(Layouts.temporary.AggregateCorpV2Bdids_extra
			,self.Count_UCCs_business := right.Count_filings;
			 self := left;
		)
		,left outer
		,local
	);
	
	dcountrollup := rollup(
		sort(distribute(dgetucccounts	,hash64(vendor_id)),source,vendor_id,local)
		,		left.source			= right.source
		and left.vendor_id	= right.vendor_id
		,transform(
			 Layouts.temporary.AggregateCorpV2Bdids_extra
			,self.Count_UCCs_business							:= left.Count_UCCs_business							+ right.Count_UCCs_business							;
			 self.Count_Liens_Judgements_business	:= left.Count_Liens_Judgements_business + right.Count_Liens_Judgements_business	;
			 self.Count_Bankruptcies_business			:= left.Count_Bankruptcies_business			+ right.Count_Bankruptcies_business			;
			 self := left;
		)
		,local
	);

	//now join back to pCorpV2 to append the counts
	dgetcounts := join(
		 distribute(pCorpV2				,hash64(vendor_id))
		,distribute(dcountrollup	,hash64(vendor_id))
		,		left.source 		= right.source
		and left.vendor_id	= right.vendor_id
		,transform(
			Layouts.laybus
			,self.Count_UCCs_business							:= right.Count_UCCs_business						;
			 self.Count_Liens_Judgements_business := right.Count_Liens_Judgements_business;
			 self.Count_Bankruptcies_business 		:= right.Count_Bankruptcies_business 		;
			 self 																:= left;
		)
		,local
		,left outer
	);

	d4rollup := dgetcounts;

	// ----------------------------------------------------------
	// -- Rollup
	// ----------------------------------------------------------
	dcorp_rollup2 := rollup(sort(distribute(d4rollup, hash64(vendor_id)), source,vendor_id, -Date_Current_Status,local)
		,left.vendor_id = right.vendor_id
		and left.source = right.source
		,transform(
			 Layouts.laybus
			 ,
				// address changes if 
			 self.bdid 										:= business_functions.mymin(left.bdid,right.bdid);
			 self.vendor_id     					:= left.vendor_id;
			 self.source 									:= left.source;
			 self.latest_status     			:= if(business_functions.mymax(left.Date_Current_Status, right.Date_Current_Status) = left.Date_Current_Status
																					,left.latest_status
																					,right.latest_status
																			);
			 self.Date_Filing_First_Seen	:= business_functions.mymin(left.Date_Filing_First_Seen,right.Date_Filing_First_Seen	);
			 self.Date_Filing_Last_Seen 	:= business_functions.mymax(left.Date_Filing_last_Seen	,right.Date_Filing_last_Seen	);
			 self.Date_Current_Status 		:= business_functions.mymax(left.Date_Current_Status, right.Date_Current_Status);
			 //so check statuses to make sure it is a different status, only populate if true
			 //also check that it is less than current status date, but 
			 
			 self.date_prior_status			 	:= if(left.latest_status != right.latest_status
																					,if(left.date_prior_status > right.date_prior_status
																					and left.date_prior_status < self.Date_Current_Status
																						,left.date_prior_status
																						,right.date_prior_status
																					)
																					,left.date_prior_status
																			);
			 self.Date_Last_Event 								:= business_functions.mymax(left.Date_Last_Event								,right.Date_Last_Event								);
			 self.Date_Last_Derog_Event						:= business_functions.mymax(left.Date_Last_Derog_Event					,right.Date_Last_Derog_Event					);
			 self.Date_Most_Recent_Dissolution		:= business_functions.mymax(left.Date_Most_Recent_Dissolution	,right.Date_Most_Recent_Dissolution		);
			 self.Date_Most_Recent_Reinstatement	:= business_functions.mymax(left.Date_Most_Recent_Reinstatement,right.Date_Most_Recent_Reinstatement	);
			 
			 self.count_address_changes										:= left.count_address_changes									+ right.count_address_changes									;
			 self.Count_Business_At_Address								:= left.Count_Business_At_Address							+ right.Count_Business_At_Address							;
			 self.Count_Delinquent_Business_At_Address		:= left.Count_Delinquent_Business_At_Address	+ right.Count_Delinquent_Business_At_Address	;
			 self.Count_Derogatory_Business_At_Address		:= left.Count_Derogatory_Business_At_Address	+ right.Count_Derogatory_Business_At_Address	;			 
			 self.Count_Delinquent_Statuses 							:= left.Count_Delinquent_Statuses 						+ right.Count_Delinquent_Statuses							;
			 self.Count_Derog_Events 											:= left.Count_Derog_Events 		 								+ right.Count_Derog_Events 										;
			 self.Count_Bankruptcies_Business 						:= left.Count_Bankruptcies_Business 		 			+ right.Count_Bankruptcies_Business 					;
			 self.Count_Liens_Judgements_business 				:= left.Count_Liens_Judgements_business 			+ right.Count_Liens_Judgements_business				;
			 self.Count_UCCs_business 										:= left.Count_UCCs_business 						 			+ right.Count_UCCs_business 									;
			 
			 self.time_since_last_report_date							:= ut.DaysApart(pDateFilter,(string)self.Date_Filing_Last_Seen) / 30;
			 self.time_between_filings										:= if(self.Date_Current_Status != 0 and self.date_prior_status != 0,ut.DaysApart((string)self.Date_Current_Status, (string)self.date_prior_status) / 30,0);
			 self.time_between_events											:= if(left.time_between_events != 0, left.time_between_events,right.time_between_events);
			 self.time_between_dissolution_reinstatement	:= if(self.Date_Most_Recent_Dissolution != 0 and self.Date_Most_Recent_Reinstatement != 0
																														,ut.DaysApart((string)self.Date_Most_Recent_Dissolution, (string)self.Date_Most_Recent_Reinstatement) / 30
																														,0
																												);
			 self																					:= left;
		
		)
		,local
	);
	
	dcorp_sort := project(
								sort(dcorp_rollup2(bdid != 0),-bDid)
							+ dcorp_rollup2(bdid = 0)
							,transform(Layouts.laybus
								,self.date_prior_status := if(left.date_prior_status = left.Date_Current_Status
																							,0
																							,left.date_prior_status
																						);
								 self.Date_Last_Event		:= if(left.Date_Last_Event != 0, left.Date_Last_Event,left.Date_Filing_Last_Seen);
								 self										:= left;
							)
						)
						;

	dcorpreturn_debug := dcorp_sort;

	dcorpreturn_prod := project(dcorp_sort,transform(layouts.business_summary, /*self.count_address_changes := left.count_address_changes1 + left.count_address_changes2;*/self := left));

	#if(_Dataset().IsDebugging = true)
		dcorp_return := dcorpreturn_debug
		: persist(persistnames().fSummarizeBusiness);
	#else
		dcorp_return := dcorpreturn_prod
		: persist(persistnames().fSummarizeBusiness);
	#end
	
	return dcorp_return;

end;