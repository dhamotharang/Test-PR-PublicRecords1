import doxie, dx_Header;

rm_score := doxie.header_pre_keybuild;

export data_key_header := PROJECT (rm_score, TRANSFORM (dx_Header.layout_key_header,
                                                        SELF.s_did := LEFT.did, SELF := LEFT));
//INDEX(rm_score, {unsigned6 s_did := did}, {rm_score}-_Control.Layout_KeyExclusions, 
//						data_services.Data_Location.Person_header+'thor_data400::key::header_' + version_superkey, OPT);