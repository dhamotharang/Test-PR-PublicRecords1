import CRIM;

l_plus :=
RECORD
	minibuild.Layout_FL_Crim_Common;
	unsigned integer8 __filepos { virtual(fileposition)};
END;


export File_CrimHist := dataset('~matrixbuild::base::CrimHist', l_plus, flat);