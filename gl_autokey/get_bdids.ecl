export get_bdids(
	string autokey_keyname,
	set of string1 get_skip_set,
	gl_autokey.autokey_interfaces.bdids in_parms) :=
		function
			isBareAddr :=
				in_parms.comp_name_value = '' and
				in_parms.pname_value <> '' and
				'C' not in get_skip_set;
			ids_fein :=
				if(
					'F' not in get_skip_set,
					gl_autokey.Fetch_Biz_FEIN(autokey_keyname,in_parms));
			ids_phone :=
				if(
					'Q' not in get_skip_set,
					gl_autokey.Fetch_Biz_Phone(autokey_keyname,in_parms));
			ids_addr :=
				if(
					not isBareAddr,
					gl_autokey.Fetch_Biz_Address(autokey_keyname,in_parms));
			ids_scfl :=
				if(
					not isBareAddr,
					gl_autokey.Fetch_Biz_StCityFLName(autokey_keyname,in_parms));
			ids_zip :=
				if(
					not isBareAddr,
					gl_autokey.Fetch_Biz_Zip(autokey_keyname,in_parms));
			ids_sn :=
				if(
					not isBareAddr,
					gl_autokey.Fetch_Biz_StName(autokey_keyname,in_parms));
			ids_n :=
				gl_autokey.Fetch_Biz_Name(autokey_keyname,in_parms);
			ids_nw :=
				gl_autokey.Fetch_Biz_Name_Words(autokey_keyname,in_parms);

			// output(ids_fein, 	named('ids_fein'));		// DEBUG
			// output(ids_phone,	named('ids_phone'));	// DEBUG
			// output(ids_addr, 	named('ids_addr'));		// DEBUG
			// output(ids_scfl, 	named('ids_scfl'));		// DEBUG
			// output(ids_zip,		named('ids_zip'));		// DEBUG
			// output(ids_sn, 		named('ids_sn'));			// DEBUG
			// output(ids_n,			named('ids_n'));			// DEBUG
			// output(ids_nw, 		named('ids_nw'));			// DEBUG

			ids :=
				ids_fein +
				ids_phone +
				ids_addr +
				ids_scfl +
				ids_zip +
				ids_sn +
				ids_n +
				ids_nw;

			return dedup(ids, record, all)(bdid > 0);
		end;
