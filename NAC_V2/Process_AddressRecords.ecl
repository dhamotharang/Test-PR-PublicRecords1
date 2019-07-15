/*
Update Logic
There is no special update logic for Address Records.  
The latest received set of Address Records for a Case or Client are considered to be the whole truth,
  always treated as an update/replacement for previous Addresses if any exist.  
For example, if a prior submission had separate Physical and Mailing addresses assigned to a Case, 
  and a single Address Record is submitted for that Case, it becomes the lone Address Record for that case.

To ensure each NCF2 can be validated alone, if the Address Record is related to a Case, 
  that Case/Household Record should be submitted, too.  
If related to a Client, then that Client/Individual Record should be submitted.  
Note that submission of a Client/Individual Record similarly requires its Case/Household Record to be submitted, as well.

If easier to process, sending the entire Case data to update an Address—that is, the Case/Household Record, 
  all Client/Individual Records, and all updated Address Records—can be submitted to update the Address(es).


*/
import STD;
EXPORT Process_AddressRecords(DATASET(Layouts2.rAddressEx) inrec) := FUNCTION

	//clnAddr := DISTRIBUTE(Nac_V2.proc_cleanAddr(inrec), HASH64(ProgramState, ProgramCode, CaseID, ClientId));
	clnAddr := DISTRIBUTE(inrec, HASH64(ProgramState, ProgramCode, CaseID, ClientId));

	addresses := DISTRIBUTE(Files('').dsAddressRecords,HASH64(ProgramState, ProgramCode, CaseID, ClientId)); 
	
	/*
		Determine which address records are unchanged
		Do not process records that have previously been replaced
	*/
	unchanged := JOIN(addresses(replaced=0), clnAddr,
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode
										and LEFT.CaseId = RIGHT.CaseId and LEFT.ClientId = RIGHT.ClientId,
								TRANSFORM(Layouts2.rAddressEx, self := LEFT;),
								LEFT ONLY, LOCAL)
							+ addresses(replaced<>0);

	removed := JOIN(addresses(replaced=0), clnAddr,
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode
										and LEFT.CaseId = RIGHT.CaseId and LEFT.ClientId = RIGHT.ClientId,
								TRANSFORM(Nac_V2.Layouts2.rAddressEx,
										self.replaced := Std.Date.Today();
										self := LEFT;),
								INNER, LOCAL);


	return unchanged + removed + clnAddr;		// unchanged addresses + replaced + new addresses

END;

/*
	j := JOIN(addresses, clnAddr,
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode
										and LEFT.CaseId = RIGHT.CaseId and LEFT.ClientId = RIGHT.ClientId
										and LEFT.AddressType = RIGHT.AddressType,
							TRANSFORM(Layouts2.rAddressEx,
								// key fields
								self.ProgramState := Coalesce(LEFT.ProgramState, RIGHT.ProgramState);
								self.ProgramCode := Coalesce(LEFT.ProgramCode, RIGHT.ProgramCode);
								self.CaseId := Coalesce(LEFT.CaseId, RIGHT.CaseId);
								self.ClientId := Coalesce(LEFT.ClientId, RIGHT.ClientId);
								self.AddressType := Coalesce(Left.AddressType, right.AddressType);
								// Address Fields
								self.Street1 := IF(RIGHT.ProgramState='',Left.Street1, right.Street1);
								self.Street2 := IF(RIGHT.ProgramState='',Left.Street2, right.Street2);
								self.City := IF(RIGHT.ProgramState='',Left.City, right.City);
								self.State := IF(RIGHT.ProgramState='',Left.State, right.State);
								self.ZipCode := IF(RIGHT.ProgramState='',Left.ZipCode, right.ZipCode);
								// Miscellaneous
								self.AddressCategory := IF(RIGHT.ProgramState='',Left.AddressCategory, right.AddressCategory);

								// clean addresses
								SELF.prim_range  			:= IF(RIGHT.ProgramState='',Left.prim_range, right.prim_range);
								SELF.predir      			:= IF(RIGHT.ProgramState='',Left.predir, right.predir);
								SELF.prim_name   			:= IF(RIGHT.ProgramState='',Left.prim_name, right.prim_name);
								SELF.addr_suffix 			:= IF(RIGHT.ProgramState='',Left.addr_suffix, right.addr_suffix);
								SELF.postdir     			:= IF(RIGHT.ProgramState='',Left.postdir, right.postdir);
								SELF.unit_desig  			:= IF(RIGHT.ProgramState='',Left.unit_desig, right.unit_desig);
								SELF.sec_range   			:= IF(RIGHT.ProgramState='',Left.sec_range, right.sec_range);
								SELF.p_city_name 			:= IF(RIGHT.ProgramState='',Left.p_city_name, right.p_city_name);
								SELF.v_city_name 			:= IF(RIGHT.ProgramState='',Left.v_city_name, right.v_city_name);
								SELF.st          			:= IF(RIGHT.ProgramState='',Left.st, right.st);
								SELF.zip         			:= IF(RIGHT.ProgramState='',Left.zip, right.zip);
								SELF.zip4       	 		:= IF(RIGHT.ProgramState='',Left.zip4, right.zip4);
								SELF.cart        			:= IF(RIGHT.ProgramState='',Left.cart, right.cart);
								SELF.cr_sort_sz  			:= IF(RIGHT.ProgramState='',Left.cr_sort_sz, right.cr_sort_sz);
								SELF.lot         			:= IF(RIGHT.ProgramState='',Left.lot, right.lot);
								SELF.lot_order   			:= IF(RIGHT.ProgramState='',Left.lot_order, right.lot_order);
								SELF.dbpc        			:= IF(RIGHT.ProgramState='',Left.dbpc, right.dbpc);
								SELF.chk_digit   			:= IF(RIGHT.ProgramState='',Left.chk_digit, right.chk_digit);
								SELF.rec_type    			:= IF(RIGHT.ProgramState='',Left.rec_type, right.rec_type);
								SELF.fips_state 			:= IF(RIGHT.ProgramState='',Left.fips_state, right.fips_state);
								SELF.fips_county 			:= IF(RIGHT.ProgramState='',Left.fips_county, right.fips_county);
								SELF.geo_lat     			:= IF(RIGHT.ProgramState='',Left.geo_lat, right.geo_lat);
								SELF.geo_long    			:= IF(RIGHT.ProgramState='',Left.geo_long, right.geo_long);
								SELF.msa         			:= IF(RIGHT.ProgramState='',Left.msa, right.msa);
								SELF.geo_blk     			:= IF(RIGHT.ProgramState='',Left.geo_blk, right.geo_blk);
								SELF.geo_match   			:= IF(RIGHT.ProgramState='',Left.geo_match, right.geo_match);
								SELF.err_stat    			:= IF(RIGHT.ProgramState='',Left.err_stat, right.err_stat);
															
								self.Created := IF(RIGHT.ProgramState='',LEFT.Created,
																	IF(LEFT.ProgramState='',Std.Date.Today(), left.Created));
								self.Updated := IF(RIGHT.ProgramState='',LEFT.Updated,Std.Date.Today());
								
								self.Errors := IF(RIGHT.ProgramState='',LEFT.Errors,RIGHT.Errors);
								self.Warnings := IF(RIGHT.ProgramState='',LEFT.Warnings,RIGHT.Warnings);
							),
							FULL OUTER, LOCAL);
	*/								