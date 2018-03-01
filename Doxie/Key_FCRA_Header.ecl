import mdr,header,_control, data_services;

rm_score := doxie.FCRA_header_pre_keybuild;

export Key_FCRA_Header := INDEX(rm_score, {unsigned6 s_did := did}, {rm_score}-_Control.Layout_KeyExclusions, 
						Data_Services.Data_location.person_header+'thor_data400::key::fcra::header_' + version_superkey, OPT);