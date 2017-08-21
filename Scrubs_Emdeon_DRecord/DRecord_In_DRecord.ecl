IMPORT Emdeon,ut;

EXPORT DRecord_In_DRecord(string pVersion = '') := MODULE
	EXPORT In_DRecord := DATASET('~enclarity_emdeon::base::claims::detail_level::' + pVersion,Emdeon.Layouts.Base.D_Record,flat,__compressed__);

END;