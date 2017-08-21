import tools;

EXPORT Keys2(DATASET(layout_LGID3) ih = dataset([],layout_LGID3),string pversion = 'qa'	,boolean	pUseOtherEnvironment	= false
) :=
module

  EXPORT Specificity       := tools.macf_FilesIndex('Keys(BIPV2_LGID3_dev.In_LGID3).Specificities_Key', keynames(pversion,pUseOtherEnvironment).specificities_debug   );
  EXPORT MatchSamples      := tools.macf_FilesIndex('Keys(BIPV2_LGID3_dev.In_LGID3).MatchSample      ', keynames(pversion,pUseOtherEnvironment).match_sample_debug    );
  EXPORT PatchedCandidate  := tools.macf_FilesIndex('Keys(BIPV2_LGID3_dev.In_LGID3).PatchedCandidates', keynames(pversion,pUseOtherEnvironment).patched_candidates    );
  EXPORT MatchCandidates   := tools.macf_FilesIndex('Keys(BIPV2_LGID3_dev.In_LGID3).Candidates       ', keynames(pversion,pUseOtherEnvironment).match_candidates_debug);

  EXPORT Specificities_Key  := Specificity.logical     ;
  EXPORT MatchSample        := MatchSamples.logical    ;
  EXPORT PatchedCandidates  := PatchedCandidate.logical;
  EXPORT Candidates         := MatchCandidates.logical ;
  
end;
