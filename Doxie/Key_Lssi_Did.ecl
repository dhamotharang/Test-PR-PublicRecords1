//define the lssi full file key using the did field
import lssi;

export key_lssi_did := index(lssi.file_hhid_did_lssi(did<>0, trim(clean_phone)<>''),
                        {unsigned6 l_did := did},{lssi.file_hhid_did_lssi},
				    '~thor_data400::key::lssi_did_key_' + doxie.Version_SuperKey);