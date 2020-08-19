IMPORT $, data_services, doxie;

string prefix := data_services.data_location.prefix ('Provider');
								 
EXPORT names(STRING version = doxie.Version_SuperKey) := MODULE

	EXPORT i_vendor_src := prefix + 'thor_data400::key::vendor_src_info::vendor_source_'+ version;	

END;
