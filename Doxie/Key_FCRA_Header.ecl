import mdr,ut,header,_control;

rm_score := doxie.FCRA_header_pre_keybuild;

export Key_FCRA_Header := INDEX(rm_score, {unsigned6 s_did := did}, {rm_score}-_Control.Layout_KeyExclusions, 
						ut.Data_Location.Person_header+'thor_data400::key::fcra::header_' + version_superkey, OPT);