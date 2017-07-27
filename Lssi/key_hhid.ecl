//define the key using hhid field

export key_hhid := index(file_hhid_did_lssi(hhid<>0, trim(clean_phone)<>''),
                         {unsigned6 l_hhid := hhid}, {file_hhid_did_lssi},
					'~thor_data400::key::lssi_hhid' + thorlib.WUID());