IMPORT $,data_services, doxie;

STRING filename :='thor_data400::key::vendor_src_info::vendor_source_';
									 
									 
EXPORT Names(string file_version = doxie.Version_SuperKey) := module

		export name :=filename + file_version ;
		
end;
									 
									 
