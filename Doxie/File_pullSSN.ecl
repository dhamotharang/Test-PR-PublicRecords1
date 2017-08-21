import header_services;

inRec :=
RECORD
	STRING60 ssn;
	STRING1 lf;
END;

header_services.Supplemental_Data.mac_verify('pull_ssn',inRec,readit);
 
supplemental := readit();

d1 := dataset('~thor_data400::in::pull_ssn', inRec, flat);

newSupplementals := JOIN(d1, supplemental, LEFT.ssn = RIGHT.ssn,
													TRANSFORM(RIGHT), RIGHT ONLY);
													
export File_pullSSN := dataset('~thor_data400::in::pull_ssn', inRec, flat) + newSupplementals;