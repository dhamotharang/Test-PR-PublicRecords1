import tools;

packag_name := 'BipV2SearchKeys';
pversion    := '20121208f';

all_superkeynames := DATASET([
	 {'~thor_data400::key::bizlinkfull::qa::proxid::meow'                      ,'~thor_data400::key::bizlinkfull::@version@::proxid::meow'                        }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::refs'                      ,'~thor_data400::key::bizlinkfull::@version@::proxid::refs'                        }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_address1'          ,'~thor_data400::key::bizlinkfull::@version@::proxid::refs::l_address1'            }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_address2'          ,'~thor_data400::key::bizlinkfull::@version@::proxid::refs::l_address2'            }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_address3'          ,'~thor_data400::key::bizlinkfull::@version@::proxid::refs::l_address3'            }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_cnpname'           ,'~thor_data400::key::bizlinkfull::@version@::proxid::refs::l_cnpname'             }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_cnpname_st'        ,'~thor_data400::key::bizlinkfull::@version@::proxid::refs::l_cnpname_st'          }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_contact'           ,'~thor_data400::key::bizlinkfull::@version@::proxid::refs::l_contact'             }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_contact_ssn'       ,'~thor_data400::key::bizlinkfull::@version@::proxid::refs::l_contact_ssn'         }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_email'             ,'~thor_data400::key::bizlinkfull::@version@::proxid::refs::l_email'               }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_fein'              ,'~thor_data400::key::bizlinkfull::@version@::proxid::refs::l_fein'                }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_phone'             ,'~thor_data400::key::bizlinkfull::@version@::proxid::refs::l_phone'               }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_source'            ,'~thor_data400::key::bizlinkfull::@version@::proxid::refs::l_source'              }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_url'               ,'~thor_data400::key::bizlinkfull::@version@::proxid::refs::l_url'                 }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::wheel::company_name'       ,'~thor_data400::key::bizlinkfull::@version@::proxid::wheel::company_name'         }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::wheel::p_city_name'        ,'~thor_data400::key::bizlinkfull::@version@::proxid::wheel::p_city_name'          }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::wheel_quick::company_name' ,'~thor_data400::key::bizlinkfull::@version@::proxid::wheel_quick::company_name'   }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::wheel_quick::p_city_name'  ,'~thor_data400::key::bizlinkfull::@version@::proxid::wheel_quick::p_city_name'    }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::word::cnp_name'            ,'~thor_data400::key::bizlinkfull::@version@::proxid::word::cnp_name'              }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::word::company_name'        ,'~thor_data400::key::bizlinkfull::@version@::proxid::word::company_name'          }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::word::company_url'         ,'~thor_data400::key::bizlinkfull::@version@::proxid::word::company_url'           }
	,{'~thor_data400::key::bizlinkfull::qa::proxid::words'                     ,'~thor_data400::key::bizlinkfull::@version@::proxid::words'                       }
], Tools.Layout_SuperFilenames.InputLayout);
                                                                                                                                                                               
Tools.fun_RenameFiles(all_superkeynames, false,pversion);