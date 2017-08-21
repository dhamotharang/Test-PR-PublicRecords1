//define the key using hhid field
base:=lssi.File_Lssi_Weekly_keybuild;
export key_hhid := index(base,
                         {unsigned6 l_hhid := hhid}, {base},
					'~thor_data400::key::lssi_hhid' + thorlib.WUID());