import corp2,BankruptcyV2,LiensV2,UCCV2,Property,Advo,address,aid,mdr;

export fSummarize_Address_CorpV2(

	 dataset(Corp2.Layout_Corporate_Direct_Corp_Base	) pCorp				= Prep_CorpV2.fCorp()
	,dataset(Corp2.Layout_Corporate_Direct_Cont_Base	) pCorpCont		= Prep_CorpV2.fCont()
	,dataset(Corp2.Layout_Corporate_Direct_Event_Base	) pCorpEvent	= Prep_CorpV2.fEvent()

) :=
function

	dcorp_filt := pcorp			/*(dt_last_seen < 20091001)*/;
	dcont_filt := pCorpCont	/*(dt_last_seen < 20091001)*/;
	
	mymin(unsigned8 pnum1, unsigned8 pnum2) := map(pnum2 != 0 and pnum1 = 0 => pnum2
																								,pnum1 != 0 and pnum2 = 0 => pnum1
																								,pnum1 > pnum2						=> pnum2
																								,pnum1
																						);
	mymax(unsigned8 pnum1, unsigned8 pnum2) := map(pnum2 != 0 and pnum1 = 0 => pnum2
																								,pnum1 != 0 and pnum2 = 0 => pnum1
																								,pnum1 > pnum2						=> pnum1
																								,pnum2
																						);

	dcorp_prep := normalize(dcorp_filt
		,3
		,transform(layouts.temporary.addresssummary,
		address1 := Address.Addr1FromComponents(
								 choose(counter,left.corp_addr1_prim_range	,left.corp_addr2_prim_range		,left.corp_ra_prim_range	)
								,choose(counter,left.corp_addr1_predir			,left.corp_addr2_predir				,left.corp_ra_predir			)
								,choose(counter,left.corp_addr1_prim_name		,left.corp_addr2_prim_name		,left.corp_ra_prim_name		)
								,choose(counter,left.corp_addr1_addr_suffix	,left.corp_addr2_addr_suffix	,left.corp_ra_addr_suffix	)
								,choose(counter,left.corp_addr1_postdir			,left.corp_addr2_postdir			,left.corp_ra_postdir			)
								,choose(counter,left.corp_addr1_unit_desig	,left.corp_addr2_unit_desig		,left.corp_ra_unit_desig	)
								,choose(counter,left.corp_addr1_sec_range		,left.corp_addr2_sec_range		,left.corp_ra_sec_range		)
								);
		address2 := Address.Addr2FromComponents(
								 choose(counter,left.corp_addr1_v_city_name	,left.corp_addr2_v_city_name	,left.corp_ra_v_city_name	)
								,choose(counter,left.corp_addr1_state				,left.corp_addr2_state				,left.corp_ra_state				)
								,choose(counter,left.corp_addr1_zip5				,left.corp_addr2_zip5					,left.corp_ra_zip5				)
								);
		
		self.bdid 														:= (unsigned8)left.bdid;
		self.source 													:= mdr.sourceTools.fcorpv2(left.corp_key,left.corp_state_origin);
		self.vendor_id												:= left.corp_key;
		self.address_id 											:= 0;
		self.address_type 										:= if(counter = 1 or counter = 2
																							,business_functions.fStandardizeAddressType(left.corp_address1_type_desc,left.corp_addr1_prim_name)
																							,'R');
		self.Date_Address_First_Seen					:= choose(counter
																								,mymin((unsigned8)left.corp_address1_effective_date, (unsigned8)left.dt_first_seen)
																								,mymin((unsigned8)left.corp_address2_effective_date, (unsigned8)left.dt_first_seen)
																								,(unsigned8)left.dt_first_seen
																							);
		self.Date_Address_Last_Seen 					:= choose(counter
																								,mymax((unsigned8)left.corp_address1_effective_date, (unsigned8)left.dt_last_seen)
																								,mymax((unsigned8)left.corp_address2_effective_date, (unsigned8)left.dt_last_seen)
																								,(unsigned8)left.dt_last_seen
																							);
		self.address1													:= address1;
		self.address2													:= address2;
		self.unique_id												:= 0;
	  self.current_address_change						:= false;
		self.time_between_last_two_addresses	:= 0;
		self.count_address_changes						:= 0;
	  self.Count_Business_At_Address							:= 0;	
		self.Count_Delinquent_Business_At_Address		:= 0;
		self.Count_Derogatory_Business_At_Address		:= 0;
		self.city															:= choose(counter,left.corp_addr1_v_city_name	,left.corp_addr2_v_city_name	,left.corp_ra_v_city_name	);
		self.state														:= choose(counter,left.corp_addr1_state				,left.corp_addr2_state				,left.corp_ra_state				);
		self.name															:= stringlib.stringtouppercase(left.corp_legal_name);
		self.business_residential							:= ''	;
		self.vacant_property									:= '' ;
		self.Seasonal_Delivery_Indicator			:= ''	;
		self.college                    			:= ''	;
		self.cmra	                    				:= ''	;
		self.recent_foreclosure								:= ''	;
	  self.date_of_foreclosure							:= 0	;
		self.usps_hotlist											:= ''	;
		self.phone														:= (unsigned8)left.corp_phone_number;
		self.input_phone_matches_address     	:= '';	
		self.phone_type_match                	:= '';	
		self.alternate_phone_at_address      	:= '';	
		self.alternate_phone_type            	:= '';	
		self.alternate_phone_listed_name     	:= '';	
		
	));
	
	dcorp_slim := project(dcorp_prep(address1 != '',address2 != '')
		, transform({string address1,string address2,unsigned8 address_id}
		,self := left
		)
	);
	
	dcorp_dedup4aid := dedup(dcorp_slim,hash64(address1,address2),all);

	unsigned4	lFlags := AID.Common.eReturnValues.ACEAIDs;

	AID.MacAppendFromRaw_2Line(
		dcorp_dedup4aid	// Incoming dataset
	 ,address1				// Fieldname of address Line1
	 ,address2				// Fieldname of address LineLast (city, state, zip)
	 ,address_id			// Fieldname of incoming Raw Address ID
	 ,dcorp_aid				// Resulting dataset out-reference
	 ,lFlags
	);
	
	//join back to get aid
	dcorp_withaid := join(
		 dcorp_prep(address1 != '',address2 != '')
		,dcorp_aid
		,left.address1 = right.address1
		and left.address2 = right.address2
		,transform(
			recordof(dcorp_prep)
			,self.address_id := right.aidwork_aceaid;
			 self := left;
		)
		,left outer
	) : persist(persistnames().fSummarizeAddressCorpV2aid);
	
//	dcorp_all := if(_Dataset().ShouldRecaculatePersist,project(dcorp_withaid,transform(recordof(dcorp_prep),self.unique_id := counter;self := left)),persists().fSummarizeAddressCorpV2aid);
	dcorp_all := project(dcorp_withaid,transform(recordof(dcorp_prep),self.unique_id := counter;self := left));
	
	// split up dataset into two, one with current addresses, one with previous
	// add previous back in at end, but do not count them for changes, etc
	dcorp_curr_address_type := dcorp_all(not	regexfind('previous',address_type,nocase));
	dcorp_prev_address_type := dcorp_all(			regexfind('previous',address_type,nocase));

	dcorp_dist := distribute(dcorp_curr_address_type, hash64(vendor_id));
	
	// -- current_address_change
  // -- time_between_last_two_addresses
	dcorp_sort_addr_change := group(sort(dcorp_dist	,source,vendor_id, address_type,-Date_Address_Last_Seen,address_id,local)
																									,source,vendor_id, address_type,local);
																								
	dcorp_iter_addr_change := group(iterate(dcorp_sort_addr_change
		,transform(
				recordof(dcorp_sort_addr_change)
			 ,self.unique_id												:= right.unique_id;
			  self.current_address_change := if((counter = 2 and left.address_id != right.address_id)
																										or left.current_address_change = true, true, false);
				self.time_between_last_two_addresses := if(counter > 1 and left.address_id != right.address_id
																														and left.time_between_last_two_addresses = 0
																																,ut.DaysApart((string)left.Date_Address_First_Seen,(string)right.Date_Address_Last_Seen) / 30
																																,left.time_between_last_two_addresses
																														);
				self.count_address_changes						:= if(counter > 1 and left.address_id != right.address_id
																										,left.count_address_changes + 1
																										,left.count_address_changes
																								);
				self := right;
		)
	),local);
	
	// -- Do iterate again, so make sure fields(current_address_change, time_between_last_two_addresses) 
	// -- are populated the same for all records in group
	dcorp_sort_addr_change2 := group(sort(dcorp_iter_addr_change	,source,vendor_id, address_type,Date_Address_Last_Seen,address_id,local)
																																,source,vendor_id, address_type,local);
	
	dcorp_iter_addr_change2 := group(iterate(dcorp_sort_addr_change2
		,transform(
				recordof(dcorp_sort_addr_change)
			 ,self.unique_id												:= right.unique_id;
			  self.current_address_change := if(left.current_address_change = true, true, right.current_address_change);
				self.time_between_last_two_addresses := if(left.time_between_last_two_addresses != 0
																																,left.time_between_last_two_addresses
																																,right.time_between_last_two_addresses
																														);
				self.count_address_changes						:= if(left.count_address_changes != 0
																																,left.count_address_changes
																																,right.count_address_changes
																								);
				self := right;
		)
	),local);

	// figure out date_address_first/last_seens
	dcorp_all_dist := dcorp_dist + distribute(dcorp_prev_address_type, hash64(vendor_id));

	dcorp_sort := sort(dcorp_all_dist, source,vendor_id, address_type,-Date_Address_Last_Seen,address_id,local);

	//should handle move backs
	dcorp_rollup := rollup(dcorp_sort
		,		left.source				= right.source
		and left.vendor_id		= right.vendor_id
		and left.address_type = right.address_type
		and left.address_id		= right.address_id
		,transform(
			 recordof(dcorp_curr_address_type)
			,self.Date_Address_First_Seen	:= mymin(left.Date_Address_First_Seen	,right.Date_Address_First_Seen);
			 self.Date_Address_Last_Seen 	:= mymax(left.Date_Address_Last_Seen	,right.Date_Address_Last_Seen );
			 self.bdid 										:= mymin(left.bdid										,right.bdid										);
			 self.vendor_id     					:= left.vendor_id;
			 self.source 									:= left.source;
			 self.address_id   						:= left.address_id;
			 self.address_type   					:= left.address_type;
			 self.address1								:= left.address1;
			 self.address2								:= left.address2;
			 self.unique_id								:= left.unique_id;
			 self.current_address_change 	:= 0;
			 self.time_between_last_two_addresses := 0;
			 self.count_address_changes			:= 0;
			 self.Count_Business_At_Address							:= 0;	
			 self.Count_Delinquent_Business_At_Address		:= 0;
			 self.Count_Derogatory_Business_At_Address		:= 0;
			 self.city											:= left.city;
			 self.state											:= left.state;
			 self.name											:= left.name;
			 self.business_residential				:= ''	;//not populated yet, so doesn't matter
			 self.vacant_property							:= '' ;
			 self.Seasonal_Delivery_Indicator	:= ''	;
			 self.college                    	:= ''	;
			 self.cmra	                    	:= ''	;
			 self.recent_foreclosure					:= ''	;
			 self.date_of_foreclosure					:= 0;
			 self.usps_hotlist								:= ''	;
			 self.phone												:= if(left.phone != 0, left.phone,right.phone);
			 self.input_phone_matches_address := '';	
			 self.phone_type_match            := '';	
			 self.alternate_phone_at_address  := '';	
			 self.alternate_phone_type        := '';	
			 self.alternate_phone_listed_name := '';	
//			 self 												:= [];
		)
		,local
	);
	
	dcorp_get_addr_changes := join(
		 dcorp_rollup
		,dcorp_iter_addr_change2
		,left.unique_id = right.unique_id
		,transform(
			 recordof(dcorp_curr_address_type)
			,self.current_address_change := right.current_address_change;
			 self.time_between_last_two_addresses := right.time_between_last_two_addresses;
			 self.count_address_changes	:= right.count_address_changes;
			 self := left;
		)
		,left outer
	);
	
	//////////////////////////////////////////
	// -- get other businesses at address, for this address_id only
	//////////////////////////////////////////
	
	// -- Filter out address older than 20 yrs
	pAddrSummary_filt := Filters.AggregateCorpV2Addresses(dcorp_get_addr_changes);

	// Unique business filings at address
	dUniqueFilingAtAddress	:= table(pAddrSummary_filt	,{address_id, vendor_id,source},address_id,vendor_id,source);

	// -- Rolled up dataset per vendor_id with latest status and count derog events fields
	dfSummarize_Business_CorpV2 := fSummarize_Address_CorpV2_Append(pCorp,pCorpCont,pCorpEvent);

	// -- Join to Unique filings, get biz counts
	dUniqueFilingAtAddress_prep1 := join(
		 distribute(dUniqueFilingAtAddress			,hash64(source,vendor_id))
		,distribute(dfSummarize_Business_CorpV2	,hash64(source,vendor_id))
		,		left.vendor_id	= right.vendor_id
		and left.source			= right.source
		,transform(
			{unsigned8 address_id, string source,string vendor_id,unsigned8 Count_Delinquent_Business_At_Address,unsigned8 Count_Derogatory_Business_At_Address}
			,self := left;
			 self.Count_Delinquent_Business_At_Address := if(right.latest_status != 'G', 1,0);
			 self.Count_Derogatory_Business_At_Address := if(right.Count_Derog_Events > 0, 1,0);
		)
		,local
	);
	
	// -- Sum up counts by address_id
	dUniqueFilingAtAddress2 := table(dUniqueFilingAtAddress_prep1	
		,{address_id	,unsigned8 Count_Business_At_Address := count(group),unsigned8 Count_Delinquent_Business_At_Address := sum(group,Count_Delinquent_Business_At_Address),unsigned8 Count_Derogatory_Business_At_Address := sum(group,Count_Derogatory_Business_At_Address)}
		,address_id);
	
	// - join back to address summary to append the biz counts
	dback2addrsummary := join(
	
		 distribute(dcorp_get_addr_changes	,address_id)
		,distribute(dUniqueFilingAtAddress2	,address_id)
		,left.address_id = right.address_id
		,transform(
			layouts.temporary.addresssummary
			,self := right;
			 self	:= left	;
		)
		,local
	);

	//////////////////////////////////////////

	
	dcorp_sort_results := sort(dback2addrsummary, source,vendor_id, address_type,-Date_Address_Last_Seen,address_id);
	
	dcorpreturn := project(dcorp_sort_results,transform(layouts.address_summary, self := left));

	dcorp_return := dcorp_sort_results
	: persist(persistnames().fSummarizeAddressCorpV2);
	
	return dcorp_return;

	
end;