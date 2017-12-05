//Compile all keys for bizlinkfull in one place
//easy to output this module to see if keys exist/are correct layout/etc
import bipv2,BIPV2_Company_Names,TopBusiness_BIPV2,BIPV2_ProxID,BIPV2_Best,BIPV2_Relative,BizLinkFull,tools,BIPV2_Seleid_Relative,BIPV2_LGID3,Address_Attributes,BIPv2_HRCHY;

EXPORT _Keys(

   string   pversion              = 'qa'
  ,boolean	pUseOtherEnvironment	= false

) :=
module

  shared bizbase        := BizLinkFull.File_BizHead;
  shared specs          := BizLinkFull.specificities(bizbase);

  shared bizknames        := BizLinkFull.keynames           (pversion,puseotherenvironment);

  //key definitions
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
  export Xlinkrefs_l_sic                := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_SIC.Key              ' ,bizknames.refs_l_sic               );

  export outputkeys := 
  parallel(
     output('______________________________________________________________________________')
    ,output(choosen(Xlinkmeow                    .logical ,100),named('Xlinkmeow'                     ))
    ,output(choosen(Xlinkrefs                    .logical ,100),named('Xlinkrefs'                     ))
    ,output(choosen(Xlinkwords                   .logical ,100),named('Xlinkwords'                    ))
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
    ,output(choosen(Xlinkrefs_l_sic              .logical ,100),named('Xlinkrefs_l_sic'               ))
  );       
end;
