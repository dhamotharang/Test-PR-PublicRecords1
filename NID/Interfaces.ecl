export Interfaces := 
MODULE



	/*
	BEGIN NID.lib_PFirst SENSITIVE AREA
	If you are making changes to these layouts or interfaces, be sure you are aware of the impact to the library and its callers.
	*/
	export type_name := string20;
	export type_versions := Set of integer;
	export type_PFirstX := Set of string20;

	export LIBIN_PFirst := INTERFACE
		export type_name name;  
	END;

	export LIBOUT_PFirst(LIBIN_PFirst args) := INTERFACE
		export dataset({type_name name}) Names;
	END;	
	/*
	END NID.lib_PFirst SENSITIVE AREA
	*/

END;