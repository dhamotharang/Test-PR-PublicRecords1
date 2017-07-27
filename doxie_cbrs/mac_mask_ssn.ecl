export mac_mask_ssn(infile, outfile, ssn_field) := macro
	import Suppress;
	Suppress.MAC_Mask(infile, outfile, ssn_field, null, true, false);
endmacro;