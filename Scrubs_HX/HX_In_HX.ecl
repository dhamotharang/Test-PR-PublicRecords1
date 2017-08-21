IMPORT hxmx,ut;

EXPORT HX_In_HX(string pVersion = '') := MODULE
	EXPORT In_HX := DATASET('~thor400_data::base::hxmx_claims::hx_level::' + pVersion,hxmx.Layouts.Base.hx_record,flat,__compressed__);

END;