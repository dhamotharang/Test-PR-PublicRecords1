import data_services;

export Key_PullZip := index(doxie.File_pullZip, 
                           {zip}, 
													 {zip},
													 data_services.data_location.prefix() + 'thor_data400::key::pullZip_' + doxie.Version_SuperKey);