IMPORT doxie, dx_Header;

ds_ready := doxie.file_header_dob_fname;

// file is shared between dx_Header/key_DOB_fname and dx_Header/key_DOB_pfname
EXPORT data_key_DOB_Fname := PROJECT (ds_ready, TRANSFORM (dx_Header.layouts.i_dob_fname,
                                                           SELF.f2 := LEFT.fname[1..2],
                                                           SELF.pf2 := LEFT.pfname[1..2],
                                                           SELF := LEFT));

//EXPORT Key_Header_Dob_Fname := INDEX (ds_ready, {f2:=fname[1..2], dob, fname, st, zip}, {did}, 
//                                      '~thor_data400::key::header.dob_fname_' + doxie.version_superkey, OPT);
