IMPORT Emdeon,ut;

EXPORT CRecord_In_CRecord(string pVersion = '') := MODULE
	EXPORT In_CRecord := DATASET('~enclarity_emdeon::base::claims::claim_level::' + pVersion,Emdeon.Layouts.Base.C_Record,flat,__compressed__);

END;