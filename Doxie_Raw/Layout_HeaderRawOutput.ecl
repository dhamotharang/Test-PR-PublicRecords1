import doxie;
export Layout_HeaderRawOutput := record
	recordof(doxie.Key_Header);
	boolean glb;
	boolean dppa;
	string9 ssn_unmasked := '';
end;