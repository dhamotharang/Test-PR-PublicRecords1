import data_services, doxie, prte2_firstdata;

EXPORT Keys := module

	export drvr_license 	:= index(prte2_firstdata.files.drvrlicense, {dl_state,dl_id}, {prte2_firstdata.files.drvrlicense}, 
																 data_services.data_location.prefix ('') + prte2_firstdata.Constants.key_prefix + doxie.Version_SuperKey + '::driverslicense');

	export did_fcra				:= index(prte2_firstdata.files.keyfile_did, {LEX_ID}, {prte2_firstdata.files.keyfile_did}, 
																data_services.data_location.prefix ('') + prte2_firstdata.Constants.key_prefix + '::FCRA::' + doxie.Version_SuperKey + '::did');
	
end;											
	