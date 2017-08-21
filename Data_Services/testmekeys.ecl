export testmekeys := macro
	string_rec := record
	string10 myinfo;
	string2 dummy := ''
end;

ds := dataset([{'abc'}],string_rec);
	output(index(ds,{myinfo},{ds},'~thor::qa::testme::key'));
		output(index(ds,{myinfo},{ds},'~thor::qa::testme::key1'));
endmacro;