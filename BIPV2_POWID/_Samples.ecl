import BIPV2_POWID, tools, std,BIPV2;

export _Samples(dataset(BIPV2_POWID.Layout_POWID)ih=BIPV2_POWID.In_POWID) := module
		
	export BasicSamp := module
		shared s := BIPV2_POWID.specificities(ih).Specificities[1];
		basicAsMatch := project(ENTH(BIPV2_POWID.BasicMatch(ih).patch_file,1000), transform(BIPV2_POWID.match_candidates(ih).layout_matches,self.rule:=99,self.conf:=99,self:=left));
		inputAsCandidates := project(BIPV2_POWID.specificities(ih).input_file, transform(BIPV2_POWID.match_candidates(ih).layout_candidates,self:=left,self:=[]));
		shared BasicMatchSampleRecords := BIPV2_POWID.Debug(ih,s).AnnotateMatchesFromRecordData(inputAsCandidates,basicAsMatch);
		export out := OUTPUT(BasicMatchSampleRecords,NAMED('BasicMatchSampleRecords'),ALL);
	end;

	export ReviewSamples := module
		shared psetReviewers					:= BIPV2._Config.Set_Sample_Reviewers;
		shared pNumSamplesPerReviewer	:= 20;
		shared ConfThreshold					:= '38';
		shared kmtch									:= BIPV2_POWID.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_POWID.Keys(ih).Candidates;
		export out										:= Tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_POWID.In_POWID,powid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);
	end;

	export out := parallel(ReviewSamples.out, BasicSamp.out);
	
end;