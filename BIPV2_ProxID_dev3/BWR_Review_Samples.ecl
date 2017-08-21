iter                    := '25';
psetReviewers           := ['CM','LB','TL','JL','FN','DW','SS'];
pNumSamplesPerReviewer  := 15;
ConfThreshold           := '21';
dotbase                 := BIPV2_ProxID_dev3.In_DOT_Base;
kmtch                   := index(BIPV2_ProxID_dev3.Keys(dotbase).MatchSample ,BIPV2_ProxID_dev3.keynames('20130330_' + iter).match_sample_debug.logical);
kcand                   := index(BIPV2_ProxID_dev3.Keys(dotbase).Candidates  ,BIPV2_ProxID_dev3.keynames('20130330_' + iter).match_candidates_debug.logical);

#workunit('name','BIPV2_ProxID_dev3 Iter ' + iter + ' review samples');

Tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_ProxID_dev3.In_DOT_Base,proxid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers,false);

/*

BFile := BIPV2_ProxID_dev3.In_DOT_Base;
odl := PROJECT(CHOOSEN(BIPV2_ProxID_dev3.Keys(BFile).Candidates(Proxid=Proxidone),100000)  ,BIPV2_ProxID_dev3.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_ProxID_dev3.Keys(BFile).Candidates(Proxid=ProxidTwo),100000)  ,BIPV2_ProxID_dev3.match_candidates(BFile).layout_candidates);
k := BIPV2_ProxID_dev3.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_ProxID_dev3.Layout_Specificities.R)[1]);
odlv := BIPV2_ProxID_dev3.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_ProxID_dev3.Debug(BFile,s).RolledEntities(odr);


*/