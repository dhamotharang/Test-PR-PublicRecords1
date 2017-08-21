import ut;
/////////////////////////////////////////////////////////////////////
// -- Aggregate_CorpV2_Addresses
// -- Aggregates addresses per source, vendor_id
/////////////////////////////////////////////////////////////////////
export Dell_Count_Bizs_at_Address(

	 dataset(layouts.base			)	pBusSum
	,dataset(layouts.layaddr	)	pAddrSummary			= fSummarize_Address_CorpV2	()
	,string											pPersistname			= persistnames().DellCountBizsatAddress
	,string 										pDateFilter				= _Dataset().CurrentDate

) :=
function

	current_year := (unsigned4)pDateFilter[1..4];
	
	// filter out addresses older than 20 years
	pAddrSummary_filt := Filters.AggregateCorpV2Addresses(pAddrSummary);

	// Dedup on filing and address
	duniquebizataddress	:= table(pAddrSummary_filt	,{address_id, vendor_id,source},address_id,vendor_id,source);
	dcountbizataddress := table(duniquebizataddress	,{address_id, unsigned8 cnt := count(group)},address_id);

	// join to biz Sum to get delinquent, derog events
	// output of this is unique on vendor_id, source, address_id
	duniquebizataddress_prep1 := join(
		 distribute(duniquebizataddress	,hash64(source,vendor_id))
		,distribute(pBusSum							,hash64(source,vendor_id))
		,		left.vendor_id	= right.vendor_id
		and left.source			= right.source
		,transform(
			{unsigned8 address_id, string source,string vendor_id,unsigned8 Count_Delinquent_Business_At_Address,unsigned8 Count_Derogatory_Business_At_Address}
			,self := left;
			 self.Count_Delinquent_Business_At_Address := if(right.latest_status != 'G', 1,0);
			 self.Count_Derogatory_Business_At_Address := if(right.Count_Derog_Events > 0, 1,0);
		)
		,local
	)
	: persist(persistnames().AggregateCorpV2Addresses + '.duniquebizataddress_prep1');
	
	// want to prevent counting of businesses more than once, if they are from different addresses
	//so get all other vendor_ids associated with each address id.
	// then dedup them per filing
	dgetotherbusinesses_vendor_ids := join(
		 distribute(duniquebizataddress_prep1	,random())
		,distribute(duniquebizataddress_prep1	,random())
		,			left.address_id = right.address_id
			and left.vendor_id != right.vendor_id
		,transform(
			{unsigned8 address_id, string source,string vendor_id,string other_vendor_id,unsigned8 Count_Business_At_Address,unsigned8 Count_Delinquent_Business_At_Address,unsigned8 Count_Derogatory_Business_At_Address}
			,
			 self.other_vendor_id												:= right.vendor_id;
			 self.Count_Delinquent_Business_At_Address	:= if(right.Count_Delinquent_Business_At_Address != 0,right.Count_Delinquent_Business_At_Address,left.Count_Delinquent_Business_At_Address);
			 self.Count_Derogatory_Business_At_Address	:= if(right.Count_Derogatory_Business_At_Address != 0,right.Count_Derogatory_Business_At_Address,left.Count_Derogatory_Business_At_Address);
			 self.Count_Business_At_Address							:= if(self.other_vendor_id != '',1,0);
			 self := left;
		
		)
		,local
		,left outer
	)
	: persist(persistnames().AggregateCorpV2Addresses + '.dgetotherbusinesses_vendor_ids');
	
	//then take out the matches from the duniquebizataddress_prep1 dataset, then self join again
	djoinmatches_firstpass		:= dgetotherbusinesses_vendor_ids(other_vendor_id != '')
		: persist(persistnames().AggregateCorpV2Addresses + '.djoinmatches_firstpass');

	djoinNomatches_firstpass := join(
		 distribute(dgetotherbusinesses_vendor_ids	,hash64(address_id,vendor_id))
		,distribute(djoinmatches_firstpass					,hash64(address_id,vendor_id))
		,			left.address_id				= right.address_id
			and left.vendor_id				= right.vendor_id
			and left.other_vendor_id	= right.other_vendor_id
		,transform(
			recordof(duniquebizataddress_prep1)
			,self := left;
		)
		,left only
	)
		: persist(persistnames().AggregateCorpV2Addresses + '.djoinNomatches_firstpass');

	// do another join to get rest of matches
	dgetotherbusinesses_vendor_ids2 := join(
		 distribute(djoinNomatches_firstpass	,address_id)
		,distribute(djoinNomatches_firstpass	,address_id)
		,			left.address_id = right.address_id
			and left.vendor_id != right.vendor_id
		,transform(
			{unsigned8 address_id, string source,string vendor_id,string other_vendor_id,unsigned8 Count_Business_At_Address,unsigned8 Count_Delinquent_Business_At_Address,unsigned8 Count_Derogatory_Business_At_Address}
			,
			 self.other_vendor_id												:= right.vendor_id;
			 self.Count_Delinquent_Business_At_Address	:= right.Count_Delinquent_Business_At_Address;
			 self.Count_Derogatory_Business_At_Address	:= right.Count_Derogatory_Business_At_Address;
			 self.Count_Business_At_Address							:= if(self.other_vendor_id != '',1,0);
			 self := left;
		
		)
		,local
	)
	: persist(persistnames().AggregateCorpV2Addresses + '.dgetotherbusinesses_vendor_ids2');
	
	dallmatches := dgetotherbusinesses_vendor_ids2 + djoinmatches_firstpass;

	dgetotherbusinesses_vendor_ids_dedup := dedup(sort(distribute(dallmatches	,hash64(source,vendor_id,other_vendor_id)),hash64(source,vendor_id,other_vendor_id)),hash64(source,vendor_id,other_vendor_id),local)
	: persist(persistnames().AggregateCorpV2Addresses + '.dgetotherbusinesses_vendor_ids_dedup');
	
	
	// rollup so can join to get addr changes
	// addr changes is per filing, not per address
	drollup := rollup(
		 sort(distribute(dgetotherbusinesses_vendor_ids_dedup,hash64(vendor_id)), source,vendor_id, local)
		,left.source = right.source
		and left.vendor_id = right.vendor_id
		,transform(
			recordof(dgetotherbusinesses_vendor_ids_dedup)
			,self.Count_Business_At_Address							:= left.Count_Business_At_Address							+ right.Count_Business_At_Address						;
			,self.Count_Delinquent_Business_At_Address	:= left.Count_Delinquent_Business_At_Address	+ right.Count_Delinquent_Business_At_Address;
			,self.Count_Derogatory_Business_At_Address	:= left.Count_Derogatory_Business_At_Address	+ right.Count_Derogatory_Business_At_Address;
			,self																				:= left;
		)
		,local
	)
	: persist(persistnames().AggregateCorpV2Addresses + '.drollup');
	
	
	// count address changes, remove zeros
	// each summary address record per filing has the total number of address changes for that filing, so can just dedup
	dcountaddr_changes := dedup(pAddrSummary_filt(count_address_changes != 0)	,hash64(source,vendor_id));

	// -- join to get address changes
	dgetaddr_changes := join(
		 distribute(drollup							,hash64(source,vendor_id))
		,distribute(dcountaddr_changes	,hash64(source,vendor_id))
		,		left.source			= right.source
		and left.vendor_id	= right.vendor_id
		,transform(
			layouts.temporary.AggregateCorpV2Addresses
			,self.count_address_changes := right.count_address_changes;
			 self := left;
		)
		,local
		,left outer
	);
	
	daddr_all := sort(dgetaddr_changes,source,vendor_id)
		: persist(pPersistname);

	return daddr_all;

end;