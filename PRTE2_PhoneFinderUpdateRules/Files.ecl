EXPORT Files := module

			EXPORT phonefinder_update_rules_in		 := DATASET(constants.in_phonefinder_update_rules, Layouts.layout_phonefinder_update_rules_base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
   EXPORT phonefinder_update_rules_base := DATASET(constants.base_phonefinder_update_rules, Layouts.layout_phonefinder_update_rules_base, FLAT );

END;