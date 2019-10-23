import tools;

EXPORT Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
	//,string		pkeystring						= 'key'
	//,string		pPrefix								= 'prte'
	,string   pCluster              = ''	

) :=
module

	shared lprefix	:= _Dataset(pUseOtherEnvironment).thor_cluster_Files;
	
		
	//weekly keys
	export contact_linkids           := tools.mod_FilenamesBuild(lprefix + 'key::bipv2::business_header::@version@::contact_linkids'            ,pversion    );
	export directories_linkids       := tools.mod_FilenamesBuild(lprefix + 'key::bipv2::business_header::@version@::directories_linkids'        ,pversion    );

  //misc keys
	export linkids                   := tools.mod_FilenamesBuild(lprefix + 'key::bipv2::business_header::@version@::linkids'                    ,pversion    );
	export linkids_hidden            := tools.mod_FilenamesBuild(lprefix + 'key::bipv2::business_header::@version@::linkids_hidden'             ,pversion    );
	
	export translations              := tools.mod_FilenamesBuild(lprefix + 'bip2.0::translations::@version@::date'                    	        ,pversion    );
	export zipcityst                 := tools.mod_FilenamesBuild(lprefix + 'key::bipv2::@version@::zipcityst'                                   ,pversion    );
	export status                    := tools.mod_FilenamesBuild(lprefix + 'key::bipv2::business_header::@version@::status'                     ,pversion    );

	export strnbrname                := tools.mod_FilenamesBuild(lprefix + 'bip_v2::@version@::strnbrname'                          						,pversion    );
	export aml_addr                  := tools.mod_FilenamesBuild(lprefix + 'key::@version@::bipv2_aml_addr'                                     ,pversion    );

	export biz_preferred             := tools.mod_FilenamesBuild(lprefix + 'key::bipv2::@version@::biz_preferred'                               ,pversion    );
	
	//*** BIPv2_HRCHY keynames
	export HrchyProxid      				 := tools.mod_FilenamesBuild(lprefix + 'bipv2_HRCHY::key::@version@::proxid' ,pversion );
	export HrchyLgid 	      				 := tools.mod_FilenamesBuild(lprefix + 'bipv2_HRCHY::key::@version@::LGID'   ,pversion );
	
	//*** bipv2_proxid keynames
	export proxid_attribute_matches        := tools.mod_FilenamesBuild(lprefix + 'key::proxid::BIPV2_ProxID::@version@::attribute_matches'      ,pversion );
	export proxid_match_candidates_debug   := tools.mod_FilenamesBuild(lprefix + 'key::proxid::BIPV2_ProxID::@version@::match_candidates_debug' ,pversion );
	export proxid_specificities_debug      := tools.mod_FilenamesBuild(lprefix + 'key::proxid::BIPV2_ProxID::@version@::specificities_debug'    ,pversion );
	export proxid_match_sample_debug       := tools.mod_FilenamesBuild(lprefix + 'key::proxid::BIPV2_ProxID::@version@::match_sample_debug'     ,pversion );
	export proxid_patched_candidates       := tools.mod_FilenamesBuild(lprefix + 'key::proxid::BIPV2_ProxID::@version@::patched_candidates'     ,pversion );
	export proxid_in_data                  := tools.mod_FilenamesBuild(lprefix + 'key::proxid::BIPV2_ProxID::@version@::in_data'                ,pversion );
	export proxid_match_history            := tools.mod_FilenamesBuild(lprefix + 'key::proxid::BIPV2_ProxID::@version@::match_history'          ,pversion );
	
	export lgid3_matches                 := tools.mod_FilenamesBuild(lprefix + 'key::BIPV2_LGID3::@version@::attribute_matches'      ,pversion );// key::BIPV2_LGID3::LGID3::Debug::attribute_matches'
	
	export lgid3_specificities_debug      := tools.mod_FilenamesBuild(lprefix + 'key::BIPV2_LGID3::@version@::specificities_debug'    ,pversion );// key::BIPV2_LGID3::LGID3::Debug::specificities_debug'
	export lgid3_match_sample_debug       := tools.mod_FilenamesBuild(lprefix + 'key::BIPV2_LGID3::@version@::match_sample_debug'     ,pversion );// key::BIPV2_LGID3::LGID3::Debug::match_sample_debug';
	export lgid3_patched_candidates       := tools.mod_FilenamesBuild(lprefix + 'key::BIPV2_LGID3::@version@::patched_candidates'     ,pversion );// key::BIPV2_LGID3::LGID3::Datafile::patched_candidates';
	export lgid3_match_candidates_debug   := tools.mod_FilenamesBuild(lprefix + 'key::BIPV2_LGID3::@version@::match_candidates_debug' ,pversion );// key::BIPV2_LGID3::LGID3::Debug::match_candidates_debug';
	
	//*** BizLinkFull keynames
	export meow                      := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::meow'                     	   ,pversion    );
	export refs                      := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs'          	             ,pversion    );
	export words                     := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::words'          	             ,pversion    );
	export refs_l_cnpname            := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_cnpname'          	   ,pversion    );
	export refs_l_cnpname_zip        := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_cnpname_zip'       	 ,pversion    );
	export refs_l_cnpname_st         := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_cnpname_st'       	   ,pversion    );
	export refs_l_cnpname_fuzzy      := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_cnpname_fuzzy'        ,pversion    );
	export refs_l_address1           := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_address1'         	   ,pversion    );
	export refs_l_address2           := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_address2'         	   ,pversion    );
	export refs_l_address3           := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_address3'         	   ,pversion    );
	export refs_l_phone              := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_phone'            	   ,pversion    );
	export refs_l_sic                := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_sic'            	     ,pversion    );
	export refs_l_rcid               := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_rcid'            	   ,pversion    );
	export refs_l_fein               := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_fein'             	   ,pversion    );
	export refs_l_contact            := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_contact'          	   ,pversion    );
	export refs_l_url                := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_url'              	   ,pversion    );
	export refs_l_email              := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_email'            	   ,pversion    );
	export refs_l_contact_did        := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_contact_did'      	   ,pversion    );
	export refs_l_contact_ssn        := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_contact_ssn'      	   ,pversion    );
	export refs_l_source             := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::refs::l_source'           	   ,pversion    );  
	export wheel_city_clean          := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::wheel::city_clean'       	   ,pversion    );
	export wheel_quick_city_clean    := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::wheel_quick::city_clean' 	   ,pversion    );
	export word_cnp_name             := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::word::cnp_name'           	   ,pversion    );
	export word_company_url          := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::word::company_url'        	   ,pversion    );
	export sup_proxid                := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::sup::proxid'                  ,pversion    );  
	export sup_seleid                := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::sup::seleid'                  ,pversion    );  
	export sup_orgid                 := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::sup::orgid'                   ,pversion    );  
	export sup_ultid                 := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::sup::ultid'                   ,pversion    );  
	export sup_rcid                  := tools.mod_FilenamesBuild(lprefix + 'key::bizlinkfull::@version@::proxid::sup::rcid'                    ,pversion    );  
	
	//*** BIPV2_Best Keynames
	export Best_LinkIds									 := tools.mod_FilenamesBuild(lprefix + 'key::BIPV2_Best::@version@::linkIds'			,pversion);
	//export ProxID										 := tools.mod_FilenamesBuild(lprefix + 'key::BIPV2_Best::@version@::proxid'			,pversion);
	
	//*** BIPV2_Relative keynames
	export assoc       							 := tools.mod_FilenamesBuild(lprefix + 'key::proxid::bipv2_relative::@version@::assoc'      ,pversion );
	
	//*** BIPV2_Seleid_Relative keynames
	export assoc_seleid  						 := tools.mod_FilenamesBuild(lprefix + 'key::BIPV2_Seleid_Relative::@version@::seleid::rel::assoc'      ,pversion );
	
	//*** TopBusiness_BIPV2 KeyNames
	export Industry_linkids	 				 := tools.mod_FilenamesBuild(lprefix + 'key::BIPV2::@version@::Industry_linkids',pversion);
	export License_linkids	 				 := tools.mod_FilenamesBuild(lprefix + 'key::BIPV2::@version@::License_linkids' ,pversion);
	
	//*** bipv2_proxid_mj6 keynames
	export mj6_attribute_matches        := tools.mod_FilenamesBuild(lprefix + 'key::proxid::BIPV2_ProxID_mj6::@version@::attribute_matches'      ,pversion );
	export mj6_match_candidates_debug   := tools.mod_FilenamesBuild(lprefix + 'key::proxid::BIPV2_ProxID_mj6::@version@::match_candidates_debug' ,pversion );
	export mj6_specificities_debug      := tools.mod_FilenamesBuild(lprefix + 'key::proxid::BIPV2_ProxID_mj6::@version@::specificities_debug'    ,pversion );
	export mj6_match_sample_debug       := tools.mod_FilenamesBuild(lprefix + 'key::proxid::BIPV2_ProxID_mj6::@version@::match_sample_debug'     ,pversion );
	export mj6_patched_candidates       := tools.mod_FilenamesBuild(lprefix + 'key::proxid::BIPV2_ProxID_mj6::@version@::patched_candidates'     ,pversion );
	export mj6_in_data                  := tools.mod_FilenamesBuild(lprefix + 'key::proxid::BIPV2_ProxID_mj6::@version@::in_data'                ,pversion );
	


  export BIPV2FullKeys := 
      linkids                 .dall_filenames
		+ linkids_hidden					.dall_filenames //newly added	
    + translations            .dall_filenames
    + zipcityst               .dall_filenames
    + strnbrname              .dall_filenames
    + status                  .dall_filenames
    + aml_addr                .dall_filenames
    + biz_preferred           .dall_filenames
		//+ BIPv2_HRCHY.keynames            (pversion,pUseOtherEnvironment).dall_filenames
		+ HrchyProxid							.dall_filenames
		+ HrchyLgid								.dall_filenames    
 //   + bipv2_proxid.keynames(pversion).attribute_matches     .dall_filenames
    //+ bipv2_proxid.keynames           (pversion,pUseOtherEnvironment).match_candidates_debug.dall_filenames
    //+ bipv2_proxid.keynames           (pversion,pUseOtherEnvironment).specificities_debug   .dall_filenames
    //+ bipv2_proxid.keynames           (pversion,pUseOtherEnvironment).attribute_matches     .dall_filenames
		+ proxid_match_candidates_debug.dall_filenames
		+ proxid_specificities_debug.dall_filenames
		+ proxid_attribute_matches.dall_filenames
		+ proxid_patched_candidates.dall_filenames
    //+ bipv2_lgid3.keynames            (pversion,pUseOtherEnvironment).match_candidates_debug.dall_filenames
    //+ bipv2_lgid3.keynames            (pversion,pUseOtherEnvironment).specificities_debug   .dall_filenames
    //+ bipv2_lgid3.keynames            (pversion,pUseOtherEnvironment).match_sample_debug    .dall_filenames
		+ lgid3_match_candidates_debug.dall_filenames
		+ lgid3_specificities_debug.dall_filenames
		+ lgid3_match_sample_debug.dall_filenames
		+ lgid3_matches.dall_filenames
		
    //+ BizLinkFull.keynames            (pversion,pUseOtherEnvironment).dall_filenames
		+ meow                      .dall_filenames
    + refs                      .dall_filenames
    + words                     .dall_filenames
    + refs_l_cnpname            .dall_filenames
    + refs_l_cnpname_zip        .dall_filenames
    + refs_l_cnpname_st         .dall_filenames
    + refs_l_cnpname_fuzzy      .dall_filenames
    + refs_l_address1           .dall_filenames
    + refs_l_address2           .dall_filenames
    + refs_l_address3           .dall_filenames
    + refs_l_phone              .dall_filenames
    + refs_l_sic                .dall_filenames
    + refs_l_fein               .dall_filenames
    + refs_l_contact            .dall_filenames
    + refs_l_url                .dall_filenames
    + refs_l_email              .dall_filenames
    + refs_l_contact_did        .dall_filenames
    + refs_l_contact_ssn        .dall_filenames
    + refs_l_source             .dall_filenames
    + wheel_city_clean          .dall_filenames
    + wheel_quick_city_clean    .dall_filenames
    + word_cnp_name             .dall_filenames
    + word_company_url          .dall_filenames
    + sup_proxid                .dall_filenames
    + sup_seleid                .dall_filenames
    + sup_orgid                 .dall_filenames   
    + sup_rcid                  .dall_filenames   
    //+ BIPV2_Best.Keynames             (pversion,pUseOtherEnvironment).dall_filenames
		+ Best_LinkIds							.dall_filenames
    //+ BIPV2_Relative.keynames         (pversion,pUseOtherEnvironment).dall_filenames
		+ assoc											.dall_filenames
    //+ BIPV2_Seleid_Relative.keynames  (pversion,pUseOtherEnvironment).dall_filenames
		+ assoc_seleid							.dall_filenames
    //+ TopBusiness_BIPV2.KeyNames      (pversion,pUseOtherEnvironment).dall_filenames
		+ Industry_linkids					.dall_filenames
		+ License_linkids						.dall_filenames
		
    ;
    
  export BIPV2WeeklyKeys := 
      directories_linkids         .dall_filenames
    + contact_linkids             .dall_filenames
      ;
			
	export dall_filenames := 
      BIPV2FullKeys
    + BIPV2WeeklyKeys
    //+ BIPv2_HRCHY.keynames(pversion).dall_filenames
    //+ bipv2_proxid.keynames            (pversion,pUseOtherEnvironment).patched_candidates    .dall_filenames
    //+ bipv2_proxid_mj6._keynames       (pversion,pUseOtherEnvironment).patched_candidates    .dall_filenames
    //+ bipv2_proxid_mj6._keynames       (pversion,pUseOtherEnvironment).match_candidates_debug.dall_filenames
    //+ bipv2_proxid_mj6._keynames       (pversion,pUseOtherEnvironment).specificities_debug   .dall_filenames
    //+ bipv2_proxid_mj6._keynames       (pversion,pUseOtherEnvironment).attribute_matches     .dall_filenames
		+ mj6_patched_candidates.dall_filenames
		+ mj6_match_candidates_debug.dall_filenames
		+ mj6_specificities_debug.dall_filenames
		+ mj6_attribute_matches.dall_filenames		
    ;
end;