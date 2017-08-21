IMPORT ut,Data_Services;
EXPORT Proc_Copy_To_Alpha(string pversion) := FUNCTION

		aEsp 					:= '10.194.12.2';
		aCluster			:= 'thor400_198_a';
		flagFileName 	:= 'thor_data400::flag::personHeader::boca::hhid_copy';
		
		l := Data_Services.Data_location.person_header;
		copy_to_alpha(string lfn):= fileservices.RemotePull('http://'+aEsp+':8010/FileSpray',l+lfn,aCluster,'~'+lfn);

		
		createFlagFile := output(dataset([{pversion}],{string9 version}),,'~'+flagFileName,overwrite);
		
		return sequential(
				
					createFlagFile,
					copy_to_alpha(nothor(fileservices.SuperFileContents(l+'thor_data400::BASE::HHID')[1].name)),
					copy_to_alpha(nothor(fileservices.SuperFileContents(l+'thor_data400::key::did_hhid_qa')[1].name)),
					copy_to_alpha(nothor(fileservices.SuperFileContents(l+'thor_data400::key::hhid_did_qa')[1].name)),
					copy_to_alpha(nothor(fileservices.SuperFileContents(l+'thor_data400::base::hss_household',true)[1].name)),
					copy_to_alpha(nothor(fileservices.SuperFileContents(l+'thor_data400::key::hhid_qa')[1].name)),
					copy_to_alpha(flagFileName),
					Header.check_alphaMonitorCopyFromBoca_isRunning
					
		);

end;
