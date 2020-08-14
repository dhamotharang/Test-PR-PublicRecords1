EXPORT mac_getKeyByBDID(k, kbdid_field, outlay, include_flag, bdids, outfile) := MACRO

#uniquename(keepk)
outlay %keepk%(k l) := TRANSFORM
  SELF := l;
END;

outfile := JOIN(bdids, k, include_flag AND KEYED(LEFT.bdid = RIGHT.kbdid_field), %keepk%(RIGHT));

ENDMACRO;
