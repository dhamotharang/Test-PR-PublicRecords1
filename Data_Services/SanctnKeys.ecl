export SanctnKeys := macro
	output(choosen(SANCTN.Key_SANCTN_casenum,10));
	output(choosen(SANCTN.Key_SANCTN_incident,10));
	output(choosen(SANCTN.Key_SANCTN_party,10));
	output(choosen(SANCTN.Key_SANCTN_autokey_payload,10));
	output(choosen(autokey.key_address('~thor_data400::key::sanctn::qa::autokey::'),10));
	output(choosen(autokey.key_citystname('~thor_data400::key::sanctn::qa::autokey::'),10));
	output(choosen(autokey.key_name('~thor_data400::key::sanctn::qa::autokey::'),10));
	output(choosen(autokey.key_zip('~thor_data400::key::sanctn::qa::autokey::'),10));
	output(choosen(autokey.key_stname('~thor_data400::key::sanctn::qa::autokey::'),10));
	output(choosen(autokeyb2.key_address('~thor_data400::key::sanctn::qa::autokey::'),10));
	output(choosen(autokeyb2.key_citystname('~thor_data400::key::sanctn::qa::autokey::'),10));
	output(choosen(autokeyb2.key_name('~thor_data400::key::sanctn::qa::autokey::'),10));
	output(choosen(autokeyb2.key_zip('~thor_data400::key::sanctn::qa::autokey::'),10));
	output(choosen(autokeyb2.key_stname('~thor_data400::key::sanctn::qa::autokey::'),10));
	output(choosen(autokeyb2.key_namewords('~thor_data400::key::sanctn::qa::autokey::'),10));

endmacro;