export mac_CountByState(inf, outp, name) := macro

#uniquename(rec)
%rec% := record
	inf.file_state;
	inf.isdirect;
	counted := count(group);
end;

#uniquename(t)
#uniquename(s)
%t% := table(inf, %rec%, file_state, isdirect);
%s% := sort(%t%, file_state, isdirect);
outp := output(choosen(%s%, 1000), named(name));

endmacro;