mod := module
	shared psetReviewers					:= ['CM','LB','TL','JL','FN','DW','SS'];
	shared pNumSamplesPerReviewer	:= 15;
	shared ConfThreshold					:= '41';
	shared kmtch									:= BIPV2_DOTID_PLATFORM.Keys(BIPV2_DOTID_PLATFORM.In_DOT).MatchSample;
	shared kcand									:= BIPV2_DOTID_PLATFORM.Keys(BIPV2_DOTID_PLATFORM.In_DOT).Candidates;
	export outputReviewSamples		:= BIPV2_DOTID_PLATFORM.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_DOTID_PLATFORM.In_DOT,DotID,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);
end;

mod.outputReviewSamples;
