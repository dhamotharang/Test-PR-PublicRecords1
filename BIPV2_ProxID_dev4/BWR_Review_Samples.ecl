shared psetReviewers           := ['CM','LB','TL','JL','FN','DW','SS'];
shared pNumSamplesPerReviewer  := 15;
shared ConfThreshold           := '21';
shared dotbase                 := BIPV2_ProxID_dev4.In_DOT_Base;
shared kmtch                   := index(BIPV2_ProxID_dev4.Keys(dotbase).MatchSample ,BIPV2_ProxID_dev4.keynames().match_sample_debug.built    );
shared kcand                   := index(BIPV2_ProxID_dev4.Keys(dotbase).Candidates  ,BIPV2_ProxID_dev4.keynames().match_candidates_debug.built);
export outputReviewSamples     := Tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_ProxID_dev4.In_DOT_Base,proxid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers,false);
outputReviewSamples;