import tools,bipv2_proxid,bipv2_proxid_mj6,BizLinkFull,BIPV2_Best,BIPV2_Relative,TopBusiness_BIPV2,BIPV2_Seleid_Relative,bipv2_lgid3,BIPv2_HRCHY,BIPV2_Crosswalk,BIPV2_Segmentation,BIPV2_Suppression;
import dx_BIPV2;

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

  export highRiskIndustriesPhone   := tools.mod_FilenamesBuild(lcluster + 'key::bipv2::@version@::high_risk_industries_phone'                  ,pversion    );
  export highRiskIndustriesAddr    := tools.mod_FilenamesBuild(lcluster + 'key::bipv2::@version@::high_risk_industries_addr'                   ,pversion    );
  export highRiskIndustriesCodes   := tools.mod_FilenamesBuild(lcluster + 'key::bipv2::@version@::high_risk_industries'                        ,pversion    );
  
  export firmographicsScore         := dx_BIPV2.Keynames(pVersion).FirmographicsScore;
  export locid                      := dx_BIPV2.Keynames(pVersion).Locid;

  export BIPV2FullKeys := 
    (
      linkids                 .dall_filenames
		+ linkids_hidden					.dall_filenames //newly added	
    + translations            .dall_filenames
    + zipcityst               .dall_filenames
    + strnbrname              .dall_filenames
    + status                  .dall_filenames
    + aml_addr                .dall_filenames
    + biz_preferred           .dall_filenames
    + highRiskIndustriesPhone .dall_filenames
    + highRiskIndustriesAddr  .dall_filenames
    + highRiskIndustriesCodes .dall_filenames
    + firmographicsScore      .dall_filenames
    + locid                   .dall_filenames
    + BIPv2_HRCHY.keynames            (pversion,pUseOtherEnvironment).dall_filenames
    + BIPV2_Crosswalk.filenames(pversion,pUseOtherEnvironment).dall_keynames
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
    + BIPV2_Segmentation.keynames     (pversion,pUseOtherEnvironment).dall_filenames
    )
    (~regexfind('ext_data',logicalname,nocase)) //remove external xlink keys because they are not in this package
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
  export BIPV2FullKeys_Alpha := 
    ( BizLinkFull.keynames            (pversion,pUseOtherEnvironment).dall_filenames
    + BIPV2_Segmentation.keynames     (pversion,pUseOtherEnvironment).dall_filenames
    + contact_title_linkids       .dall_filenames
    + BIPV2_Best.Keynames             (pversion,pUseOtherEnvironment).dall_filenames
    + strnbrname                  .dall_filenames
    + zipcityst                   .dall_filenames
    )
    (~regexfind('ext_data',logicalname,nocase)) //remove external xlink keys because they are not in this package
      ;

  export BIPV2SuppressionKeys_Alpha := 
      BIPV2_Suppression.FileNames.key_sele_prox_names(pversion).dall_filenames
      ;

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