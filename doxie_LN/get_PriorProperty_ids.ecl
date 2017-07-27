import doxie;
export get_PriorProperty_ids(dataset(doxie.layout_propertySearch) infile) := 
FUNCTION

pba := doxie_LN.fn_PropIDsByAddr(infile, dataset([], doxie.layout_NameDID),,,,,, true, false).records;

outf := record
	unsigned6	did;
	string12 fid;
	integer3 address_seq_no;
	string2  source_code;
end;

return dedup(project(pba, outf),all);

END;