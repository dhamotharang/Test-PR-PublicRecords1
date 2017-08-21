import _control,ut,RoxieKeyBuild,header,PromoteSupers;
export proc_quickHdr_build_all (string sourceIP, string filedate) := function

	sprayIP := map(
									sourceIP = 'bctlpedata10' => _control.IPAddress.bctlpedata10,
									sourceIP
									);	
	
	sourcePath 				:= '/data/data_lib_2_hus2/efx_hdrs/in/';
	
	destinationGroup	:= _control.TargetGroup.Thor400_44;
	recordSize				:= 567;
	
	checkFileExists		:= if(count(FileServices.remotedirectory(sprayIP,sourcePath,'MONTHLY_HEADER_*.DAT',false)(size != 0 )) = 4,
													true,
													false
												 );
												 
	weeklyFileName		:= FileServices.remotedirectory(sprayIP,sourcePath,'WEEKLY_HEADER_*.DAT',false)(size != 0 )[1].name;
	
	sprayWeeklyFile		:= fileservices.sprayfixed(sprayIP,sourcePath+weeklyFileName,recordSize,destinationGroup,'~thor400_84::in::eq_weekly::'+filedate,-1,,,true,true,true);
	
	monthly_verion		:= Header.Sourcedata_month.v_version;										 
	sprayMonthlyFiles	:= parallel(
																fileservices.sprayfixed(sprayIP,sourcePath+'MONTHLY_HEADER_E_'+monthly_verion+'.DAT',recordSize,destinationGroup,'~thor_data400::in::hdr_east_'+filedate,-1,,,true,true,true),
																fileservices.sprayfixed(sprayIP,sourcePath+'MONTHLY_HEADER_W_'+monthly_verion+'.DAT',recordSize,destinationGroup,'~thor_data400::in::hdr_west_'+filedate,-1,,,true,true,true),
																fileservices.sprayfixed(sprayIP,sourcePath+'MONTHLY_HEADER_S_'+monthly_verion+'.DAT',recordSize,destinationGroup,'~thor_data400::in::hdr_south_'+filedate,-1,,,true,true,true),
																fileservices.sprayfixed(sprayIP,sourcePath+'MONTHLY_HEADER_C_'+monthly_verion+'.DAT',recordSize,destinationGroup,'~thor_data400::in::hdr_central_'+filedate,-1,,,true,true,true)
																);
																	
	addWeeklySuper		:= sequential(
																	fileservices.StartSuperFileTransaction(),
																	fileservices.addsuperfile('~thor400_84::in::eq_weekly','~thor400_84::in::eq_weekly::'+filedate),
																	fileServices.FinishSuperFileTransaction()
																	);
																		
	addMonthlySuper		:= sequential(
																	fileservices.StartSuperFileTransaction(),
																	fileservices.clearsuperfile('~thor_data400::in::hdr_raw'),
																	fileservices.addsuperfile('~thor_data400::in::quickhdr_raw_history','~thor_data400::in::quickhdr_raw_father',,true),
																	fileservices.clearsuperfile('~thor_data400::in::quickhdr_raw_father'),
																	fileservices.addsuperfile('~thor_data400::in::quickhdr_raw_father','~thor_data400::in::quickhdr_raw',,true),
																	fileservices.clearsuperfile('~thor_data400::in::quickhdr_raw'),
																	fileservices.addsuperfile('~thor_data400::in::quickhdr_raw','~thor_data400::in::hdr_east_'+filedate),
																	fileservices.addsuperfile('~thor_data400::in::quickhdr_raw','~thor_data400::in::hdr_west_'+filedate),
																	fileservices.addsuperfile('~thor_data400::in::quickhdr_raw','~thor_data400::in::hdr_south_'+filedate),
																	fileservices.addsuperfile('~thor_data400::in::quickhdr_raw','~thor_data400::in::hdr_central_'+filedate),
																	fileservices.addsuperfile('~thor_data400::in::hdr_raw','~thor_data400::in::quickhdr_raw'),
																	fileServices.FinishSuperFileTransaction()
																	);

	doWeekly	:= sequential(sprayWeeklyFile,addWeeklySuper);
	
	PromoteSupers.MAC_SF_BuildProcess(Header.Mod_CreditBureau_address.flagged_nlr_addresses,'~thor_data400::prepped::nlr_addresses',bld_prepped,pcompress:=true,numgenerations:='2');
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Header.Mod_CreditBureau_address.Key_flagged_nlr_addresses,'~thor_data400::key::quickheader::flagged_nlr_addresses','~thor_data400::key::quickheader::'+filedate+'::flagged_nlr_addresses',bld_key);

	doMonthly := if(checkFileExists
											,sequential(
																	sprayMonthlyFiles
																	,addMonthlySuper
																	,bld_prepped
																	,output(Header.Mod_CreditBureau_address.stats,named('nlr_counts'))
																	,bld_key
																	,_control.fSubmitNewWorkunit('#workunit(\'name\',\'Scrubs_Equifax_Monthly\');\r\n'+
																	'Scrubs_Equifax_Monthly.proc_generate_report();','thor400_60')
																	)
											,output('No Monthly Files available')
										 );
	
	buildAll	:= header_quick.proc_build_quick_hdr(filedate);
	
	QA_sample  := header_quick.New_records_sample ; 
	
	Source_Check_rep := header_quick.Proc_source_check_report();
	
	return sequential(doWeekly,doMonthly,Inputs_Clear,Inputs_Set(filedate),buildAll,QA_sample/*,Source_Check_rep*/);
end;