
countrec := record
	string2 source_code;
	string2 orig_state;
	unsigned6 counted;
	string2 src;
end;

export Source_Counts:=dataset('~thor400_84::persist::drvlic_source_counts',countrec,thor);