import STD;
EXPORT CvtPilcrow(unicode remarks) := Std.Uni.FindReplace(remarks,U'Â¶',U'\r\n');
//EXPORT CvtPilcrow(unicode remarks) := TRIM(REGEXREPLACE(U'Â¶+',remarks,U'\r\n'));
