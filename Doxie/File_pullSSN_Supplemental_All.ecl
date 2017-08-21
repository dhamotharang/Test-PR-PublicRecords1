import header_services,ut;

inRec :=
RECORD
	STRING60 ssn;
	STRING1 lf;
END;

header_services.Supplemental_Data.mac_verify('pull_ssn',inRec,readit);
 
supplemental := readit();

//d1 := dataset(ut.foreign_prod + '~thor_data400::in::pull_ssn', inRec, flat);

//newSupplementals := JOIN(d1, supplemental, LEFT.ssn = RIGHT.ssn,
//													TRANSFORM(RIGHT), RIGHT ONLY);

											
//export File_pullSSN_Supplemental := newSupplementals;
export File_pullSSN_Supplemental_All := supplemental;