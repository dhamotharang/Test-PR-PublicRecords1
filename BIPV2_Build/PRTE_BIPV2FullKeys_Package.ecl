// BIPV2_Build.PRTE_BIPV2FullKeys_Package('20150810a').outputpackage;
// Compile all keys in this package in one place
// easy to output this module to see if keys exist/are correct layout/etc
// BIPV2_Build.BWR_Check_PRTE_BIPV2FullKeys -- checks all of these keys in different wuids so you don't have to sandbox anything to figure out all the offending keys
// PRTE_BIP.PRTE_Proc_Build_BIP_Header_keys -- this builds these keys

import bipv2,BIPV2_Company_Names,TopBusiness_BIPV2,BIPV2_ProxID,BIPV2_Best,BIPV2_Relative,BizLinkFull,tools,BIPV2_Seleid_Relative,BIPV2_LGID3,Address_Attributes,BIPv2_HRCHY;

EXPORT PRTE_BIPV2FullKeys_Package(

   string   pversion              = 'qa'
  ,boolean	pUseOtherEnvironment	= false
  ,unsigned pKey                  = 0

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
  shared HrchyKnames      := BIPv2_HRCHY.Keynames           (pversion,puseotherenvironment);

  shared toPRTE(string pfilename) := regexreplace('thor_data400',pfilename,'prte',nocase);

  //key definitions
  export strnbr                         := dataset('~prte::bip_v2::' + pversion + '::strnbrname',recordof(BIPV2_Company_Names.files.StrNbr_SF_DS),flat);  //file, not key, but it is in the package file
  export license_linkids                := index(TopBusiness_BIPV2.Key_License_Linkids.key  ,toPRTE(TopBusiness_BIPV2.keynames(pversion,pUseOtherEnvironment).License_LinkIds.logical));
  export industry_linkids               := index(TopBusiness_BIPV2.Key_Industry_Linkids.key  ,toPRTE(TopBusiness_BIPV2.keynames(pversion,pUseOtherEnvironment).Industry_LinkIds.logical));
  export linkids                        := index(BIPV2.Key_BH_Linking_Ids.key                    ,toPRTE(knames.linkids                    .logical));
  export translations                   := index(BIPV2_Company_Names.files.TranslationsKey       ,toPRTE(knames.translations               .logical));
  export ZipCitySt                      := index(BIPV2_Build.keys     ().ZipCitySt.qa               ,toPRTE(keynames(pversion,pUseOtherEnvironment).zipcityst    .logical));
  export Status                         := index(BIPV2.key_Status.key                         ,toPRTE(keynames(pversion,pUseOtherEnvironment).status       .logical));
  export proxid_mtch_cand               := index(BIPV2_ProxID.Keys().Candidates                  ,toPRTE(proxknames.match_candidates_debug .logical));
  export proxid_specs                   := index(BIPV2_ProxID.Keys().Specificities_Key           ,toPRTE(proxknames.specificities_debug    .logical));
  export proxid_atts                    := index(BIPV2_ProxID.Keys().Attribute_Matches           ,toPRTE(proxknames.Attribute_Matches      .logical));
  export lgid3_mtch_cand                := index(BIPV2_LGID3.Keys2().MatchCandidates.qa             ,toPRTE(lgid3knames.match_candidates_debug  .logical));
  export lgid3_specs                    := index(BIPV2_LGID3.Keys2().Specificity.qa                 ,toPRTE(lgid3knames.specificities_debug   .logical));
  export best_linkids                   := index(BIPV2_Best.Key_LinkIds.key                      ,toPRTE(bestknames.LinkIds                .logical));
  // export relative_assoc                 := index(BIPv2_Relative.keys(relbase).ASSOC              ,toPRTE(relknames.assoc                   .logical));
  export Seleid_relative_assoc          := index(BIPV2_Seleid_Relative.keys(Seleidrelbase).ASSOC ,toPRTE(Seleidrelknames.assoc             .logical));
  export Xlinkmeow                      := index(BizLinkFull.Process_Biz_Layouts.Key             ,toPRTE(bizknames.meow                    .logical));
  // export Xlinkrefs                      := index(BizLinkFull.Key_BizHead_.Key                    ,toPRTE(bizknames.refs                    .logical));
  // export Xlinkwords                     := index(BizLinkFull.Key_BizHead_.ValueKey               ,toPRTE(bizknames.words                   .logical));
  export Xlinkrefs_l_cnpname            := index(BizLinkFull.Key_BizHead_L_CNPNAME.Key           ,toPRTE(bizknames.refs_l_cnpname          .logical));
  export Xlinkrefs_l_cnpname_st         := index(BizLinkFull.Key_BizHead_L_CNPNAME_ST.Key        ,toPRTE(bizknames.refs_l_cnpname_st       .logical));
  export Xlinkrefs_l_cnpname_zip        := index(BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.Key       ,toPRTE(bizknames.refs_l_cnpname_zip      .logical));
  export Xlinkrefs_l_cnpname_fuzzy      := index(BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.Key     ,toPRTE(bizknames.refs_l_cnpname_fuzzy    .logical));
  export Xlinkrefs_l_address1           := index(BizLinkFull.Key_BizHead_L_ADDRESS1.Key          ,toPRTE(bizknames.refs_l_address1         .logical));
  export Xlinkrefs_l_address2           := index(BizLinkFull.Key_BizHead_L_ADDRESS2.Key          ,toPRTE(bizknames.refs_l_address2         .logical));
  export Xlinkrefs_l_address3           := index(BizLinkFull.Key_BizHead_L_ADDRESS3.Key          ,toPRTE(bizknames.refs_l_address3         .logical));
  export Xlinkrefs_l_phone              := index(BizLinkFull.Key_BizHead_L_PHONE.Key             ,toPRTE(bizknames.refs_l_phone            .logical));
  export Xlinkrefs_l_fein               := index(BizLinkFull.Key_BizHead_L_FEIN.Key              ,toPRTE(bizknames.refs_l_fein             .logical));
  export Xlinkrefs_l_contact            := index(BizLinkFull.Key_BizHead_L_CONTACT.Key           ,toPRTE(bizknames.refs_l_contact          .logical));
  export Xlinkrefs_l_url                := index(BizLinkFull.Key_BizHead_L_URL.Key               ,toPRTE(bizknames.refs_l_url              .logical));
  export Xlinkrefs_l_email              := index(BizLinkFull.Key_BizHead_L_EMAIL.Key             ,toPRTE(bizknames.refs_l_email            .logical));
  export Xlinkrefs_l_contact_did        := index(BizLinkFull.Key_BizHead_L_CONTACT_DID.Key       ,toPRTE(bizknames.refs_l_contact_did      .logical));
  export Xlinkrefs_l_contact_ssn        := index(BizLinkFull.Key_BizHead_L_CONTACT_SSN.Key       ,toPRTE(bizknames.refs_l_contact_ssn      .logical));
  export Xlinkrefs_l_source             := index(BizLinkFull.Key_BizHead_L_SOURCE.Key            ,toPRTE(bizknames.refs_l_source           .logical));
  export Xlinkwheel_city_clean          := index(BizLinkFull.Wheel.Key_city_clean                ,toPRTE(bizknames.wheel_city_clean        .logical));
  export Xlinkwheel_quick_city_clean    := index(BizLinkFull.Wheel.KeyQuick_city_clean           ,toPRTE(bizknames.wheel_quick_city_clean  .logical));
  export Xlinkword_cnp_name             := index(specs.cnp_name_values_key                       ,toPRTE(bizknames.word_cnp_name           .logical));
  export Xlinkword_company_url          := index(specs.company_url_values_key                    ,toPRTE(bizknames.word_company_url        .logical));
  export Xlinksup_proxid                := index(BizLinkFull.Process_Biz_Layouts.KeyproxidUp     ,toPRTE(bizknames.sup_proxid              .logical));
  export Xlinksup_seleid                := index(BizLinkFull.Process_Biz_Layouts.KeyseleidUp     ,toPRTE(bizknames.sup_seleid              .logical));
  export Xlinksup_orgid                 := index(BizLinkFull.Process_Biz_Layouts.KeyorgidUp      ,toPRTE(bizknames.sup_orgid               .logical));
  export Xlinksup_rcid                  := index(BizLinkFull.Process_Biz_Layouts.KeyIDHistory    ,toPRTE(bizknames.sup_rcid                .logical));
  export HrchyProxid                    := index(BIPv2_HRCHY.Keys().HrchyProxid.qa               ,toPRTE(HrchyKnames.HrchyProxid   .logical));
  export HrchyLgid                      := index(BIPv2_HRCHY.Keys().HrchyLgid  .qa               ,toPRTE(HrchyKnames.HrchyLgid     .logical));
  export AML_Addr                       := index(Address_Attributes.key_AML_addr                 ,toPRTE(keynames(pversion).aml_addr.logical     ));                                                                                                                                                            
  export biz_preferred                  := index(BIPV2_Company_Names.key_preferred               ,toPRTE(keynames(pversion).biz_preferred.logical     ));
  export Xlinkrefs_l_sic                := index(BizLinkFull.Key_BizHead_L_SIC.Key               ,toPRTE(bizknames.refs_l_sic             .logical));
  // export relative_assoc                 := index(BIPV2_Relative.keys(dataset()).ASSOC ,toPRTE(Relknames.assoc                  .logical));

  export outputpackage := 
  parallel(
     output('______________________________________________________________________________')
    ,output('BIPV2FullKeys Package Follows')
    ,if(pKey in [0 ,1 ] ,output(choosen(strnbr                        ,100),named('strnbrFile'                    )))
    ,if(pKey in [0 ,2 ] ,output(choosen(license_linkids               ,100),named('license_linkids'               )))
    ,if(pKey in [0 ,3 ] ,output(choosen(industry_linkids              ,100),named('industry_linkids'              )))
    ,if(pKey in [0 ,4 ] ,output(choosen(linkids                       ,100),named('linkids'                       )))
    ,if(pKey in [0 ,5 ] ,output(choosen(translations                  ,100),named('translations'                  )))
    ,if(pKey in [0 ,6 ] ,output(choosen(ZipCitySt                     ,100),named('ZipCitySt'                     )))
    ,if(pKey in [0 ,7 ] ,output(choosen(Status                        ,100),named('Status'                        )))
    ,if(pKey in [0 ,8 ] ,output(choosen(proxid_mtch_cand              ,100),named('proxid_mtch_cand'              ))) //for giri
    ,if(pKey in [0 ,9 ] ,output(choosen(proxid_specs                  ,100),named('proxid_specs'                  )))
    ,if(pKey in [0 ,10] ,output(choosen(proxid_atts                   ,100),named('proxid_atts'                   )))
    ,if(pKey in [0 ,11] ,output(choosen(lgid3_mtch_cand               ,100),named('lgid3_mtch_cand'               )))
    ,if(pKey in [0 ,12] ,output(choosen(lgid3_specs                   ,100),named('lgid3_specs'                   )))
    ,if(pKey in [0 ,13] ,output(choosen(best_linkids                  ,100),named('best_linkids'                  )))
    // ,if(pKey in [0 ,14] ,output(choosen(relative_assoc                ,100),named('relative_assoc'                )))
    ,if(pKey in [0 ,15] ,output(choosen(Seleid_relative_assoc         ,100),named('Seleid_relative_assoc'         )))
    ,if(pKey in [0 ,16] ,output(choosen(Xlinkmeow                     ,100),named('Xlinkmeow'                     )))
    // ,if(pKey in [0 ,17] ,output(choosen(Xlinkrefs                     ,100),named('Xlinkrefs'                     )))
    // ,if(pKey in [0 ,18] ,output(choosen(Xlinkwords                    ,100),named('Xlinkwords'                    )))
    ,if(pKey in [0 ,19] ,output(choosen(Xlinkrefs_l_cnpname           ,100),named('Xlinkrefs_l_cnpname'           )))
    ,if(pKey in [0 ,20] ,output(choosen(Xlinkrefs_l_cnpname_st        ,100),named('Xlinkrefs_l_cnpname_st'        )))
    ,if(pKey in [0 ,21] ,output(choosen(Xlinkrefs_l_cnpname_zip       ,100),named('Xlinkrefs_l_cnpname_zip'       )))
    ,if(pKey in [0 ,22] ,output(choosen(Xlinkrefs_l_cnpname_fuzzy     ,100),named('Xlinkrefs_l_cnpname_fuzzy'     )))
    ,if(pKey in [0 ,23] ,output(choosen(Xlinkrefs_l_address1          ,100),named('Xlinkrefs_l_address1'          )))
    ,if(pKey in [0 ,24] ,output(choosen(Xlinkrefs_l_address2          ,100),named('Xlinkrefs_l_address2'          )))
    ,if(pKey in [0 ,25] ,output(choosen(Xlinkrefs_l_address3          ,100),named('Xlinkrefs_l_address3'          )))
    ,if(pKey in [0 ,26] ,output(choosen(Xlinkrefs_l_phone             ,100),named('Xlinkrefs_l_phone'             )))
    ,if(pKey in [0 ,27] ,output(choosen(Xlinkrefs_l_fein              ,100),named('Xlinkrefs_l_fein'              )))
    ,if(pKey in [0 ,28] ,output(choosen(Xlinkrefs_l_contact           ,100),named('Xlinkrefs_l_contact'           )))
    ,if(pKey in [0 ,29] ,output(choosen(Xlinkrefs_l_url               ,100),named('Xlinkrefs_l_url'               )))
    ,if(pKey in [0 ,30] ,output(choosen(Xlinkrefs_l_email             ,100),named('Xlinkrefs_l_email'             )))
    ,if(pKey in [0 ,31] ,output(choosen(Xlinkrefs_l_contact_did       ,100),named('Xlinkrefs_l_contact_did'       )))
    ,if(pKey in [0 ,32] ,output(choosen(Xlinkrefs_l_contact_ssn       ,100),named('Xlinkrefs_l_contact_ssn'       )))
    ,if(pKey in [0 ,33] ,output(choosen(Xlinkrefs_l_source            ,100),named('Xlinkrefs_l_source'            )))
    ,if(pKey in [0 ,34] ,output(choosen(Xlinkwheel_city_clean         ,100),named('Xlinkwheel_city_clean'         )))
    ,if(pKey in [0 ,35] ,output(choosen(Xlinkwheel_quick_city_clean   ,100),named('Xlinkwheel_quick_city_clean'   )))
    ,if(pKey in [0 ,36] ,output(choosen(Xlinkword_cnp_name            ,100),named('Xlinkword_cnp_name'            )))
    ,if(pKey in [0 ,37] ,output(choosen(Xlinkword_company_url         ,100),named('Xlinkword_company_url'         )))
    ,if(pKey in [0 ,38] ,output(choosen(Xlinksup_proxid               ,100),named('Xlinksup_proxid'               )))
    ,if(pKey in [0 ,39] ,output(choosen(Xlinksup_seleid               ,100),named('Xlinksup_seleid'               )))
    ,if(pKey in [0 ,40] ,output(choosen(Xlinksup_orgid                ,100),named('Xlinksup_orgid'                )))
    ,if(pKey in [0 ,41] ,output(choosen(Xlinksup_rcid                 ,100),named('Xlinksup_rcid'                 )))
    ,if(pKey in [0 ,42] ,output(choosen(HrchyProxid                   ,100),named('HrchyProxid'                   )))
    ,if(pKey in [0 ,43] ,output(choosen(HrchyLgid                     ,100),named('HrchyLgid'                     )))
    ,if(pKey in [0 ,44] ,output(choosen(AML_Addr                      ,100),named('AML_Addr'                      )))
    ,if(pKey in [0 ,45] ,output(choosen(biz_preferred                 ,100),named('biz_preferred'                 )))
    ,if(pKey in [0 ,46] ,output(choosen(Xlinkrefs_l_sic               ,100),named('Xlinkrefs_l_sic'               )))
    // ,output(choosen(relative_assoc                ,100),named('relative_assoc'                ))
  );       
end;