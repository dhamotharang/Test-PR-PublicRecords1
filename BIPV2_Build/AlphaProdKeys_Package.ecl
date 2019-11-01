﻿//Compile all keys in this package in one place
//easy to output this module to see if keys exist/are correct layout/etc
import BizLinkFull,tools;

EXPORT AlphaProdKeys_Package(

   string   pversion              = 'qa'
  ,boolean	pUseOtherEnvironment	= false
  ,unsigned pKey                  = 0
  ,string   pRegexFieldFilter     = ''

) :=
module

  shared bizbase        := BizLinkFull.File_BizHead;
  shared specs          := BizLinkFull.specificities(bizbase);

  shared bizknames        := BizLinkFull.keynames           (pversion,puseotherenvironment);

  //key definitions
  export Xlinkmeow                      := tools.macf_FilesIndex('BizLinkFull.Process_Biz_Layouts.Key            ' ,bizknames.meow                    );  
  export Xlinkrefs_l_cnpname            := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_CNPNAME.Key          ' ,bizknames.refs_l_cnpname          );  
  export Xlinkrefs_l_cnpname_slim       := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_CNPNAME.SlimKey      ' ,bizknames.refs_l_cnpname_slim     );  
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
  export Xlinkrefs_l_sic                := tools.macf_FilesIndex('BizLinkFull.Key_BizHead_L_SIC.Key              ' ,bizknames.refs_l_sic              );  
                                                                                                                                                          
                                                                                                                                                          
  export outputpackage :=                                                                                                                                     
  sequential(
     output('______________________________________________________________________________')
    ,output('Bizlinkfull keys Follow')
    ,output(0  ,named('KeyNumber'),overwrite)
    ,if(pKey in [0 ,1 ] ,sequential(output(1  ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkmeow                    .logical ,100),named('Xlinkmeow'                     ))))
    ,if(pKey in [0 ,2 ] ,sequential(output(2  ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_cnpname          .logical ,100),named('Xlinkrefs_l_cnpname'           ))))
    ,if(pKey in [0 ,3 ] ,sequential(output(3  ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_cnpname_slim     .logical ,100),named('Xlinkrefs_l_cnpname_slim'      ))))
    ,if(pKey in [0 ,4 ] ,sequential(output(4  ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_cnpname_st       .logical ,100),named('Xlinkrefs_l_cnpname_st'        ))))
    ,if(pKey in [0 ,5 ] ,sequential(output(5  ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_cnpname_zip      .logical ,100),named('Xlinkrefs_l_cnpname_zip'       ))))
    ,if(pKey in [0 ,6 ] ,sequential(output(6  ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_cnpname_fuzzy    .logical ,100),named('Xlinkrefs_l_cnpname_fuzzy'     ))))
    ,if(pKey in [0 ,7 ] ,sequential(output(7  ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_address1         .logical ,100),named('Xlinkrefs_l_address1'          ))))
    ,if(pKey in [0 ,8 ] ,sequential(output(8  ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_address2         .logical ,100),named('Xlinkrefs_l_address2'          ))))
    ,if(pKey in [0 ,9 ] ,sequential(output(9  ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_address3         .logical ,100),named('Xlinkrefs_l_address3'          ))))
    ,if(pKey in [0 ,10] ,sequential(output(10 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_phone            .logical ,100),named('Xlinkrefs_l_phone'             ))))
    ,if(pKey in [0 ,11] ,sequential(output(11 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_fein             .logical ,100),named('Xlinkrefs_l_fein'              ))))
    ,if(pKey in [0 ,12] ,sequential(output(12 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_contact          .logical ,100),named('Xlinkrefs_l_contact'           ))))
    ,if(pKey in [0 ,13] ,sequential(output(13 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_url              .logical ,100),named('Xlinkrefs_l_url'               ))))
    ,if(pKey in [0 ,14] ,sequential(output(14 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_email            .logical ,100),named('Xlinkrefs_l_email'             ))))
    ,if(pKey in [0 ,15] ,sequential(output(15 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_contact_did      .logical ,100),named('Xlinkrefs_l_contact_did'       ))))
    ,if(pKey in [0 ,16] ,sequential(output(16 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_contact_ssn      .logical ,100),named('Xlinkrefs_l_contact_ssn'       ))))
    ,if(pKey in [0 ,17] ,sequential(output(17 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_source           .logical ,100),named('Xlinkrefs_l_source'            ))))
    ,if(pKey in [0 ,18] ,sequential(output(18 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkwheel_city_clean        .logical ,100),named('Xlinkwheel_city_clean'         ))))
    ,if(pKey in [0 ,19] ,sequential(output(19 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkwheel_quick_city_clean  .logical ,100),named('Xlinkwheel_quick_city_clean'   ))))
    ,if(pKey in [0 ,20] ,sequential(output(20 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkword_cnp_name           .logical ,100),named('Xlinkword_cnp_name'            ))))
    ,if(pKey in [0 ,21] ,sequential(output(21 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkword_company_url        .logical ,100),named('Xlinkword_company_url'         ))))
    ,if(pKey in [0 ,22] ,sequential(output(22 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinksup_proxid              .logical ,100),named('Xlinksup_proxid'               ))))
    ,if(pKey in [0 ,23] ,sequential(output(23 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinksup_seleid              .logical ,100),named('Xlinksup_seleid'               ))))
    ,if(pKey in [0 ,24] ,sequential(output(24 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinksup_orgid               .logical ,100),named('Xlinksup_orgid'                ))))
    ,if(pKey in [0 ,25] ,sequential(output(25 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinksup_rcid                .logical ,100),named('Xlinksup_rcid'                 ))))
    ,if(pKey in [0 ,26] ,sequential(output(26 ,named('KeyNumber'),overwrite) ,output(choosen(Xlinkrefs_l_sic              .logical ,100),named('Xlinkrefs_l_sic'               ))))
  );       

end;