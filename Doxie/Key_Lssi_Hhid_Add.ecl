//define the lssi update-add key using hhid field
import lssi;

base := lssi.File_Lssi_Daily_Keybuild;

export key_lssi_hhid_add := index(base,
                                  {unsigned6 l_hhid := hhid}, {base},
					         '~thor_data400::key::lssi_hhid_add_' + doxie.Version_SuperKey, OPT);