import BIPV2_EmpID, tools, std,bipv2;

export _Samples(dataset(BIPV2_EmpID.Layout_EmpID)ih=BIPV2_EmpID.In_EmpID) := module
		
	export BasicSamp := module
		shared s := BIPV2_EmpID.specificities(ih).Specificities[1];
		basicAsMatch := project(ENTH(BIPV2_EmpID.BasicMatch(ih).patch_file,1000), transform(BIPV2_EmpID.match_candidates(ih).layout_matches,self.rule:=99,self.conf:=99,self:=left));
		inputAsCandidates := project(BIPV2_EmpID.specificities(ih).input_file, transform(BIPV2_EmpID.match_candidates(ih).layout_candidates,self:=left,self:=[]));
		shared BasicMatchSampleRecords := BIPV2_EmpID.Debug(ih,s).AnnotateMatchesFromRecordData(inputAsCandidates,basicAsMatch);
		export out := OUTPUT(BasicMatchSampleRecords,NAMED('BasicMatchSampleRecords'),ALL);
	end;

	export ReviewSamples := module
		shared psetReviewers					:= BIPV2._Config.Set_Sample_Reviewers;
		shared pNumSamplesPerReviewer	:= 20;
		shared ConfThreshold					:= '41';
		shared kmtch									:= BIPV2_EmpID.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_EmpID.Keys(ih).Candidates;
		export out										:= Tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_EmpID.In_EmpID,EmpID,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);
	end;

	export out := parallel(ReviewSamples.out, BasicSamp.out);
	
end;