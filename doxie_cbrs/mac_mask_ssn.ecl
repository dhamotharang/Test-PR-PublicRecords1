EXPORT mac_mask_ssn(infile, outfile, ssn_field) := MACRO
  IMPORT Suppress;
  Suppress.MAC_Mask(infile, outfile, ssn_field, null, TRUE, FALSE);
ENDMACRO;
