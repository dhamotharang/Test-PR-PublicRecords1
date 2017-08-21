IMPORT Emdeon,ut;

EXPORT SRecord_In_SRecord(string pVersion = '') := MODULE
	EXPORT In_SRecord := DATASET('~enclarity_emdeon::base::claims::split_level::' + pVersion,Emdeon.Layouts.Base.S_Record,flat,__compressed__);

END;