import BizLinkFull, tools;

EXPORT Proc_Build_BizLinkFull_Keys(
   string   pversion
  ,boolean  pPromote2QA = true
) :=
function

	shared bizbase	:= PRTE2_BIPV2_BusHeader.File_BizHead;
  shared specs  	:= PRTE2_BIPV2_BusHeader.specificities(bizbase);
  shared knames 	:= PRTE2_BIPV2_BusHeader.keynames(pversion);
  
  //BuildSpecs                     := tools.macf_writeindex('Keys(bizbase).Specificities_Key',,true);
  Buildmeow                      := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.Key         ,knames.meow                     .new'      );
  Buildsup_proxid                := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.KeyproxidUp ,knames.sup_proxid               .new'      );
  Buildsup_seleid                := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.KeyseleidUp ,knames.sup_seleid               .new'      );
  Buildsup_orgid                 := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.KeyorgidUp  ,knames.sup_orgid                .new'      );
  Buildsup_rcid                  := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.KeyIDHistory,knames.sup_rcid                 .new'      );
  Buildrefs                      := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_.Key                ,knames.refs                     .new'      );  
  Buildwords                     := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_.ValueKey           ,knames.words                    .new'      );
  Buildrefs_l_cnpname            := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_CNPNAME.Key       ,knames.refs_l_cnpname           .new'      );
  Buildrefs_l_cnpname_zip        := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_CNPNAME_ZIP.Key   ,knames.refs_l_cnpname_zip       .new'      );
  Buildrefs_l_cnpname_st         := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_CNPNAME_ST.Key    ,knames.refs_l_cnpname_st        .new'      );
  Buildrefs_l_cnpname_fuzzy      := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_CNPNAME_FUZZY.Key ,knames.refs_l_cnpname_fuzzy     .new'      );
  Buildrefs_l_address1           := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_ADDRESS1.Key      ,knames.refs_l_address1          .new'      );
  Buildrefs_l_address2           := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_ADDRESS2.Key      ,knames.refs_l_address2          .new'      );
  Buildrefs_l_address3           := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_ADDRESS3.Key      ,knames.refs_l_address3          .new'      );
  Buildrefs_l_phone              := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_PHONE.Key         ,knames.refs_l_phone             .new'      );
  Buildrefs_l_sic                := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_SIC.Key           ,knames.refs_l_sic               .new'      );
  Buildrefs_l_fein               := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_FEIN.Key          ,knames.refs_l_fein              .new'      );
  Buildrefs_l_contact            := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_CONTACT.Key       ,knames.refs_l_contact           .new'      );
  Buildrefs_l_url                := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_URL.Key           ,knames.refs_l_url               .new'      );
  Buildrefs_l_email              := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_EMAIL.Key         ,knames.refs_l_email             .new'      );
  Buildrefs_l_contact_did        := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_CONTACT_DID.Key   ,knames.refs_l_contact_did       .new'      );
  Buildrefs_l_contact_ssn        := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_CONTACT_SSN.Key   ,knames.refs_l_contact_ssn       .new'      );
  Buildrefs_l_source             := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Key_BizHead_L_SOURCE.Key        ,knames.refs_l_source            .new'      );
  Buildword_cnp_name             := tools.macf_writeindex('specs.cnp_name_values_key      											 ,knames.word_cnp_name            .new'      );
  Buildword_company_url          := tools.macf_writeindex('specs.company_url_values_key  												 ,knames.word_company_url         .new'      );
  Buildwheel_city_clean          := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Wheel.Key_city_clean            ,knames.wheel_city_clean         .new'      );
  Buildwheel_quick_city_clean    := tools.macf_writeindex('PRTE2_BIPV2_BusHeader.Wheel.KeyQuick_city_clean       ,knames.wheel_quick_city_clean   .new'      );
  
	returnresult := sequential(
		if(not tools.fun_DoAllFilesExist.fNamesBuilds(knames.dall_filenames)
      ,sequential(
        parallel(
           //BuildSpecs                   
					 Buildmeow                    
          ,Buildsup_proxid              
          ,Buildsup_seleid              
          ,Buildsup_orgid   
          ,Buildsup_rcid
          ,Buildrefs                    
          ,Buildwords                   
          ,Buildrefs_l_cnpname    
          ,Buildrefs_l_cnpname_zip
          ,Buildrefs_l_cnpname_st       
          ,Buildrefs_l_cnpname_fuzzy    
          ,Buildrefs_l_address1         
          ,Buildrefs_l_address2         
          ,Buildrefs_l_address3         
          ,Buildrefs_l_phone  
          ,Buildrefs_l_sic
          ,Buildrefs_l_fein             
          ,Buildrefs_l_contact          
          ,Buildrefs_l_url              
          ,Buildrefs_l_email            
          ,Buildrefs_l_contact_did      
          ,Buildrefs_l_contact_ssn      
          ,Buildrefs_l_source           
          ,Buildword_cnp_name           
          ,Buildword_company_url  
          ,sequential(
             Buildwheel_city_clean  
            ,Buildwheel_quick_city_clean 
          )
        )))
        ,Promote(pversion).New2Built
        ,if(pPromote2QA = true  ,Promote(pversion).Built2QA)
        ,Send_Emails(pversion).BuildSuccess
      ) : failure(Send_Emails(pversion).BuildFailure)
      ;
    
  return returnresult;
    
end;
