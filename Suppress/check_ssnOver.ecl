import suppress;

export boolean check_ssnOver(unsigned6 did, string9 ssn) := function
	myHash := hashmd5(did, ssn);
	return exists(suppress.key_ssnOver(hval = myHash) );
end;
