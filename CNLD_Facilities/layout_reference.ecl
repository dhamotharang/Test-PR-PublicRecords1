export layout_reference := MODULE

	export rfile := RECORD
		STRING10  TABLENAME,
		STRING5   START,
		STRING50  LABEL,
		STRING5   HLO
	END;

	export rlookup := RECORD
		string lic_type,
		string	licdesc,
		string	srce_updt,
		string	create_dt,
		string	licTypePK,
	END;

end;
