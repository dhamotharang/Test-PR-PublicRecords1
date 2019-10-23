IMPORT PRTE2_PhoneFinderUpdateRules, PromoteSupers;

EXPORT proc_build_base(String filedate) := FUNCTION

	set_valid_rules := SET(PRTE2_PhoneFinderUpdateRules.fn_GetDate.valid_override_rules,override_rule);
 
	
 err_msg(string phone_number, string field_name, string field_value) := FUNCTION
 				msg := 'PRTE2_PhoneFinderUpdateRules.proc_build_base: Phone number ' + phone_number + ' has an invalid value "' + field_value + '" for field name ' + field_name + '.';
				RETURN msg;
	END; 
	
	
	df_in	:= PRTE2_PhoneFinderUpdateRules.Files.phonefinder_update_rules_in;
	
	
	df_base := PROJECT(df_in, TRANSFORM(PRTE2_PhoneFinderUpdateRules.Layouts.layout_phonefinder_update_rules_base,
												SELF.last_port_dt_rule := IF(LEFT.last_port_dt_rule in set_valid_rules, LEFT.last_port_dt_rule, error(err_msg(LEFT.phone_number, 'last_port_dt_rule', LEFT.last_port_dt_rule)));
												SELF.last_spoof_dt_rule := IF(LEFT.last_spoof_dt_rule in set_valid_rules, LEFT.last_spoof_dt_rule, error(err_msg(LEFT.phone_number, 'last_spoof_dt_rule', LEFT.last_spoof_dt_rule)));
												SELF.first_seen_dt_rule := IF(LEFT.first_seen_dt_rule in set_valid_rules, LEFT.first_seen_dt_rule, error(err_msg(LEFT.phone_number, 'first_seen_dt_rule', LEFT.first_seen_dt_rule)));
												SELF.last_seen_dt_rule := IF(LEFT.last_seen_dt_rule in set_valid_rules, LEFT.last_seen_dt_rule, error(err_msg(LEFT.phone_number, 'last_seen_dt_rule', LEFT.last_seen_dt_rule)));
												SELF.deact_dt_rule := IF(LEFT.deact_dt_rule in set_valid_rules, LEFT.deact_dt_rule, error(err_msg(LEFT.phone_number, 'deact_dt_rule', LEFT.deact_dt_rule)));
												SELF := LEFT)
																				);

					
	PromoteSupers.MAC_SF_BuildProcess(df_base,PRTE2_PhoneFinderUpdateRules.Constants.base_phonefinder_update_rules, writefile);

	RETURN writefile;


END;