import doxie, data_services;

f := DCA.File_DCA_Base_bdid(bdid <> 0);

export Key_DCA_BDID := index(f,
                             {bdid},
                             {f},
                             data_services.data_location.prefix() + 'thor_data400::key::dca_bdid_'+doxie.Version_SuperKey);
