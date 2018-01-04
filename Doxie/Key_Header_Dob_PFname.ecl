IMPORT doxie, data_services;

ds_ready := doxie.file_header_dob_fname;

EXPORT Key_Header_Dob_PFname := INDEX (ds_ready, {pf2:=pfname[1..2], dob, pfname, st, zip}, {did}, 
                                       data_services.data_location.prefix() + 'thor_data400::key::header.dob_pfname_' + doxie.version_superkey, OPT);
