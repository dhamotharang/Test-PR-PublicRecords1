/*2005-02-07T08:36:07Z (Mark Luber)
all for diffing superkeys
*/
export mac_create_superkey_files(basename,num_gens = '3',diffing = 'false',diffonly = 'false') := macro
import roxiekeybuild;

roxiekeybuild.mac_create_superkey_files(basename,num_gens,diffing,diffonly);
	
endmacro : deprecated('use roxiekeybuild.mac_create_superkey_files instead');