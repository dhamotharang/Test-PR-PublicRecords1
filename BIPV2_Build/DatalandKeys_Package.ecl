//Compile all keys in this package in one place
//easy to output this module to see if keys exist/are correct layout/etc
import bipv2,BIPV2_Company_Names,TopBusiness_BIPV2,BIPV2_ProxID,BIPV2_Best,BIPV2_Relative,BizLinkFull,tools,BIPV2_Seleid_Relative,BIPV2_LGID3;

EXPORT DatalandKeys_Package(

   string   pversion              = 'qa'
  ,boolean	pUseOtherEnvironment	= false

) :=
module

  shared relbase        := DATASET([],BIPv2_Relative.layout_DOT_Base);
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
  export translations                   := tools.macf_FilesIndex('BIPV2_Company_Names.files.TranslationsKey      ' ,knames.translations               );
  export ZipCitySt                      := BIPV2_Build.keys     (pversion,puseotherenvironment).ZipCitySt               ;
  export Status                         := BIPV2.key_Status.lkey(pversion,puseotherenvironment)               ;
  export proxid_mtch_cand               := tools.macf_FilesIndex('BIPV2_ProxID.Keys(BIPV2_ProxID.In_DOT_Base).Candidates                 ' ,proxknames.match_candidates_debug );
  export proxid_specs                   := tools.macf_FilesIndex('BIPV2_ProxID.Keys(BIPV2_ProxID.In_DOT_Base).Specificities_Key          ' ,proxknames.specificities_debug    );
  export proxid_atts                    := tools.macf_FilesIndex('BIPV2_ProxID.Keys(BIPV2_ProxID.In_DOT_Base).Attribute_Matches          ' ,proxknames.Attribute_Matches      );
  export lgid3_mtch_cand                := BIPV2_LGID3.Keys2(,pversion,puseotherenvironment).MatchCandidates;
  export lgid3_specs                    := BIPV2_LGID3.Keys2(,pversion,puseotherenvironment).Specificity    ;
  export best_linkids                   := tools.macf_FilesIndex('BIPV2_Best.Key_LinkIds.key                     ' ,bestknames.LinkIds                );
  // export relative_assoc                 := tools.macf_FilesIndex('BIPv2_Relative.keys(relbase).ASSOC             ' ,relknames.assoc                   );
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



  export outputpackage := 
  parallel(
     output('BIPV2FullKeys Package Follows')
    ,output(choosen(strnbr                                ,100),named('strnbrFile'                    ))
    // ,output(choosen(license_linkids              .logical ,100),named('license_linkids'               ))
    // ,output(choosen(industry_linkids             .logical ,100),named('industry_linkids'              ))
    // ,output(choosen(linkids                      .logical ,100),named('linkids'                       ))
    // ,output(choosen(translations                 .logical ,100),named('translations'                  ))
    // ,output(choosen(ZipCitySt                    .logical ,100),named('ZipCitySt'                     ))
    // ,output(choosen(Status                       .logical ,100),named('Status'                        ))
    // ,output(choosen(proxid_mtch_cand             .logical ,100),named('proxid_mtch_cand'              ))
    // ,output(choosen(proxid_specs                 .logical ,100),named('proxid_specs'                  ))
    // ,output(choosen(proxid_atts                  .logical ,100),named('proxid_atts'                   ))
    // ,output(choosen(lgid3_mtch_cand              .logical ,100),named('lgid3_mtch_cand'               ))
    // ,output(choosen(lgid3_specs                  .logical ,100),named('lgid3_specs'                   ))
    ,output(choosen(best_linkids                 .logical ,100),named('best_linkids'                  ))
    // ,output(choosen(relative_assoc               .logical ,100),named('relative_assoc'                ))
    ,output(choosen(Seleid_relative_assoc        .logical ,100),named('Seleid_relative_assoc'         ))
    ,output(choosen(Xlinkmeow                    .logical ,100),named('Xlinkmeow'                     ))
    // ,output(choosen(Xlinkrefs                    .logical ,100),named('Xlinkrefs'                     ))
    // ,output(choosen(Xlinkwords                   .logical ,100),named('Xlinkwords'                    ))
    ,output(choosen(Xlinkrefs_l_cnpname          .logical ,100),named('Xlinkrefs_l_cnpname'           ))
    ,output(choosen(Xlinkrefs_l_cnpname_st       .logical ,100),named('Xlinkrefs_l_cnpname_st'        ))
    ,output(choosen(Xlinkrefs_l_cnpname_zip      .logical ,100),named('Xlinkrefs_l_cnpname_zip'       ))
    ,output(choosen(Xlinkrefs_l_cnpname_fuzzy    .logical ,100),named('Xlinkrefs_l_cnpname_fuzzy'     ))
    ,output(choosen(Xlinkrefs_l_address1         .logical ,100),named('Xlinkrefs_l_address1'          ))
    ,output(choosen(Xlinkrefs_l_address2         .logical ,100),named('Xlinkrefs_l_address2'          ))
    ,output(choosen(Xlinkrefs_l_address3         .logical ,100),named('Xlinkrefs_l_address3'          ))
    ,output(choosen(Xlinkrefs_l_phone            .logical ,100),named('Xlinkrefs_l_phone'             ))
    ,output(choosen(Xlinkrefs_l_fein             .logical ,100),named('Xlinkrefs_l_fein'              ))
    ,output(choosen(Xlinkrefs_l_contact          .logical ,100),named('Xlinkrefs_l_contact'           ))
    ,output(choosen(Xlinkrefs_l_url              .logical ,100),named('Xlinkrefs_l_url'               ))
    ,output(choosen(Xlinkrefs_l_email            .logical ,100),named('Xlinkrefs_l_email'             ))
    ,output(choosen(Xlinkrefs_l_contact_did      .logical ,100),named('Xlinkrefs_l_contact_did'       ))
    ,output(choosen(Xlinkrefs_l_contact_ssn      .logical ,100),named('Xlinkrefs_l_contact_ssn'       ))
    ,output(choosen(Xlinkrefs_l_source           .logical ,100),named('Xlinkrefs_l_source'            ))
    ,output(choosen(Xlinkwheel_city_clean        .logical ,100),named('Xlinkwheel_city_clean'         ))
    ,output(choosen(Xlinkwheel_quick_city_clean  .logical ,100),named('Xlinkwheel_quick_city_clean'   ))
    ,output(choosen(Xlinkword_cnp_name           .logical ,100),named('Xlinkword_cnp_name'            ))
    ,output(choosen(Xlinkword_company_url        .logical ,100),named('Xlinkword_company_url'         ))
    ,output(choosen(Xlinksup_proxid              .logical ,100),named('Xlinksup_proxid'               ))
    ,output(choosen(Xlinksup_seleid              .logical ,100),named('Xlinksup_seleid'               ))
    ,output(choosen(Xlinksup_orgid               .logical ,100),named('Xlinksup_orgid'                ))
    ,output(choosen(Xlinksup_rcid                .logical ,100),named('Xlinksup_rcid'                 ))
  );       
end;