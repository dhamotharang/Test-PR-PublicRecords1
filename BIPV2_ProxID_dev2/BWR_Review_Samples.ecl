iter                    := '25';
psetReviewers           := ['CM','LB','TL','JL','FN','DW','SS'];
pNumSamplesPerReviewer  := 15;
ConfThreshold           := '21';
dotbase                 := BIPV2_ProxID_dev2.In_DOT_Base;
kmtch                   := index(BIPV2_ProxID_dev2.Keys(dotbase).MatchSample ,BIPV2_ProxID_dev2.keynames('20130330_' + iter).match_sample_debug.logical);
kcand                   := index(BIPV2_ProxID_dev2.Keys(dotbase).Candidates  ,BIPV2_ProxID_dev2.keynames('20130330_' + iter).match_candidates_debug.logical);

#workunit('name','BIPV2_ProxID_dev2 Iter ' + iter + ' review samples');

Tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_ProxID_dev2.In_DOT_Base,proxid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers,false);

/*

BFile := BIPV2_ProxID_dev2.In_DOT_Base;
odl := PROJECT(CHOOSEN(BIPV2_ProxID_dev2.Keys(BFile).Candidates(Proxid=Proxidone),100000)  ,BIPV2_ProxID_dev2.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_ProxID_dev2.Keys(BFile).Candidates(Proxid=ProxidTwo),100000)  ,BIPV2_ProxID_dev2.match_candidates(BFile).layout_candidates);
k := BIPV2_ProxID_dev2.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_ProxID_dev2.Layout_Specificities.R)[1]);
odlv := BIPV2_ProxID_dev2.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_ProxID_dev2.Debug(BFile,s).RolledEntities(odr);


*/