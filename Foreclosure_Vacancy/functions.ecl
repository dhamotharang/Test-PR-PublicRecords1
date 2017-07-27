export functions := module;

	export Hash_FOV(
									string first_name, 
									string last_name, 
									string street_address, 
									string zip
																) := function

		retval := hashmd5(first_name, last_name, street_address, zip);
		return retval;
	end;

End;