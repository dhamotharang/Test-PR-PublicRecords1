IMPORT ut,Data_Services,_control,data_services;
EXPORT Proc_Copy_To_Alpha(string pversion) := FUNCTION

		aEsp 				:= _control.IPAddress.aprod_thor_esp;
		bEsp				:= data_services.foreign_prod;
		aCluster			:= 'thor400_112';
		flagFileName 	:= 'thor_data400::flag::personHeader::boca::hhid_copy_';
		
		l := bEsp;//Data_Services.Data_location.person_header;
		copy_to_alpha(string lfn):= fileservices.RemotePull('http://'+aEsp+':8010/FileSpray',l+lfn,aCluster,'~'+lfn
                                ,/*tmOut*/,/*maxConn*/,/*ovrt*/,/*relct*/,/*asSuper*/,/*frcPsh*/,/*bfrSz*/,/*wrp*/,true) ;


		
		createFlagFile := output(dataset([{pversion}],{string9 version}),,'~'+flagFileName,overwrite);
		
		return sequential(
				
					createFlagFile,
					copy_to_alpha('thor_data400::base::hhid_'+pversion),
					copy_to_alpha('thor_data400::key::header::hhid::'+pversion+'::did.ver'),
					copy_to_alpha('thor_data400::key::header::hhid::'+pversion+'::hhid.ver'),
					copy_to_alpha('thor400_44::base::hss_household_'+pversion),
					copy_to_alpha('thor_data400::key::header::'+pversion+'::hhid'),
					copy_to_alpha(flagFileName),
					Header.check_alphaMonitorCopyFromBoca_isRunning
					
		);

end;
