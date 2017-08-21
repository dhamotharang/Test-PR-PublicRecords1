#option('outputLimit', 100);

import ut, corp, uccd, bankrupt;

abn_amro_base := dataset('~thor_data400::TMTEST::abn_amro_c2btest_data_append', Equifax.Layout_ABN_AMRO_C2BTest_Base, flat, __compressed__);

// Select BDIDs for Sample Output based on Business Owners
layout_bdid_list := record
abn_amro_base.seq;
abn_amro_base.bdid;
abn_amro_base.confidence_level;
end;

bdid_list := table(abn_amro_base(bdid <> 0, ut.TitleRank(contact_title) = 1), layout_bdid_list);
bdid_list_dist := distribute(bdid_list, hash(seq));
bdid_list_sort := sort(bdid_list_dist, seq, confidence_level, bdid, local);
bdid_list_dedup := dedup(bdid_list_sort, seq, local);

// Output Corporate Sample Data
corp_sample := join(Corp.File_Corp_Base(bdid <> 0),
                    bdid_list_dedup,
				left.bdid = right.bdid,
				transform(Corp.Layout_Corp_Base, self := left),
				lookup);

corp_sample_sort := sort(corp_sample, bdid);

output(corp_sample_sort, all);

// Output Corporate Contacts Sample Data
corp_cont_sample := join(Corp.File_Corp_Cont_Base(bdid <> 0),
                    bdid_list_dedup,
				left.bdid = right.bdid,
				transform(Corp.Layout_Corp_Cont_Base, self := left),
				lookup);

corp_cont_sample_sort := sort(corp_cont_sample, bdid);

output(corp_cont_sample_sort, all);


// Output UCC Sample Data
ucc_sample := join(UCCD.File_WithExpParty((unsigned6)bdid <> 0),
                   bdid_list_dedup,
			    (unsigned6)left.bdid = right.bdid,
			    transform(UCCD.Layout_WithExpParty, self := left),
			    lookup);

ucc_sample_sort := sort(ucc_sample, bdid);

output(ucc_sample_sort, all);

// Output Liens/Judgments Sample Data
flj := Bankrupt.File_Liens;

lj_sample := join(flj((unsigned6)bdid <> 0),
                  bdid_list_dedup,
			   (unsigned6)left.bdid = right.bdid,
			   transform(bankrupt.Layout_Liens, self := left),
			   lookup);

lj_sample_sort := sort(lj_sample, bdid);

output(lj_sample_sort, all);


// Output Bankruptcy Sample Data
bk_sample := join(Bankrupt.File_BK_Search((unsigned6)bdid <> 0),
                  bdid_list_dedup,
			   (unsigned6)left.bdid = right.bdid,
			   transform(Bankrupt.Layout_BK_Search_v8, self := left),
			   lookup);

bk_sample_sort := sort(bk_sample, bdid, court_code, case_number, seq_number);

output(bk_sample_sort, all);

// Output Bankruptcy Filing Detail Information
layout_bk_court_case := record
unsigned6 bdid := (unsigned6)bk_sample.bdid;
bk_sample.court_code;
bk_sample.case_number;
end;

bk_court_case_list := table(bk_sample, layout_bk_court_case);
bk_court_case_list_dedup := dedup(bk_court_case_list, all);

layout_bk_sample_filing := record
unsigned6 bdid;
Bankrupt.Layout_BK_Main_v8;
end;

bk_sample_filings := join(Bankrupt.File_BK_Main,
                          bk_court_case_list_dedup,
					 left.court_code = right.court_code and
					   left.case_number = right.case_number,
					 transform(layout_bk_sample_filing, self.bdid := right.bdid, self := left),
					 lookup);
						  
bk_sample_filings_sort := sort(bk_sample_filings, bdid, court_code, case_number, seq_number);

output(bk_sample_filings_sort, all);
