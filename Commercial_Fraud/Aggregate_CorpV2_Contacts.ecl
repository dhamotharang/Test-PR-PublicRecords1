export Aggregate_CorpV2_Contacts(

	 dataset(layouts.temporary.BusinessSummary	)	pBusSum
	,dataset(Layouts.laycont										)	pSummaryContact	= fSummarize_Contact_CorpV2()
	,string																				pPersistname		= persistnames().AggregateCorpV2Contacts

):=
function

	// ----------------------------------------------------------
	// -- add contact stuff
	// ----------------------------------------------------------
	pSummaryContact_withdid			:= pSummaryContact(did != 0);
	pSummaryContact_withoutdid	:= pSummaryContact(did  = 0);
	
	dbuscorpv2_slim := project(pBusSum
		,transform(
			{string source,string vendor_id,string latest_status,unsigned8 Count_Derog_Events}
			,self := left
	));
	
	dgetdid := join(
		 distribute(dbuscorpv2_slim					,hash64(source,vendor_id))
		,distribute(pSummaryContact_withdid	,hash64(source,vendor_id))
		,			left.source			= right.source
		 and	left.vendor_id	= right.vendor_id
		,transform(
			{unsigned6 did,string source,string vendor_id,string latest_status,unsigned8 Count_Derog_Events,unsigned8 count_contact_changes}
			,self.did := right.did;
			 self := left;
			 self := right;
		)
		,local
	);
	
	ddedupbc := dedup(dgetdid, hash64(did,source,vendor_id),all);
	
	dtotalbc := table(ddedupbc	,{did
		,unsigned8 count_business_contacts						:= count(group)
		,unsigned8 count_delinquent_business_contacts := sum(group,if(latest_status = 'D', 1, 0))
		,unsigned8 count_derogatory_business_contacts := sum(group,if(Count_Derog_Events != 0, 1, 0))
		,unsigned8 count_contact_changes 							:= sum(group,count_contact_changes)
		},did);
		
	dgetotherbuscounts := join(
		 distribute(pSummaryContact		,Did)
		,distribute(dtotalbc					,Did)
		,left.Did = right.did
		,transform(
			layouts.temporary.AggregateCorpV2Contacts
			,self.count_business_contacts						 := right.count_business_contacts						;
			 self.count_delinquent_business_contacts := right.count_delinquent_business_contacts;
			 self.count_derogatory_business_contacts := right.count_derogatory_business_contacts;
			 self.count_contact_changes 						 := right.count_contact_changes							;
			 self																		 := left																		;
		)
		,local
	)
	+ project(pSummaryContact_withoutdid, transform(layouts.temporary.AggregateCorpV2Contacts,self := left;self := []))
	;
	
	drollupbyvendor_id := rollup(dgetotherbuscounts
		,		left.source			= right.source
		and left.vendor_id	= right.vendor_id
		,transform(
			layouts.temporary.AggregateCorpV2Contacts
			,
			 self.count_business_contacts						 := left.count_business_contacts						+ right.count_business_contacts						;
			 self.count_delinquent_business_contacts := left.count_delinquent_business_contacts + right.count_delinquent_business_contacts;
			 self.count_derogatory_business_contacts := left.count_derogatory_business_contacts + right.count_derogatory_business_contacts;
			 self.count_contact_changes 						 := left.count_contact_changes							+ right.count_contact_changes							;
			 self																		 := left;
		)
	);
	
	dreturn := sort(drollupbyvendor_id,source,vendor_id)
		: persist(pPersistname);
	
	return dreturn;

end;