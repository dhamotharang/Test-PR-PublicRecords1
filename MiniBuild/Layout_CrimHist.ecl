import CRIM;

export Layout_CrimHist :=
RECORD
	integer rec_id;
	CRIM.Layout_Crim_Common;
	integer4				 crime_code;
    integer4				 date_offense;
END;