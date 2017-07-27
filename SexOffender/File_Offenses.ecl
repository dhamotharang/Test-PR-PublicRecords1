import doxie_build, ut;

ds := sexoffender.File_offenses_2;

Layout_common_Offense slimTrans(ds l):= transform
	self := l;
end;

export File_Offenses := project(ds, slimTrans(left));