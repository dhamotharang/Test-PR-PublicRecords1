import tools,bipv2_proxid,bipv2_proxid_mj6,BizLinkFull,BIPV2_Best,BIPV2_Relative,TopBusiness_BIPV2,BIPV2_Seleid_Relative,bipv2_lgid3,BIPv2_HRCHY;
 
EXPORT keynames(

   string   pversion              = ''
  ,boolean	pUseOtherEnvironment	= false
  ,string   pCluster              = ''	
  
) :=
module

	shared lprefix	:= _Constants(pUseOtherEnvironment).prefix			;

  shared lcluster := lprefix + if(pCluster = ''  ,'thor_data400'
                                                 ,pCluster
                               ) 
                     + '::';

  //weekly keys
	export contact_linkids           := tools.mod_FilenamesBuild(lcluster + 'key::bipv2::business_header::@version@::contact_linkids'            ,pversion    );
	export contact_title_linkids     := tools.mod_FilenamesBuild(lcluster + 'key::bipv2::business_header::@version@::contact_title_linkids'      ,pversion    );
	export directories_linkids       := tools.mod_FilenamesBuild(lcluster + 'key::bipv2::business_header::@version@::directories_linkids'        ,pversion    );

  //misc keys
	export linkids                   := tools.mod_FilenamesBuild(lcluster + 'key::bipv2::business_header::@version@::linkids'                    ,pversion    );
	export linkids_hidden            := tools.mod_FilenamesBuild(lcluster + 'key::bipv2::business_header::@version@::linkids_hidden'             ,pversion    );
	
	export translations              := tools.mod_FilenamesBuild(lcluster + 'bip2.0::translations::@version@::date'                    	         ,pversion    );
	export zipcityst                 := tools.mod_FilenamesBuild(lcluster + 'key::bipv2::@version@::zipcityst'                                   ,pversion    );
	export status                    := tools.mod_FilenamesBuild(lcluster + 'key::bipv2::business_header::@version@::status'                     ,pversion    );

	export strnbrname                := tools.mod_FilenamesBuild(lcluster + 'bip_v2::strnbrname::@version@'                                      ,pversion    ,lcluster + 'bip_v2::@version@::strnbrname');
	export aml_addr                  := tools.mod_FilenamesBuild(lcluster + 'key::@version@::bipv2_aml_addr'                                     ,pversion    );

	export biz_preferred             := tools.mod_FilenamesBuild(lcluster + 'key::bipv2::@version@::biz_preferred'                               ,pversion    );

  export BIPV2FullKeys := 
      linkids                 .dall_filenames
		+ linkids_hidden					.dall_filenames //newly added	
    + translations            .dall_filenames
    + zipcityst               .dall_filenames
    + strnbrname              .dall_filenames
    + status                  .dall_filenames
    + aml_addr                .dall_filenames
    + biz_preferred           .dall_filenames
    + BIPv2_HRCHY.keynames            (pversion,pUseOtherEnvironment).dall_filenames
 //   + bipv2_proxid.keynames(pversion).attribute_matches     .dall_filenames
    + bipv2_proxid.keynames           (pversion,pUseOtherEnvironment).match_candidates_debug.dall_filenames
    + bipv2_proxid.keynames           (pversion,pUseOtherEnvironment).specificities_debug   .dall_filenames
    + bipv2_proxid.keynames           (pversion,pUseOtherEnvironment).attribute_matches     .dall_filenames
    + bipv2_lgid3.keynames            (pversion,pUseOtherEnvironment).match_candidates_debug.dall_filenames
    + bipv2_lgid3.keynames            (pversion,pUseOtherEnvironment).specificities_debug   .dall_filenames
    + bipv2_lgid3.keynames            (pversion,pUseOtherEnvironment).match_sample_debug    .dall_filenames
    + bipv2_lgid3.keynames            (pversion,pUseOtherEnvironment).attribute_matches     .dall_filenames
    + BizLinkFull.keynames            (pversion,pUseOtherEnvironment).dall_filenames
    + BIPV2_Best.Keynames             (pversion,pUseOtherEnvironment).dall_filenames
    // + BIPV2_Relative.keynames         (pversion,pUseOtherEnvironment).dall_filenames
    + BIPV2_Seleid_Relative.keynames  (pversion,pUseOtherEnvironment).dall_filenames
    + TopBusiness_BIPV2.KeyNames      (pversion,pUseOtherEnvironment).dall_filenames
    ;
    
  export BIPV2WeeklyKeys := 
      directories_linkids         .dall_filenames
    + contact_linkids             .dall_filenames
    + contact_title_linkids       .dall_filenames
      ;
  
  export BIPV2DatalandKeys := BIPV2FullKeys;
      // BizLinkFull.keynames            (pversion,pUseOtherEnvironment).dall_filenames
    // + BIPV2_Seleid_Relative.keynames  (pversion,pUseOtherEnvironment).dall_filenames
    // + BIPV2_Best.Keynames             (pversion,pUseOtherEnvironment).dall_filenames
      // ;

	export dall_filenames := 
      BIPV2FullKeys
    + BIPV2WeeklyKeys
    + BIPv2_HRCHY.keynames(pversion).dall_filenames
    + bipv2_proxid.keynames            (pversion,pUseOtherEnvironment).patched_candidates    .dall_filenames
    + bipv2_proxid_mj6._keynames       (pversion,pUseOtherEnvironment).patched_candidates    .dall_filenames
    + bipv2_proxid_mj6._keynames       (pversion,pUseOtherEnvironment).match_candidates_debug.dall_filenames
    + bipv2_proxid_mj6._keynames       (pversion,pUseOtherEnvironment).specificities_debug   .dall_filenames
    + bipv2_proxid_mj6._keynames       (pversion,pUseOtherEnvironment).attribute_matches     .dall_filenames
    ;

end;