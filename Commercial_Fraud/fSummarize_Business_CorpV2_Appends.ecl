import corp2,BankruptcyV2,LiensV2,UCCV2,Property,Advo,address,mdr,aid,ut;

export fSummarize_Business_CorpV2_Appends(

	 dataset(layouts.temporary.BusinessSummary				) pBizSum
	,dataset(Corp2.Layout_Corporate_Direct_Event_Base	) pCorpEvent			= Prep_CorpV2.fEvent()
	,dataset(Layouts.laycont													)	pSummaryContact	= fSummarize_Contact_CorpV2()
	,dataset(layouts.layaddr													)	pAddrSummary		= fSummarize_Address_CorpV2()
	,string																							pPersistname		= Persistnames().fSummarizeBusinessCorpV2Appends

) :=
function

	// ----------------------------------------------------------
	// -- add Event stuff
	// ----------------------------------------------------------
	//rollup event file on corp_key, and get latest filing event
	devent_rollup				:= Aggregate_CorpV2_Events(pCorpEvent,false	);
	devent_derog_rollup := Aggregate_CorpV2_Events(pCorpEvent,true	,persistnames().AggregateCorpV2EventsDerog);

	dcorp_join2event := join(
		 distribute(pBizSum					,hash64(vendor_id))
		,distribute(devent_rollup		,hash64(vendor_id))
		,left.vendor_id = right.vendor_id
		,transform(
			layouts.temporary.BusinessSummary
			,self.Date_Filing_Last_Seen := if(left.Date_Filing_Last_Seen > right.Date_Filing_Last_Seen
																					,left.Date_Filing_Last_Seen
																					,right.Date_Filing_Last_Seen
																			);
			 self.Date_Last_Event				:= right.Date_Filing_Last_Seen;
			 self.time_between_events		:= right.time_between_events;
			 self												:= left;
		)
		,local
		,left outer
	);
	dcorp_join2eventderog := join(
		 distribute(dcorp_join2event		,hash64(vendor_id))
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
	
	// ----------------------------------------------------------
	// -- add contact stuff
	// ----------------------------------------------------------
	dGetContactCounts := Aggregate_CorpV2_Contacts(dcorp_join2eventderog,pSummaryContact);

	dgetcontcounts := join(
	
		 distribute(dcorp_join2eventderog			,hash64(source,vendor_id))
		,distribute(dGetContactCounts					,hash64(source,vendor_id))
		,		left.source			= right.source
		and left.vendor_id	= right.vendor_id
		,transform(
			 layouts.temporary.BusinessSummary
			,self.count_business_contacts							:= right.count_business_contacts						;
			 self.count_delinquent_business_contacts	:= right.count_delinquent_business_contacts	;
			 self.count_derogatory_business_contacts	:= right.count_derogatory_business_contacts	;
			 self.count_contact_changes 							:= right.count_contact_changes							;
			 self																			:= left																			;
		)
		,local
		,left outer
	
	);
	
	// ----------------------------------------------------------
	// -- add address stuff
	// ----------------------------------------------------------
	dGetAddressCounts := Aggregate_CorpV2_Addresses(dgetcontcounts,pAddrSummary);

	dgetaddrcounts := join(
	
		 distribute(dgetcontcounts		,hash64(source,vendor_id))
		,distribute(dGetAddressCounts	,hash64(source,vendor_id))
		,		left.source			= right.source
		and left.vendor_id	= right.vendor_id
		,transform(
			 layouts.temporary.BusinessSummary
			,self.count_address_changes									:= right.count_address_changes								;
			 self.Count_Business_At_Address							:= right.Count_Business_At_Address						;
			 self.Count_Delinquent_Business_At_Address	:= right.Count_Delinquent_Business_At_Address	;
			 self.Count_Derogatory_Business_At_Address	:= right.Count_Derogatory_Business_At_Address	;
			 self																				:= left																				;
		)
		,local
		,left outer
	
	);

	dcorp_standard := project(dgetaddrcounts,transform(layouts.temporary.BusinessSummary,self := left))
			: persist(pPersistname);
	
	return dcorp_standard;

	
end;
