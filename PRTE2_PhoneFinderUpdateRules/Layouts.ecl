EXPORT Layouts := MODULE
 
    EXPORT layout_phonefinder_update_rules_base := RECORD 
					STRING 	phone_number	;
					STRING		last_port_dt_rule	;
					STRING		last_spoof_dt_rule	;
					STRING		first_seen_dt_rule	;
					STRING		last_seen_dt_rule	;
					STRING		deact_dt_rule	;
				END;
				
END;