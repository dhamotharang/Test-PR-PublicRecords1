export mac_create_superfiles(basename, num_gens = '3', infiles = 'false', inname = '\'frblfrbl\'') := macro
	import Promotesupers;
	promotesupers.mac_create_superfiles(basename, num_gens, infiles, inname);
endmacro : deprecated('use promotesupers.mac_create_superfiles instead');