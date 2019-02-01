import BIPV2_EmpID_Down,BIPV2,tools;

export _Samples(dataset(BIPV2_EmpID_Down.Layout_EmpID)ih=BIPV2_EmpID_Down.In_EmpID) := module
		
	export BasicSamp := module
		shared s := BIPV2_EmpID_Down.specificities(ih).Specificities[1];
		basicAsMatch := project(ENTH(BIPV2_EmpID_Down.BasicMatch(ih).patch_file,1000), transform(BIPV2_EmpID_Down.match_candidates(ih).layout_matches,self.rule:=99,self.conf:=99,self:=left));
		inputAsCandidates := project(BIPV2_EmpID_Down.specificities(ih).input_file, transform(BIPV2_EmpID_Down.match_candidates(ih).layout_candidates,self:=left,self:=[]));
		shared BasicMatchSampleRecords := BIPV2_EmpID_Down.Debug(ih,s).AnnotateMatchesFromData(inputAsCandidates,basicAsMatch);
		export out := OUTPUT(BasicMatchSampleRecords,NAMED('BasicMatchSampleRecords'),ALL);
	end;

	export ReviewSamples := module
		shared psetReviewers					:= BIPV2._Config.Set_Sample_Reviewers;
		shared pNumSamplesPerReviewer	:= 20;
		shared ConfThreshold					:= '60';
		shared kmtch									:= BIPV2_EmpID_Down.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_EmpID_Down.Keys(ih).Candidates;
		export out										:= Tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_EmpID_Down.In_EmpID,EmpID,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);
	end;

	export out := parallel(ReviewSamples.out, BasicSamp.out);
	
end;