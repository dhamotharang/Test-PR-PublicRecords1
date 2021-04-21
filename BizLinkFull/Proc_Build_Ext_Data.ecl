IMPORT tools;
EXPORT Proc_Build_Ext_Data(
   string   pversion
  ,BOOLEAN  isFullBuild = FALSE//Default to false unless noted
  ,boolean  pPromote2QA = true
) :=
function
  shared knames := keynames(pversion);
  
  Buildext_data_baseFile        := Proc_Build_Ext_Data_Basefile(pversion,isFullBuild);
  Buildext_data_payload         := tools.macf_writeindex('Mod_Ext_Data().PayloadByproxid				,knames.ext_data_payload          .new'	);
  Buildext_data_l_cnpname       := tools.macf_writeindex('Mod_Ext_Data().KeyL_CNPNAME   				,knames.ext_data_l_cnpname        .new'	);
  Buildext_data_l_cnpname_zip   := tools.macf_writeindex('Mod_Ext_Data().KeyL_CNPNAME_ZIP			  ,knames.ext_data_l_cnpname_zip    .new'	);
  Buildext_data_l_cnpname_st    := tools.macf_writeindex('Mod_Ext_Data().KeyL_CNPNAME_ST				,knames.ext_data_l_cnpname_st     .new'	);
  Buildext_data_l_cnpname_fuzzy	:= tools.macf_writeindex('Mod_Ext_Data().KeyL_CNPNAME_FUZZY	    ,knames.ext_data_l_cnpname_fuzzy	.new'	);
  Buildext_data_l_address1      := tools.macf_writeindex('Mod_Ext_Data().KeyL_ADDRESS1					,knames.ext_data_l_address1       .new'	);
  Buildext_data_l_address2      := tools.macf_writeindex('Mod_Ext_Data().KeyL_ADDRESS2          ,knames.ext_data_l_address2       .new'	);  
  Buildext_data_l_address3      := tools.macf_writeindex('Mod_Ext_Data().KeyL_ADDRESS3          ,knames.ext_data_l_address3       .new'	);
  Buildext_data_l_phone         := tools.macf_writeindex('Mod_Ext_Data().KeyL_PHONE       		  ,knames.ext_data_l_phone          .new'	);
  Buildext_data_l_sic           := tools.macf_writeindex('Mod_Ext_Data().KeyL_SIC   						,knames.ext_data_l_sic       			.new'	);
  Buildext_data_l_fein          := tools.macf_writeindex('Mod_Ext_Data().KeyL_FEIN    					,knames.ext_data_l_fein        		.new'	);
  Buildext_data_l_contact_zip   := tools.macf_writeindex('Mod_Ext_Data().KeyL_CONTACT_ZIP 		  ,knames.ext_data_l_contact_zip    .new'	);
  Buildext_data_l_contact_st    := tools.macf_writeindex('Mod_Ext_Data().KeyL_CONTACT_ST 				,knames.ext_data_l_contact_st     .new'	);
  Buildext_data_l_url           := tools.macf_writeindex('Mod_Ext_Data().KeyL_URL      					,knames.ext_data_l_url          	.new'	);
  Buildext_data_l_email         := tools.macf_writeindex('Mod_Ext_Data().KeyL_EMAIL      			  ,knames.ext_data_l_email          .new'	);
  Buildext_data_l_contact_did   := tools.macf_writeindex('Mod_Ext_Data().KeyL_CONTACT_DID       ,knames.ext_data_l_contact_did    .new'	);
  Buildext_data_l_contact_ssn   := tools.macf_writeindex('Mod_Ext_Data().KeyL_CONTACT_SSN       ,knames.ext_data_l_contact_ssn    .new'	);
  Buildext_data_l_source        := tools.macf_writeindex('Mod_Ext_Data().KeyL_SOURCE            ,knames.ext_data_l_source         .new'	);
 
	
	
	returnresult := sequential(
    if(not tools.fun_DoAllFilesExist.fNamesBuilds(knames.dall_filenames)
      ,sequential(
        Buildext_data_baseFile
       ,parallel(
           Buildext_data_payload
          ,Buildext_data_l_cnpname
          ,Buildext_data_l_cnpname_zip
          ,Buildext_data_l_cnpname_st
          ,Buildext_data_l_cnpname_fuzzy
          ,Buildext_data_l_address1
          ,Buildext_data_l_address2
          ,Buildext_data_l_address3
          ,Buildext_data_l_phone
          ,Buildext_data_l_sic
          ,Buildext_data_l_fein
          ,Buildext_data_l_contact_st
          ,Buildext_data_l_contact_zip
          ,Buildext_data_l_url
          ,Buildext_data_l_email
          ,Buildext_data_l_contact_did
          ,Buildext_data_l_contact_ssn
          ,Buildext_data_l_source

        )))
        ,Promote(pversion).New2Built
        ,if(pPromote2QA = true  ,Promote(pversion).Built2QA)
        ,Send_Emails(pversion,/*pUseOtherEnvironment*/,/*pShouldUpdateRoxiePage*/,/*pBIPV2FullKeys*/,/*pEmailList*/,/*pRoxieEmailList*/,'BIPV2 Xlink External File','External File Build Completed').BuildSuccess
      ) : failure(Send_Emails(pversion,/*pUseOtherEnvironment*/,/*pShouldUpdateRoxiePage*/,/*pBIPV2FullKeys*/,/*pEmailList*/,/*pRoxieEmailList*/,'BIPV2 Xlink External File','External File Build Failed').BuildFailure)
      ;
    
  return returnresult;
    
end;