import ut, Equifax, Business_Header, Corp, UCC, Busreg, Bankrupt;

#option('outputLimit', 30);

test_output := Equifax.abn_amro_test_bdid_append;

// List of bdids from test
layout_bdid_list := record
test_output.seq;
test_output.bdid;
test_output.PROSPECT_HOUSEHOLD_KEY;
end;

bdid_list := table(test_output(bdid<>0), layout_bdid_list);
bdid_list_dedup := dedup(bdid_list, all);

count(bdid_list_dedup);

// Output Corporate Sample Data
layout_corp_sample := record
unsigned4 seq;
string PROSPECT_HOUSEHOLD_KEY;
Corp.Layout_Corp_Base;
end;

layout_corp_sample SelectCorpSample(Corp.Layout_Corp_Base l, layout_bdid_list r) := transform
self.seq := r.seq;
self.PROSPECT_HOUSEHOLD_KEY := r.PROSPECT_HOUSEHOLD_KEY;
self := l;
end;

corp_sample := join(Corp.File_Corp_Base,
                    bdid_list_dedup,
					left.bdid = right.bdid,
					SelectCorpSample(left, right),
					lookup);

corp_sample_sort := sort(corp_sample, bdid);

output(corp_sample_sort, all);

// Output UCC Sample Data
layout_ucc_sample := record
unsigned4 seq;
string PROSPECT_HOUSEHOLD_KEY;
UCC.Layout_UCC_Initial_Party_Master;
end;

layout_ucc_sample SelectUCCSample(UCC.Layout_UCC_Initial_Party_Master l, layout_bdid_list r) := transform
self.seq := r.seq;
self.PROSPECT_HOUSEHOLD_KEY := r.PROSPECT_HOUSEHOLD_KEY;
self := l;
end;

ucc_sample := join(UCC.File_UCC_Debtor_Master + UCC.File_UCC_Secured_Master,
                    bdid_list_dedup,
					left.bdid = right.bdid,
					SelectUCCSample(left, right),
					lookup);

ucc_sample_sort := sort(ucc_sample, bdid);

output(ucc_sample_sort, all);


// Output Business Registration Sample Data
layout_busreg_sample := record
unsigned4 seq;
string PROSPECT_HOUSEHOLD_KEY;
BusReg.Layout_BusReg_Company;
end;

layout_busreg_sample SelectBusRegSample(BusReg.Layout_BusReg_Company l, layout_bdid_list r) := transform
self.seq := r.seq;
self.PROSPECT_HOUSEHOLD_KEY := r.PROSPECT_HOUSEHOLD_KEY;
self := l;
end;

busreg_sample := join(BusReg.File_BusReg_Company,
                      bdid_list_dedup,
					  left.bdid = right.bdid,
					  SelectBusRegSample(left, right),
					  lookup);

busreg_sample_sort := sort(busreg_sample, bdid);

output(busreg_sample_sort, all);

// Output Liens/Judgments Sample Data
layout_lj_sample := record
unsigned4 seq;
string PROSPECT_HOUSEHOLD_KEY;
bankrupt.Layout_Liens;
end;

layout_lj_sample SelectLJSample(bankrupt.Layout_Liens l, layout_bdid_list r) := transform
self.seq := r.seq;
self.PROSPECT_HOUSEHOLD_KEY := r.PROSPECT_HOUSEHOLD_KEY;
self := l;
end;

flj := Bankrupt.File_Liens;

lj_sample := join(flj,
                  bdid_list_dedup,
			      (unsigned6)left.bdid = right.bdid,
				  SelectLJSample(left, right),
				  lookup);

lj_sample_sort := sort(lj_sample, bdid);

output(lj_sample_sort, all);

// Output Bankruptcy Sample Data
layout_bk_sample := record
unsigned4 seq;
string PROSPECT_HOUSEHOLD_KEY;
Bankrupt.Layout_BK_Search;
end;

layout_bk_sample SelectBKSample(Bankrupt.Layout_BK_Search_v8 l, layout_bdid_list r) := transform
self.seq := r.seq;
self.PROSPECT_HOUSEHOLD_KEY := r.PROSPECT_HOUSEHOLD_KEY;
self := l;
end;

bk_sample := join(Bankrupt.File_BK_Search,
                  bdid_list_dedup,
			      (unsigned6)left.bdid = right.bdid,
				  SelectBKSample(left, right),
				  lookup);

bk_sample_sort := sort(bk_sample, bdid);

output(bk_sample_sort, all);

// Output Bankruptcy Filing Detail Information
layout_bk_court_case := record
bk_sample.seq;
bk_sample.PROSPECT_HOUSEHOLD_KEY;
bk_sample.court_code;
bk_sample.case_number;
end;

bk_court_case_list := table(bk_sample, layout_bk_court_case);
bk_court_case_list_dedup := dedup(bk_court_case_list, all);

layout_bk_main_sample := record
unsigned4 seq;
string PROSPECT_HOUSEHOLD_KEY;
Bankrupt.Layout_BK_Main_v8;
end;

layout_bk_main_sample SelectBKFilings(Bankrupt.Layout_BK_Main_v8 l, layout_bk_court_case r) := transform
self.seq := r.seq;
self.PROSPECT_HOUSEHOLD_KEY := r.PROSPECT_HOUSEHOLD_KEY;
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

