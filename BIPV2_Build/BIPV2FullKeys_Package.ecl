//Compile all keys in this package in one place
//easy to output this module to see if keys exist/are correct layout/etc
import bipv2,BIPV2_Company_Names,TopBusiness_BIPV2,BIPV2_ProxID,BIPV2_Best,BIPV2_Relative,BizLinkFull,tools,BIPV2_Seleid_Relative,BIPV2_LGID3,Address_Attributes,BIPv2_HRCHY;

EXPORT BIPV2FullKeys_Package(

   string   pversion              = 'qa'
  ,boolean	pUseOtherEnvironment	= false
  ,unsigned pKey                  = 0

) :=
module

	shared relbase        := DATASET([],BIPV2.CommonBase.Layout);
  shared Seleidrelbase  := DATASET([],BIPV2.CommonBase.layout);
  shared bizbase        := BizLinkFull.File_BizHead;
  shared specs          := BizLinkFull.specificities(bizbase);

  shared bizknames        := BizLinkFull.keynames           (pversion,puseotherenvironment);
  shared knames           := keynames                       (pversion,puseotherenvironment);
  shared tbknames         := TopBusiness_BIPV2.keynames     (pversion,puseotherenvironment);
  shared proxknames       := BIPV2_ProxID.keynames          (pversion,puseotherenvironment);
  shared lgid3knames      := BIPV2_LGID3.keynames           (pversion,puseotherenvironment);
  shared bestknames       := BIPV2_Best.Keynames            (pversion,puseotherenvironment);
  shared relknames        := BIPV2_Relative.keynames        (pversion,puseotherenvironment);
  shared Seleidrelknames  := BIPV2_Seleid_Relative.keynames (pversion,puseotherenvironment);

  //key definitions
  export strnbr                         := BIPV2_Company_Names.files.StrNbr_SF_DS;  //file, not key, but it is in the package file
  export license_linkids                := TopBusiness_BIPV2.Key_License_Linkids.keyvs (pversion,puseotherenvironment);
  export industry_linkids               := TopBusiness_BIPV2.Key_Industry_Linkids.keyvs(pversion,puseotherenvironment);
  export linkids                        := tools.macf_FilesIndex('BIPV2.Key_BH_Linking_Ids.key                   ' ,knames.linkids                    );
  export linkids_hidden                 := tools.macf_FilesIndex('BIPV2.Key_BH_Linking_Ids.key_hidden            ' ,knames.linkids_hidden                    );
  export translations                   := tools.macf_FilesIndex('BIPV2_Company_Names.files.TranslationsKey      ' ,knames.translations               );
  export ZipCitySt                      := BIPV2_Build.keys     (pversion,puseotherenvironment).ZipCitySt               ;
  export Status                         := BIPV2.key_Status.lkey(pversion,puseotherenvironment)               ;
  export proxid_mtch_cand               := tools.macf_FilesIndex('BIPV2_ProxID.Keys().Candidates                 ' ,proxknames.match_candidates_debug );
  export proxid_specs                   := tools.macf_FilesIndex('BIPV2_ProxID.Keys().Specificities_Key          ' ,proxknames.specificities_debug    );
  export proxid_atts                    := tools.macf_FilesIndex('BIPV2_ProxID.Keys().Attribute_Matches          ' ,proxknames.Attribute_Matches      );
  export lgid3_mtch_cand                := BIPV2_LGID3.Keys2(,pversion,puseotherenvironment).MatchCandidates;
  export lgid3_specs                    := BIPV2_LGID3.Keys2(,pversion,puseotherenvironment).Specificity    ;
  export best_linkids                   := tools.macf_FilesIndex('BIPV2_Best.Key_LinkIds.key                     ' ,bestknames.LinkIds                );
  export relative_assoc                 := tools.macf_FilesIndex('BIPv2_Relative.keys(relbase).ASSOC             ' ,relknames.assoc                   );
  export Seleid_relative_assoc          := tools.macf_FilesIndex('BIPV2_Seleid_Relative.keys(Seleidrelbase).ASSOC' ,Seleidrelknames.assoc             );
  export Xlinkmeow                      := tools.macf_FilesIndex('BizLinkFull.Process_Biz_Layouts.Key            ' ,bizknames.meow                    );
  export Xlinkrefs                      := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_.Key                   ' ,bizknames.refs                    );
  export Xlinkwords                     := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_.ValueKey              ' ,bizknames.words                   );
  export Xlinkrefs_l_cnpname            := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_CNPNAME.Key          ' ,bizknames.refs_l_cnpname          );
  export Xlinkrefs_l_cnpname_st         := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_CNPNAME_ST.Key       ' ,bizknames.refs_l_cnpname_st       );
  export Xlinkrefs_l_cnpname_zip        := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.Key      ' ,bizknames.refs_l_cnpname_zip      );
  export Xlinkrefs_l_cnpname_fuzzy      := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.Key    ' ,bizknames.refs_l_cnpname_fuzzy    );
  export Xlinkrefs_l_address1           := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_ADDRESS1.Key         ' ,bizknames.refs_l_address1         );
  export Xlinkrefs_l_address2           := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_ADDRESS2.Key         ' ,bizknames.refs_l_address2         );
  export Xlinkrefs_l_address3           := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_ADDRESS3.Key         ' ,bizknames.refs_l_address3         );
  export Xlinkrefs_l_phone              := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_PHONE.Key            ' ,bizknames.refs_l_phone            );
  export Xlinkrefs_l_fein               := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_FEIN.Key             ' ,bizknames.refs_l_fein             );
  export Xlinkrefs_l_contact            := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_CONTACT.Key          ' ,bizknames.refs_l_contact          );
  export Xlinkrefs_l_url                := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_URL.Key              ' ,bizknames.refs_l_url              );
  export Xlinkrefs_l_email              := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_EMAIL.Key            ' ,bizknames.refs_l_email            );
  export Xlinkrefs_l_contact_did        := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_CONTACT_DID.Key      ' ,bizknames.refs_l_contact_did      );
  export Xlinkrefs_l_contact_ssn        := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_CONTACT_SSN.Key      ' ,bizknames.refs_l_contact_ssn      );
  export Xlinkrefs_l_source             := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_SOURCE.Key           ' ,bizknames.refs_l_source           );
  export Xlinkwheel_city_clean          := tools.macf_FilesIndex('BizLinkFull.Wheel.Key_city_clean               ' ,bizknames.wheel_city_clean        );
  export Xlinkwheel_quick_city_clean    := tools.macf_FilesIndex('BizLinkFull.Wheel.KeyQuick_city_clean          ' ,bizknames.wheel_quick_city_clean  );
  export Xlinkword_cnp_name             := tools.macf_FilesIndex('specs.cnp_name_values_key                      ' ,bizknames.word_cnp_name           );
  export Xlinkword_company_url          := tools.macf_FilesIndex('specs.company_url_values_key                   ' ,bizknames.word_company_url        );
  export Xlinksup_proxid                := tools.macf_FilesIndex('BizLinkFull.Process_Biz_Layouts.KeyproxidUp    ' ,bizknames.sup_proxid              );
  export Xlinksup_seleid                := tools.macf_FilesIndex('BizLinkFull.Process_Biz_Layouts.KeyseleidUp    ' ,bizknames.sup_seleid              );
  export Xlinksup_orgid                 := tools.macf_FilesIndex('BizLinkFull.Process_Biz_Layouts.KeyorgidUp     ' ,bizknames.sup_orgid               );
  export Xlinksup_rcid                  := tools.macf_FilesIndex('BizLinkFull.Process_Biz_Layouts.KeyIDHistory   ' ,bizknames.sup_rcid                );
  
  export HrchyProxid                    := BIPv2_HRCHY.Keys(pversion,puseotherenvironment).HrchyProxid;
  export HrchyLgid                      := BIPv2_HRCHY.Keys(pversion,puseotherenvironment).HrchyLgid  ;

  export AML_Addr                       := tools.macf_FilesIndex('Address_Attributes.key_AML_addr               ' ,keynames(pversion,puseotherenvironment).aml_addr        );
  export biz_preferred                  := tools.macf_FilesIndex('BIPV2_Company_Names.key_preferred             ' ,keynames(pversion,puseotherenvironment).biz_preferred   );
  export Xlinkrefs_l_sic                := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_SIC.Key             ' ,bizknames.refs_l_sic               );

  // export AML_Addr                       := index(Address_Attributes.key_AML_addr                   ,keynames(pversion).aml_addr.logical     );
  // export biz_preferred                  := index(BIPV2_Company_Names.key_preferred                 ,keynames(pversion).biz_preferred.logical     );
  // export Xlinkrefs_l_sic                := index(BizLinkFull.Key_BizHead_L_SIC.Key                 ,bizknames.refs_l_sic             .logical);



  export outputpackage := 
  sequential(
     output('______________________________________________________________________________')
    ,output('BIPV2FullKeys Package Follows')
    ,output(0  ,named('KeyNumber'),overwrite)
    ,if(pKey in [0 ,1 ] ,sequential(output(1  ,named('KeyNumber'),overwrite) ,output(choosen(strnbr                                ,100),named('strnbrFile'                    ))))
    ,if(pKey in [0 ,2 ] ,sequential(output(2  ,named('KeyNumber'),overwrite) ,output(choosen(license_linkids              .logical ,100),named('license_linkids'               ))))
    ,if(pKey in [0 ,3 ] ,sequential(output(3  ,named('KeyNumber'),overwrite) ,output(choosen(industry_linkids             .logical ,100),named('industry_linkids'              ))))
    ,if(pKey in [0 ,4 ] ,sequential(output(4  ,named('KeyNumber'),overwrite) ,output(choosen(linkids                      .logical ,100),named('linkids'                       ))))
    ,if(pKey in [0 ,5 ] ,sequential(output(5  ,named('KeyNumber'),overwrite) ,output(choosen(translations                 .logical ,100),named('translations'                  ))))
    ,if(pKey in [0 ,6 ] ,sequential(output(6  ,named('KeyNumber'),overwrite) ,output(choosen(ZipCitySt                    .logical ,100),named('ZipCitySt'                     ))))
    ,if(pKey in [0 ,7 ] ,sequential(output(7  ,named('KeyNumber'),overwrite) ,output(choosen(Status                       .logical ,100),named('Status'                        ))))
    ,if(pKey in [0 ,8 ] ,sequential(output(8  ,named('KeyNumber'),overwrite) ,output(choosen(proxid_mtch_cand             .logical ,100),named('proxid_mtch_cand'              ))))
    ,if(pKey in [0 ,9 ] ,sequential(output(9  ,named('KeyNumber'),overwrite) ,output(choosen(proxid_specs                 .logical ,100),named('proxid_specs'                  ))))
    ,if(pKey in [0 ,10] ,sequential(output(10 ,named('KeyNumber'),overwrite) ,output(choosen(proxid_atts                  .logical ,100),named('proxid_atts'                   ))))
    ,if(pKey in [0 ,11] ,sequential(output(11 ,named('KeyNumber'),overwrite) ,output(choosen(lgid3_mtch_cand              .logical ,100),named('lgid3_mtch_cand'               ))))
    ,if(pKey in [0 ,12] ,sequential(output(12 ,named('KeyNumber'),overwrite) ,output(choosen(lgid3_specs                  .logical ,100),named('lgid3_specs'                   ))))
    ,if(pKey in [0 ,13] ,sequential(output(13 ,named('KeyNumber'),overwrite) ,output(choosen(best_linkids                 .logical ,100),named('best_linkids'                  ))))
    ,if(pKey in [0 ,14] ,sequential(output(14 ,named('KeyNumber'),overwrite) ,output(choosen(relative_assoc               .logical ,100),named('relative_assoc'                ))))
    ,if(pKey in [0 ,15] ,sequential(output(15 ,named('KeyNumber'),overwrite) ,output(choosen(Seleid_relative_assoc        .logical ,100),named('Seleid_relative_assoc'         ))))
    ,if(pKey in [0 ,16] ,sequential(output(16 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkmeow                    .logical ,100),named('Xlinkmeow'                     ))))
    ,if(pKey in [0 ,17] ,sequential(output(17 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs                    .logical ,100),named('Xlinkrefs'                     ))))
    ,if(pKey in [0 ,18] ,sequential(output(18 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkwords                   .logical ,100),named('Xlinkwords'                    ))))
    ,if(pKey in [0 ,19] ,sequential(output(19 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_cnpname          .logical ,100),named('Xlinkrefs_l_cnpname'           ))))
    ,if(pKey in [0 ,20] ,sequential(output(20 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_cnpname_st       .logical ,100),named('Xlinkrefs_l_cnpname_st'        ))))
    ,if(pKey in [0 ,21] ,sequential(output(21 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_cnpname_zip      .logical ,100),named('Xlinkrefs_l_cnpname_zip'       ))))
    ,if(pKey in [0 ,22] ,sequential(output(22 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_cnpname_fuzzy    .logical ,100),named('Xlinkrefs_l_cnpname_fuzzy'     ))))
    ,if(pKey in [0 ,23] ,sequential(output(23 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_address1         .logical ,100),named('Xlinkrefs_l_address1'          ))))
    ,if(pKey in [0 ,24] ,sequential(output(24 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_address2         .logical ,100),named('Xlinkrefs_l_address2'          ))))
    ,if(pKey in [0 ,25] ,sequential(output(25 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_address3         .logical ,100),named('Xlinkrefs_l_address3'          ))))
    ,if(pKey in [0 ,26] ,sequential(output(26 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_phone            .logical ,100),named('Xlinkrefs_l_phone'             ))))
    ,if(pKey in [0 ,27] ,sequential(output(27 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_fein             .logical ,100),named('Xlinkrefs_l_fein'              ))))
    ,if(pKey in [0 ,28] ,sequential(output(28 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_contact          .logical ,100),named('Xlinkrefs_l_contact'           ))))
    ,if(pKey in [0 ,29] ,sequential(output(29 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_url              .logical ,100),named('Xlinkrefs_l_url'               ))))
    ,if(pKey in [0 ,30] ,sequential(output(30 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_email            .logical ,100),named('Xlinkrefs_l_email'             ))))
    ,if(pKey in [0 ,31] ,sequential(output(31 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_contact_did      .logical ,100),named('Xlinkrefs_l_contact_did'       ))))
    ,if(pKey in [0 ,32] ,sequential(output(32 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_contact_ssn      .logical ,100),named('Xlinkrefs_l_contact_ssn'       ))))
    ,if(pKey in [0 ,33] ,sequential(output(33 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_source           .logical ,100),named('Xlinkrefs_l_source'            ))))
    ,if(pKey in [0 ,34] ,sequential(output(34 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkwheel_city_clean        .logical ,100),named('Xlinkwheel_city_clean'         ))))
    ,if(pKey in [0 ,35] ,sequential(output(35 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkwheel_quick_city_clean  .logical ,100),named('Xlinkwheel_quick_city_clean'   ))))
    ,if(pKey in [0 ,36] ,sequential(output(36 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkword_cnp_name           .logical ,100),named('Xlinkword_cnp_name'            ))))
    ,if(pKey in [0 ,37] ,sequential(output(37 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkword_company_url        .logical ,100),named('Xlinkword_company_url'         ))))
    ,if(pKey in [0 ,38] ,sequential(output(38 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinksup_proxid              .logical ,100),named('Xlinksup_proxid'               ))))
    ,if(pKey in [0 ,39] ,sequential(output(39 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinksup_seleid              .logical ,100),named('Xlinksup_seleid'               ))))
    ,if(pKey in [0 ,40] ,sequential(output(40 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinksup_orgid               .logical ,100),named('Xlinksup_orgid'                ))))
    ,if(pKey in [0 ,41] ,sequential(output(41 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinksup_rcid                .logical ,100),named('Xlinksup_rcid'                 ))))
    ,if(pKey in [0 ,42] ,sequential(output(42 ,named('KeyNumber'),overwrite) ,output(choosen(HrchyProxid                  .logical ,100),named('HrchyProxid'                   ))))
    ,if(pKey in [0 ,43] ,sequential(output(43 ,named('KeyNumber'),overwrite) ,output(choosen(HrchyLgid                    .logical ,100),named('HrchyLgid'                     ))))
    ,if(pKey in [0 ,44] ,sequential(output(44 ,named('KeyNumber'),overwrite) ,output(choosen(AML_Addr                     .logical ,100),named('AML_Addr'                      ))))
    ,if(pKey in [0 ,45] ,sequential(output(45 ,named('KeyNumber'),overwrite) ,output(choosen(biz_preferred                .logical ,100),named('biz_preferred'                 ))))
    ,if(pKey in [0 ,46] ,sequential(output(46 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_sic              .logical ,100),named('Xlinkrefs_l_sic'               ))))
  );       
end;