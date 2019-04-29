//Compile all keys in this package in one place
//easy to output this module to see if keys exist/are correct layout/etc
import bipv2,BIPV2_Company_Names,TopBusiness_BIPV2,BIPV2_ProxID,BIPV2_Best,BIPV2_Relative,BizLinkFull,tools,BIPV2_Seleid_Relative,BIPV2_LGID3,Address_Attributes,BIPv2_HRCHY,tools;

EXPORT BIPV2FullKeys_Package(

   string   pversion              = 'qa'
  ,boolean	pUseOtherEnvironment	= false
  ,unsigned pKey                  = 0
  ,string   pRegexFieldFilter     = ''

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
  // shared relknames        := BIPV2_Relative.keynames        (pversion,puseotherenvironment);
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
  export lgid3_atts                     := BIPV2_LGID3.Keys2(,pversion,puseotherenvironment).Attribute_Match;
  export best_linkids                   := tools.macf_FilesIndex('BIPV2_Best.Key_LinkIds.key                     ' ,bestknames.LinkIds                );
  // export relative_assoc                 := tools.macf_FilesIndex('BIPv2_Relative.keys(relbase).ASSOC             ' ,relknames.assoc                   );
  export Seleid_relative_specs          := tools.macf_FilesIndex('BIPV2_Seleid_Relative.keys(Seleidrelbase).Specificities_Key' ,Seleidrelknames.specs             );
  export Seleid_relative_mc             := tools.macf_FilesIndex('BIPV2_Seleid_Relative.keys(Seleidrelbase).Candidates' ,Seleidrelknames.mc             );
  export Seleid_relative_assoc          := tools.macf_FilesIndex('BIPV2_Seleid_Relative.keys(Seleidrelbase).ASSOC' ,Seleidrelknames.assoc             );
  export Xlinkmeow                      := tools.macf_FilesIndex('BizLinkFull.Process_Biz_Layouts.Key            ' ,bizknames.meow                    );
  // export Xlinkrefs                      := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_.Key                   ' ,bizknames.refs                    );
  // export Xlinkwords                     := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_.ValueKey              ' ,bizknames.words                   );
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
    ,if(pKey in [0 ,13] ,sequential(output(13 ,named('KeyNumber'),overwrite) ,output(choosen(lgid3_atts                   .logical ,100),named('lgid3_atts'                    ))))
    ,if(pKey in [0 ,14] ,sequential(output(14 ,named('KeyNumber'),overwrite) ,output(choosen(best_linkids                 .logical ,100),named('best_linkids'                  ))))
    // ,if(pKey in [0 ,14] ,sequential(output(14 ,named('KeyNumber'),overwrite) ,output(choosen(relative_assoc               .logical ,100),named('relative_assoc'                ))))
    ,if(pKey in [0 ,15] ,sequential(output(15 ,named('KeyNumber'),overwrite) ,output(choosen(Seleid_relative_specs        .logical ,100),named('Seleid_relative_specs'         ))))
    ,if(pKey in [0 ,16] ,sequential(output(16 ,named('KeyNumber'),overwrite) ,output(choosen(Seleid_relative_mc           .logical ,100),named('Seleid_relative_mc'            ))))
    ,if(pKey in [0 ,17] ,sequential(output(17 ,named('KeyNumber'),overwrite) ,output(choosen(Seleid_relative_assoc        .logical ,100),named('Seleid_relative_assoc'         ))))
    ,if(pKey in [0 ,18] ,sequential(output(18 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkmeow                    .logical ,100),named('Xlinkmeow'                     ))))
    // ,if(pKey in [0 ,17] ,sequential(output(17 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs                    .logical ,100),named('Xlinkrefs'                     ))))
    // ,if(pKey in [0 ,18] ,sequential(output(18 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkwords                   .logical ,100),named('Xlinkwords'                    ))))
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
/*
  regexfilter := pRegexFieldFilter;

  tls_strnbr                       := tools.macf_LayoutTools(recordof(strnbr                               )  ,false,regexfilter,true);
  tls_license_linkids              := tools.macf_LayoutTools(recordof(license_linkids              .logical)  ,false,regexfilter,true,true);
  tls_industry_linkids             := tools.macf_LayoutTools(recordof(industry_linkids             .logical)  ,false,regexfilter,true,true);
  tls_linkids                      := tools.macf_LayoutTools(recordof(linkids                      .logical)  ,false,regexfilter,true,true);
  tls_translations                 := tools.macf_LayoutTools(recordof(translations                 .logical)  ,false,regexfilter,true,true);
  tls_ZipCitySt                    := tools.macf_LayoutTools(recordof(ZipCitySt                    .logical)  ,false,regexfilter,true,true);
  tls_Status                       := tools.macf_LayoutTools(recordof(Status                       .logical)  ,false,regexfilter,true,true);
  tls_proxid_mtch_cand             := tools.macf_LayoutTools(recordof(proxid_mtch_cand             .logical)  ,false,regexfilter,true,true);
  tls_proxid_specs                 := tools.macf_LayoutTools(recordof(proxid_specs                 .logical)  ,false,regexfilter,true,true);
  tls_proxid_atts                  := tools.macf_LayoutTools(recordof(proxid_atts                  .logical)  ,false,regexfilter,true,true);
  tls_lgid3_mtch_cand              := tools.macf_LayoutTools(recordof(lgid3_mtch_cand              .logical)  ,false,regexfilter,true,true);
  tls_lgid3_specs                  := tools.macf_LayoutTools(recordof(lgid3_specs                  .logical)  ,false,regexfilter,true,true);
  tls_best_linkids                 := tools.macf_LayoutTools(recordof(best_linkids                 .logical)  ,false,regexfilter,true,true);
  tls_relative_assoc               := tools.macf_LayoutTools(recordof(relative_assoc               .logical)  ,false,regexfilter,true,true);
  tls_Seleid_relative_assoc        := tools.macf_LayoutTools(recordof(Seleid_relative_assoc        .logical)  ,false,regexfilter,true,true);
  tls_Xlinkmeow                    := tools.macf_LayoutTools(recordof(Xlinkmeow                    .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs                    := tools.macf_LayoutTools(recordof(Xlinkrefs                    .logical)  ,false,regexfilter,true,true);
  tls_Xlinkwords                   := tools.macf_LayoutTools(recordof(Xlinkwords                   .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_cnpname          := tools.macf_LayoutTools(recordof(Xlinkrefs_l_cnpname          .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_cnpname_st       := tools.macf_LayoutTools(recordof(Xlinkrefs_l_cnpname_st       .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_cnpname_zip      := tools.macf_LayoutTools(recordof(Xlinkrefs_l_cnpname_zip      .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_cnpname_fuzzy    := tools.macf_LayoutTools(recordof(Xlinkrefs_l_cnpname_fuzzy    .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_address1         := tools.macf_LayoutTools(recordof(Xlinkrefs_l_address1         .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_address2         := tools.macf_LayoutTools(recordof(Xlinkrefs_l_address2         .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_address3         := tools.macf_LayoutTools(recordof(Xlinkrefs_l_address3         .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_phone            := tools.macf_LayoutTools(recordof(Xlinkrefs_l_phone            .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_fein             := tools.macf_LayoutTools(recordof(Xlinkrefs_l_fein             .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_contact          := tools.macf_LayoutTools(recordof(Xlinkrefs_l_contact          .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_url              := tools.macf_LayoutTools(recordof(Xlinkrefs_l_url              .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_email            := tools.macf_LayoutTools(recordof(Xlinkrefs_l_email            .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_contact_did      := tools.macf_LayoutTools(recordof(Xlinkrefs_l_contact_did      .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_contact_ssn      := tools.macf_LayoutTools(recordof(Xlinkrefs_l_contact_ssn      .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_source           := tools.macf_LayoutTools(recordof(Xlinkrefs_l_source           .logical)  ,false,regexfilter,true,true);
  tls_Xlinkwheel_city_clean        := tools.macf_LayoutTools(recordof(Xlinkwheel_city_clean        .logical)  ,false,regexfilter,true,true);
  tls_Xlinkwheel_quick_city_clean  := tools.macf_LayoutTools(recordof(Xlinkwheel_quick_city_clean  .logical)  ,false,regexfilter,true,true);
  tls_Xlinkword_cnp_name           := tools.macf_LayoutTools(recordof(Xlinkword_cnp_name           .logical)  ,false,regexfilter,true,true);
  tls_Xlinkword_company_url        := tools.macf_LayoutTools(recordof(Xlinkword_company_url        .logical)  ,false,regexfilter,true,true);
  tls_Xlinksup_proxid              := tools.macf_LayoutTools(recordof(Xlinksup_proxid              .logical)  ,false,regexfilter,true,true);
  tls_Xlinksup_seleid              := tools.macf_LayoutTools(recordof(Xlinksup_seleid              .logical)  ,false,regexfilter,true,true);
  tls_Xlinksup_orgid               := tools.macf_LayoutTools(recordof(Xlinksup_orgid               .logical)  ,false,regexfilter,true,true);
  tls_Xlinksup_rcid                := tools.macf_LayoutTools(recordof(Xlinksup_rcid                .logical)  ,false,regexfilter,true,true);
  tls_HrchyProxid                  := tools.macf_LayoutTools(recordof(HrchyProxid                  .logical)  ,false,regexfilter,true,true);
  tls_HrchyLgid                    := tools.macf_LayoutTools(recordof(HrchyLgid                    .logical)  ,false,regexfilter,true,true);
  tls_AML_Addr                     := tools.macf_LayoutTools(recordof(AML_Addr                     .logical)  ,false,regexfilter,true,true);
  tls_biz_preferred                := tools.macf_LayoutTools(recordof(biz_preferred                .logical)  ,false,regexfilter,true,true);
  tls_Xlinkrefs_l_sic              := tools.macf_LayoutTools(recordof(Xlinkrefs_l_sic              .logical)  ,false,regexfilter,true,true);

  export output_fields := 
  sequential(
     output('fields that match the regex follow')
    ,if(count(tls_strnbr                     .setAllFields) > 0 ,output(tls_strnbr                     .setAllFields ,named('tls_strnbrFile'                    )))
    ,if(count(tls_license_linkids            .setAllFields) > 0 ,output(tls_license_linkids            .setAllFields ,named('tls_license_linkids'               )))
    ,if(count(tls_industry_linkids           .setAllFields) > 0 ,output(tls_industry_linkids           .setAllFields ,named('tls_industry_linkids'              )))
    ,if(count(tls_linkids                    .setAllFields) > 0 ,output(tls_linkids                    .setAllFields ,named('tls_linkids'                       )))
    ,if(count(tls_translations               .setAllFields) > 0 ,output(tls_translations               .setAllFields ,named('tls_translations'                  )))
    ,if(count(tls_ZipCitySt                  .setAllFields) > 0 ,output(tls_ZipCitySt                  .setAllFields ,named('tls_ZipCitySt'                     )))
    ,if(count(tls_Status                     .setAllFields) > 0 ,output(tls_Status                     .setAllFields ,named('tls_Status'                        )))
    ,if(count(tls_proxid_mtch_cand           .setAllFields) > 0 ,output(tls_proxid_mtch_cand           .setAllFields ,named('tls_proxid_mtch_cand'              )))
    ,if(count(tls_proxid_specs               .setAllFields) > 0 ,output(tls_proxid_specs               .setAllFields ,named('tls_proxid_specs'                  )))
    ,if(count(tls_proxid_atts                .setAllFields) > 0 ,output(tls_proxid_atts                .setAllFields ,named('tls_proxid_atts'                   )))
    ,if(count(tls_lgid3_mtch_cand            .setAllFields) > 0 ,output(tls_lgid3_mtch_cand            .setAllFields ,named('tls_lgid3_mtch_cand'               )))
    ,if(count(tls_lgid3_specs                .setAllFields) > 0 ,output(tls_lgid3_specs                .setAllFields ,named('tls_lgid3_specs'                   )))
    ,if(count(tls_best_linkids               .setAllFields) > 0 ,output(tls_best_linkids               .setAllFields ,named('tls_best_linkids'                  )))
    ,if(count(tls_relative_assoc             .setAllFields) > 0 ,output(tls_relative_assoc             .setAllFields ,named('tls_relative_assoc'                )))
    ,if(count(tls_Seleid_relative_assoc      .setAllFields) > 0 ,output(tls_Seleid_relative_assoc      .setAllFields ,named('tls_Seleid_relative_assoc'         )))
    ,if(count(tls_Xlinkmeow                  .setAllFields) > 0 ,output(tls_Xlinkmeow                  .setAllFields ,named('tls_Xlinkmeow'                     )))
    ,if(count(tls_Xlinkrefs                  .setAllFields) > 0 ,output(tls_Xlinkrefs                  .setAllFields ,named('tls_Xlinkrefs'                     )))
    ,if(count(tls_Xlinkwords                 .setAllFields) > 0 ,output(tls_Xlinkwords                 .setAllFields ,named('tls_Xlinkwords'                    )))
    ,if(count(tls_Xlinkrefs_l_cnpname        .setAllFields) > 0 ,output(tls_Xlinkrefs_l_cnpname        .setAllFields ,named('tls_Xlinkrefs_l_cnpname'           )))
    ,if(count(tls_Xlinkrefs_l_cnpname_st     .setAllFields) > 0 ,output(tls_Xlinkrefs_l_cnpname_st     .setAllFields ,named('tls_Xlinkrefs_l_cnpname_st'        )))
    ,if(count(tls_Xlinkrefs_l_cnpname_zip    .setAllFields) > 0 ,output(tls_Xlinkrefs_l_cnpname_zip    .setAllFields ,named('tls_Xlinkrefs_l_cnpname_zip'       )))
    ,if(count(tls_Xlinkrefs_l_cnpname_fuzzy  .setAllFields) > 0 ,output(tls_Xlinkrefs_l_cnpname_fuzzy  .setAllFields ,named('tls_Xlinkrefs_l_cnpname_fuzzy'     )))
    ,if(count(tls_Xlinkrefs_l_address1       .setAllFields) > 0 ,output(tls_Xlinkrefs_l_address1       .setAllFields ,named('tls_Xlinkrefs_l_address1'          )))
    ,if(count(tls_Xlinkrefs_l_address2       .setAllFields) > 0 ,output(tls_Xlinkrefs_l_address2       .setAllFields ,named('tls_Xlinkrefs_l_address2'          )))
    ,if(count(tls_Xlinkrefs_l_address3       .setAllFields) > 0 ,output(tls_Xlinkrefs_l_address3       .setAllFields ,named('tls_Xlinkrefs_l_address3'          )))
    ,if(count(tls_Xlinkrefs_l_phone          .setAllFields) > 0 ,output(tls_Xlinkrefs_l_phone          .setAllFields ,named('tls_Xlinkrefs_l_phone'             )))
    ,if(count(tls_Xlinkrefs_l_fein           .setAllFields) > 0 ,output(tls_Xlinkrefs_l_fein           .setAllFields ,named('tls_Xlinkrefs_l_fein'              )))
    ,if(count(tls_Xlinkrefs_l_contact        .setAllFields) > 0 ,output(tls_Xlinkrefs_l_contact        .setAllFields ,named('tls_Xlinkrefs_l_contact'           )))
    ,if(count(tls_Xlinkrefs_l_url            .setAllFields) > 0 ,output(tls_Xlinkrefs_l_url            .setAllFields ,named('tls_Xlinkrefs_l_url'               )))
    ,if(count(tls_Xlinkrefs_l_email          .setAllFields) > 0 ,output(tls_Xlinkrefs_l_email          .setAllFields ,named('tls_Xlinkrefs_l_email'             )))
    ,if(count(tls_Xlinkrefs_l_contact_did    .setAllFields) > 0 ,output(tls_Xlinkrefs_l_contact_did    .setAllFields ,named('tls_Xlinkrefs_l_contact_did'       )))
    ,if(count(tls_Xlinkrefs_l_contact_ssn    .setAllFields) > 0 ,output(tls_Xlinkrefs_l_contact_ssn    .setAllFields ,named('tls_Xlinkrefs_l_contact_ssn'       )))
    ,if(count(tls_Xlinkrefs_l_source         .setAllFields) > 0 ,output(tls_Xlinkrefs_l_source         .setAllFields ,named('tls_Xlinkrefs_l_source'            )))
    ,if(count(tls_Xlinkwheel_city_clean      .setAllFields) > 0 ,output(tls_Xlinkwheel_city_clean      .setAllFields ,named('tls_Xlinkwheel_city_clean'         )))
    ,if(count(tls_Xlinkwheel_quick_city_clean.setAllFields) > 0 ,output(tls_Xlinkwheel_quick_city_clean.setAllFields ,named('tls_Xlinkwheel_quick_city_clean'   )))
    ,if(count(tls_Xlinkword_cnp_name         .setAllFields) > 0 ,output(tls_Xlinkword_cnp_name         .setAllFields ,named('tls_Xlinkword_cnp_name'            )))
    ,if(count(tls_Xlinkword_company_url      .setAllFields) > 0 ,output(tls_Xlinkword_company_url      .setAllFields ,named('tls_Xlinkword_company_url'         )))
    ,if(count(tls_Xlinksup_proxid            .setAllFields) > 0 ,output(tls_Xlinksup_proxid            .setAllFields ,named('tls_Xlinksup_proxid'               )))
    ,if(count(tls_Xlinksup_seleid            .setAllFields) > 0 ,output(tls_Xlinksup_seleid            .setAllFields ,named('tls_Xlinksup_seleid'               )))
    ,if(count(tls_Xlinksup_orgid             .setAllFields) > 0 ,output(tls_Xlinksup_orgid             .setAllFields ,named('tls_Xlinksup_orgid'                )))
    ,if(count(tls_Xlinksup_rcid              .setAllFields) > 0 ,output(tls_Xlinksup_rcid              .setAllFields ,named('tls_Xlinksup_rcid'                 )))
    ,if(count(tls_HrchyProxid                .setAllFields) > 0 ,output(tls_HrchyProxid                .setAllFields ,named('tls_HrchyProxid'                   )))
    ,if(count(tls_HrchyLgid                  .setAllFields) > 0 ,output(tls_HrchyLgid                  .setAllFields ,named('tls_HrchyLgid'                     )))
    ,if(count(tls_AML_Addr                   .setAllFields) > 0 ,output(tls_AML_Addr                   .setAllFields ,named('tls_AML_Addr'                      )))
    ,if(count(tls_biz_preferred              .setAllFields) > 0 ,output(tls_biz_preferred              .setAllFields ,named('tls_biz_preferred'                 )))
    ,if(count(tls_Xlinkrefs_l_sic            .setAllFields) > 0 ,output(tls_Xlinkrefs_l_sic            .setAllFields ,named('tls_Xlinkrefs_l_sic'               )))
  );       

*/
end;