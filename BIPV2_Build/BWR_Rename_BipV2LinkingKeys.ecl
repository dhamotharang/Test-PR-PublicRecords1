import tools;
packag_name := 'BipV2LinkingKeys';
pversion    := '20121208f';

all_superkeynames := DATASET([
	 {'~thor_data400::key::bipv2_relative::qa'                        ,'~thor_data400::key::proxid::bipv2_relative::@version@::assoc'                 }  
	,{'~thor_data400::key::bipv2_proxid::qa'                          ,'~thor_data400::key::proxid_test::@version@::qa'                               }
	,{'~thor_data400::key::bipv2_xlink_bizhead_qa'                    ,'~thor_data400::key::bipv2_xlink::@version@::bizhead'                          }
	,{'~thor_data400::key::bipv2_xlinkbizheadl_address1refs_qa'       ,'~thor_data400::key::bipv2_xlink::@version@::bizheadl_address1refs'            }
	,{'~thor_data400::key::bipv2_xlinkbizheadl_address2refs_qa'       ,'~thor_data400::key::bipv2_xlink::@version@::bizheadl_address2refs'            }
	,{'~thor_data400::key::bipv2_xlinkbizheadl_cnpnamerefs_qa'        ,'~thor_data400::key::bipv2_xlink::@version@::bizheadl_cnpnamerefs'             }
	,{'~thor_data400::key::bipv2_xlinkbizheadl_contactrefs_qa'        ,'~thor_data400::key::bipv2_xlink::@version@::bizheadl_contactrefs'             }
	,{'~thor_data400::key::bipv2_xlinkbizheadl_emailrefs_qa'          ,'~thor_data400::key::bipv2_xlink::@version@::bizheadl_emailrefs'               }
	,{'~thor_data400::key::bipv2_xlinkbizheadl_feinrefs_qa'           ,'~thor_data400::key::bipv2_xlink::@version@::bizheadl_feinrefs'                }
	,{'~thor_data400::key::bipv2_xlinkbizheadl_phonerefs_qa'          ,'~thor_data400::key::bipv2_xlink::@version@::bizheadl_phonerefs'               }
	,{'~thor_data400::key::bipv2_xlinkbizheadl_sourcerefs_qa'         ,'~thor_data400::key::bipv2_xlink::@version@::bizheadl_sourcerefs'              }
	,{'~thor_data400::key::bipv2_xlinkbizheadl_urlrefs_qa'            ,'~thor_data400::key::bipv2_xlink::@version@::bizheadl_urlrefs'                 }
	,{'~thor_data400::key::bipv2_xlinkbizheadrefs_qa'                 ,'~thor_data400::key::bipv2_xlink::@version@::bizheadrefs'                      }
	,{'~thor_data400::key::bipv2_xlinkbizheadwords_qa'                ,'~thor_data400::key::bipv2_xlink::@version@::bizheadwords'                     }
	,{'~thor_data400::key::values::bipv2_xlink_proxid_cnp_name_qa'    ,'~thor_data400::key::values::bipv2_xlink::@version@::proxid_cnp_name'          }
	,{'~thor_data400::key::values::bipv2_xlink_proxid_company_name_qa','~thor_data400::key::values::bipv2_xlink::@version@::proxid_company_name'      }
	,{'~thor_data400::key::bipv2_proxid::attribute_matches::qa'       ,'~thor_data400::key::proxid::bipv2_proxid::@version@::attribute_matches'       }
	,{'~thor_data400::key::bipv2_proxid::match_candidates_debug::qa'  ,'~thor_data400::key::proxid::bipv2_proxid::@version@::match_candidates_debug'  }
	,{'~thor_data400::key::bipv2_proxid::specificities_debug::qa'     ,'~thor_data400::key::proxid::bipv2_proxid::@version@::specificities_debug'     }
	,{'~thor_data400::bipv2_hrchy::key::proxid_qa'                    ,'~thor_data400::bipv2_hrchy::key::@version@::proxid'                           }
	,{'~thor_data400::bipv2_hrchy::key::lgid_qa'                      ,'~thor_data400::bipv2_hrchy::key::@version@::lgid'                             }
	,{'~thor_data400::key::values::bipv2_xlink_proxid_company_url_qa' ,'~thor_data400::key::values::bipv2_xlink::@version@::proxid_company_url'       }
	,{'~thor_data400::key::zipcityst_qa'                              ,'~thor_data400::key::zipcityst::@version@::zipcityst'                          }
], Tools.Layout_SuperFilenames.InputLayout);
                                                                                                                                                                               
Tools.fun_RenameFiles(all_superkeynames, false,pversion);

