import ut, Equifax, Business_Header, Corp, UCC, FBN, Busreg, Bankrupt;

#option('outputLimit', 30);

// Randomly select some CID-PIDs and their associated BDIDs
bus := Equifax.business_append;

layout_cid_pid_counts := record
bus.cid;
bus.pid;
bus.corp_record_cnt;
bus.ucc_record_cnt;
bus.fbn_record_cnt;
bus.busreg_record_cnt;
bus.bk_record_cnt;
bus.lj_record_cnt;
end;

bus_counts := table(bus, layout_cid_pid_counts);

bus_corp := enth(bus_counts(corp_record_cnt > 0), 10);
bus_ucc := enth(bus_counts(ucc_record_cnt > 0), 10);
bus_fbn := enth(bus_counts(fbn_record_cnt > 0), 10);
bus_busreg := enth(bus_counts(busreg_record_cnt > 0), 10);
bus_bk := enth(bus_counts(bk_record_cnt > 0), 10);
bus_lj := enth(bus_counts(lj_record_cnt > 0), 10);

bus_combined := bus_corp + bus_ucc + bus_fbn + bus_busreg + bus_bk + bus_lj;
bus_combined_dedup := dedup(bus_combined, cid, pid, all);

count(bus_combined_dedup);

// Use CID, PID list to get all the BDIDs for this company
layout_bdid_list := record
unsigned6 bdid;
string18 cid;
string20 pid;
end;

layout_bdid_list SelectBDIDs(bus l, layout_cid_pid_counts r) := transform
self := l;
end;

bdid_list := join(bus,
                  bus_combined_dedup,
				  left.cid = right.cid and
				    left.pid = right.pid,
				  SelectBDIDs(left, right),
				  lookup);
				  
bdid_list_dedup := dedup(bdid_list(bdid <> 0), all);

count(bdid_list_dedup);

// Output Business Append Sample Data
Equifax.Layout_Business_Append SelectBusinessAppendSample(bus l, layout_bdid_list r) := transform
self := l;
end;

business_append_sample := join(bus,
                               bdid_list_dedup,
							   left.bdid = right.bdid and
							     left.cid = right.cid and
								 left.pid = right.pid,
							   SelectBusinessAppendSample(left, right),
							   lookup);
							   
business_append_sort := sort(business_append_sample, cid, pid, bdid);

output(business_append_sort, all);

// Output Corporate Sample Data
layout_corp_sample := record
string18 cid;
string20 pid;
Corp.Layout_Corp_Base;
end;

layout_corp_sample SelectCorpSample(Corp.Layout_Corp_Base l, layout_bdid_list r) := transform
self.cid := r.cid;
self.pid := r.pid;
self := l;
end;

corp_sample := join(Corp.File_Corp_Base,
                    bdid_list_dedup,
					left.bdid = right.bdid,
					SelectCorpSample(left, right),
					lookup);

corp_sample_sort := sort(corp_sample, cid, pid, bdid);

output(corp_sample_sort, all);

// Output UCC Sample Data
layout_ucc_sample := record
string18 cid;
string20 pid;
UCC.Layout_UCC_Initial_Party_Master;
end;

layout_ucc_sample SelectUCCSample(UCC.Layout_UCC_Initial_Party_Master l, layout_bdid_list r) := transform
self.cid := r.cid;
self.pid := r.pid;
self := l;
end;

ucc_sample := join(UCC.File_UCC_Debtor_Master + UCC.File_UCC_Secured_Master,
                    bdid_list_dedup,
					left.bdid = right.bdid,
					SelectUCCSample(left, right),
					lookup);

ucc_sample_sort := sort(ucc_sample, cid, pid, bdid);

output(ucc_sample_sort, all);

// Output FBN Sample Data
layout_fbn_sample := record
string18 cid;
string20 pid;
FBN.Layout_FBN;
end;

layout_fbn_sample SelectFBNSample(FBN.Layout_FBN l, layout_bdid_list r) := transform
self.cid := r.cid;
self.pid := r.pid;
self := l;
end;

fbn_sample := join(FBN.File_FBN,
                    bdid_list_dedup,
					left.bdid = right.bdid,
					SelectFBNSample(left, right),
					lookup);

fbn_sample_sort := sort(fbn_sample, cid, pid, bdid);

output(fbn_sample_sort, all);

// Output Business Registration Sample Data
layout_busreg_sample := record
string18 cid;
string20 pid;
BusReg.Layout_BusReg_Company;
end;

layout_busreg_sample SelectBusRegSample(BusReg.Layout_BusReg_Company l, layout_bdid_list r) := transform
self.cid := r.cid;
self.pid := r.pid;
self := l;
end;

busreg_sample := join(BusReg.File_BusReg_Company,
                      bdid_list_dedup,
					  left.bdid = right.bdid,
					  SelectBusRegSample(left, right),
					  lookup);

busreg_sample_sort := sort(busreg_sample, cid, pid, bdid);

output(busreg_sample_sort, all);

// Output Liens/Judgments Sample Data
layout_lj_sample := record
string18 cid;
string20 pid;
bankrupt.Layout_Liens;
end;

layout_lj_sample SelectLJSample(bankrupt.Layout_Liens l, layout_bdid_list r) := transform
self.cid := r.cid;
self.pid := r.pid;
self := l;
end;

flj := dataset('~thor_data400::in::liens_20041221',bankrupt.Layout_Liens,flat);

lj_sample := join(flj,
                  bdid_list_dedup,
			      (unsigned6)left.bdid = right.bdid,
				  SelectLJSample(left, right),
				  lookup);

lj_sample_sort := sort(lj_sample, cid, pid, bdid);

output(lj_sample_sort, all);

// Output Bankruptcy Sample Data
layout_bk_sample := record
string18 cid;
string20 pid;
Bankrupt.Layout_BK_Search;
end;

layout_bk_sample SelectBKSample(Bankrupt.Layout_BK_Search l, layout_bdid_list r) := transform
self.cid := r.cid;
self.pid := r.pid;
self := l;
end;

bk_sample := join(Bankrupt.File_BK_Search,
                  bdid_list_dedup,
			      (unsigned6)left.bdid = right.bdid,
				  SelectBKSample(left, right),
				  lookup);

bk_sample_sort := sort(bk_sample, cid, pid, bdid);

output(bk_sample_sort, all);

// Output Bankruptcy Filing Detail Information
layout_bk_court_case := record
bk_sample.court_code;
bk_sample.case_number;
end;

bk_court_case_list := table(bk_sample, layout_bk_court_case);
bk_court_case_list_dedup := dedup(bk_court_case_list, all);

Bankrupt.Layout_BK_Main SelectBKFilings(Bankrupt.Layout_BK_Main l, layout_bk_court_case r) := transform
self := l;
end;

bk_sample_filings := join(Bankrupt.File_BK_Main,
                          bk_court_case_list_dedup,
						  left.court_code = right.court_code and
						    left.case_number = right.case_number,
						  SelectBKFIlings(left, right),
						  lookup);
						  
bk_sample_filings_sort := sort(bk_sample_filings, court_code, case_number, seq_number);

output(bk_sample_filings_sort, all);

