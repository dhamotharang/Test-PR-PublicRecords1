import BIPV2_DOTID, tools,bipv2;
export _Samples(dataset(BIPV2_DOTID.Layout_DOT)ih=BIPV2_DOTID.In_DOT) := module
		
	export BasicSamp := module
		shared s := BIPV2_DOTID.specificities(ih).Specificities[1];
		basicAsMatch := project(ENTH(BIPV2_DOTID.BasicMatch(ih).patch_file,1000), transform(BIPV2_DOTID.match_candidates(ih).layout_matches,self.rule:=99,self.conf:=99,self:=left));
		inputAsCandidates := project(BIPV2_DOTID.specificities(ih).input_file, transform(BIPV2_DOTID.match_candidates(ih).layout_candidates,self:=left,self:=[]));
		// shared BasicMatchSampleRecords := BIPV2_DOTID.Debug(ih,s).AnnotateMatchesFromData(inputAsCandidates,basicAsMatch);
		shared BasicMatchSampleRecords := BIPV2_DOTID.Debug(ih,s).AnnotateMatchesFromRecordData(inputAsCandidates,basicAsMatch);
		export out := OUTPUT(BasicMatchSampleRecords,NAMED('BasicMatchSampleRecords'),ALL);
	end;
	export ReviewSamples := module
		shared psetReviewers					:= BIPV2._Config.Set_Sample_Reviewers;
		shared pNumSamplesPerReviewer	:= 20;
		// shared ConfThreshold					:= '39';
		shared ConfThreshold					:= BIPV2_DOTID.Config.MatchThreshold;
		shared kmtch									:= BIPV2_DOTID.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_DOTID.Keys(ih).Candidates;
		// export out										:= BIPV2_DOTID.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_DOTID.In_DOT,dotid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);
		export out										:= Tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_DOTID.In_DOT,dotid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);
	end;
	export out := parallel(ReviewSamples.out, BasicSamp.out);
	
end;
