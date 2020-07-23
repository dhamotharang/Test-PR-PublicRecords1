IMPORT $,data_services, doxie;

								 
EXPORT Names(boolean PROD = TRUE, string file_version = doxie.Version_SuperKey) := module

STRING filename :=Data_Services.Data_location.Prefix('Provider') + 
										IF(PROD,data_services.foreign_prod,data_services.foreign_dataland) +
											'thor_data400::key::vendor_src_info::vendor_source_';

		export name :=filename + file_version ;
		
end;
									 
									 
