l_plus :=
RECORD
	string12 sid;
    unsigned6 DID;
	unsigned integer8 __filepos { virtual(fileposition)};
END;

d := dataset('~matrixbuild::base::CrimSidDid', l_plus, flat);

export Key_CrimHist_did := INDEX(d, {unsigned6 sdid := d.did}, {d}, '~matrixbuild::key::CrimHist_did2');