import doxie, data_services;

f := DCA.File_DCA_Base_bdid;

export Key_DCA_Root_Sub := index(f,
                                 {root, sub},
                                 {f},
                                 data_services.data_location.prefix() + 'thor_data400::key::dca_root_sub_'+doxie.Version_SuperKey);
