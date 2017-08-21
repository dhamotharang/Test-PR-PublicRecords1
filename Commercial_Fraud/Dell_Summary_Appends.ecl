export Dell_Summary_Appends :=
module

	export fAppend_Address_Summary(
	
		 dataset(layouts.base														) pDell
		,dataset(Layouts.layaddr												) pAddressSummary		= files().address_summary.built
		,dataset(layouts.temporary.AggregateCorpV2Bdids	)	pAggCorpV2Bdids		= Aggregate_CorpV2_Bdids		()
) :=
	function
	
		dDell_with_bdid			:= pDell(bdid != 0);
		dDell_without_bdid	:= pDell(bdid  = 0);
	
		dAggCorpV2Bdids_with_bdid			:= pAggCorpV2Bdids(bdid != 0);
		dAggCorpV2Bdids_without_bdid	:= pAggCorpV2Bdids(bdid  = 0);

		djoin4bdid1 := join(
			 distribute(pAddressSummary						,hash64(source,vendor_id))
			,distribute(dAggCorpV2Bdids_with_bdid	,hash64(source,vendor_id))
			,		left.source			= right.source
			and left.vendor_id	= right.vendor_id
			,transform(
				 Layouts.layaddr
				,self.bdid	:= right.bdid;
				 self				:= left;
			)
			,local
		);
	
		djoin4bdid2 := join(
			 distribute(pAddressSummary						,hash64(source,vendor_id))
			,distribute(dAggCorpV2Bdids_with_bdid	,hash64(source,vendor_id))
			,		left.source			= right.source
			and left.vendor_id	= right.vendor_id
			,transform(
				 Layouts.layaddr
				,self.bdid	:= left.bdid;
				 self				:= left;
			)
			,local
			,left only
		);
		
		dconcatbdids := djoin4bdid1 + djoin4bdid2;
		dAddressSummary_with_bdid		:= dconcatbdids(bdid != 0);

		djoin1 := join(
			 distribute(dDell_with_bdid						,bdid)
			,distribute(dAddressSummary_with_bdid	,bdid)
			,left.bdid = right.bdid
			,transform(
				 layouts.base
				,self.summary_address := right;
				 self.appended_fields.current_address_change	:= right.current_address_change;
				 self.ace_aid_from_bdid := right.address_id;
				 self									:= left;
			)
			,local
			,keep(1)
		);
		
		djoin2 := join(
			 distribute(dDell_with_bdid						,bdid)
			,distribute(dAddressSummary_with_bdid	,bdid)
			,left.bdid = right.bdid
			,transform(
				 layouts.base
				,self.summary_address := right;
				 self.appended_fields.current_address_change	:= right.current_address_change;
				 self.ace_aid_from_bdid := right.address_id;
				 self									:= left;
			)
			,local
			,left only
		);

		dconcat := dedup(djoin1 + djoin2 + dDell_without_bdid,rawfields.app_ref_key,all);

		return dconcat;
	
	end;

	export fAppend_Business_Summary(
	
		 dataset(layouts.base														) pDell
		,dataset(Layouts.laybus													) pBusinessSummary	= files().business_summary.built
		,dataset(layouts.temporary.AggregateCorpV2Bdids	)	pAggCorpV2Bdids		= Aggregate_CorpV2_Bdids		()
		,dataset(Layouts.layaddr												) pAddressSummary		= files().address_summary.built
	) :=
	function
	
		dDell_with_bdid			:= pDell(bdid != 0);
		dDell_without_bdid	:= pDell(bdid  = 0);
	
		dAggCorpV2Bdids_with_bdid			:= pAggCorpV2Bdids(bdid != 0);
		dAggCorpV2Bdids_without_bdid	:= pAggCorpV2Bdids(bdid  = 0);

		// Get all bdids associated with each filing(since there can be more than one)
		djoin4bdid1 := join(
			 distribute(pBusinessSummary					,hash64(source,vendor_id))
			,distribute(dAggCorpV2Bdids_with_bdid	,hash64(source,vendor_id))
			,		left.source			= right.source
			and left.vendor_id	= right.vendor_id
			,transform(
				 Layouts.laybus
				,self.bdid	:= right.bdid;
				 self				:= left;
			)
			,local
		);
	
		djoin4bdid2 := join(
			 distribute(pBusinessSummary					,hash64(source,vendor_id))
			,distribute(dAggCorpV2Bdids_with_bdid	,hash64(source,vendor_id))
			,		left.source			= right.source
			and left.vendor_id	= right.vendor_id
			,transform(
				 Layouts.laybus
				,self.bdid	:= left.bdid;
				 self				:= left;
			)
			,local
			,left only
		);
		
		dconcatbdids := djoin4bdid1 + djoin4bdid2;
		dBusinessSummary_with_bdid		:= dconcatbdids(bdid != 0);

		djoin1 := join(
			 distribute(dDell_with_bdid							,bdid)
			,distribute(dBusinessSummary_with_bdid	,bdid)
			,left.bdid = right.bdid
			,transform(
				 layouts.base
				 // Populate fields from business summary file
				,self.appended_fields.filing_match														:= 'Y';
				 self.appended_fields.filing_type_match												:= 'SOS';
				 self.appended_fields.Dissolution_exists											:= if(right.Date_Most_Recent_Dissolution		!= 0										,true	,false);
				 self.appended_fields.reinstatement_exists										:= if(right.Date_Most_Recent_Reinstatement	!= 0										,true	,false);
				 self.appended_fields.current_derogatory_event								:= if(right.Date_Last_Derog_Event 					 = right.Date_Last_Event	,true	,false);
				 self.appended_fields.time_since_last_report_date	 						:= right.time_since_last_report_date							;
//				 self.appended_fields.time_between_dissolution_reinstatement	:= right.time_between_dissolution_reinstatement 	;
				 self.appended_fields.latest_status														:= right.latest_status														;
				 self.appended_fields.Date_Filing_Last_Seen										:= right.Date_Filing_Last_Seen										;
				 self.appended_fields.time_between_filings										:= right.time_between_filings										;
				 self.appended_fields.Date_Last_Event													:= right.Date_Last_Event													;
				 self.appended_fields.time_between_events											:= right.time_between_events											;
				 self.appended_fields.Count_Delinquent_Statuses 							:= right.Count_Delinquent_Statuses 							;
				 self.appended_fields.Count_Derog_Events 											:= right.Count_Derog_Events 											;
				 self.appended_fields.count_address_changes										:= right.count_address_changes										;
				 self.appended_fields.count_contact_changes										:= right.count_contact_changes										;

//				 self.appended_fields.Count_Business_At_Address								:= right.Count_Business_At_Address								;
//				 self.appended_fields.Count_Delinquent_Business_At_Address		:= right.Count_Delinquent_Business_At_Address		;
//				 self.appended_fields.Count_Derogatory_Business_At_Address		:= right.Count_Derogatory_Business_At_Address		;
				 
				 self.appended_fields.count_business_contacts									:= right.count_business_contacts									;
				 self.appended_fields.count_delinquent_business_contacts	 		:= right.count_delinquent_business_contacts			;
				 self.appended_fields.count_derogatory_business_contacts	 		:= right.count_derogatory_business_contacts			;
				 self.appended_fields.Count_Bankruptcies_business							:= right.Count_Bankruptcies_business							;
				 self.appended_fields.Count_Liens_Judgements_business 				:= right.Count_Liens_Judgements_business 				;
				 self.appended_fields.Count_UCCs_business 										:= right.Count_UCCs_business 										;
				 
				 // Other stuff
				 self.appended_fields																					:= left.appended_fields			;
				 self.rawfields 																							:= left.rawfields						;
				 self.clean_contact_name 																			:= left.clean_contact_name		;
				 self.clean_address 																					:= left.clean_address				;
				 self.clean_phones 																						:= left.clean_phones					;
				 self.summary_business																				:= right												;
				 self.summary_address 																				:= left.summary_address			;
				 self.summary_contact 																				:= left.summary_contact			;
				 self																													:= left											;
			)
			,local
			,keep(1)
		);
		
		djoin2 := join(
			 distribute(dDell_with_bdid							,bdid)
			,distribute(dBusinessSummary_with_bdid	,bdid)
			,left.bdid = right.bdid
			,transform(
				 layouts.base
				,self.appended_fields.filing_match				:= 'N';
				 self.appended_fields.filing_type_match		:= 'Other';
				 self.summary_business	:= right;
				 self.appended_fields		:= right;
				 self.appended_fields		:= left.appended_fields;
				 self										:= left;
			)
			,left only
			,local
		);
		
		dDell_without_bdid_proj := project(dDell_without_bdid, transform(layouts.base,self.appended_fields.filing_match := 'N';self.appended_fields.filing_type_match := 'None'; self := left));
		dconcat := djoin1 + djoin2 + dDell_without_bdid_proj;

		// join on address_id to get the other businesses at address fields
		// since these depend on the input address from dell, not per vendor_id in corps
		dDell_bizcounts_matches := join(
			 distribute(dconcat									,ace_aid		)
			,distribute(pAddressSummary					,address_id	)
			,left.ace_aid = right.address_id
			,transform(
				layouts.base
				,self.appended_fields.Count_Business_At_Address								:= if(left.bdid != right.bdid or left.bdid = 0,right.Count_Business_At_Address						,if(right.Count_Business_At_Address 						!= 0, right.Count_Business_At_Address						 - 1, right.Count_Business_At_Address						));
				 self.appended_fields.Count_Delinquent_Business_At_Address		:= if(left.bdid != right.bdid or left.bdid = 0,right.Count_Delinquent_Business_At_Address	,if(right.Count_Delinquent_Business_At_Address	!= 0 and left.appended_fields.latest_status = 'D', right.Count_Delinquent_Business_At_Address - 1, right.Count_Delinquent_Business_At_Address));
				 self.appended_fields.Count_Derogatory_Business_At_Address		:= if(left.bdid != right.bdid or left.bdid = 0,right.Count_Derogatory_Business_At_Address	,if(right.Count_Derogatory_Business_At_Address	!= 0 and left.appended_fields.current_derogatory_event, right.Count_Derogatory_Business_At_Address - 1, right.Count_Derogatory_Business_At_Address));
				 self := left;
			)
			,local
			,keep(1)
		);

		dDell_bizcounts_nomatches := join(
			 distribute(dconcat									,ace_aid		)
			,distribute(pAddressSummary					,address_id	)
			,left.ace_aid = right.address_id
			,transform(
				layouts.base
				,self.appended_fields.Count_Business_At_Address								:= if(left.bdid != right.bdid or left.bdid = 0,right.Count_Business_At_Address						,if(right.Count_Business_At_Address 						!= 0, right.Count_Business_At_Address						 - 1, right.Count_Business_At_Address						));
				 self.appended_fields.Count_Delinquent_Business_At_Address		:= if(left.bdid != right.bdid or left.bdid = 0,right.Count_Delinquent_Business_At_Address	,if(right.Count_Delinquent_Business_At_Address	!= 0 and left.appended_fields.latest_status = 'D', right.Count_Delinquent_Business_At_Address - 1, right.Count_Delinquent_Business_At_Address));
				 self.appended_fields.Count_Derogatory_Business_At_Address		:= if(left.bdid != right.bdid or left.bdid = 0,right.Count_Derogatory_Business_At_Address	,if(right.Count_Derogatory_Business_At_Address	!= 0 and left.appended_fields.current_derogatory_event, right.Count_Derogatory_Business_At_Address - 1, right.Count_Derogatory_Business_At_Address));
				 self := left;
			)
			,local
			,left only
		);

		dDell_bizcounts_matches2 := join(
			 distribute(dDell_bizcounts_nomatches		,ace_aid_from_bdid		)
			,distribute(pAddressSummary							,address_id	)
			,left.ace_aid_from_bdid = right.address_id
			,transform(
				layouts.base
				,self.appended_fields.Count_Business_At_Address								:= if(left.bdid != right.bdid or left.bdid = 0,right.Count_Business_At_Address						,if(right.Count_Business_At_Address 						!= 0																									, right.Count_Business_At_Address						 - 1, right.Count_Business_At_Address						));
				 self.appended_fields.Count_Delinquent_Business_At_Address		:= if(left.bdid != right.bdid or left.bdid = 0,right.Count_Delinquent_Business_At_Address	,if(right.Count_Delinquent_Business_At_Address	!= 0 and left.appended_fields.latest_status = 'D'			, right.Count_Delinquent_Business_At_Address - 1, right.Count_Delinquent_Business_At_Address));
				 self.appended_fields.Count_Derogatory_Business_At_Address		:= if(left.bdid != right.bdid or left.bdid = 0,right.Count_Derogatory_Business_At_Address	,if(right.Count_Derogatory_Business_At_Address	!= 0 and left.appended_fields.current_derogatory_event, right.Count_Derogatory_Business_At_Address - 1, right.Count_Derogatory_Business_At_Address));
				 self := left;
			)
			,local
			,left outer
			,keep(1)
		);

		return dDell_bizcounts_matches + dDell_bizcounts_matches2;
	
	end;

	////////////////////////////////////////////////////////////////////////////////////
	// -- 			left.vendor_id			= right.vendor_id
	// -- 	and left.source					= right.source
	// -- 	and left.contact_type		= right.contact_type
	// -- 	and left.contact_title	= right.contact_title
//can be multiple bdids per filing 
//bdids can be on multiple filings
//so if join dell file's business summary corp_keys to contact summary
	////////////////////////////////////////////////////////////////////////////////////

	export fAppend_Contact_Summary(
	
		 dataset(layouts.base														) pDell
		,dataset(Layouts.laycont												) pContactSummary	= files().contact_summary.built	
		,dataset(layouts.temporary.AggregateCorpV2Bdids	)	pAggCorpV2Bdids	= Aggregate_CorpV2_Bdids		()
	) :=
	function
	
		dDell_with_bdid			:= pDell(bdid != 0);
		dDell_without_bdid	:= pDell(bdid  = 0);
	
		dAggCorpV2Bdids_with_bdid			:= pAggCorpV2Bdids(bdid != 0);
		dAggCorpV2Bdids_without_bdid	:= pAggCorpV2Bdids(bdid  = 0);
		
		// -- add bdids to contact summary so can match using bdids
		djoin4bdid1 := join(
			 distribute(pContactSummary						,hash64(source,vendor_id))
			,distribute(dAggCorpV2Bdids_with_bdid	,hash64(source,vendor_id))
			,		left.source			= right.source
			and left.vendor_id	= right.vendor_id
			,transform(
				 Layouts.laycont
				,self.bdid	:= right.bdid;
				 self				:= left;
			)
			,local
		);
	
		djoin4bdid2 := join(
			 distribute(pContactSummary						,hash64(source,vendor_id))
			,distribute(dAggCorpV2Bdids_with_bdid	,hash64(source,vendor_id))
			,		left.source			= right.source
			and left.vendor_id	= right.vendor_id
			,transform(
				 Layouts.laycont
				,self.bdid	:= left.bdid;
				 self				:= left;
			)
			,local
			,left only
		);
		
		dconcatbdids := djoin4bdid1 + djoin4bdid2;

		dContactSummary_with_bdid		:= dconcatbdids(bdid != 0);

		djoin1 := join(
			 distribute(dDell_with_bdid						,bdid)
			,distribute(dContactSummary_with_bdid	,bdid)
			,left.bdid = right.bdid
			,transform(
				 layouts.base
				,self.summary_contact := right;
				 self.appended_fields.current_contact_change 					 := right.current_contact_change;
//				 self.appended_fields.count_contact_changes						 := if(right.current_contact_change,1,0);
				 self.appended_fields.Count_Bankruptcies_contacts 		 := right.Count_bankruptcies    	;
				 self.appended_fields.Count_Liens_Judgements_contacts  := right.Count_liens_judgements  ;
				 self.appended_fields.Count_UCCs_contacts 						 := right.Count_ucc_filings			;
				 self																									 := left;
			)
			,local
			,keep(1)
		);
		
		//proly should rollup to sum all the count fields per vendor_id
		djoin2 := join(
			 distribute(dDell_with_bdid						,bdid)
			,distribute(dContactSummary_with_bdid	,bdid)
			,left.bdid = right.bdid
			,transform(
				 layouts.base
				,self.summary_contact := right;
				 self.appended_fields.current_contact_change 					 := right.current_contact_change;
//				 self.appended_fields.count_contact_changes						 := if(right.current_contact_change,1,0);
				 self.appended_fields.Count_Bankruptcies_contacts 		 := right.Count_bankruptcies    	;
				 self.appended_fields.Count_Liens_Judgements_contacts  := right.Count_liens_judgements  ;
				 self.appended_fields.Count_UCCs_contacts 						 := right.Count_ucc_filings			;
				 self																									 := left;
			)
			,local
			,left only
		);
		
		dconcat := djoin1 + djoin2 + dDell_without_bdid;

		return dconcat;
	
	end;

	export fAll(
		 dataset(Layouts.Base			)	pDataset
		,dataset(Layouts.layaddr	) pAddressSummary		= files().address_summary.built
		,dataset(Layouts.laybus		) pBusinessSummary	= files().business_summary.built
		,dataset(Layouts.laycont	) pContactSummary		= files().contact_summary.built	
		,boolean										pUsePersist				= false
	) :=
	function
	
		dAppendAddr		:= fAppend_Address_Summary	(pDataset		,pAddressSummary	) : persist(Persistnames().DellSummaryAppendsAddress	);
		dAppendBus		:= fAppend_Business_Summary	(dAppendAddr,pBusinessSummary	,,pAddressSummary	) : persist(Persistnames().DellSummaryAppendsBusiness	);
		dAppendCont		:= fAppend_Contact_Summary	(dAppendBus	,pContactSummary	) : persist(Persistnames().DellSummaryAppendsContact	);
		                                                              
		return if(pUsePersist = false,dAppendCont,persists().DellSummaryAppendsContact);
	
	end;


end;