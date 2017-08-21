import BIPV2_LGID3_dev2,tools;

export _Samples(dataset(BIPV2_LGID3_dev2.Layout_LGID3)ih=BIPV2_LGID3_dev2.In_LGID3) := module
		
	export BasicSamp := module
		shared s := BIPV2_LGID3_dev2.specificities(ih).Specificities[1];
		basicAsMatch := project(ENTH(BIPV2_LGID3_dev2.BasicMatch(ih).patch_file,1000), transform(BIPV2_LGID3_dev2.match_candidates(ih).layout_matches,self.rule:=99,self.conf:=99,self:=left));
		inputAsCandidates := project(BIPV2_LGID3_dev2.specificities(ih).input_file, transform(BIPV2_LGID3_dev2.match_candidates(ih).layout_candidates,self:=left,self:=[]));
		shared BasicMatchSampleRecords := BIPV2_LGID3_dev2.Debug(ih,s).AnnotateMatchesFromData(inputAsCandidates,basicAsMatch);
		export out := OUTPUT(BasicMatchSampleRecords,NAMED('BasicMatchSampleRecords'),ALL);
	end;

	export ReviewSamples := module
		shared psetReviewers					:= ['CM','LB','DW','HS','AL'];
		shared pNumSamplesPerReviewer	:= 20;
		shared ConfThreshold					:= '42';
		shared kmtch									:= BIPV2_LGID3_dev2.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_LGID3_dev2.Keys(ih).Candidates;
    shared ExtraMatchFilter       := '';
		export out										:= tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_LGID3_dev2.In_LGID3,lgid3,ConfThreshold,pNumSamplesPerReviewer,psetReviewers,,,,ExtraMatchFilter);
	end;

	export ReviewSamples_sbfe := module
		shared psetReviewers					:= ['CM','LB','DW','HS','AL'];
		shared pNumSamplesPerReviewer	:= 20;
		shared ConfThreshold					:= '42';
		shared kmtch									:= BIPV2_LGID3_dev2.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_LGID3_dev2.Keys(ih).Candidates;
    shared ExtraMatchFilter       := 'sbfe_id_score > 0';
		export out										:= tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_LGID3_dev2.In_LGID3,lgid3,ConfThreshold,pNumSamplesPerReviewer,psetReviewers,,,,ExtraMatchFilter,pUniqueOutput := 'SBFE_');
	end;

	export out := parallel(ReviewSamples_sbfe.out ,ReviewSamples.out,BasicSamp.out);
	
end;