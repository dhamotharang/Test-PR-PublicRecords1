EXPORT Keys(DATASET(layout_DOT_Base) ih = dataset([],layout_DOT_Base),string liter = 'qa' ,boolean pUseOtherEnvironment = false) := MODULE
SHARED s := Specificities(ih).Specificities;
SHARED mtch := debug(ih ,s[1]).AnnotateMatches(matches(ih).PossibleMatches,matches(ih).All_Attribute_Matches);
prop_file := project(match_candidates(ih).candidates,BIPV2_ProxID._Old_layouts.mc); // Use propogated file
EXPORT Candidates         := INDEX(prop_file,{Proxid},{prop_file},keynames(liter,pUseOtherEnvironment).match_candidates_debug.logical);
ms_temp := project(sort(mtch,Conf,Proxid1,Proxid2,SKEW(1.0))  ,BIPV2_ProxID._Old_layouts.ms); // Some headers have very skewed IDs
EXPORT MatchSample        := INDEX(ms_temp,{Conf,Proxid1,Proxid2},{ms_temp},keynames(liter,pUseOtherEnvironment).match_sample_debug.logical,SORT KEYED);

s_prep := project(s  ,transform(BIPV2_ProxID._Old_layouts.specs,//self._unnamed_1 := left._unnamed_1;
self.active_duns_number_max         := left.active_duns_number_maximum      ;
self.active_enterprise_number_max   := left.active_enterprise_number_maximum;
self.active_domestic_corp_key_max   := left.active_domestic_corp_key_maximum;
self.hist_enterprise_number_max     := left.hist_enterprise_number_maximum  ;
self.hist_duns_number_max           := left.hist_duns_number_maximum        ;
self.hist_domestic_corp_key_max     := left.hist_domestic_corp_key_maximum  ;
self.foreign_corp_key_max           := left.foreign_corp_key_maximum        ;
self.unk_corp_key_max               := left.unk_corp_key_maximum            ;
self.ebr_file_number_max            := left.ebr_file_number_maximum         ;
self.company_fein_max               := left.company_fein_maximum            ;
self.cnp_name_max                   := left.cnp_name_maximum                ;
self.cnp_number_max                 := left.cnp_number_maximum              ;
self.cnp_btype_max                  := left.cnp_btype_maximum               ;
self.company_phone_max              := left.company_phone_maximum           ;
self.prim_name_derived_max          := left.prim_name_derived_maximum       ;
self.sec_range_max                  := left.sec_range_maximum               ;
self.v_city_name_max                := left.v_city_name_maximum             ;
self.st_max                         := left.st_maximum                      ;
self.zip_max                        := left.zip_maximum                     ;
self.prim_range_derived_max         := left.prim_range_derived_maximum      ;
self.company_csz_max                := left.company_csz_maximum             ;
self.company_addr1_max              := left.company_addr1_maximum           ;
self.company_address_max            := left.company_address_maximum         ;
self.srcridvlid_max                 := left.srcridvlid_maximum              ;
self.foreigncorpkey_max             := left.foreigncorpkey_maximum          ;
self.raaddresses_max                := left.raaddresses_maximum             ;
self.filterprimnames_max            := left.filterprimnames_maximum         ;
self := left;));

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
END;
