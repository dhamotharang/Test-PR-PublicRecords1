//define the key using did field
import doxie;
base :=lssi.File_Lssi_Weekly_keybuild;
export key_did := index(base,
                        {unsigned6 l_did := did},{base},
				    '~thor_data400::key::lssi_did' + thorlib.WUID() );