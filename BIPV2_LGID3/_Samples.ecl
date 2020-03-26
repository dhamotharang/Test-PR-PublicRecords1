import BIPV2_LGID3,tools,BIPV2_Files,BIPV2;
export _Samples(dataset(BIPV2_LGID3.Layout_LGID3)ih=BIPV2_LGID3.In_LGID3) := module
		
	export BasicSamp := module
		shared s := BIPV2_LGID3.specificities(ih).Specificities[1];
		basicAsMatch := project(ENTH(BIPV2_LGID3.BasicMatch(ih).patch_file,1000), transform(BIPV2_LGID3.match_candidates(ih).layout_matches,self.rule:=99,self.conf:=99,self:=left));
		inputAsCandidates := project(BIPV2_LGID3.specificities(ih).input_file, transform(BIPV2_LGID3.match_candidates(ih).layout_candidates,self:=left,self:=[]));
		setLgid3s := set(inputAsCandidates, LGID3);
		BIPV2_LGID3.match_candidates(dataset([],BIPV2_Files.files_lgid3.Layout_LGID3)).layout_attribute_matches ainto(Keys(dataset([],BIPV2_Files.files_lgid3.Layout_LGID3)).Attribute_Matches le) := TRANSFORM
			SELF := le;
		END;
		am := PROJECT(Keys(dataset([],BIPV2_Files.files_lgid3.Layout_LGID3)).Attribute_Matches(LGID31 in setLgid3s and LGID32 in setLgid3s),ainto(LEFT));
		shared BasicMatchSampleRecords := BIPV2_LGID3.Debug(ih,s).AnnotateMatchesFromData(inputAsCandidates,basicAsMatch,am);
		export out := OUTPUT(BasicMatchSampleRecords,NAMED('BasicMatchSampleRecords'),ALL);
	end;
	export ReviewSamples := module
		shared psetReviewers					:= BIPV2._Config.Set_Sample_Reviewers;
		shared pNumSamplesPerReviewer	:= 30;//20;
		shared ConfThreshold					:= '40'; //'42';
		shared kmtch									:= BIPV2_LGID3.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_LGID3.Keys(ih).Candidates;
    shared ExtraMatchFilter       := '';
		export out										:= tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_LGID3.In_LGID3,lgid3,ConfThreshold,pNumSamplesPerReviewer,psetReviewers,,,,ExtraMatchFilter);
	end;
	export ReviewSamples_sbfe := module
		shared psetReviewers					:= BIPV2._Config.Set_Sample_Reviewers;
		shared pNumSamplesPerReviewer	:= 30;//20;
		shared ConfThreshold					:=  '40'; //'42';
		shared kmtch									:= BIPV2_LGID3.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_LGID3.Keys(ih).Candidates;
    shared ExtraMatchFilter       := 'sbfe_id_score > 0';
		export out										:= tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_LGID3.In_LGID3,lgid3,ConfThreshold,pNumSamplesPerReviewer,psetReviewers,,,,ExtraMatchFilter,pUniqueOutput := 'SBFE_');
	end;
	export out := parallel(/*ReviewSamples_sbfe.out ,*/ReviewSamples.out,BasicSamp.out);
	
end;
