export TaxproKeys := macro
	output(choosen(Taxpro.key_did,10));
output(choosen(Taxpro.key_bdid,10));
output(choosen(Taxpro.key_tmsid,10));
output(choosen(Taxpro.key_payload,10));
output(choosen(autokey.key_address('~thor_data400::key::Taxpro::qa::autokey::'),10));
output(choosen(autokeyb2.key_address('~thor_data400::key::Taxpro::qa::autokey::'),10));
output(choosen(autokey.key_citystname('~thor_data400::key::Taxpro::qa::autokey::'),10));
output(choosen(autokeyb2.key_citystname('~thor_data400::key::Taxpro::qa::autokey::'),10));
output(choosen(autokey.key_name('~thor_data400::key::Taxpro::qa::autokey::'),10));
output(choosen(autokeyb2.key_name('~thor_data400::key::Taxpro::qa::autokey::'),10));
output(choosen(autokeyb2.key_namewords('~thor_data400::key::Taxpro::qa::autokey::'),10));
output(choosen(autokey.key_ssn2('~thor_data400::key::Taxpro::qa::autokey::'),10));
output(choosen(autokey.key_stname('~thor_data400::key::Taxpro::qa::autokey::'),10));
output(choosen(autokeyb2.key_stname('~thor_data400::key::Taxpro::qa::autokey::'),10));
output(choosen(autokey.key_zip('~thor_data400::key::Taxpro::qa::autokey::'),10));
output(choosen(autokeyb2.key_zip('~thor_data400::key::Taxpro::qa::autokey::'),10));


endmacro;	