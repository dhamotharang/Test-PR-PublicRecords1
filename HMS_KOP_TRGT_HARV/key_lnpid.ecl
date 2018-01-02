import mdr, doxie, Data_Services,hms_kop_trgt_harv;

EXPORT key_lnpid(string pVersion='',boolean pUseProd=false) := function

	base := dataset('~thor400_data::base::kop_trgt_harv::trgt_harv_results::' + pVersion,hms_kop_trgt_harv.Layouts.layout_base,thor);
	
	key_name := data_services.data_location.prefix() + 'thor_data400::key::kop_trgt_harv::trgt_harv_results::' + doxie.Version_SuperKey + '::lnpid';

	return index(base(lnpid>0),{lnpid},{base},key_name);
	
end;