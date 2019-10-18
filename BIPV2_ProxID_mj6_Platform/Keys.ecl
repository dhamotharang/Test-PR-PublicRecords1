EXPORT Keys(DATASET(layout_DOT_Base) ih = dataset([],layout_DOT_Base),string liter = 'qa' ,boolean pUseOtherEnvironment = false) := MODULE
SHARED s := Specificities(ih).Specificities;
SHARED mtch := debug(ih ,s[1]).AnnotateMatches(matches(ih).PossibleMatches,matches(ih).All_Attribute_Matches);
prop_file := match_candidates(ih).candidates; // Use propogated file
EXPORT Candidates         := INDEX(prop_file,{Proxid},{prop_file},_keynames(liter,pUseOtherEnvironment).match_candidates_debug.logical);
ms_temp := sort(mtch,Conf,Proxid1,Proxid2,SKEW(1.0)); // Some headers have very skewed IDs
EXPORT MatchSample        := INDEX(ms_temp,{Conf,Proxid1,Proxid2},{mtch},_keynames(liter,pUseOtherEnvironment).match_sample_debug.logical,SORT KEYED);
EXPORT Specificities_Key  := INDEX(s,{1},{s},_keynames(liter,pUseOtherEnvironment).specificities_debug.logical);
am := matches(ih).All_Attribute_Matches;
EXPORT Attribute_Matches  := INDEX(am,{Proxid1,Proxid2},{am},_keynames(liter,pUseOtherEnvironment).attribute_matches.logical);
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2
EXPORT PatchedCandidates  := INDEX(prop_file,{Proxid},{prop_file},_keynames(liter,pUseOtherEnvironment).patched_candidates.logical);
EXPORT InData             := INDEX(ih,{Proxid},{ih},_keynames(liter,pUseOtherEnvironment).in_data.logical);

// Create logic to manage the match history key
EXPORT MatchHistoryName := '~keep::BIPV2_ProxID_mj6_PlatForm::Proxid::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,Matches(In_DOT_Base).id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::BIPV2_ProxID_mj6_PlatForm::Proxid::History::Match';
  MH := MatchHistoryFile;
 
EXPORT MatchHistoryKey := INDEX(MH,{Proxid_after},{MH},MatchHistoryKeyName);                                                
// Build enough to support the debug services such as the compare service
EXPORT BuildDebug := PARALLEL(BUILDINDEX(Candidates,_keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,_keynames(liter).specificities_debug.logical,FEW,OVERWRITE),BUILDINDEX(Attribute_Matches,_keynames(liter).attribute_matches.logical,OVERWRITE));
// Build Everything
EXPORT BuildAll := PARALLEL(BUILDINDEX(Candidates,_keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(MatchSample,_keynames(liter).match_sample_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,_keynames(liter).specificities_debug.logical,FEW,OVERWRITE),BUILDINDEX(PatchedCandidates,_keynames(liter).patched_candidates.logical,OVERWRITE),BUILDINDEX(Attribute_Matches,_keynames(liter).attribute_matches.logical,OVERWRITE)/*,BUILDINDEX(InData,_keynames(liter).in_data.logical,OVERWRITE)*/);
END;
