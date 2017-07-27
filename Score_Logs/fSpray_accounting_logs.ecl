import Versioncontrol, _Control, fbn_new, ut;

export fspray_accounting_logs(string pFilenameExp = 'accurint_*.cat', string pFileType = 'accurint', boolean fcra = false, string pVersion = '') := function
	
	version 						:= if(pVersion = '', ut.GetDate, pVersion);
	pServerIP				:= _control.IPAddress.edata12;
	
	pGroupName := if(~fcra, 'thor100_21','thor35_21');
	pPrefix	 					:= if(~fcra, '~thor100_21','~thor10_231');
	
		directory := map( pFileType = 'mbs'	=>'/inquiry_data_01/mbs',	 '/riskview/sao/in/accounting_logs');
	
	filename_template := map(
																										pFileType = 'accurint_sl'							=> pPrefix + '::in::'+version+'::accurint_acclog_sl',  /*thor100_21::in::*::accurint_acclog_sl*/
																										pFileType = 'custom_sl'								=> pPrefix + '::in::'+version+'::custom_acclog_sl', /*thor100_21::in::*::custom_acclog_sl*/
																										pFileType = 'riskwise_sl'								=> pPrefix + '::in::'+version+'::riskwise_acclog_sl',  /*thor100_21::in::*::riskwise_sl*/
																										pFileType = 'riskwise_sl_FCRA'	=> pPrefix + '::in::'+version+'::riskwise_acclog_sl', /* thor10_231::in::*::riskwise_acclog_sl*/
																							'');

	Superfile := map(
																	pFileType = 'accurint_sl'							=> pPrefix + '::in::accurint_acclogs_sl', /*thor100_21::in::*::accurint_acclog_sl*/
																	pFileType = 'custom_sl'								=> pPrefix + '::in::custom_acclogs_sl', /*thor100_21::in::*::custom_acclog_sl*/
																	pFileType = 'riskwise_sl'								=> pPrefix + '::in::riskwise_acclogs_sl', /*thor100_21::in::*::riskwise_sl*/
																	pFileType = 'riskwise_sl_FCRA'	=> pPrefix + '::in::riskwise_acclogs_sl', /*thor100_21::in::*::riskwise_sl*/
															'');

	Separate := map(
																	pFileType = 'accurint_sl'		=> '~~',
																	pFileType = 'custom_sl'			=> '~~',
																	pFileType = 'riskwise_sl'			=> '~~',
															'');


	FilesToSpray := DATASET([
	
																									{pServerIP, directory, pFilenameExp, 0, filename_template, [{Superfile}], pGroupName,'','','VARIABLE'
																									,''/*xml row*/ ,''/*maxlength*/ ,Separate ,''/* terminate*/ ,',' /*quote*/,true /*compress*/}
				
																						], 		 VersionControl.Layout_Sprays.Info);

return VersionControl.fSprayInputFiles(FilesToSpray);
end;
