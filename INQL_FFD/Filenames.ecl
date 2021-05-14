import versioncontrol,tools, data_services, dx_InquiryHistory, ut;

export Filenames(boolean isUpdate = true, boolean isFCRA = true, string pVersion = '') := module

	shared period 					  := if(isUpdate,'::daily','::weekly' );   
	shared fcra               := if(isFCRA  ,'::fcra' ,'::non_fcra');	
	export root               := '~' + Inql_ffd._Constants.THOR_ROOT + '::' + dx_InquiryHistory.Constants.dataset_name + fcra;	
		
	shared lBase 						 	:= root + '::base';
	shared lBaseTemplate			:= lBase + period + '::@version@';
	export Base							 	:= tools.mod_FilenamesBuild(lBaseTemplate, pVersion, pnGenerations:=2);

	export Input							:= root + '::in';   
	export InputFile					:= Input + '::' + pVersion;
	export InputBuilding	    := Input + '::building';	
	export InputBuilt		      := Input + '::built';		
	export InputHistory	      := Input + '::history';
	
	export PPC_Mapping        := data_services.foreign_fcra_logs + Inql_ffd._Constants.THOR_ROOT + '::' + dx_InquiryHistory.Constants.dataset_name + fcra 
	                             + '::in::permission_code_table';
	
  	
end;
