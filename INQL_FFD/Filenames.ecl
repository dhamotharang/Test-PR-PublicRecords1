import versioncontrol,tools, data_services;

export Filenames(boolean isUpdate = true, boolean isFCRA = true, string pVersion = '') := module

  shared period 						:= if(isUpdate,'::','::history::' );   
	shared fcra               := if(isFCRA  ,'::fcra' ,'::non_fcra');	
	
	shared lBase 							:= data_services.Data_location.Prefix('INQL')+'thor_data' + '::base::' + INQL_FFD._Constants.DatasetName + fcra;
	shared lBaseTemplate			:= lBase + period + '@version@';
	export Base								:= tools.mod_FilenamesBuild(lBaseTemplate, pVersion);

	export lInputTemplate			:= data_services.Data_location.Prefix('INQL')+'thor_data' + '::in::' + INQL_FFD._Constants.DatasetName + fcra;
	export lInputHistTemplate := data_services.Data_location.Prefix('INQL')+'thor_data' + '::in::' + INQL_FFD._Constants.DatasetName + fcra + '::history';	    
  	
end;
