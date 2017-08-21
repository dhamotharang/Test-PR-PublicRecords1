import crim_common, hygenics_crim, images, corrections, ut;

//Base Offender File
ds 	:= dataset('~thor_data400::base::corrections_offenders_public', corrections.layout_offender, flat)(trim(image_link,left,right) <> '');

//Crim Records
/*
	CrimFiles := ds(data_type = '2');

	Images.Layout_idDID stripCRIMs(CrimFiles L) := TRANSFORM
		SELF.state 	:= L.state_origin;
		SELF.rtype 	:= 'CR';
		SELF.id 	:= L.offender_key;
		SELF.did 	:= (unsigned)L.did;
	END;

	justCRIMid := PROJECT(CrimFiles, stripCRIMs(LEFT));
*/
//DOC
	DOCFiles := ds(data_type='1');

	Layout_idDID stripPublicDOCs(DOCFiles L) := TRANSFORM
		SELF.state 	:= ut.st2abbrev(stringlib.stringtouppercase(l.orig_state));
		SELF.rtype 	:= 'DC';
		SELF.id 		:= L.offender_key;
		SELF.did 		:= (unsigned)L.did;
	END;
	
	justDOCid := PROJECT(DOCFiles, stripPublicDOCs(LEFT));

//Arrest Logs
	ArrestFiles := ds(data_type='5');

	Layout_idDID strip_PublicARRESTs(ArrestFiles L) := transform
		self.state 	:= ut.st2abbrev(stringlib.stringtouppercase(l.orig_state));
		self.rtype 	:= 'AL';
		self.id 		:= L.offender_key;
		self.did 		:= (unsigned)L.did;
	end;

	JustARRESTid 	:= project(ArrestFiles, strip_PublicARRESTs(LEFT));

	noBlankDIDs 	:= (justDOCid + justARRESTid)(did != 0);
	allids 				:= DEDUP(noBlankDIDs, ALL);

export proc_build_idDID := allids : persist('~criminal_images::idDID');
