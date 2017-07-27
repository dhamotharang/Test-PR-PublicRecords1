import Address, Court_locator, ut;

layout_batch_out 	:= BatchServices.Layouts.CourtLocator.layout_batch_out;
layout_batch_in 	:= BatchServices.Layouts.CourtLocator.layout_batch_in;

export CourtLocator_BatchService_Records(DATASET(layout_batch_in) batch_in) := 
MODULE

	key_fips := Court_locator.key_fips;

	// ------------------------------------------------------------------
	// cleaning the address mostly to get the fips code
	//
	layout_batch_in clean_batch_in(layout_batch_in l) := transform
		addr1 			:= Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, l.unit_desig, l.sec_range);
		addr2				:= Address.Addr2FromComponents(l.p_city_name, l.st, l.z5);
		ca					:= Address.GetCleanAddress(addr1,addr2,0).results;		
		
		self.prim_range 	:= ca.prim_range;
		self.predir 			:= ca.predir;
		self.prim_name 		:= ca.prim_name;
		self.addr_suffix 	:= ca.suffix;
		self.postdir 			:= ca.postdir;
		self.unit_desig 	:= ca.unit_desig;
		self.sec_range 		:= ca.sec_range;
		self.p_city_name 	:= ca.p_city;
		self.st 					:= ca.state;
		self.z5 					:= ca.zip;
		self.zip4 				:= ca.zip4;	
		self.fips_code		:= ca.county;	
		self.acctno				:= l.acctno;
	end;

	// ------------------------------------------------------------------
	// split the input so we can take either a fips_code or address
	//
	ds_batch_in_with_fips := batch_in(fips_code<>'');
	ds_batch_in_clean := project(batch_in(fips_code=''), clean_batch_in(left));

	// ------------------------------------------------------------------
	// normalize fips to 5-digit codes so we can join below
	//
	ds_batch_in := project(ds_batch_in_clean + ds_batch_in_with_fips, 
								 transform(layout_batch_in, 
													 self.fips_code := IF(length(trim(left.fips_code,left,right))=3, ut.st2FipsCode(left.st)+left.fips_code, left.fips_code),
													 self := left));

	layout_batch_out get_location(layout_batch_in l, recordof(key_fips) r) := transform
		self.acctno 					:= l.acctno;									
		self.physicaladdress1 := r.Address1;
		self.physicaladdress2 := r.Address2;
		self.physicalcity 		:= r.city;
		self.physicalstate 		:= r.state;
		self.physicalzip 			:= r.zipcode;
		self.state 						:= r.stateofservice;
		self.county 					:= r.name;
		self 									:= r;	
	end;

	// ------------------------------------------------------------------
	// we should always have a 5-digit fips code at this point, so a 
	// simple join to load court records.
	//
	recs := join(ds_batch_in, key_fips,
							 keyed(left.fips_code = right.l_fips),
							 get_location(left, right),
							 limit(BatchServices.Constants.CourtLocator.JOIN_LIMIT));

	export records := recs;
	
END;