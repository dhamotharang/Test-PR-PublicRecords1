//define the lssi update-add key using hhid field
import lssi;

export key_lssi_hhid_add := index(lssi.file_hhid_did_add(hhid<>0, trim(clean_phone)<>''),
                                  {unsigned6 l_hhid := hhid}, {lssi.file_hhid_did_add},
					         '~thor_data400::key::lssi_hhid_add_' + doxie.Version_SuperKey, OPT);