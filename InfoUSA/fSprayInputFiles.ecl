import Versioncontrol, _Control, fbn_new;

export fSprayInputFiles( string pServerIP				= _control.IPAddress.edata10
												,string pDirectory			= '/prod_data_build_13/eval_data/infousa/abius/out'
												,string pFilenameExp		= 'abius_*.d00'
												,string pFileType				= 'abius'				// could be 'abius', 'idexec', 'fbn', 'deadco'
												,string pGroupName			= 'thor_dell400'
												) :=
function

	record_length := map(
										pFileType = 'abius'		=> sizeof(InfoUSA.Layout_ABIUS_Company_Data_In),
										pFileType = 'deadco'	=> sizeof(InfoUSA.Layout_DEADCO_In),
										pFileType = 'fbn'			=> sizeof(fbn_new.Layout_FBN_fixed_in),
										pFileType = 'idexec'	=> sizeof(InfoUSA.Layout_IDEXEC_In),
										0);
	filename_template := map(
										pFileType = 'abius'		=> '~thor_data400::in::abius_combined_data_@version@',
										pFileType = 'deadco'	=> '~thor_data400::in::infousa_deadco_@version@',
										pFileType = 'fbn'			=> '~thor_data400::in::infousa_fbn_lexx001_@version@',
										pFileType = 'idexec'	=> '~thor_data400::in::infousa_idexec_@version@',
										'');

	Superfile := map(
										pFileType = 'abius'		=> '~thor_data400::in::ABIUS_COMBINED_DATA',
										pFileType = 'deadco'	=> '~thor_data400::in::infousa_deadco',
										pFileType = 'fbn'			=> '~thor_data400::in::infousa_fbn_new',
										pFileType = 'idexec'	=> '~thor_data400::in::infousa_idexec',
										'');

	FilesToSpray := DATASET([

	 	{pServerIP
	 	,pDirectory
	 	,pFilenameExp
	 	,record_length
	 	,filename_template
	 	,[{Superfile}]
	 	,pGroupName // 9 more
		,''
		,'[0-9]{8}'
		,'FIXED'
		,''
		,0
		,''
		,''
		,''
		,false	// don't compress now because rest of files are not compressed
	 	}

	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray);

end;