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

// Output UCC Sample Data
ucc_sample := join(UCCD.File_WithExpParty((unsigned6)bdid <> 0),
                   bdid_list_dedup,
			    (unsigned6)left.bdid = right.bdid,
			    transform(UCCD.Layout_WithExpParty, self := left),
			    lookup);

ucc_sample_sort := sort(ucc_sample, bdid);

output(ucc_sample_sort, all);

