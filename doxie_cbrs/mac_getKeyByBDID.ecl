export mac_getKeyByBDID(k, kbdid_field, outlay, include_flag, bdids, outfile) := macro

#uniquename(keepk)
outlay %keepk%(k l) := transform
	self := l;
end;

outfile := join(bdids, k, include_flag and keyed(left.bdid = right.kbdid_field), %keepk%(right));

endmacro;