import tools;

packag_name := 'BipV2SearchKeys';
pversion    := '20130212b';
thorcluster := tools.fun_Groupname('92');
proddali    := _Control.IPAddress.prod_thor_dali;
istesting   := false;

/*
thor400_20
thor400_84
thor400_92
*/
#workunit('name',packag_name + ' ' + pversion + ' Copy & Rename Keys to ' + thorcluster);

FilesToCopy := DATASET([

    {'~thor_data400::key::bizlinkfull::qa::proxid::meow'                      ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::meow'                          ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::meow'                     }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::refs'                      ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::refs'                          ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::refs'                     }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_address1'          ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::refs::l_address1'              ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::refs::l_address1'         }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_address2'          ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::refs::l_address2'              ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::refs::l_address2'         }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_address3'          ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::refs::l_address3'              ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::refs::l_address3'         }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_cnpname'           ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::refs::l_cnpname'               ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::refs::l_cnpname'          }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_cnpname_st'        ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::refs::l_cnpname_st'            ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::refs::l_cnpname_st'       }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_contact'           ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::refs::l_contact'               ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::refs::l_contact'          }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_contact_ssn'       ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::refs::l_contact_ssn'           ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::refs::l_contact_ssn'      }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_email'             ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::refs::l_email'                 ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::refs::l_email'            }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_fein'              ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::refs::l_fein'                  ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::refs::l_fein'             }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_phone'             ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::refs::l_phone'                 ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::refs::l_phone'            }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_source'            ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::refs::l_source'                ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::refs::l_source'           }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::refs::l_url'               ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::refs::l_url'                   ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::refs::l_url'              }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::wheel::company_name'       ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::wheel::company_name'           ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::wheel::company_name'      }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::wheel::p_city_name'        ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::wheel::p_city_name'            ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::wheel::p_city_name'       }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::wheel_quick::company_name' ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::wheel_quick::company_name'     ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::wheel_quick::company_name'}],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::wheel_quick::p_city_name'  ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::wheel_quick::p_city_name'      ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::wheel_quick::p_city_name' }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::word::cnp_name'            ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::word::cnp_name'                ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::word::cnp_name'           }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::word::company_name'        ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::word::company_name'            ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::word::company_name'       }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::word::company_url'         ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::word::company_url'             ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::word::company_url'        }],lib_fileservices.FsLogicalFileNameRecord)}
   ,{'~thor_data400::key::bizlinkfull::qa::proxid::words'                     ,'~' + thorcluster + '::key::bizlinkfull::' + pversion + '::proxid::words'                         ,thorcluster ,proddali  ,dataset([{'~' + thorcluster + '::key::bizlinkfull::qa::proxid::words'                    }],lib_fileservices.FsLogicalFileNameRecord)}

], Tools.Layout_fun_CopyFiles.Input);

Tools.fun_CopyFiles(FilesToCopy,,istesting);																			
