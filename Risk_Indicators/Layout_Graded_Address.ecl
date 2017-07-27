// Graded addresses.
import doxie;
export Layout_Graded_Address := RECORD
	Layout_Input	indata;
	doxie.Key_Header.dt_last_seen;
	doxie.Key_Header.prim_range;
	doxie.Key_Header.prim_name;
	doxie.Key_Header.sec_range;
	doxie.Key_Header.zip;
	INTEGER support;
	INTEGER grade;
	BOOLEAN hasDL;
	BOOLEAN hasVoter;
	BOOLEAN hasReg;
	BOOLEAN hasProp;
	BOOLEAN inputMatch;
END;