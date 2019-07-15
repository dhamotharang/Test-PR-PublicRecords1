ih      := BIPV2_ProxID.In_DOT_Base;
laymtch := BIPV2_ProxID.match_candidates(ih).layout_matches;

All_Matches   := dataset('~temp::BIPV2_ProxID_Proxid_DOT_Base_all_m',laymtch,flat); // all matches before processing
remove_trans  := dataset('~temp::BIPV2_ProxID_Proxid_DOT_Base_mt'   ,laymtch,flat); // remove transitives
BestPerRecord := dataset('~temp::BIPV2_ProxID_Proxid_DOT_Base_mr'   ,laymtch,flat); // best per record

lproxid := 7842;

All_Matches_filt   := All_Matches   (proxid1 = lproxid or proxid2 = lproxid);
remove_trans_filt  := remove_trans  (proxid1 = lproxid or proxid2 = lproxid);
BestPerRecord_filt := BestPerRecord (proxid1 = lproxid or proxid2 = lproxid);

countAll_Matches   := count(All_Matches  );
countremove_trans  := count(remove_trans );
countBestPerRecord := count(BestPerRecord);

countAll_Matches_filt   := count(All_Matches_filt  );
countremove_trans_filt  := count(remove_trans_filt );
countBestPerRecord_filt := count(BestPerRecord_filt);

output(countAll_Matches   ,named('countAll_Matches'  ));
output(countremove_trans  ,named('countremove_trans' ));
output(countBestPerRecord ,named('countBestPerRecord'));

output(countAll_Matches_filt   ,named('countAll_Matches_filt'   ));
output(countremove_trans_filt  ,named('countremove_trans_filt'  ));
output(countBestPerRecord_filt ,named('countBestPerRecord_filt' ));

output(topn(All_Matches_filt   ,500,proxid1,proxid2,rcid1,rcid2),named('All_Matches_filt'   ),all);
output(topn(remove_trans_filt  ,500,proxid1,proxid2,rcid1,rcid2),named('remove_trans_filt'  ),all);
output(topn(BestPerRecord_filt ,500,proxid1,proxid2,rcid1,rcid2),named('BestPerRecord_filt' ),all);
