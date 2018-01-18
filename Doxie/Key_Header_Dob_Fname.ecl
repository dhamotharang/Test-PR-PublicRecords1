IMPORT doxie, data_services;

ds_ready := doxie.file_header_dob_fname;

EXPORT Key_Header_Dob_Fname := INDEX (ds_ready, 
                                      {f2:=fname[1..2], dob, fname, st, zip}, 
                                      {did}, 
                                      data_services.data_location.prefix() + 'thor_data400::key::header.dob_fname_' + doxie.version_superkey, OPT);