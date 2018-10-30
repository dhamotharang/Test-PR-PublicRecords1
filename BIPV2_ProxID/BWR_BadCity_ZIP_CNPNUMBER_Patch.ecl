#workunit('name','BIPV2 Proxid Bad City, Bad Zip + cnp number Patch');
dbase1 := BIPV2_ProxID.files('20130212a_1').base.logical : global;
msd               := BIPV2_ProxID.Keys(BIPV2_ProxID.In_DOT_Base).MatchSample;
gte21             := msd(conf >= 21);
gte21_badcityNZip := gte21((zip_score < 0 and v_city_name_score < 0) or ((left_cnp_number <> '' and right_cnp_number = '') or (left_cnp_number = '' and right_cnp_number <> '')));
//explode these rcids
badrcids          := table(table(gte21_badcityNZip ,{unsigned6 rcid := rcid1},rcid1) + table(gte21_badcityNZip ,{unsigned6 rcid := rcid2},rcid2),{rcid},rcid);
//join to iteration 1 base to find proxids to blow up
djoin1 := join(
   dbase1
  ,badrcids
  ,left.rcid = right.rcid
  ,transform({dbase1.proxid},self := left)
  ,lookup
);
ddedupproxids := table(djoin1 ,{proxid},proxid);
//reset proxid for records with unk corpkey
//djoin := project(dbase1 ,transform());
djoin := join(
   dbase1        
  ,ddedupproxids 
  ,left.proxid = right.proxid
  ,transform(
     recordof(left)
    ,self.proxid := if(right.proxid != 0  ,left.dotid ,left.proxid)
    ,self        := left
  )
  ,left outer
  ,lookup
);
//get samples of unk corpkey
dsamples_before  := sort(dbase1 (proxid  in set(choosen(ddedupproxids,100) ,proxid)),rcid);
dsamples_after   := sort(djoin   (dotid   in set(dbase1(proxid in set(choosen(ddedupproxids,100) ,proxid)),dotid) ),rcid);
dbase1_uniques := project(strata.macf_uniques(dbase1 ,,,false,['proxid']) ,transform({string file,recordof(left)},self.file := '1st Iteration' ,self := left));
djoin_uniques  := project(strata.macf_uniques(djoin  ,,,false,['proxid']) ,transform({string file,recordof(left)},self.file := 'Reset Proxid'  ,self := left));
//output results
countdbase1            := count(dbase1                  );
countmsd               := count(msd                   );
countgte21             := count(gte21                 );
countgte21_badcityNZip := count(gte21_badcityNZip     );
countbadrcids          := count(badrcids               );
countdjoin1            := count(djoin1                  );
countddedupproxids     := count(ddedupproxids                    );
countdjoin             := count(djoin                    );
output(djoin                            ,,'~BIPV2_ProxID::base::20130212b_1::data',__COMPRESSED__,OVERWRITE);
output(dbase1_uniques + djoin_uniques  ,named('UniqueStats'                ));
output(countdbase1                                           ,named('countProxidBase' ));
output(countmsd                                              ,named('countMatchSampleRecords' ));
output(countgte21                                            ,named('countgte21' ));
output(countgte21_badcityNZip                                ,named('countgte21_WithbadcityNZip' ));
output(countbadrcids                                         ,named('countbadrcids' ));
output(countdjoin1                                           ,named('countProxids2BlowUp' ));
output(countddedupproxids                                    ,named('countDedupProxids2BlowUp' ));
output(countdjoin                                            ,named('countPatchedFile' ));
output(dbase1                                           ,named('ProxidBase' ));
output(msd                                              ,named('MatchSampleRecords' ));
output(gte21                                            ,named('gte21' ));
output(gte21_badcityNZip                                ,named('gte21_WithbadcityNZip' ));
output(badrcids                                         ,named('badrcids' ));
output(djoin1                                           ,named('Proxids2BlowUp' ));
output(ddedupproxids                                    ,named('DedupProxids2BlowUp' ));
output(djoin                                            ,named('PatchedFile' ));
output(dsamples_before                        ,named('ProxidsSamplesBefore'),all);
output(dsamples_after                         ,named('ProxidsSamplesAfter'),all);
