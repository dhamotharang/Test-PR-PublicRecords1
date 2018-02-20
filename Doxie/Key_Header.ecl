import mdr,ut,header,_control, data_services;

rm_score := doxie.header_pre_keybuild;

export Key_Header := INDEX(rm_score, {unsigned6 s_did := did}, {rm_score}-_Control.Layout_KeyExclusions, 
						Data_Services.Data_location.person_header+'thor_data400::key::header_' + version_superkey, OPT);