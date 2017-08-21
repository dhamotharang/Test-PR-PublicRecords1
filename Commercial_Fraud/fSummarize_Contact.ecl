export fSummarize_Contact(

	 dataset(Layouts.laycont									)	pContCorpV2				= fSummarize_Contact_CorpV2()
	,dataset(layouts.Temporary.counts					)	pCount_Bankruptcy	= Count_Bankruptcy().fdid()
	,dataset(layouts.Temporary.counts					)	pCount_LJs				= Count_LJs				().fdid()
	,dataset(layouts.Temporary.counts					)	pCount_UCC				= Count_UCC				().fdid()

) :=
function
	
	dCorpV2_withDid								:= pContCorpV2(Did != 0);
	dCorpV2_withoutDid						:= pContCorpV2(Did = 0);

	dCount_Bankruptcy_withDid			:= pCount_Bankruptcy(id != 0);
	dCount_Bankruptcy_withoutDid	:= pCount_Bankruptcy(id = 0);

	dCount_LJs_withDid						:= pCount_LJs(id != 0);
	dCount_LJs_withoutDid					:= pCount_LJs(id = 0);

	dCount_UCC_withDid						:= pCount_UCC(id != 0);
	dCount_UCC_withoutDid					:= pCount_UCC(id = 0);

	dgetbkcounts := join(
		 distribute(dCorpV2_withDid						,Did)
		,distribute(dCount_Bankruptcy_withDid	,id)
		,left.Did = right.id
		,transform(layouts.laycont
			,self.Count_Bankruptcies := right.Count_filings;
			 self := left;
		)
		,local
		,left outer
	);
	
	dgetljcounts := join(
		 distribute(dgetbkcounts					,Did)
		,distribute(dCount_LJs_withDid		,id)
		,left.Did = right.id
		,transform(layouts.laycont
			,self.Count_Liens_Judgements := right.Count_filings;
			 self := left;
		)
		,local
		,left outer
	);

	dgetucccounts := join(
		 distribute(dgetljcounts					,Did)
		,distribute(dCount_UCC_withDid		,id)
		,left.Did = right.id
		,transform(layouts.laycont
			,self.Count_UCC_filings := right.Count_filings;
			 self := left;
		)
		,local
		,left outer
	);

	dconcat :=  dgetucccounts + dCorpV2_withoutDid;

	dcont_rollup := rollup(
		 dconcat
		,		left.vendor_id			= right.vendor_id
		and left.source					= right.source
		and left.contact_type		= right.contact_type
		and left.contact_title	= right.contact_title
		,transform(
			 layouts.laycont
			,self.Date_Last_Contact_Type_Change := business_functions.mymax(left.Date_Last_Contact_Type_Change	,right.Date_Last_Contact_Type_Change);
			 self.Date_Last_Contact_Filing 			:= business_functions.mymax(left.Date_Last_Contact_Filing			,right.Date_Last_Contact_Filing			);
			 self.current_contact_change				:= if(self.Date_Last_Contact_Filing = self.Date_Last_Contact_Type_Change,true,false);
			 self																:= left;
		
		)
		,local
	);

	dcorp_sort := sort(dcont_rollup(did != 0),-Did)
							+ dcont_rollup(did = 0)
							;

	dcorpreturn_debug := dcorp_sort;
	dcorpreturn_prod	:= project(dcorp_sort,transform(layouts.contact_summary, self := left));

	#if(_Dataset().IsDebugging = true)
		dcorp_return := dcorpreturn_debug
		: persist(persistnames().fSummarizeContact);
	#else
		dcorp_return := dcorpreturn_prod
		: persist(persistnames().fSummarizeContact);
	#end

	
	return dcorp_return;

end;