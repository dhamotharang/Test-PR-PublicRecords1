export Debt_SettlementKeys := macro
output(choosen(Debt_Settlement.Keys().Bdid.qa,10));
output(choosen(Debt_Settlement.Keys().payload.qa,10));
output(choosen(AutokeyB2.Key_Address('~thor_data400::key::debt_settlement::qa::autokey::'),10));
output(choosen(AutoKeyB2.Key_CityStName('~thor_data400::key::debt_settlement::qa::autokey::'),10));

output(choosen(AutoKeyB2.key_name('~thor_data400::key::debt_settlement::qa::autokey::'),10));
output(choosen(AutoKeyB2.Key_NameWords('~thor_data400::key::debt_settlement::qa::autokey::'),10));
output(choosen(AutoKeyB2.key_phone('~thor_data400::key::debt_settlement::qa::autokey::'),10));
output(choosen(AutoKeyB2.Key_StName('~thor_data400::key::debt_settlement::qa::autokey::'),10));
output(choosen(AutoKeyB2.Key_Zip('~thor_data400::key::debt_settlement::qa::autokey::'),10));

endmacro;