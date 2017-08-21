import BIPV2_DotID_dev, SALTTOOLS30;
export _Samples(dataset(BIPV2_DotID_dev.Layout_DOT)ih=BIPV2_DotID_dev.In_DOT) := module
		
	export BasicSamp := module
		shared s := BIPV2_DotID_dev.specificities(ih).Specificities[1];
		basicAsMatch := project(ENTH(BIPV2_DotID_dev.BasicMatch(ih).patch_file,1000), transform(BIPV2_DotID_dev.match_candidates(ih).layout_matches,self.rule:=99,self.conf:=99,self:=left));
		inputAsCandidates := project(BIPV2_DotID_dev.specificities(ih).input_file, transform(BIPV2_DotID_dev.match_candidates(ih).layout_candidates,self:=left,self:=[]));
		// shared BasicMatchSampleRecords := BIPV2_DotID_dev.Debug(ih,s).AnnotateMatchesFromData(inputAsCandidates,basicAsMatch);
		shared BasicMatchSampleRecords := BIPV2_DotID_dev.Debug(ih,s).AnnotateMatchesFromRecordData(inputAsCandidates,basicAsMatch);
		export out := OUTPUT(BasicMatchSampleRecords,NAMED('BasicMatchSampleRecords'),ALL);
	end;
	export ReviewSamples := module
		shared psetReviewers					:= ['CM','LB','DW','AL','HS'];
		shared pNumSamplesPerReviewer	:= 20;
		// shared ConfThreshold					:= '39';
		shared ConfThreshold					:= BIPV2_DotID_dev.Config.MatchThreshold;
		shared kmtch									:= BIPV2_DotID_dev.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_DotID_dev.Keys(ih).Candidates;
		// export out										:= BIPV2_DotID_dev.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_DotID_dev.In_DOT,dotid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);
		export out										:= SALTTOOLS30.MAC_GetSALTReviewSamples(kmtch,kcand,BIPV2_DotID_dev.In_DOT,dotid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);
	end;
	export out := parallel(ReviewSamples.out, BasicSamp.out);
	
end;
