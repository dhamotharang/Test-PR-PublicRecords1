// import BIPV2_LGID3;

export _Samples(dataset(BIPV2_POWID_Down.Layout_POWID_Down)ih=BIPV2_POWID_Down.In_POWID_Down) := module
		
	export BasicSamp := module
		shared s := BIPV2_POWID_Down.specificities(ih).Specificities[1];
		basicAsMatch := project(BIPV2_POWID_Down.BasicMatch(ih).patch_file, transform(BIPV2_POWID_Down.match_candidates(ih).layout_matches,self.rule:=99,self.conf:=99,self:=left));
		inputAsCandidates := project(BIPV2_POWID_Down.specificities(ih).input_file, transform(BIPV2_POWID_Down.match_candidates(ih).layout_candidates,self:=left,self:=[]));
		shared BasicMatchSampleRecords := BIPV2_POWID_Down.Debug(ih,s).AnnotateMatchesFromData(inputAsCandidates,basicAsMatch);
		export out := OUTPUT(CHOOSEN(BasicMatchSampleRecords,1000),NAMED('BasicMatchSampleRecords'));
	end;

	export ReviewSamples := module
		shared psetReviewers					:= ['TL','CM','LB','DW','SS','TR','FN','DB','JL'];
		shared pNumSamplesPerReviewer	:= 20;
		shared ConfThreshold					:= '38';
		shared kmtch									:= BIPV2_POWID_Down.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_POWID_Down.Keys(ih).Candidates;
		export out										:= BIPV2_POWID_Down._mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_POWID_Down.In_POWID_Down,powid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);
	end;

	export out := parallel(BasicSamp.out, ReviewSamples.out);
	
end;