import lib_fileservices, _Control;

export proc_despray(
	string8 in_date,
	string outf_prefix='~thor_data400::out::FidelityPropSlice400staging::'
) := FUNCTION

d(integer i) := function

return
lib_fileservices.fileservices.Despray(
	outf_prefix + trim((string)i),
	_Control.IPaddress.bctlpedata11, 
	'/data/hds_180/rain/data/' + in_date + '/RAINPart'+ trim((string)i) + 'Of30'
	,,,,TRUE
);

end;


d(1);
d(2);
d(3);
d(4);
d(5);
d(6);
d(7);
d(8);
d(9);
d(10);
d(11);
d(12);
d(13);
d(14);
d(15);
d(16);
d(17);
d(18);
d(19);
d(20);
d(21);
d(22);
d(23);
d(24);
d(25);
d(26);
d(27);
d(28);
d(29);
d(30);

RETURN output(0);

END;