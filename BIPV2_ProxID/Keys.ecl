EXPORT Keys(DATASET(layout_DOT_Base) ih = dataset([],layout_DOT_Base),string liter = 'qa' ,boolean pUseOtherEnvironment = false) := MODULE
SHARED s := Specificities(ih).Specificities;
SHARED mtch := debug(ih ,s[1]).AnnotateMatches(matches(ih).PossibleMatches,matches(ih).All_Attribute_Matches);
prop_file := project(match_candidates(ih).candidates,transform(BIPV2_ProxID._Old_layouts.mc
  ,self                                     := left
  ,self.active_domestic_corp_key            := left.active_corp_key
  ,self.active_domestic_corp_key_prop       := 0
  ,self.active_domestic_corp_key_weight100  := 0
  ,self.active_domestic_corp_key_isnull     := if(trim(left.active_corp_key) = '' ,true,false)
  ,self.hist_domestic_corp_key              := left.hist_corp_key
  ,self.hist_domestic_corp_key_prop         := left.hist_corp_key_prop
  ,self.hist_domestic_corp_key_weight100    := 0
  ,self.hist_domestic_corp_key_isnull       := if(trim(left.hist_corp_key) = '' ,true,false)
  ,self.foreign_corp_key                    := if(left.company_foreign_domestic = 'F' ,trim(left.company_inc_state) + '-' + trim(left.company_charter_number) ,'')
  ,self.foreign_corp_key_prop               := 0
  ,self.foreign_corp_key_weight100          := 0
  ,self.foreign_corp_key_isnull             := if(trim(self.foreign_corp_key) = '' ,true,false)
  ,self.unk_corp_key                        := if(left.company_foreign_domestic = ''  ,trim(left.company_inc_state) + '-' + trim(left.company_charter_number) ,'')
  ,self.unk_corp_key_prop                   := 0
  ,self.unk_corp_key_weight100              := 0
  ,self.unk_corp_key_isnull                 := if(trim(self.unk_corp_key) = '' ,true,false)
)); // Use propogated file
EXPORT Candidates         := INDEX(prop_file,{Proxid},{prop_file},keynames(liter,pUseOtherEnvironment).match_candidates_debug.logical);
ms_temp := project(sort(mtch,Conf,Proxid1,Proxid2,SKEW(1.0))  ,transform(BIPV2_ProxID._Old_layouts.ms
  ,self.left_active_domestic_corp_key        := left.left_active_corp_key
  ,self.right_active_domestic_corp_key       := left.right_active_corp_key
  ,self.active_domestic_corp_key_match_code  := 0
  ,self.active_domestic_corp_key_score       := 0     
  ,self.active_domestic_corp_key_score_prop  := 0
  ,self.active_domestic_corp_key_skipped     := false

  ,self.left_hist_domestic_corp_key        := left.left_hist_corp_key
  ,self.right_hist_domestic_corp_key       := left.right_hist_corp_key
  ,self.hist_domestic_corp_key_match_code  := left.hist_corp_key_match_code
  ,self.hist_domestic_corp_key_score       := left.hist_corp_key_score     
  ,self.hist_domestic_corp_key_score_prop  := left.hist_corp_key_score_prop
  
  ,self.left_foreign_corp_key        := if(left.left_company_foreign_domestic  = 'F' ,trim(left.left_company_inc_state ) + '-' + trim(left.left_company_charter_number ) ,'')
  ,self.right_foreign_corp_key       := if(left.right_company_foreign_domestic = 'F' ,trim(left.right_company_inc_state) + '-' + trim(left.right_company_charter_number) ,'')
  ,self.foreign_corp_key_match_code  := 0
  ,self.foreign_corp_key_score       := 0     
  ,self.foreign_corp_key_score_prop  := 0

  ,self.left_unk_corp_key        := if(left.left_company_foreign_domestic  = '' ,trim(left.left_company_inc_state ) + '-' + trim(left.left_company_charter_number ) ,'')
  ,self.right_unk_corp_key       := if(left.right_company_foreign_domestic = '' ,trim(left.right_company_inc_state) + '-' + trim(left.right_company_charter_number) ,'')
  ,self.unk_corp_key_match_code  := 0
  ,self.unk_corp_key_score       := 0     
  ,self.unk_corp_key_score_prop  := 0

  // ,self.right_hist_domestic_corp_key_match_code  := left.right_hist_corp_key_match_code
  // ,self.right_hist_domestic_corp_key_score       := left.right_hist_corp_key_score     
  // ,self.right_hist_domestic_corp_key_score_prop  := left.right_hist_corp_key_score_prop
  
  ,self := left
  


)); // Some headers have very skewed IDs
EXPORT MatchSample        := INDEX(ms_temp,{Conf,Proxid1,Proxid2},{ms_temp},keynames(liter,pUseOtherEnvironment).match_sample_debug.logical,SORT KEYED);
s_prep := project(s  ,transform(BIPV2_ProxID._Old_layouts.specs
  ,self := left
  ,self.hist_domestic_corp_key_specificity  := left.hist_corp_key_specificity
  ,self.hist_domestic_corp_key_switch       := left.hist_corp_key_switch
  ,self.hist_domestic_corp_key_maximum      := left.hist_corp_key_maximum
  ,self.nulls_hist_domestic_corp_key        := project(left.nulls_hist_corp_key ,transform(_Old_layouts.hist_domestic_corp_key_childrec,self.hist_domestic_corp_key := left.hist_corp_key,self := left))

  ,self := []
));

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