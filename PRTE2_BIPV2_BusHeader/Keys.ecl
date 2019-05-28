import BIPV2_Files,BIPV2_HRCHY,BIPV2_LGID3,BIPV2_PROXID,BIPV2_Relative,riskwise,data_services,tools;

EXPORT Keys(
   string   pversion
  ,boolean	pUseOtherEnvironment	= false

) :=
module

 	shared knames := keynames(pversion,pUseOtherEnvironment);
	
	shared f := riskwise.File_CityStateZip;
	
	export ZipCitySt := tools.macf_FilesIndex('f,{city,state},{f}',knames.zipcityst);
	
	//*** LGID3 SALT Keys ******
	
	shared lgid3_m					:= dataset([],layouts.layout_matches);
	 
	shared lgid3_ih					:= dataset([],BIPV2_LGID3.layout_LGID3);
	
	shared lgid3_prop_file	:= dataset([], recordof(BIPV2_LGID3.match_candidates(lgid3_ih).candidates)); // Use propogated file
 
  EXPORT lgid3_MatchesKeyName            := '~'+'prte::key::BIPV2_LGID3::LGID3::Debug::attribute_matches';	


	EXPORT lgid3_CandidatesKeyName 				 := '~'+'prte::key::BIPV2_LGID3::LGID3::Debug::match_candidates_debug';

  EXPORT Key_lgid3_Matches := INDEX(lgid3_m,{lgid31,lgid32},{lgid3_m},lgid3_MatchesKeyName);

  EXPORT Key_lgid3_Candidates		 := INDEX(lgid3_prop_file,{LGID3},{lgid3_prop_file},lgid3_CandidatesKeyName);
	
		
	//*** PROXID SALT Keys ******
	shared proxID_ih				:= dataset([], BIPV2_ProxID.layout_DOT_Base);
	shared proxID_prop_file := dataset([], BIPV2_ProxID._Old_layouts.mc);
	SHARED proxID_s					:= dataset([], BIPV2_ProxID._Old_layouts.specs);
	SHARED proxID_am				:= dataset([], recordof(BIPV2_ProxID.matches(proxID_ih).All_Attribute_Matches));	
	
	EXPORT Key_ProxID_Candidates         := INDEX(proxID_prop_file,{Proxid},{proxID_prop_file},knames.proxid_match_candidates_debug.logical);
	EXPORT Key_ProxID_Specificities 		 := INDEX(proxID_s,{1},{proxID_s},knames.proxid_specificities_debug.logical);
	EXPORT Key_ProxID_Attribute_Matches  := INDEX(proxID_am,{Proxid1,Proxid2},{proxID_am},knames.proxid_attribute_matches.logical);
	
	shared proxId_rel_ih			 := dataset([], BIPV2_Relative.layout_DOT_Base);
	shared Proxid_Relative     := dataset([], recordof(BIPV2_Relative.Relationships(proxId_rel_ih).ASSOC_Links));
	EXPORT Key_Proxid_Relative := INDEX(Proxid_Relative,{Proxid1,Proxid2},{Proxid_Relative},knames.assoc.logical);

			
end;
