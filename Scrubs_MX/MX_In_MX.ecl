IMPORT hxmx,ut;

EXPORT MX_In_MX(string pVersion = '') := MODULE
	EXPORT In_MX := DATASET('~thor400_data::base::hxmx_claims::mx_level::' + pVersion,hxmx.Layouts.Base.mx_record,flat,__compressed__);

END;