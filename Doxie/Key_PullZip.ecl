import ut;

export Key_PullZip := index(doxie.File_pullZip(zip = 'ABCDEF'), 
                           {zip}, 
													 {zip},
													 '~thor_data400::key::pullZip_' + doxie.Version_SuperKey);