﻿import BIPV2_POWID_Platform, tools, std;

export _Samples(dataset(BIPV2_POWID_Platform.Layout_POWID)ih=BIPV2_POWID_Platform.In_POWID) := module
		
	export BasicSamp := module
		shared s := BIPV2_POWID_Platform.specificities(ih).Specificities[1];
		basicAsMatch := project(ENTH(BIPV2_POWID_Platform.BasicMatch(ih).patch_file,1000), transform(BIPV2_POWID_Platform.match_candidates(ih).layout_matches,self.rule:=99,self.conf:=99,self:=left));
		inputAsCandidates := project(BIPV2_POWID_Platform.specificities(ih).input_file, transform(BIPV2_POWID_Platform.match_candidates(ih).layout_candidates,self:=left,self:=[]));
		shared BasicMatchSampleRecords := BIPV2_POWID_Platform.Debug(ih,s).AnnotateMatchesFromRecordData(inputAsCandidates,basicAsMatch);
		export out := OUTPUT(BasicMatchSampleRecords,NAMED('BasicMatchSampleRecords'),ALL);
	end;

	export ReviewSamples := module
		shared psetReviewers					:= ['TL','CM','LB','DW','SS','TR','FN','DB','JL'];
		shared pNumSamplesPerReviewer	:= 20;
		shared ConfThreshold					:= '38';
		shared kmtch									:= BIPV2_POWID_Platform.Keys(ih).MatchSample;
		shared kcand									:= BIPV2_POWID_Platform.Keys(ih).Candidates;
		export out										:= BIPV2_POWID_Platform.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_POWID_Platform.In_POWID,powid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);
	end;

	export out := parallel(ReviewSamples.out, BasicSamp.out);
	
end;