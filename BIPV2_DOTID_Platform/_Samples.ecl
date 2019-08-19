import BIPV2_DOTID_PLATFORM, SALTTOOLS30;
export _Samples(dataset(BIPV2_DOTID_PLATFORM.Layout_DOT)ih=BIPV2_DOTID_PLATFORM.In_DOT) := module
		
	export BasicSamp := module
		shared s := BIPV2_DOTID_PLATFORM.specificities(ih).Specificities[1];
		basicAsMatch := project(ENTH(BIPV2_DOTID_PLATFORM.BasicMatch(ih).patch_file,1000), transform(BIPV2_DOTID_PLATFORM.match_candidates(ih).layout_matches,self.rule:=99,self.conf:=99,self:=left));
		inputAsCandidates := project(BIPV2_DOTID_PLATFORM.specificities(ih).input_file, transform(BIPV2_DOTID_PLATFORM.match_candidates(ih).layout_candidates,self:=left,self:=[]));
		// shared BasicMatchSampleRecords := BIPV2_DOTID_PLATFORM.Debug(ih,s).AnnotateMatchesFromData(inputAsCandidates,basicAsMatch);
		shared BasicMatchSampleRecords := BIPV2_DOTID_PLATFORM.Debug(ih,s).AnnotateMatchesFromRecordData(inputAsCandidates,basicAsMatch);
		export out := OUTPUT(BasicMatchSampleRecords,NAMED('BasicMatchSampleRecords'),ALL);
	end;
	export ReviewSamples := module
		shared psetReviewers					:= ['CM','LB','DW','AL','HS'];
		shared pNumSamplesPerReviewer	:= 20;
		// shared ConfThreshold					:= '39';
		shared ConfThreshold					:= BIPV2_DOTID_PLATFORM.Config.MatchThreshold;
		shared kmtch									:= BIPV2_DOTID_PLATFORM.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_DOTID_PLATFORM.Keys(ih).Candidates;
		// export out										:= BIPV2_DOTID_PLATFORM.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_DOTID_PLATFORM.In_DOT,dotid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);
		export out										:= SALTTOOLS30.MAC_GetSALTReviewSamples(kmtch,kcand,BIPV2_DOTID_PLATFORM.In_DOT,dotid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);
	end;
	export out := parallel(ReviewSamples.out, BasicSamp.out);
	
end;
