//define the lssi update-add key using the did field
import lssi;
base := lssi.File_Lssi_Daily_Keybuild;
export key_lssi_did_add := index(base,
                                 {unsigned6 l_did := did},{base},
				             '~thor_data400::key::lssi_did_add_' + doxie.Version_SuperKey, OPT);