import STD;
EXPORT CvtPilcrow(unicode remarks) := Std.Uni.FindReplace(remarks,U'¶',U'\r\n');
//EXPORT CvtPilcrow(unicode remarks) := TRIM(REGEXREPLACE(U'¶+',remarks,U'\r\n'));
