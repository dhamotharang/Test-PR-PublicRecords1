import BIPV2_Files,BIPV2_HRCHY,BIPV2_LGID3,BIPV2_PROXID,BIPV2_Relative,riskwise,data_services,tools;

EXPORT Keys(
   string   pversion
  ,boolean	pUseOtherEnvironment	= false

) :=
module

 	shared knames := keynames(pversion,pUseOtherEnvironment);
	
	shared f := riskwise.File_CityStateZip;
	
	//export KeyZipCitySt := INDEX(f,{city,state},{f},knames.zipcityst);
	
  export ZipCitySt := tools.macf_FilesIndex('f,{city,state},{f}',knames.zipcityst);
	
	//*** LGID3 SALT Keys ******
	shared lgid3_ih					:= dataset([],BIPV2_LGID3.layout_LGID3);
	//SHARED lgid3_s					:= BIPV2_LGID3.Specificities(lgid3_ih).Specificities;	
	shared lgid3_s					:= dataset([],BIPV2_LGID3.Layout_Specificities.R);	
	shared lgid3_prop_file	:= dataset([], recordof(BIPV2_LGID3.match_candidates(lgid3_ih).candidates)); // Use propogated file
 
	EXPORT lgid3_SpecificitiesDebugKeyName := '~'+'prte::key::BIPV2_LGID3::LGID3::Debug::specificities_debug';
	EXPORT lgid3_CandidatesKeyName 				 := '~'+'prte::key::BIPV2_LGID3::LGID3::Debug::match_candidates_debug';
 
	EXPORT Key_lgid3_Specificities := INDEX(lgid3_s,{1},{lgid3_s},lgid3_SpecificitiesDebugKeyName);;
	EXPORT Key_lgid3_Candidates		 := INDEX(lgid3_prop_file,{LGID3},{lgid3_prop_file},lgid3_CandidatesKeyName);
	
	//export lgid3_Specificity       := tools.macf_FilesIndex('Key_lgid3_Specificities', knames.lgid3_specificities_debug   );
	//export lgid3_MatchCandidates   := tools.macf_FilesIndex('Key_lgid3_Candidates   ', knames.lgid3_match_candidates_debug);
	
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

		
	//export Proxid_Specificity       := tools.macf_FilesIndex('lgid3_Specificities_Key', knames.lgid3_specificities_debug   );
	//export Proxid_MatchCandidates   := tools.macf_FilesIndex('lgid3_Candidates       ', knames.lgid3_match_candidates_debug);

end;
