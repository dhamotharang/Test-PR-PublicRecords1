import ut, Business_Header, did_add, Watchdog;

// get list of all bdids for group_id/bdis without a corresponding did
layout_group_id := record
unsigned6 group_id;
end;

gid_list_init := project(cedarssinai_prep(group_id <> 0, did = 0),
                         transform(layout_group_id, self := left));
					
// get all bdids for selected group
bhg := Business_Header.File_Super_Group;

bdid_list := join(bhg,
                  gid_list_init,
			   left.group_id = right.group_id,
			   transform(Business_header.Layout_BH_Super_Group, self := left),
			   hash);
			   
// Limit the bdid list to non-marketing retricted bdids
bh_mkt_best := Business_Header.BestAll_MktApp;

bdid_list_mkt := join(bh_mkt_best,
                      bdid_list,
				  left.bdid = right.bdid,
				  transform(Business_header.Layout_BH_Super_Group, self := right),
				  hash);

// get business contacts with dids from bdid list
bc := Business_Header.File_Business_Contacts;

layout_bc_temp := record
unsigned6 group_id;
Business_Header.Layout_Business_Contact_Full;
end;

bc_to_match := join(bc(from_hdr='N', bdid <> 0, did <> 0, not glb, not dppa),
                    bdid_list_mkt,
				left.bdid = right.bdid,
				transform(layout_bc_temp, self.group_id := right.group_id, self := left),
				hash);

layout_bc_match := record
unsigned4 seq;
unsigned6 did;
// best information
  string10 	best_phone := '';
  string5		best_title := '';
  string20	best_fname := '';
  string20	best_mname := '';
  string20	best_lname := '';
  string5		best_name_suffix := '';
  string120 	best_addr1 := '';
  string30	best_city := '';
  string2		best_state := '';
  string5		best_zip :='';
  string4		best_zip4 := '';
  unsigned3	best_addr_date := 0;
  string8  	best_dob := '';
  string8  	best_dod := '';
end;

// match names
bc_match := join(distribute(cedarssinai_prep(group_id <> 0, did = 0), hash(group_id)),
                 distribute(bc_to_match, hash(group_id)),
			  left.group_id = right.group_id and
			    ut.NameMatch(left.fname, left.mname, left.lname,
			                 right.fname, right.mname, right.lname) <= 3,
			  transform(layout_bc_match, self.seq := left.seq, self.did := right.did));

bc_match_dedup := dedup(bc_match, seq, all);

// Append person best information (non-glb)
phb := Watchdog.File_Best_nonglb;

os(string i) := if (i='','',trim(i)+' ');

layout_bc_match AppendBestPersonInfo(phb l, layout_bc_match r) := transform
self.best_phone := l.phone;
self.best_title := l.title;
self.best_fname := l.fname;
self.best_mname := l.mname;
self.best_lname := l.lname;
self.best_name_suffix := l.name_suffix;
self.best_addr1 := os(l.prim_range)+os(l.predir)+os(l.prim_name)+os(l.suffix)+os(l.postdir)+IF(ut.tails(l.prim_name,os(l.unit_desig)+os(l.sec_range)),'',os(l.unit_desig)+os(l.sec_range));
self.best_city := l.city_name;
self.best_state := l.st;
self.best_zip := l.zip;
self.best_zip4 := l.zip4;
self.best_addr_date := l.addr_dt_last_seen;
self.best_dob := (string8)if(l.dob<=0,'',(string8)l.dob);
self.best_dod := l.dod;
self := r;
end;

bc_match_best := join(phb,
                      bc_match_dedup,
				  left.did = right.did,
				  AppendBestPersonInfo(left, right),
				  hash);
						 
// Append to original input
// Add did and did scores and best info
Layout_cedarssinai_base AppendDIDBest(Layout_cedarssinai_base l, layout_bc_match r) := transform
self.did := if(r.did <> 0, r.did, l.did);
self.score := if(r.did <> 0, 0, l.score);
self.best_phone := if(r.did <> 0, r.best_phone, l.best_phone);
self.best_title := if(r.did <> 0, r.best_title, l.best_title);
self.best_fname := if(r.did <> 0, r.best_fname, l.best_fname);
self.best_mname := if(r.did <> 0, r.best_mname, l.best_mname);
self.best_lname := if(r.did <> 0, r.best_lname, l.best_lname);
self.best_name_suffix := if(r.did <> 0, r.best_name_suffix, l.best_name_suffix);
self.best_addr1 := if(r.did <> 0, r.best_addr1, l.best_addr1);
self.best_city := if(r.did <> 0, r.best_city, l.best_city);
self.best_state := if(r.did <> 0, r.best_state, l.best_state);
self.best_zip := if(r.did <> 0, r.best_zip, l.best_zip);
self.best_zip4 := if(r.did <> 0, r.best_zip4, l.best_zip4);
self.best_addr_date := if(r.did <> 0, r.best_addr_date, l.best_addr_date);
self.best_dob := if(r.did <> 0, r.best_dob, l.best_dob);
self.best_dod := if(r.did <> 0, r.best_dod, l.best_dod);
self := l;
end;

bc_match_append := join(cedarssinai_prep(group_id <> 0, did = 0),
                        bc_match_best,
				    left.seq = right.seq,
				    AppendDIDBest(left, right),
				    left outer,
				    hash);

// combine with the remainder of the records				    
bc_match_combined := sort((bc_match_append + cedarssinai_prep(not(group_id <> 0 and did = 0))), seq, -score);

export cedarssinai_match := bc_match_combined : persist('TMTEST::cedars_sinai_match');