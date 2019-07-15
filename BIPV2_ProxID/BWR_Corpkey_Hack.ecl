#workunit('name','BIPV2 Proxid Corpkey Patch');
dbase14 := BIPV2_ProxID.files(BIPV2.KeySuffix + '_14').base.logical : global;
//reset active domestic corpkey
dsetsos := BIPV2_Files.tools_dotid.SetSOS(dbase14);
//find proxids with unk_corp_key populated
dpopunkcorpkey      := table(dbase14(unk_corp_key != '') ,{rcid,proxid},rcid,proxid);
//find proxids with unk_corp_key that changed to active domestic corpkey
dpopunkcorpkey_new  := table(dsetsos(unk_corp_key != '') ,{rcid,proxid},rcid,proxid);
//proxids that had an unk_corp_key that don't after the patch were changed.
dgetchangedproxids := join(
   dpopunkcorpkey
  ,dpopunkcorpkey_new
  ,left.rcid = right.rcid
  ,transform({dpopunkcorpkey.proxid},self := left)
  ,left only
);
dgetchangedproxids_dedup := table(dgetchangedproxids  ,{proxid},proxid);
//reset proxid for records with unk corpkey
djoin := join(
   dsetsos
  ,dgetchangedproxids_dedup
  ,left.proxid = right.proxid
  ,transform(
     recordof(left)
    ,self.proxid := if(right.proxid != 0  ,left.dotid ,left.proxid)
    ,self        := left
  )
  ,left outer
);
//get samples of unk corpkey
dsamples_unk_corpkey_before  := sort(dbase14 (proxid  in set(choosen(dpopunkcorpkey,100) ,proxid)),rcid);
dsamples_unk_corpkey_after   := sort(djoin   (dotid   in set(dbase14(proxid in set(choosen(dpopunkcorpkey,100) ,proxid)),dotid) ),rcid);
dbase14_uniques := project(strata.macf_uniques(dbase14 ,,,false,['proxid','unk_corp_key','active_domestic_corp_key']) ,transform({string file,recordof(left)},self.file := '14th Iteration'               ,self := left));
dsetsos_uniques := project(strata.macf_uniques(dsetsos ,,,false,['proxid','unk_corp_key','active_domestic_corp_key']) ,transform({string file,recordof(left)},self.file := 'Reset Active Domestic Corpkey',self := left));
djoin_uniques   := project(strata.macf_uniques(djoin   ,,,false,['proxid','unk_corp_key','active_domestic_corp_key']) ,transform({string file,recordof(left)},self.file := 'Reset Proxid'                 ,self := left));
//output results
countdbase14                  := count(dbase14                  );
countdpopunkcorpkey           := count(dpopunkcorpkey           );
countdpopunkcorpkey_new       := count(dpopunkcorpkey_new       );
countdgetchangedproxids       := count(dgetchangedproxids       );
countdgetchangedproxids_dedup := count(dgetchangedproxids_dedup );
countdsetsos                  := count(dsetsos                  );
countdjoin                    := count(djoin                    );
output(djoin  ,,'~BIPV2_ProxID::base::20130212_14a::data',__COMPRESSED__,OVERWRITE);
output(dbase14_uniques + dsetsos_uniques + djoin_uniques  ,named('UniqueStats'                ));
output(countdpopunkcorpkey                                ,named('CountProxidsWithUnkCorpKey' ));
output(countdpopunkcorpkey_new                            ,named('CountProxidsWithUnkCorpKey_New'      ));
output(countdgetchangedproxids                            ,named('CountProxidsWhereUnkCorpKeyChangedAfterPatch'      ));
output(countdgetchangedproxids_dedup                      ,named('CountProxidsWhereUnkCorpKeyChangedAfterPatchDedup'      ));
output(dpopunkcorpkey                                     ,named('ProxidsWithUnkCorpKey'      ));
output(dpopunkcorpkey_new                                 ,named('ProxidsWithUnkCorpKey_New'      ));
output(dgetchangedproxids                                 ,named('ProxidsWhereUnkCorpKeyChangedAfterPatch'      ));
output(dgetchangedproxids_dedup                           ,named('ProxidsWhereUnkCorpKeyChangedAfterPatchDedup'      ));
output(dsamples_unk_corpkey_before                        ,named('ProxidsWithUnkCorpKeyBefore'));
output(dsamples_unk_corpkey_after                         ,named('ProxidsWithUnkCorpKeyAfter'));
