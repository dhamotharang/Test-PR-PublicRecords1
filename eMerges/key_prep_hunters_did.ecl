import doxie;

export key_prep_hunters_did := index(
	emerges.file_hunters_keybuild((integer)did_out != 0),
	{UNSIGNED8 did := (UNSIGNED8) did_out}, {emerges.file_hunters_keybuild},
	'~thor_data400::key::hunters_doxie_did' + thorlib.wuid());