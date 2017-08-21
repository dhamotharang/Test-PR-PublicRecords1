//-------Eliminate duplications
import phonesplus;
export Fn_Eliminate_Duplications(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

//---Split record with blank addresses
no_address := phplus_in(trim(prim_range + prim_name + sec_range, all) = '');                                                                                                                                           
no_address_with_did_dedp := dedup(sort(distribute(no_address(pdid = 0),  hash(npa+phone7)),npa+phone7, did, -zip5, prim_range, prim_name, -append_best_addr_match_flag, -append_best_nm_match_flag, -lname, -fname, -sec_range,local), npa+phone7, did, zip5, prim_range,prim_name, local);
no_address_no_did_dedp := dedup(sort(distribute(no_address(pdid > 0),  hash(npa+phone7)),npa+phone7, -zip5, prim_range, prim_name, -append_best_addr_match_flag, -append_best_nm_match_flag, -lname, -fname, -sec_range,  local), npa+phone7, zip5, prim_range,prim_name, lname, local);

with_address := phplus_in(trim(prim_range + prim_name + sec_range, all) <> '');

//-----Dedup records by phone, did and address
pplus_include_with_did := dedup(sort(distribute(with_address(in_flag and pdid = 0),  hash(npa+phone7)),npa+phone7, did, -zip5, prim_range, prim_name, -append_best_addr_match_flag, -append_best_nm_match_flag, -lname, -fname, -sec_range, local), npa+phone7, did, zip5, prim_range,prim_name, local);
pplus_exclude_with_did := dedup(sort(distribute(with_address(~in_flag and pdid = 0), hash(npa+phone7)),npa+phone7, did, -zip5, prim_range, prim_name, -append_best_addr_match_flag, -append_best_nm_match_flag, -lname, -fname, -sec_range, local), npa+phone7, did, zip5, prim_range,prim_name, local);

//-----Dedup records by phone, name and address
pplus_include_no_did := dedup(sort(distribute(with_address(in_flag and pdid > 0),  hash(npa+phone7)),npa+phone7, -zip5, prim_range, prim_name, -append_best_addr_match_flag, -lname, -fname, -sec_range,  local), npa+phone7, zip5, prim_range,prim_name, lname, local);
pplus_exclude_no_did := dedup(sort(distribute(with_address(~in_flag and pdid > 0), hash(npa+phone7)),npa+phone7, -zip5, prim_range, prim_name, -append_best_addr_match_flag, -lname, -fname, -sec_range,  local), npa+phone7, zip5, prim_range,prim_name, lname, local);

//----Concatenate all records to be included with address
pplus_all_with_address  := pplus_include_with_did + pplus_exclude_with_did + pplus_include_no_did + pplus_exclude_no_did;

//---Find records with no address where that records is the only one available for the phone and individual
no_address_only_one := join(distribute(no_address_with_did_dedp + no_address_no_did_dedp, hash(npa+phone7)),
                            distribute(pplus_all_with_address, hash(npa+phone7)),
							left.npa + left.phone7 = right.npa + right.phone7 and
							((left.pdid = 0 and 
							 left.did = right.did) or
							  (left.pdid > 0 and
							  left.lname = right.lname and
							  left.fname = right.fname)),
							  transform(recordof(no_address_with_did_dedp), self := left),
							  left only,
							  local);

//----Concatenate all records to be included in final base file
pplus_all := pplus_all_with_address + no_address_only_one;

return pplus_all;
end;
