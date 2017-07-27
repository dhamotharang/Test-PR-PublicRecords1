import doxie, business_header;


export address_variations_base(dataset(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare();

base_recs := doxie_cbrs.fn_getBaseRecs(bdids,false)(Include_AddressVariations_val and (prim_name <> '' or prim_range <> '' or zip <> '' or (state <> '' and city <> '')));

base_recs1 := base_recs(Stringlib.Stringfind(prim_name, '* *', 1) < 1);

rolled_addresses := rollup(
	sort(base_recs1,addr_source_id,-county_name,-msaDesc,-dt_last_seen,-dt_first_seen,record),
	left.addr_source_id = right.addr_source_id,
	transform(recordof(base_recs1),
		self.dt_last_seen := if(left.dt_last_seen > right.dt_last_seen,left.dt_last_seen,right.dt_last_seen),
		self.dt_first_seen := if(left.dt_first_seen != 0 and left.dt_first_seen < right.dt_first_seen,left.dt_first_seen,right.dt_first_seen),
		self := left));

/* Mod for bug 108845 in which a customer search on a company name and state (SWISS POST INTERNATIONAL and NJ),
   The customer had a "hit" on the search, but there wasn't any address with the state of NJ in the results.
   The reason being is that they matched on a D&B address, but since Risk can only display city and state info 
   from D&B the record is dropped from the report. This change will keep any address with only a city/state if 
   there isn't already an address with street parts with that city/state . */
PrimAddrRecs := rolled_addresses(prim_name != '' or prim_range != '' or  zip != '');

// Keep and address that doesn't match on city/state with address that have street parts
KeepStateOnly := JOIN (PrimAddrRecs,rolled_addresses,
											 LEFT.state = RIGHT.state AND
											 LEFT.city = RIGHT.city,
											 TRANSFORM(RIGHT),
											 RIGHT ONLY);

shared final_addresses := (PrimAddrRecs + KeepStateOnly);

doxie_cbrs.mac_Selection_Declare();
					
export records := table(choosen(final_addresses,Max_AddressVariations_val),{prim_range,predir,prim_name,addr_suffix,sec_range,city,state,zip,msaDesc,county_name,msa,addr_source_id,dt_first_seen,dt_last_seen});

export records_count := COUNT(final_addresses);

END;
						
