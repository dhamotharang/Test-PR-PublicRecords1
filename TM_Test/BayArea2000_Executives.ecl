import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

// Normalize Executive Name information from input data
layout_bayarea2000_seq := record
unsigned4 rid;
unsigned4 seq := 0;
layout_bayarea2000_test_in;
end;

bayarea2000_seq := dataset('TMTEST::bayarea2000_Seq', layout_bayarea2000_seq, flat);

layout_bayarea2000_norm := record
unsigned4 rid;
unsigned4 seq := 0;
string ExecutiveName;
string ExecutiveTitle;
end;

layout_bayarea2000_norm NormalizeExecutiveName(layout_bayarea2000_seq l, unsigned4 cnt) := transform
self.ExecutiveName := choose(cnt, l.ExecutiveName1, l.ExecutiveName2, l.ExecutiveName3, l.ExecutiveName4,
                                   l.ExecutiveName5, l.ExecutiveName6, l.ExecutiveName7, l.ExecutiveName8,
					          l.ExecutiveName9, l.ExecutiveName10);
self.ExecutiveTitle := choose(cnt, l.ExecutiveTitle1, l.ExecutiveTitle2, l.ExecutiveTitle3, l.ExecutiveTitle4,
                                   l.ExecutiveTitle5, l.ExecutiveTitle6, l.ExecutiveTitle7, l.ExecutiveTitle8,
					          l.ExecutiveTitle9, l.ExecutiveTitle10);
self := l;
end;

bayarea2000_norm := normalize(bayarea2000_seq, 10, NormalizeExecutiveName(left, counter));

// Add unique sequence number to normalized input
layout_bayarea2000_norm SequenceInput(layout_bayarea2000_norm l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

bayarea2000_norm_seq := project(bayarea2000_norm(ExecutiveName <> ''), SequenceInput(left, counter)) : persist('TMTEST::bayarea2000_execs_norm');


layout_bayarea2000_clean := record
layout_bayarea2000_norm;
string73  clean_name; 
end;

layout_bayarea2000_clean CleanInputNames(layout_bayarea2000_norm l) := transform
self.clean_name := addrcleanlib.cleanPerson73(trim(l.ExecutiveName));
self := l;
end;

bayarea2000_clean_init := project(bayarea2000_norm_seq, CleanInputNames(left));

Layout_BayArea2000_Executive_Base AppendCompanyInfo(layout_bayarea2000_clean l, Layout_BayArea2000_Test_Base r) := transform
  self.seq := l.seq;
  // clean contact name
  self.title := l.clean_name[1..5];
  self.fname := l.clean_name[6..25];
  self.mname := l.clean_name[26..45];
  self.lname := l.clean_name[46..65];
  self.name_suffix := l.clean_name[66..70];
  self.name_score := l.clean_name[71..73];
  self := r;
  self := l;
 end;

// Append company information
bayarea2000_clean_append := join(bayarea2000_clean_init,
                                 bayarea2000_prep,
						   left.rid = right.rid,
						   AppendCompanyInfo(left, right),
						   hash) : persist('TMTEST::bayarea2000_execs_clean');
						   
// Add dids for executives associated with the businesses
didville.Layout_Did_OutBatch InitExec(Layout_BayArea2000_Executive_Base l) := transform
self.dob := '';
self.ssn := '';
self.phone10 := l.phone10;
self.suffix := l.name_suffix;
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

bayarea2000_exec_to_did := project(bayarea2000_clean_append(lname <> ''),InitExec(left));

DID_Matchset := ['A','Z','P'];

DID_Add.MAC_Match_Flex(bayarea2000_exec_to_did, 
	 DID_Matchset,
	 ssn, dob, fname, mname,lname, suffix, 
	 prim_range, prim_name, sec_range, z5, st, phone10, 
	 did,
	 didville.Layout_Did_OutBatch, 
	 TRUE, score, 
      50,  //low score threshold
	 bayarea2000_exec_did_match)

didville.MAC_BestAppend(bayarea2000_exec_did_match,'BEST_ALL','BEST_ALL',0,true,bayarea2000_exec_did_best)

// Add did and did scores and best info
Layout_BayArea2000_Executive_Base AppendDIDBest(Layout_BayArea2000_Executive_Base l, didville.Layout_Did_OutBatch r) := transform
self.did := r.did;
self.score := r.score;
self.best_phone := r.best_phone;
self.best_title := r.best_title;
self.best_fname := r.best_fname;
self.best_mname := r.best_mname;
self.best_lname := r.best_lname;
self.best_name_suffix := r.best_name_suffix;
self.best_addr1 := r.best_addr1;
self.best_city := r.best_city;
self.best_state := r.best_state;
self.best_zip := r.best_zip;
self.best_zip4 := r.best_zip4;
self.best_addr_date := r.best_addr_date;
self.best_dob := r.best_dob;
self.best_dod := r.best_dod;
self := l;
end;

bayarea2000_exec_did_append := join(bayarea2000_clean_append,
                                     bayarea2000_exec_did_best,
					            left.seq = right.seq,
					            AppendDIDBest(left, right),
					            left outer,
							  hash)    : persist('TMTEST::bayarea2000_execs_did_best');

bayarea2000_executives_out := dedup(sort(bayarea2000_exec_did_append, rid, seq, -score), rid, seq) : persist('TMTEST::bayarea2000_execs');;


export BayArea2000_Executives := bayarea2000_executives_out;