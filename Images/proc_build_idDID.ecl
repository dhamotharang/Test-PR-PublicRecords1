import drivers, crim_common, sexoffender, hygenics_crim, ut;

// DL
// DLfiles := drivers.File_Dl(orig_state = 'FL');

// Images.Layout_idDID stripDLs (DLfiles L) :=
// TRANSFORM
	// SELF.state := L.orig_state;
	// SELF.rtype := 'DL';
	// SELF.id := L.dl_number;
	// SELF.did := L.did;
// END;
// justDLid := PROJECT(DLfiles, stripDLs(LEFT));

// public
DOCpublicFiles := hygenics_crim.File_Moxie_Crim_Offender2_Dev;
DOCFiles 				:= DOCpublicFiles(data_type='1');

	Layout_idDID stripPublicDOCs(DOCFiles L) := TRANSFORM
		SELF.state 	:= ut.st2abbrev(stringlib.stringtouppercase(l.orig_state));
		SELF.rtype 	:= 'DC';
		SELF.id 		:= L.doc_num;
		SELF.did 		:= (unsigned)L.did;
	END;
	
	justDOCid := PROJECT(DOCFiles, stripPublicDOCs(LEFT));

SOpublicFiles := sexoffender.file_main;

Images.Layout_idDID strip_PublicSOs(SOPublicFiles L) := transform
	// orig_state is mapped to full state name, won't work for us
	// luckily, the state abbrev is stored in the spk.
	self.state := L.seisint_primary_key[3..4]; 
	self.rtype := 'SO';
	self.id := L.seisint_primary_key;
	self.did := L.did;
end;

JustSOid := project(SOpublicFiles, strip_PublicSOs(LEFT));

noBlankDIDs := (/*justDLid +*/ justDOCid + justSOid)(did != 0);
allids := DEDUP(noBlankDIDs, ALL);

export proc_build_idDID := allids : persist('~images::idDID');
