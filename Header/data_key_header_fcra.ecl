import dx_Header, ut, doxie, strata; //_control, data_services, 

rm_score0 := doxie.FCRA_header_pre_keybuild;

ut.MAC_CLEAR_FIELDS(rm_score0,rm_score1,'death_code');

report_blanks := output(strata.macf_pops(rm_score1,,,,,,FALSE,['death_code']),named('verify_fcra_suppression_key_data'));

rm_score := rm_score1 : success(report_blanks);

EXPORT data_key_header_fcra := PROJECT (rm_score, TRANSFORM (dx_Header.layout_key_header,
                                                             SELF.s_did := LEFT.did, SELF := LEFT));
// INDEX(rm_score, {unsigned6 s_did := did}, {rm_score}-_Control.Layout_KeyExclusions, 
// 						data_services.foreign_prod+'thor_data400::key::fcra::header_0::header_' + version_superkey, OPT);
