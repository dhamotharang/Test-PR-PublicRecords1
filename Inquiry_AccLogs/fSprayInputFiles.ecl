import Versioncontrol, _Control, fbn_new;

export fSprayInputFiles(string pFilenameExp = 'accurint_*.cat', string pFileType = 'accurint', boolean fcra = false, string pVersion = '') :=
function
	
	version := if(pVersion = '', '@version@', pVersion);
	pServerIP		:= _control.IPAddress.edata12;
	pDirectory	:= '/inquiry_data_01/spray_ready';
	pGroupName	:= if(~fcra, 'thor20_11', 'thor10_231_fcra');
	pPrefix			:= if(~fcra, '~thor10_11', '~thor10_231');
	
	filename_template := map(
										pFileType = 'accurint'		=> '~thor10_11::in::'+version+'::accurint_acclog',
										pFileType = 'custom'			=> '~thor10_11::in::'+version+'::custom_acclog',
										pFileType = 'case_connect'	=> '~thor10_11::in::'+version+'::accurint_acclog_cc',
										pFileType = 'deconfliction'			=> '~thor10_11::in::mbs::'+version+'::deconfliction',

										pFileType = 'banko_batch'	=> pPrefix + '::in::'+version+'::banko_batch_acclog',
										pFileType = 'banko'				=> pPrefix + '::in::'+version+'::banko_acclog',
										pFileType = 'batch'				=> pPrefix + '::in::'+version+'::batch_acclog',
										pFileType = 'riskwise'		=> pPrefix + '::in::'+version+'::riskwise_acclog',
										'');

	Superfile := map(
										pFileType = 'accurint'		=> '~thor10_11::in::accurint_acclogs_preprocess',
										pFileType = 'custom'			=> '~thor10_11::in::custom_acclogs_preprocess',
										pFileType = 'case_connect'	=> '~thor10_11::in::accurint_acclogs_cc_preprocess',
										pFileType = 'deconfliction'	=> '~thor10_11::in::mbs::deconfliction',

										pFileType = 'banko_batch'	=> pPrefix + '::in::banko_batch_acclogs_preprocess',
										pFileType = 'banko'				=> pPrefix + '::in::banko_acclogs_preprocess',
										pFileType = 'batch'				=> pPrefix + '::in::batch_acclogs_preprocess',
										pFileType = 'riskwise'		=> pPrefix + '::in::riskwise_acclogs_preprocess',
										'');

	Separate := map(
										pFileType = 'accurint'			=> '~~',
										pFileType = 'banko_batch'		=> '|',
										pFileType = 'banko'					=> '~~',
										pFileType = 'custom'				=> '~~',
										pFileType = 'batch'					=> '|',
										pFileType = 'riskwise'			=> '~~',
										pFileType = 'case_connect'	=> '~~',
										pFileType = 'deconfliction'	=> '~~',
										'');


	FilesToSpray := DATASET([

       {
       	 pServerIP												
       	,pDirectory                             
       	,pFilenameExp                                          
       	,0                                                             
       	,filename_template    
       	,[{Superfile}]    
       	,pGroupName                                                
       	,''                                                    
       	,''                                                            
       	,'VARIABLE'
				,''  // xml row
				,''  // maxlength
				,Separate
				,'' // terminate
				,',' //quote
				,true //compress
       	}], VersionControl.Layout_Sprays.Info);

return VersionControl.fSprayInputFiles(FilesToSpray);
end;
