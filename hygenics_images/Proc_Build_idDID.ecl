import crim_common, hygenics_crim, images;

//Base Offender File
ds 	:= dataset(Crim_Common.Name_Moxie_Crim_Offender2_Dev +'_new', hygenics_crim.Layout_Common_Crim_Offender_new, flat)(trim(image_link,left,right) <> '');

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
		SELF.state 	:= L.state_origin;
		SELF.rtype 	:= 'DC';
		SELF.id 	:= L.offender_key;
		SELF.did 	:= (unsigned)L.did;
	END;
	
	justDOCid := PROJECT(DOCFiles, stripPublicDOCs(LEFT));

//Arrest Logs
	ArrestFiles := ds(data_type='5');

	Layout_idDID strip_PublicARRESTs(ArrestFiles L) := transform
		self.state 	:= L.state_origin; 
		self.rtype 	:= 'AL';
		self.id 	:= L.offender_key;
		self.did 	:= (unsigned)L.did;
	end;

	JustARRESTid := project(ArrestFiles, strip_PublicARRESTs(LEFT));

	noBlankDIDs := (justDOCid + justARRESTid)(did != 0);
	allids 		:= DEDUP(noBlankDIDs, ALL);

export proc_build_idDID := allids : persist('~criminal_images::idDID');
