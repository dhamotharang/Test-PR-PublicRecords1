EXPORT Keys(DATASET(layout_DOT_Base) ih = dataset([],layout_DOT_Base),string liter = 'qa' ,boolean pUseOtherEnvironment = false) := MODULE
SHARED s := Specificities(ih).Specificities;
SHARED mtch := debug(ih ,s[1]).AnnotateMatches(matches(ih).PossibleMatches,matches(ih).All_Attribute_Matches);
prop_file := match_candidates(ih).candidates; // Use propogated file
EXPORT Candidates         := INDEX(prop_file,{Proxid},{prop_file},keynames(liter,pUseOtherEnvironment).match_candidates_debug.logical);
ms_temp := sort(mtch,Conf,Proxid1,Proxid2,SKEW(1.0)); // Some headers have very skewed IDs
EXPORT MatchSample        := INDEX(ms_temp,{Conf,Proxid1,Proxid2},{ms_temp},keynames(liter,pUseOtherEnvironment).match_sample_debug.logical,SORT KEYED);
s_prep := s;
EXPORT Specificities_Key  := INDEX(s_prep,{1},{s_prep},keynames(liter,pUseOtherEnvironment).specificities_debug.logical);
am := matches(ih).All_Attribute_Matches;
EXPORT Attribute_Matches  := INDEX(am,{Proxid1,Proxid2},{am},keynames(liter,pUseOtherEnvironment).attribute_matches.logical);
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2
EXPORT PatchedCandidates  := INDEX(prop_file,{Proxid},{prop_file},keynames(liter,pUseOtherEnvironment).patched_candidates.logical);
EXPORT InData             := INDEX(ih,{Proxid},{ih},keynames(liter,pUseOtherEnvironment).in_data.logical);

// Create logic to manage the match history key
//EXPORT MatchHistoryName := '~keep::BIPV2_ProxID::Proxid::MatchHistory';
//EXPORT MatchHistoryFile := DATASET(MatchHistoryName,Matches(In_DOT_Base).id_shift_r,THOR); // Read in all the change history
//EXPORT MatchHistoryKeyName := '~'+'key::BIPV2_ProxID::Proxid::History::Match';
//  MH := MatchHistoryFile;
//EXPORT MatchHistoryKey := INDEX(MH,{Proxid_after},{MH},MatchHistoryKeyName);
// Build enough to support the data services such as cleave/best
// EXPORT InDataKeyName := '~'+'key::BIPV2_ProxID::Proxid::Datafile::in_data';
// EXPORT InData := INDEX(ih,{Proxid},{ih},InDataKeyName);
// SHARED Build_InData := BUILDINDEX(InData, OVERWRITE);
// EXPORT BuildData := PARALLEL(Build_Specificities_Key,Build_InData);
// Build enough to support the debug services such as the compare service
EXPORT BuildDebug := PARALLEL(BUILDINDEX(Candidates,keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,keynames(liter).specificities_debug.logical,FEW,OVERWRITE),BUILDINDEX(Attribute_Matches,keynames(liter).attribute_matches.logical,OVERWRITE));
// Build Everything
EXPORT BuildAll := PARALLEL(BUILDINDEX(Candidates,keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(MatchSample,keynames(liter).match_sample_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,keynames(liter).specificities_debug.logical,FEW,OVERWRITE)/*,BUILDINDEX(PatchedCandidates,keynames(liter).patched_candidates.logical,OVERWRITE)*/,BUILDINDEX(Attribute_Matches,keynames(liter).attribute_matches.logical,OVERWRITE)/*,BUILDINDEX(InData,keynames(liter).in_data.logical,OVERWRITE)*/);
END;/*HACKKeys*/
