import BIPV2_LGID3_PlatForm,tools;
export _Samples(dataset(BIPV2_LGID3_PlatForm.Layout_LGID3)ih=BIPV2_LGID3_PlatForm.In_LGID3) := module
		
	export BasicSamp := module
		shared s := BIPV2_LGID3_PlatForm.specificities(ih).Specificities[1];
		basicAsMatch := project(ENTH(BIPV2_LGID3_PlatForm.BasicMatch(ih).patch_file,1000), transform(BIPV2_LGID3_PlatForm.match_candidates(ih).layout_matches,self.rule:=99,self.conf:=99,self:=left));
		inputAsCandidates := project(BIPV2_LGID3_PlatForm.specificities(ih).input_file, transform(BIPV2_LGID3_PlatForm.match_candidates(ih).layout_candidates,self:=left,self:=[]));
		shared BasicMatchSampleRecords := BIPV2_LGID3_PlatForm.Debug(ih,s).AnnotateMatchesFromData(inputAsCandidates,basicAsMatch);
		export out := OUTPUT(BasicMatchSampleRecords,NAMED('BasicMatchSampleRecords'),ALL);
	end;
	export ReviewSamples := module
		shared psetReviewers					:= ['CM','LB','DW','HS','AL'];
		shared pNumSamplesPerReviewer	:= 30;//20;
		shared ConfThreshold					:= '38'; //'42';
		shared kmtch									:= BIPV2_LGID3_PlatForm.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_LGID3_PlatForm.Keys(ih).Candidates;
    shared ExtraMatchFilter       := '';
		export out										:= tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_LGID3_PlatForm.In_LGID3,lgid3,ConfThreshold,pNumSamplesPerReviewer,psetReviewers,,,,ExtraMatchFilter);
	end;
	export ReviewSamples_sbfe := module
		shared psetReviewers					:= ['CM','LB','DW','HS','AL'];
		shared pNumSamplesPerReviewer	:= 30;//20;
		shared ConfThreshold					:=  '38'; //'42';
		shared kmtch									:= BIPV2_LGID3_PlatForm.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_LGID3_PlatForm.Keys(ih).Candidates;
    shared ExtraMatchFilter       := 'sbfe_id_score > 0';
		export out										:= tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_LGID3_PlatForm.In_LGID3,lgid3,ConfThreshold,pNumSamplesPerReviewer,psetReviewers,,,,ExtraMatchFilter,pUniqueOutput := 'SBFE_');
	end;
	export out := parallel(ReviewSamples_sbfe.out ,ReviewSamples.out,BasicSamp.out);
	
end;
