import _Control, Data_Services, doxie, prte2_header, header; 

rm_score0  := header.fn_persistent_record_ID(PRTE2_Header.pre_keys.header_FCRA_pre_keybuild); 

rm_score := PROJECT(rm_score0, TRANSFORM(Layouts.insuranceheader_xlink_did, /*UNSIGNED4 DT_EFFECTIVE_FIRST, UNSIGNED4	DT_EFFECTIVE_LAST := 0},*/ 
                                 SELF.DT_EFFECTIVE_FIRST := 20160101, 
                                 SELF := LEFT;
														 		 SELF := [];
                                 )); 

EXPORT key_insuranceheader_xlink_did := INDEX(rm_score, {unsigned6 s_did := did}, {rm_score}-_Control.Layout_KeyExclusions, 
																																													Data_Services.Data_location.prefix('PRTE')+'~prte::key::insuranceheader_xlink::'+ doxie.Version_SuperKey+'::did');