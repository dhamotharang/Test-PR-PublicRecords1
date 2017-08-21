mod := module
	shared psetReviewers					:= ['CM','DW','TL','DB'];
	shared pNumSamplesPerReviewer	:= 20;
	shared ConfThreshold					:= '42';
	shared kmtch									:= BIPV2_LGID3_dev.Keys(BIPV2_LGID3_dev.In_LGID3).MatchSample;
	shared kcand									:= BIPV2_LGID3_dev.Keys(BIPV2_LGID3_dev.In_LGID3).Candidates;
	export outputReviewSamples		:= BIPV2_LGID3_dev.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_LGID3_dev.In_LGID3,lgid3,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);
end;

mod.outputReviewSamples;
