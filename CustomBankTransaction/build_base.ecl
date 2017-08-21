
import custombanktransaction, did_add;

base_layout := custombanktransaction.layouts.base;
infile := custombanktransaction.cleaned_raw;

//infile := dataset('~thor_data400::persist::chase_clean_address_comb',base_layout, flat);

matchset :=['A','S','D','G','Z','4','Q'];

	did_Add.MAC_Match_Flex(infile, matchset,
													ssn, brth_dt, fname, mname, lname, name_suffix, 
													prim_range, prim_name, sec_range, zip, st, foo,
													DID,   			
													base_layout, 
													true, DID_score,	//these should default to zero in definition
													75,	  //dids with a score below here will be dropped 
													outfile);
		
did_outfile := outfile : persist('~thor_data400::persist::chase_comb_DID');

temp_rec := record
base_layout;
string clean_bank_addr;

end;

chase_has_DID := did_outfile(did > 0);

chase_has_no_DID := did_outfile(did = 0);

chase_has_open_year := chase_has_DID(Q16_opn_yr <> '');

chase_year_dist := distribute(chase_has_open_year, hash(did));

deduped_did_year := dedup(sort(chase_year_dist, did,Q16_opn_yr, local),did,Q16_opn_yr, local);

grouped_did_year := group(deduped_did_year, did, local);

rolled_did_year := group(rollup(grouped_did_year, true, transform(base_layout, 
									 self.Q16_opn_yr := if(left.Q16_opn_yr = right.Q16_opn_yr, right.Q16_opn_yr, 'M'),
									 self := right)));	

did_multi_year := rolled_did_year(Q16_opn_yr = 'M');

//count(did_multi_year);

chase_has_bank_addr := project(chase_has_DID, transform(temp_rec,
self.clean_bank_addr := trim(left.Q17_bk_ctr_addr_clean.prim_range + left.Q17_bk_ctr_addr_clean.predir +
left.Q17_bk_ctr_addr_clean.prim_name + left.Q17_bk_ctr_addr_clean.addr_suffix + left.Q17_bk_ctr_addr_clean.postdir + left.Q17_bk_ctr_addr_clean.sec_range + left.Q17_bk_ctr_addr_clean.p_city_name +
left.Q17_bk_ctr_addr_clean.zip,left,right), self := left)); 

chase_addr_dist := distribute(chase_has_bank_addr(clean_bank_addr <> ''), hash(did));

deduped_did_addr := dedup(sort(chase_addr_dist, did, clean_bank_addr, local),did, clean_bank_addr, local);

grouped_did_addr := group(deduped_did_addr, did, local);

rolled_did_addr := group(rollup(grouped_did_addr, true, transform(temp_rec, 
									 self.clean_bank_addr := if(left.clean_bank_addr = right.clean_bank_addr, right.clean_bank_addr, 'M'),
									 self := right)));	

did_multi_bank_addr := rolled_did_addr(clean_bank_addr = 'M');

//count(did_multi_bank_addr);
//multiple Q06_cosigner_dob per LexID
chase_has_dob := chase_has_DID(Q06_cosigner_dob <> '');

chase_dob_dist := distribute(chase_has_dob, hash(did));

deduped_did_dob := dedup(sort(chase_dob_dist, did,Q06_cosigner_dob, local),did,Q06_cosigner_dob, local);

grouped_did_dob := group(deduped_did_dob, did, local);

rolled_did_dob := group(rollup(grouped_did_dob, true, transform(base_layout, 
									 self.Q06_cosigner_dob := if(left.Q06_cosigner_dob = right.Q06_cosigner_dob, right.Q06_cosigner_dob, 'M'),
									 self := right)));	

did_multi_dob := rolled_did_dob(Q06_cosigner_dob = 'M');

//count(did_multi_dob);
//setup open_year = '' if there are multiple open year per LexID
chase_has_DID_dist := distribute(chase_has_DID, hash(did));

chase_has_DID_dist tjoin_multi_year(chase_has_DID_dist le, did_multi_year ri) := transform

self.Q16_opn_yr := if(le.did = ri.did, '', le.Q16_opn_yr);

self := le;

end;

chase_append_multi_year := join(chase_has_DID_dist, did_multi_year, left.did = right.did, tjoin_multi_year(left, right),
left outer, local);

//setup bank address = '' if there are multiple bank addr per LexID

chase_append_multi_year tjoin_multi_addr(chase_append_multi_year le, did_multi_bank_addr ri) := transform

//self.Q17_bk_ctr_addr := if(le.did = ri.did, '', le.Q17_bk_ctr_addr);
self.Q17_bk_ctr_addr_clean.prim_range := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.prim_range);
self.Q17_bk_ctr_addr_clean.predir			 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.predir);
self.Q17_bk_ctr_addr_clean.prim_name		 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.prim_name);
self.Q17_bk_ctr_addr_clean.addr_suffix		 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.addr_suffix);
self.Q17_bk_ctr_addr_clean.postdir				 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.postdir);
self.Q17_bk_ctr_addr_clean.unit_desig		 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.unit_desig);
self.Q17_bk_ctr_addr_clean.sec_range			 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.sec_range);
self.Q17_bk_ctr_addr_clean.p_city_name		 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.p_city_name);
self.Q17_bk_ctr_addr_clean.v_city_name		 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.v_city_name);
self.Q17_bk_ctr_addr_clean.st						 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.st);
self.Q17_bk_ctr_addr_clean.zip						 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.zip);
self.Q17_bk_ctr_addr_clean.zip4				 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.zip4);
self.Q17_bk_ctr_addr_clean.cart					 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.cart);
self.Q17_bk_ctr_addr_clean.cr_sort_sz		 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.cr_sort_sz);
self.Q17_bk_ctr_addr_clean.lot						 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.lot);
self.Q17_bk_ctr_addr_clean.lot_order			 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.lot_order);
self.Q17_bk_ctr_addr_clean.dbpc					 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.dbpc);
self.Q17_bk_ctr_addr_clean.chk_digit		 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.chk_digit);
self.Q17_bk_ctr_addr_clean.rec_type			 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.rec_type);
self.Q17_bk_ctr_addr_clean.fips_state		 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.fips_state);
self.Q17_bk_ctr_addr_clean.fips_county		 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.fips_county);
self.Q17_bk_ctr_addr_clean.geo_lat				 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.geo_lat);
self.Q17_bk_ctr_addr_clean.geo_long			 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.geo_long);
self.Q17_bk_ctr_addr_clean.msa						 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.msa);
self.Q17_bk_ctr_addr_clean.geo_blk				 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.geo_blk);
self.Q17_bk_ctr_addr_clean.geo_match		 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.geo_match);
self.Q17_bk_ctr_addr_clean.err_stat			 := if(le.did = ri.did, '', le.Q17_bk_ctr_addr_clean.err_stat);
self := le;

end;

chase_append_multi_addr := join(chase_append_multi_year, did_multi_bank_addr, left.did = right.did, tjoin_multi_addr(left, right),
left outer, local);

//setup Q06_cosigner_dob = '' if there are multiple Q06_cosigner_dob per LexID

chase_append_multi_addr tjoin_multi_dob(chase_append_multi_addr le, did_multi_dob ri) := transform

self.Q06_cosigner_dob := if(le.did = ri.did, '', le.Q06_cosigner_dob);

self := le;

end;

chase_append_multi_dob := join(chase_append_multi_addr, did_multi_dob, left.did = right.did, tjoin_multi_dob(left, right),
left outer, local);

//make cosigner_DOB, account_open_year and clean bank address the same per LexID

chase_append_multi_dob_sort := group(sort(distribute(chase_append_multi_dob, hash(did)), did, -Q06_cosigner_dob,-Q16_opn_yr, -Q17_bk_ctr_addr_clean.prim_range, -Q17_bk_ctr_addr_clean.prim_name, 
-Q17_bk_ctr_addr_clean.zip, local), did, local);

chase_append_multi_dob_sort tInteration1(chase_append_multi_dob_sort le, chase_append_multi_dob_sort ri) := transform

self.Q06_cosigner_dob  := if(le.Q06_cosigner_dob = '' and ri.Q06_cosigner_dob != '', ri.Q06_cosigner_dob,  le.Q06_cosigner_dob);
self.Q16_opn_yr        := if(le.Q16_opn_yr = '' and ri.Q16_opn_yr != '', ri.Q16_opn_yr, le.Q16_opn_yr);
//self.Q17_bk_ctr_addr        := if(le.Q17_bk_ctr_addr = '' and ri.Q17_bk_ctr_addr != '', ri.Q17_bk_ctr_addr, le.Q17_bk_ctr_addr);
self.Q17_bk_ctr_addr_clean.prim_range := if(le.Q17_bk_ctr_addr_clean.prim_range = '' and ri.Q17_bk_ctr_addr_clean.prim_range != '', ri.Q17_bk_ctr_addr_clean.prim_range, le.Q17_bk_ctr_addr_clean.prim_range);
self.Q17_bk_ctr_addr_clean.predir			 := if(le.Q17_bk_ctr_addr_clean.predir = '' and ri.Q17_bk_ctr_addr_clean.predir != '', ri.Q17_bk_ctr_addr_clean.predir, le.Q17_bk_ctr_addr_clean.predir);
self.Q17_bk_ctr_addr_clean.prim_name		 := if(le.Q17_bk_ctr_addr_clean.prim_name = '' and ri.Q17_bk_ctr_addr_clean.prim_name != '', ri.Q17_bk_ctr_addr_clean.prim_name, le.Q17_bk_ctr_addr_clean.prim_name);
self.Q17_bk_ctr_addr_clean.addr_suffix		 := if(le.Q17_bk_ctr_addr_clean.addr_suffix = '' and ri.Q17_bk_ctr_addr_clean.addr_suffix != '', ri.Q17_bk_ctr_addr_clean.addr_suffix,le.Q17_bk_ctr_addr_clean.addr_suffix );
self.Q17_bk_ctr_addr_clean.postdir				 := if(le.Q17_bk_ctr_addr_clean.postdir = '' and ri.Q17_bk_ctr_addr_clean.postdir != '', ri.Q17_bk_ctr_addr_clean.postdir, le.Q17_bk_ctr_addr_clean.postdir);
self.Q17_bk_ctr_addr_clean.unit_desig		 := if(le.Q17_bk_ctr_addr_clean.unit_desig = '' and ri.Q17_bk_ctr_addr_clean.unit_desig != '', ri.Q17_bk_ctr_addr_clean.unit_desig, le.Q17_bk_ctr_addr_clean.unit_desig);
self.Q17_bk_ctr_addr_clean.sec_range			 := if(le.Q17_bk_ctr_addr_clean.sec_range = '' and ri.Q17_bk_ctr_addr_clean.sec_range != '', ri.Q17_bk_ctr_addr_clean.sec_range, le.Q17_bk_ctr_addr_clean.sec_range);
self.Q17_bk_ctr_addr_clean.p_city_name		 := if(le.Q17_bk_ctr_addr_clean.p_city_name = '' and ri.Q17_bk_ctr_addr_clean.p_city_name != '', ri.Q17_bk_ctr_addr_clean.p_city_name, le.Q17_bk_ctr_addr_clean.p_city_name);
self.Q17_bk_ctr_addr_clean.v_city_name		 := if(le.Q17_bk_ctr_addr_clean.v_city_name = '' and ri.Q17_bk_ctr_addr_clean.v_city_name != '', ri.Q17_bk_ctr_addr_clean.v_city_name, le.Q17_bk_ctr_addr_clean.v_city_name);
self.Q17_bk_ctr_addr_clean.st						 := if(le.Q17_bk_ctr_addr_clean.st = '' and ri.Q17_bk_ctr_addr_clean.st != '', ri.Q17_bk_ctr_addr_clean.st, le.Q17_bk_ctr_addr_clean.st);
self.Q17_bk_ctr_addr_clean.zip						 := if(le.Q17_bk_ctr_addr_clean.zip = '' and ri.Q17_bk_ctr_addr_clean.zip != '', ri.Q17_bk_ctr_addr_clean.zip, le.Q17_bk_ctr_addr_clean.zip);
self.Q17_bk_ctr_addr_clean.zip4				 := if(le.Q17_bk_ctr_addr_clean.zip4 = '' and ri.Q17_bk_ctr_addr_clean.zip4 != '', ri.Q17_bk_ctr_addr_clean.zip4, le.Q17_bk_ctr_addr_clean.zip4);
self.Q17_bk_ctr_addr_clean.cart					 := if(le.Q17_bk_ctr_addr_clean.cart = '' and ri.Q17_bk_ctr_addr_clean.cart != '', ri.Q17_bk_ctr_addr_clean.cart, le.Q17_bk_ctr_addr_clean.cart);
self.Q17_bk_ctr_addr_clean.cr_sort_sz		 := if(le.Q17_bk_ctr_addr_clean.cr_sort_sz = '' and ri.Q17_bk_ctr_addr_clean.cr_sort_sz != '', ri.Q17_bk_ctr_addr_clean.cr_sort_sz, le.Q17_bk_ctr_addr_clean.cr_sort_sz);
self.Q17_bk_ctr_addr_clean.lot						 := if(le.Q17_bk_ctr_addr_clean.lot = '' and ri.Q17_bk_ctr_addr_clean.lot != '', ri.Q17_bk_ctr_addr_clean.lot,  le.Q17_bk_ctr_addr_clean.lot);
self.Q17_bk_ctr_addr_clean.lot_order			 := if(le.Q17_bk_ctr_addr_clean.lot_order = '' and ri.Q17_bk_ctr_addr_clean.lot_order != '', ri.Q17_bk_ctr_addr_clean.lot_order, le.Q17_bk_ctr_addr_clean.lot_order);
self.Q17_bk_ctr_addr_clean.dbpc					 := if(le.Q17_bk_ctr_addr_clean.dbpc = '' and ri.Q17_bk_ctr_addr_clean.dbpc != '', ri.Q17_bk_ctr_addr_clean.dbpc, le.Q17_bk_ctr_addr_clean.dbpc);
self.Q17_bk_ctr_addr_clean.chk_digit		 := if(le.Q17_bk_ctr_addr_clean.chk_digit = '' and ri.Q17_bk_ctr_addr_clean.chk_digit != '', ri.Q17_bk_ctr_addr_clean.chk_digit,  le.Q17_bk_ctr_addr_clean.chk_digit);
self.Q17_bk_ctr_addr_clean.rec_type			 := if(le.Q17_bk_ctr_addr_clean.rec_type = '' and ri.Q17_bk_ctr_addr_clean.rec_type != '', ri.Q17_bk_ctr_addr_clean.rec_type, le.Q17_bk_ctr_addr_clean.rec_type);
self.Q17_bk_ctr_addr_clean.fips_state		 := if(le.Q17_bk_ctr_addr_clean.fips_state = '' and ri.Q17_bk_ctr_addr_clean.fips_state != '', ri.Q17_bk_ctr_addr_clean.fips_state, le.Q17_bk_ctr_addr_clean.fips_state);
self.Q17_bk_ctr_addr_clean.fips_county		 := if(le.Q17_bk_ctr_addr_clean.fips_county = '' and ri.Q17_bk_ctr_addr_clean.fips_county != '', ri.Q17_bk_ctr_addr_clean.fips_county, le.Q17_bk_ctr_addr_clean.fips_county);
self.Q17_bk_ctr_addr_clean.geo_lat				 := if(le.Q17_bk_ctr_addr_clean.geo_lat = '' and ri.Q17_bk_ctr_addr_clean.geo_lat != '', ri.Q17_bk_ctr_addr_clean.geo_lat, le.Q17_bk_ctr_addr_clean.geo_lat);
self.Q17_bk_ctr_addr_clean.geo_long			 := if(le.Q17_bk_ctr_addr_clean.geo_long = '' and ri.Q17_bk_ctr_addr_clean.geo_long != '', ri.Q17_bk_ctr_addr_clean.geo_long, le.Q17_bk_ctr_addr_clean.geo_long);
self.Q17_bk_ctr_addr_clean.msa						 := if(le.Q17_bk_ctr_addr_clean.msa = '' and ri.Q17_bk_ctr_addr_clean.msa != '', ri.Q17_bk_ctr_addr_clean.msa, le.Q17_bk_ctr_addr_clean.msa);
self.Q17_bk_ctr_addr_clean.geo_blk				 := if(le.Q17_bk_ctr_addr_clean.geo_blk = '' and ri.Q17_bk_ctr_addr_clean.geo_blk != '', ri.Q17_bk_ctr_addr_clean.geo_blk, le.Q17_bk_ctr_addr_clean.geo_blk);
self.Q17_bk_ctr_addr_clean.geo_match		 := if(le.Q17_bk_ctr_addr_clean.geo_match = '' and ri.Q17_bk_ctr_addr_clean.geo_match != '', ri.Q17_bk_ctr_addr_clean.geo_match, le.Q17_bk_ctr_addr_clean.geo_match);
self.Q17_bk_ctr_addr_clean.err_stat			 := if(le.Q17_bk_ctr_addr_clean.err_stat = '' and ri.Q17_bk_ctr_addr_clean.err_stat != '', ri.Q17_bk_ctr_addr_clean.err_stat, le.Q17_bk_ctr_addr_clean.err_stat);
self := ri;

end;

chase_iteration1 := group(iterate(chase_append_multi_dob_sort,tInteration1(left,right)));

chase_iteration1_grp := group(sort(distribute(chase_iteration1, hash(did)), did, -Q06_cosigner_dob,-Q16_opn_yr, -Q17_bk_ctr_addr_clean.prim_range, -Q17_bk_ctr_addr_clean.prim_name, 
-Q17_bk_ctr_addr_clean.zip, local), did, local);

chase_iteration1_grp tInteration2(chase_iteration1_grp le, chase_iteration1_grp ri) := transform

self.Q06_cosigner_dob  := if(le.Q06_cosigner_dob = '' and ri.Q06_cosigner_dob != '', ri.Q06_cosigner_dob,  le.Q06_cosigner_dob);
self.Q16_opn_yr        := if(le.Q16_opn_yr = '' and ri.Q16_opn_yr != '', ri.Q16_opn_yr, le.Q16_opn_yr);
//self.Q17_bk_ctr_addr        := if( le.Q17_bk_ctr_addr = '' and ri.Q17_bk_ctr_addr != '', ri.Q17_bk_ctr_addr, le.Q17_bk_ctr_addr);
self.Q17_bk_ctr_addr_clean.prim_range := if(le.Q17_bk_ctr_addr_clean.prim_range = '' and ri.Q17_bk_ctr_addr_clean.prim_range != '', ri.Q17_bk_ctr_addr_clean.prim_range, le.Q17_bk_ctr_addr_clean.prim_range);
self.Q17_bk_ctr_addr_clean.predir			 := if(le.Q17_bk_ctr_addr_clean.predir = '' and ri.Q17_bk_ctr_addr_clean.predir != '', ri.Q17_bk_ctr_addr_clean.predir, le.Q17_bk_ctr_addr_clean.predir);
self.Q17_bk_ctr_addr_clean.prim_name		 := if(le.Q17_bk_ctr_addr_clean.prim_name = '' and ri.Q17_bk_ctr_addr_clean.prim_name != '', ri.Q17_bk_ctr_addr_clean.prim_name, le.Q17_bk_ctr_addr_clean.prim_name);
self.Q17_bk_ctr_addr_clean.addr_suffix		 := if(le.Q17_bk_ctr_addr_clean.addr_suffix = '' and ri.Q17_bk_ctr_addr_clean.addr_suffix != '', ri.Q17_bk_ctr_addr_clean.addr_suffix,le.Q17_bk_ctr_addr_clean.addr_suffix );
self.Q17_bk_ctr_addr_clean.postdir				 := if(le.Q17_bk_ctr_addr_clean.postdir = '' and ri.Q17_bk_ctr_addr_clean.postdir != '', ri.Q17_bk_ctr_addr_clean.postdir, le.Q17_bk_ctr_addr_clean.postdir);
self.Q17_bk_ctr_addr_clean.unit_desig		 := if(le.Q17_bk_ctr_addr_clean.unit_desig = '' and ri.Q17_bk_ctr_addr_clean.unit_desig != '', ri.Q17_bk_ctr_addr_clean.unit_desig, le.Q17_bk_ctr_addr_clean.unit_desig);
self.Q17_bk_ctr_addr_clean.sec_range			 := if(le.Q17_bk_ctr_addr_clean.sec_range = '' and ri.Q17_bk_ctr_addr_clean.sec_range != '', ri.Q17_bk_ctr_addr_clean.sec_range, le.Q17_bk_ctr_addr_clean.sec_range);
self.Q17_bk_ctr_addr_clean.p_city_name		 := if(le.Q17_bk_ctr_addr_clean.p_city_name = '' and ri.Q17_bk_ctr_addr_clean.p_city_name != '', ri.Q17_bk_ctr_addr_clean.p_city_name, le.Q17_bk_ctr_addr_clean.p_city_name);
self.Q17_bk_ctr_addr_clean.v_city_name		 := if(le.Q17_bk_ctr_addr_clean.v_city_name = '' and ri.Q17_bk_ctr_addr_clean.v_city_name != '', ri.Q17_bk_ctr_addr_clean.v_city_name, le.Q17_bk_ctr_addr_clean.v_city_name);
self.Q17_bk_ctr_addr_clean.st						 := if(le.Q17_bk_ctr_addr_clean.st = '' and ri.Q17_bk_ctr_addr_clean.st != '', ri.Q17_bk_ctr_addr_clean.st, le.Q17_bk_ctr_addr_clean.st);
self.Q17_bk_ctr_addr_clean.zip						 := if(le.Q17_bk_ctr_addr_clean.zip = '' and ri.Q17_bk_ctr_addr_clean.zip != '', ri.Q17_bk_ctr_addr_clean.zip, le.Q17_bk_ctr_addr_clean.zip);
self.Q17_bk_ctr_addr_clean.zip4				 := if(le.Q17_bk_ctr_addr_clean.zip4 = '' and ri.Q17_bk_ctr_addr_clean.zip4 != '', ri.Q17_bk_ctr_addr_clean.zip4, le.Q17_bk_ctr_addr_clean.zip4);
self.Q17_bk_ctr_addr_clean.cart					 := if(le.Q17_bk_ctr_addr_clean.cart = '' and ri.Q17_bk_ctr_addr_clean.cart != '', ri.Q17_bk_ctr_addr_clean.cart, le.Q17_bk_ctr_addr_clean.cart);
self.Q17_bk_ctr_addr_clean.cr_sort_sz		 := if(le.Q17_bk_ctr_addr_clean.cr_sort_sz = '' and ri.Q17_bk_ctr_addr_clean.cr_sort_sz != '', ri.Q17_bk_ctr_addr_clean.cr_sort_sz, le.Q17_bk_ctr_addr_clean.cr_sort_sz);
self.Q17_bk_ctr_addr_clean.lot						 := if(le.Q17_bk_ctr_addr_clean.lot = '' and ri.Q17_bk_ctr_addr_clean.lot != '', ri.Q17_bk_ctr_addr_clean.lot,  le.Q17_bk_ctr_addr_clean.lot);
self.Q17_bk_ctr_addr_clean.lot_order			 := if(le.Q17_bk_ctr_addr_clean.lot_order = '' and ri.Q17_bk_ctr_addr_clean.lot_order != '', ri.Q17_bk_ctr_addr_clean.lot_order, le.Q17_bk_ctr_addr_clean.lot_order);
self.Q17_bk_ctr_addr_clean.dbpc					 := if(le.Q17_bk_ctr_addr_clean.dbpc = '' and ri.Q17_bk_ctr_addr_clean.dbpc != '', ri.Q17_bk_ctr_addr_clean.dbpc, le.Q17_bk_ctr_addr_clean.dbpc);
self.Q17_bk_ctr_addr_clean.chk_digit		 := if(le.Q17_bk_ctr_addr_clean.chk_digit = '' and ri.Q17_bk_ctr_addr_clean.chk_digit != '', ri.Q17_bk_ctr_addr_clean.chk_digit,  le.Q17_bk_ctr_addr_clean.chk_digit);
self.Q17_bk_ctr_addr_clean.rec_type			 := if(le.Q17_bk_ctr_addr_clean.rec_type = '' and ri.Q17_bk_ctr_addr_clean.rec_type != '', ri.Q17_bk_ctr_addr_clean.rec_type, le.Q17_bk_ctr_addr_clean.rec_type);
self.Q17_bk_ctr_addr_clean.fips_state		 := if(le.Q17_bk_ctr_addr_clean.fips_state = '' and ri.Q17_bk_ctr_addr_clean.fips_state != '', ri.Q17_bk_ctr_addr_clean.fips_state, le.Q17_bk_ctr_addr_clean.fips_state);
self.Q17_bk_ctr_addr_clean.fips_county		 := if(le.Q17_bk_ctr_addr_clean.fips_county = '' and ri.Q17_bk_ctr_addr_clean.fips_county != '', ri.Q17_bk_ctr_addr_clean.fips_county, le.Q17_bk_ctr_addr_clean.fips_county);
self.Q17_bk_ctr_addr_clean.geo_lat				 := if(le.Q17_bk_ctr_addr_clean.geo_lat = '' and ri.Q17_bk_ctr_addr_clean.geo_lat != '', ri.Q17_bk_ctr_addr_clean.geo_lat, le.Q17_bk_ctr_addr_clean.geo_lat);
self.Q17_bk_ctr_addr_clean.geo_long			 := if(le.Q17_bk_ctr_addr_clean.geo_long = '' and ri.Q17_bk_ctr_addr_clean.geo_long != '', ri.Q17_bk_ctr_addr_clean.geo_long, le.Q17_bk_ctr_addr_clean.geo_long);
self.Q17_bk_ctr_addr_clean.msa						 := if(le.Q17_bk_ctr_addr_clean.msa = '' and ri.Q17_bk_ctr_addr_clean.msa != '', ri.Q17_bk_ctr_addr_clean.msa, le.Q17_bk_ctr_addr_clean.msa);
self.Q17_bk_ctr_addr_clean.geo_blk				 := if(le.Q17_bk_ctr_addr_clean.geo_blk = '' and ri.Q17_bk_ctr_addr_clean.geo_blk != '', ri.Q17_bk_ctr_addr_clean.geo_blk, le.Q17_bk_ctr_addr_clean.geo_blk);
self.Q17_bk_ctr_addr_clean.geo_match		 := if(le.Q17_bk_ctr_addr_clean.geo_match = '' and ri.Q17_bk_ctr_addr_clean.geo_match != '', ri.Q17_bk_ctr_addr_clean.geo_match, le.Q17_bk_ctr_addr_clean.geo_match);
self.Q17_bk_ctr_addr_clean.err_stat			 := if(le.Q17_bk_ctr_addr_clean.err_stat = '' and ri.Q17_bk_ctr_addr_clean.err_stat != '', ri.Q17_bk_ctr_addr_clean.err_stat, le.Q17_bk_ctr_addr_clean.err_stat);
self := ri;

end;

chase_iteration2 := group(iterate(chase_iteration1_grp,tInteration2(left,right)));

out_comb := dedup(chase_iteration2, all, local) + chase_has_no_DID;

ut.MAC_SF_BuildProcess(out_comb,'~thor_Data400::base::chase_data',out_base,2,,true)
													
EXPORT build_base := out_base;