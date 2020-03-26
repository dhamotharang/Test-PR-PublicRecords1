import header,autokey;

// FnSetCurrAddrBit sets bit 32 in lookups field if the address is "best".  Bit is set here b/c
// setting it in header.Prepped_For_Keys exposes a different value in lookups
// used in other keys which do not include an address and do not exclude 
// the lookups field in dedup leaving duplicates in the key,
// one with the curr_addr bit set and one w/o.

t := Header.FnSetCurrAddrBit(header.Prepped_For_Keys);

autokey.MAC_data_address(t,fname,mname,lname,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,city_name,zip,sec_range,
						states,
						lname1,lname2,lname3,
						city1,city2,city3,
						rel_fname1,rel_fname2,rel_fname3,
						lookups,
						did,
						'',
						k)
export data_key_address := k;