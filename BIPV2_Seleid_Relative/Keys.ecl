import doxie;/*HACK TO ADD doxie import*/
EXPORT Keys(DATASET(layout_Base) ih,string pversion = BIPV2_Seleid_Relative.KeyInfix/*HACK TO ADD PVERSION*/) := INLINE MODULE/*HACK INLINE FOR ROXIE*/
SHARED s := Specificities(ih).Specificities;
 
EXPORT SpecificitiesDebugKeyName := BIPV2_Seleid_Relative.keynames(doxie.Version_SuperKey).specs.logical;/*HACK TO NAME SPECS KEY TO ROXIE SUPERKEY*/
 
EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key,BIPV2_Seleid_Relative.keynames(pversion).specs.logical, OVERWRITE, FEW);/*HACK TO BUILD SPECS KEY IN CORRECT NAME FOR ROXIE*/
SHARED mtch := debug(ih,s[1]).AnnotateMatches(matches(ih).PossibleMatches);
 
EXPORT SampleKeyName := '~'+'key::BIPV2_Seleid_Relative::Seleid::Debug::match_sample_debug';
ms_temp := SORT(mtch,Conf,Seleid1,Seleid2,SKEW(1.0)); // Some headers have very skewed IDs
 
EXPORT MatchSample := INDEX(ms_temp,{Conf,Seleid1,Seleid2},{mtch},SampleKeyName, SORT KEYED);
 
EXPORT PatchedCandidatesKeyName := '~'+'key::BIPV2_Seleid_Relative::Seleid::Datafile::patched_candidates';
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2
 
EXPORT PatchedCandidates := INDEX(prop_file,{Seleid},{prop_file},PatchedCandidatesKeyName);
 
EXPORT CandidatesKeyName := BIPV2_Seleid_Relative.keynames(doxie.Version_SuperKey).mc.logical;/*HACK TO NAME MC KEY TO ROXIE SUPERKEY*/
prop_file := match_candidates(ih).candidates; // Use propogated file
 
EXPORT Candidates := INDEX(prop_file,{Seleid},{prop_file},CandidatesKeyName);
 
// Create logic to manage the match history key
EXPORT MatchHistoryName := '~keep::BIPV2_Seleid_Relative::Seleid::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,Matches(ih).id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::BIPV2_Seleid_Relative::Seleid::History::Match';
  MH := MatchHistoryFile;
 
EXPORT MatchHistoryKey := INDEX(MH,{Seleid_after},{MH},MatchHistoryKeyName);
// Build enough to support the debug services such as the compare service
EXPORT BuildDebug := PARALLEL(Build_Specificities_Key, PARALLEL(BUILDINDEX(Candidates,BIPV2_Seleid_Relative.keynames(pversion).mc.logical, OVERWRITE)/*HACK TO BUILD MC KEY IN CORRECT NAME FOR ROXIE*//*,BUILDINDEX(MatchHistoryKey, OVERWRITE)*//*REMOVE MATCH HISTORY HACK*/));
// Build Everything
EXPORT BuildAll := PARALLEL(BuildDebug, PARALLEL(BUILDINDEX(MatchSample, OVERWRITE),BUILDINDEX(PatchedCandidates, OVERWRITE)));
 
EXPORT RelKeyNameASSOC := BIPV2_Seleid_Relative.keynames(doxie.Version_SuperKey).assoc.logical;/*HACK TO NAME ASSOC KEY TO ROXIE SUPERKEY*/;
 
EXPORT RelKeyNameASSOC_sf := '~'+KeyPrefix+'::'+'key::BIPV2_Seleid_Relative'+'::'+KeySuperfile+'::Seleid::Rel::ASSOC';
  Dta := Relationships(ih).ASSOC_Links;
  TYPEOF(RECORDOF(Dta)) Inv(Dta le) := TRANSFORM
	SELF.Seleid1 := le.Seleid2;
	SELF.Seleid2 := le.Seleid1;
    SELF := le;
  END;
  Both := Dta + PROJECT(Dta,Inv(LEFT));
 
EXPORT ASSOC := INDEX(Both,{Seleid1,Seleid2},{Both},RelKeyNameASSOC);
EXPORT RelationshipKeys := BUILDINDEX(ASSOC,BIPV2_Seleid_Relative.keynames(pversion).assoc.logical, OVERWRITE)/*HACK TO BUILD ASSOC KEY IN CORRECT NAME FOR ROXIE*/;
END;
 
