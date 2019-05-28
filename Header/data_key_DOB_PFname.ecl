IMPORT doxie, dx_Header;

ds_ready := doxie.file_header_dob_fname;

EXPORT data_key_DOB_PFname := PROJECT (ds_ready, dx_Header.layouts.i_dob_fname);

//EXPORT Key_Header_Dob_PFname := INDEX (ds_ready, {pf2:=pfname[1..2], dob, pfname, st, zip}, {did}, 
//                                       '~thor_data400::key::header.dob_pfname_' + doxie.version_superkey, OPT);
