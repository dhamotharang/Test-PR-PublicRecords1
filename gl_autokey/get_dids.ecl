export get_dids(
	string autokey_keyname,
	set of string1 get_skip_set,
	boolean useAllLookups,
	gl_autokey.autokey_interfaces.dids in_parms) :=
		if(
			'C' not in get_skip_set,
			dedup(
				if(
					'S' not in get_skip_set,
					if(
						useAllLookups,
						gl_autokey.fetch_ssn2(autokey_keyname,in_parms),
						gl_autokey.fetch_ssn(autokey_keyname,in_parms))) +
				if(
					'P' not in get_skip_set,
					if(
						useAllLookups,
						gl_autokey.fetch_phone2(autokey_keyname,in_parms),
						gl_autokey.fetch_phone(autokey_keyname,in_parms))) +
				gl_autokey.fetch_address(autokey_keyname,in_parms) +
				gl_autokey.fetch_zip(autokey_keyname,in_parms) +
				gl_autokey.fetch_name(autokey_keyname,in_parms) +
				gl_autokey.fetch_stflname(autokey_keyname,in_parms) +
				gl_autokey.fetch_stcityflname(autokey_keyname,in_parms),
				did,
				all));
