//define the key using did field

export key_did := index(file_hhid_did_lssi(did<>0, trim(clean_phone)<>''),
                        {unsigned6 l_did := did},{file_hhid_did_lssi},
				    '~thor_data400::key::lssi_did' + thorlib.WUID());