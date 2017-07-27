import Matrix_DL, drivers, crim_common;

// DL
DLfiles := drivers.File_Dl(orig_state = 'FL');

Images.Layout_idDID stripDLs (DLfiles L) :=
TRANSFORM
	SELF.state := L.orig_state;
	SELF.rtype := 'DL';
	SELF.id := L.dl_number;
	SELF.did := L.did;
END;
justDLid := PROJECT(DLfiles, stripDLs(LEFT));

// public
DOCpublicFiles := Crim_Common.File_Moxie_Crim_Offender2_Prod;

Images.Layout_idDID stripPublicDOCs (DOCpublicFiles L) :=
TRANSFORM
	SELF.state := L.state_origin;
	SELF.rtype := 'DC';
	SELF.id := L.doc_num;
	SELF.did := (unsigned)L.did;
END;
justDOCid := PROJECT(DOCpublicFiles, stripPublicDOCs(LEFT));

noBlankDIDs := (justDLid + justDOCid)(did != 0);
allids := DEDUP(noBlankDIDs, ALL);

export BWR_PullPublicDID := output(allids,,'~images::idDID', overwrite);
