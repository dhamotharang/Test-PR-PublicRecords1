import BIPV2_Company_Names, tools;

export Proc_Build_Keys(

   string   pversion
  ,boolean  pPromote2QA 					= true
	,boolean  puseotherenvironment	= false

) := 
function

	shared knames           := keynames(pversion, puseotherenvironment);
		
	shared fSTrNbr_SF_ds 		:= BIPV2_Company_Names.files.StrNbr_SF_DS;
	
	//strnbr is a file, not key, but it is in the package file
	Build_strnbr 										:= tools.macf_WriteFile('~prte::bip_v2::' + pversion + '::strnbrname'	,fSTrNbr_SF_ds);
		
  Build_license_linkids          := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_License_Linkids.Key 			 																 		,knames.License_linkids.new'							 );
  Build_industry_linkids         := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_Industry_Linkids.Key 		 	 																	,knames.Industry_Linkids.new'							 );
  Build_linkids                  := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BH_Linking_Ids.key           																,knames.linkids.new'                  		 );
	//*** key linkids_hidden is not in the BIPV2FullKeys PACKAGE file.
  //Build_linkids_hidden           := tools.macf_FilesIndex('PRTE2_BIPV2_BusHeader.Key_BH_Linking_Ids.key_hidden  																	 ,knames.linkids_hidden.new'   		        );
  Build_translations             := tools.macf_writeindex('BIPV2_Company_Names.files.TranslationsKey      				 														 		,knames.translations.new'               	 );
  Build_Status                   := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_Status.lkey(pversion).new'												 																											 );
	Build_ZipCitySt                := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Keys(pversion).ZipCitySt.new'										 																													 );

	//* those keys are used for internal use only in the ProxID and LGID3 id compare services.
  Build_proxid_mtch_cand         := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Keys(pversion,puseotherenvironment).Key_ProxID_Candidates     		,knames.proxid_match_candidates_debug.new' );
  Build_proxid_specs             := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Keys(pversion,puseotherenvironment).Key_ProxID_Specificities  		,knames.proxid_specificities_debug.new'    );
  Build_proxid_atts              := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Keys(pversion,puseotherenvironment).Key_ProxID_Attribute_Matches ,knames.proxid_Attribute_Matches.new'      );
  Build_lgid3_mtch_cand          := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Keys(pversion,puseotherenvironment).Key_lgid3_Candidates 		 		,knames.lgid3_match_candidates_debug.new'	 );
  Build_lgid3_specs              := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Keys(pversion,puseotherenvironment).Key_lgid3_Specificities	 		,knames.lgid3_specificities_debug.new'	 	 );
	
	Build_Proxid_rel_assoc         := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Keys(pversion,puseotherenvironment).Key_proxid_relative			 		,knames.assoc.new'												 );
	
	Build_AML_Addr                 := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_AML_addr              			 																	,knames.aml_addr.new'        							 );
  Build_biz_preferred            := tools.macf_writeindex('BIPV2_Company_Names.key_preferred             																					,knames.biz_preferred.new'   							 );
  
	
	resurnBuildKeys := sequential(
												parallel(
														Build_strnbr
													 ,Build_license_linkids
													 ,Build_industry_linkids
													 ,Build_linkids
													 ,Build_translations
													 ,Build_ZipCitySt
													 ,Build_Status
													 ,Build_proxid_mtch_cand
													 ,Build_proxid_specs
													 ,Build_proxid_atts
													 ,Build_lgid3_mtch_cand
													 ,Build_lgid3_specs
													 ,Build_Proxid_rel_assoc
													 ,Build_AML_Addr
													 ,Build_biz_preferred													 
													)
											);
											
	return resurnBuildKeys;

end;