import std;
shared psetReviewers           := ['CM','LB','TL','JL','FN','DW','SS'];
shared pNumSamplesPerReviewer  := 15;
shared ConfThreshold           := '21';
shared dotbase                 := BIPV2_ProxID.In_DOT_Base;
shared kmtch                   := index(BIPV2_ProxID.Keys(dotbase).MatchSample ,BIPV2_ProxID.keynames().match_sample_debug.built    );
shared kcand                   := index(BIPV2_ProxID.Keys(dotbase).Candidates  ,BIPV2_ProxID.keynames().match_candidates_debug.built);
export outputReviewSamples     := Tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_ProxID.In_DOT_Base,proxid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers,false);
outputReviewSamples;
