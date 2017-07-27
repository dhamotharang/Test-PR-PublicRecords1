import ut, Business_Header;

// Determine BDID by company_name and contact name or DID

bc := Business_Header.File_Business_Contacts;

layout_bc_slim := record
bc.bdid;
bc.did;
bc.fname;
bc.mname;
bc.lname;
bc.name_suffix;
bc.company_name;
bc.company_state;
end;

bc_slim := table(bc(bdid <> 0, from_hdr = 'N'), layout_bc_slim);

nh := usbank_test_prep;

layout_usbank_name := record
nh.seq;
nh.bdid;
nh.bdid_score;
nh.fname;
nh.mname;
nh.lname;
nh.name_suffix;
Business_Name := Stringlib.StringToUpperCase(nh.Business_Name);
State := Stringlib.StringToUpperCase(nh.State);
end;

layout_usbank_did := record
nh.seq;
nh.bdid;
nh.bdid_score;
nh.did;
Business_Name := Stringlib.StringToUpperCase(nh.Business_Name);
end;

// Use DID if available
nh_did := table(nh(did <> 0, bdid = 0 or (bdid <> 0 and bdid_score < 75)), layout_usbank_did);

layout_usbank_did AssignBDIDbyDID(bc_slim l, layout_usbank_did r) := transform
self.bdid := l.bdid;
self.bdid_score := 100 - ut.CompanySimilar100(l.company_name, r.Business_Name);
self := r;
end;

nh_did_bdid := join(bc_slim,
                    nh_did,
					left.did = right.did and
					  ut.CompanySimilar100(left.company_name, right.Business_Name) <= 35,
					AssignBDIDbyDID(left, right),
					ALL);

nh_did_bdid_sort := sort(nh_did_bdid, seq, -bdid_score);
nh_did_bdid_dedup := dedup(nh_did_bdid_sort, seq);

// Append BDID and Score to original records
Layout_usbank_Test_Base AppendNH_DID_BDID(Layout_usbank_Test_Base l, layout_usbank_did r) := transform
self.bdid := r.bdid;
self.bdid_score := r.bdid_score;
self := l;
end;

nh_did_bdid_full := join(nh,
                         nh_did_bdid_dedup,
						 left.seq = right.seq and
						   left.bdid <> right.bdid,
						 AppendNH_DID_BDID(left, right),
						 lookup);

// Use name if no DID
nh_name := table(nh(did = 0, lname <> '', State <> '', bdid = 0 or (bdid <> 0 and bdid_score < 75)), layout_usbank_name);

layout_usbank_name AssignBDIDbyName(bc_slim l, layout_usbank_name r) := transform
self.bdid := l.bdid;
self.bdid_score := 100 - ut.CompanySimilar100(l.company_name, r.Business_Name);
self := r;
end;

nh_name_bdid := join(bc_slim(company_state <> ''),
                    nh_name,
					left.company_state = right.State and
					  ut.CompanySimilar100(left.company_name, right.Business_Name) <= 25 and
					  ut.NameMatch(left.fname, left.mname, left.lname, right.fname, right.mname, right.lname) < 2,
					AssignBDIDbyName(left, right),
					ALL);

nh_name_bdid_sort := sort(nh_name_bdid, seq, -bdid_score);
nh_name_bdid_dedup := dedup(nh_name_bdid_sort, seq);

Layout_usbank_Test_Base AppendNH_Name_BDID(Layout_usbank_Test_Base l, layout_usbank_name r) := transform
self.bdid := r.bdid;
self.bdid_score := r.bdid_score;
self := l;
end;

nh_name_bdid_full := join(nh,
                          nh_name_bdid_dedup,
					      left.seq = right.seq and
					        left.bdid <> right.bdid,
					      AppendNH_Name_BDID(left, right),
					      lookup);

// Combine to add best info
nh_bdid_full := nh_did_bdid_full + nh_name_bdid_full;

// Project into BDID in batch format
Business_Header_SS.Layout_BDID_OutBatch InitBatch(layout_usbank_test_base l) := transform
//Business_Header_SS.Layout_BDID_InBatch InitBatch(layout_usbank_test_base l) := transform
self.score := l.bdid_score;
self.phone10 := l.phone10;
self.company_name := Stringlib.StringToUpperCase(trim(l.Business_Name));
self.prim_range := l.bus_prim_range;
self.predir := l.bus_predir;
self.prim_name := l.bus_prim_name;
self.addr_suffix := l.bus_addr_suffix;
self.postdir := l.bus_postdir;
self.unit_desig := l.bus_unit_desig;
self.sec_range := l.bus_sec_range;
self.p_city_name := l.bus_p_city_name;
self.st := l.bus_st;
self.z5 := l.bus_zip;
self.zip4 := l.bus_zip4;
self := l;
end;

nh_bdid_match := project(nh_bdid_full, InitBatch(left));

Business_Header_SS.MAC_BestAppend(
	nh_bdid_match,
	'BEST_ALL',
	'BEST_ALL',
	nh_bdid_best,
	false
)

// Replace information in original records
Layout_usbank_Test_Base ReplaceNH(Layout_usbank_Test_Base l, Business_Header_SS.Layout_BDID_OutBatch r) := transform
self.bdid_from_contact := 'Y';
self.bdid_score := r.score;
self.score := l.score;
self := r;
self := l;
end;

nh_bdid_best_full := join(nh_bdid_full,
                          nh_bdid_best,
					      left.seq = right.seq,
						  ReplaceNH(left, right),
						  lookup) : persist('TMTEST::usbank_test_bdid_to_replace');
						  
// Replace updated records in full test file
layout_seq := record
nh_bdid_best_full.seq;
end;

seq_list := table(nh_bdid_best_full, layout_seq);

Layout_usbank_Test_Base RemoveContactRecs(Layout_usbank_Test_Base l, layout_seq r) := transform
self := l;
end;

nh_remove := join(nh,
                  seq_list,
				  left.seq = right.seq,
				  RemoveContactRecs(left, right),
				  left only,
				  lookup);
				  
nh_replace := nh_remove + nh_bdid_best_full;

// clear BDID score and Best information if score is less than 33
Layout_usbank_Test_Base ClearBDID(Layout_usbank_Test_Base l ) := transform
self.bdid := 0;
self.bdid_score := 0;
self.best_phone := '';
self.best_fein := '';
self.best_CompanyName := '';
self.best_addr1 := '';
self.best_addr2 := '';
self.verify_best_phone := 255;
self.verify_best_fein := 255;
self.verify_best_address := 255;
self.verify_best_CompanyName := 255;
self := l;
end;

nh_clear := project(nh_replace(bdid <> 0 and bdid_score < 33), ClearBDID(left));

nh_out := nh_replace(not(bdid <> 0 and bdid_score < 33)) + nh_clear;


export usbank_test_bdid_by_contact := nh_out : persist('TMTEST::usbank_test_bdid_by_contact');
