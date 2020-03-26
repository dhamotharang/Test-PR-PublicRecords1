IMPORT UT,_Control,doxie,header; 

rm_score0  := header.fn_persistent_record_ID(doxie.header_pre_keybuild) ; 

rm_score := PROJECT(rm_score0, TRANSFORM({rm_score0 , UNSIGNED4 DT_EFFECTIVE_FIRST, UNSIGNED4	DT_EFFECTIVE_LAST := 0}, 
                                 SELF.DT_EFFECTIVE_FIRST := 20160101, 
                                 SELF := LEFT
                                 )); 

rm_score_ccpa_compliant := header.fn_suppress_ccpa(rm_score,true);

EXPORT Key_InsuranceHeader_DID := INDEX(rm_score_ccpa_compliant, {unsigned6 s_did := did}, {rm_score_ccpa_compliant}-_Control.Layout_KeyExclusions, 
						                      '~thor_data400::key::insuranceheader_xlink::' + doxie.Version_SuperKey + '::did' );

