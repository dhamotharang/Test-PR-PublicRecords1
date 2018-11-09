import tools;
EXPORT keynames(
   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
  ,string   pCluster              = ''
) :=
module

	shared lfileprefix		          := _Constants(pUseOtherEnvironment).prefix	;

  shared lcluster := lfileprefix + if(pCluster = ''   ,'thor_data400'
                                                      ,pCluster
                                    ) 
             + '::';

	export meow                      := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::meow'                     	   ,pversion    );
	export refs                      := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs'          	               ,pversion    );
	export words                     := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::words'          	             ,pversion    );
	export refs_l_cnpname            := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_cnpname'          	   ,pversion    );
	export refs_l_cnpname_zip        := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_cnpname_zip'       	   ,pversion    );
	export refs_l_cnpname_st         := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_cnpname_st'       	   ,pversion    );
	export refs_l_cnpname_fuzzy      := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_cnpname_fuzzy'       	 ,pversion    );
	export refs_l_address1           := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_address1'         	   ,pversion    );
	export refs_l_address2           := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_address2'         	   ,pversion    );
	export refs_l_address3           := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_address3'         	   ,pversion    );
	export refs_l_phone              := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_phone'            	   ,pversion    );
	export refs_l_sic                := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_sic'            	     ,pversion    );
	export refs_l_rcid               := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_rcid'            	     ,pversion    );
	export refs_l_fein               := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_fein'             	   ,pversion    );
	export refs_l_contact            := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_contact'          	   ,pversion    );
	export refs_l_url                := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_url'              	   ,pversion    );
	export refs_l_email              := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_email'            	   ,pversion    );
	export refs_l_contact_did        := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_contact_did'      	   ,pversion    );
	export refs_l_contact_ssn        := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_contact_ssn'      	   ,pversion    );
	export refs_l_source             := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::refs::l_source'           	   ,pversion    );  
	export wheel_city_clean          := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::wheel::city_clean'       	     ,pversion    );
	export wheel_quick_city_clean    := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::wheel_quick::city_clean' 	     ,pversion    );
	export word_cnp_name             := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::word::cnp_name'           	   ,pversion    );
	export word_company_url          := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::word::company_url'        	   ,pversion    );
	export sup_proxid                := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::sup::proxid'                   ,pversion    );  
	export sup_seleid                := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::sup::seleid'                   ,pversion    );  
	export sup_orgid                 := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::sup::orgid'                    ,pversion    );  
	export sup_ultid                 := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::sup::ultid'                    ,pversion    );  
	export sup_rcid                  := tools.mod_FilenamesBuild(lcluster + 'key::bizlinkfull::@version@::proxid::sup::rcid'                     ,pversion    );  

  export dall_filenames := 
      meow                      .dall_filenames
    // + refs                      .dall_filenames
    // + words                     .dall_filenames
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
//    + sup_ultid                 .dall_filenames   //not built yet
    ;
  
end;