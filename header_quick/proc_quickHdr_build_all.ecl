IMPORT _control,ut,RoxieKeyBuild,header,PromoteSupers,Data_Services,STD;

EXPORT proc_quickHdr_build_all (
	STRING sourceIP = _control.IPAddress.bctlpedata10,
    STRING sourcePathWeekly  = '/data/Builds/builds/quick_header/data/',
    STRING overwriteWeeklyFileDate = '',
    STRING sourcePathMonthly = '/data/Builds/builds/quick_header/data/',
    STRING overwriteMonthlyFileDate = '',
    STRING destinationGroup  = STD.System.Thorlib.Group(),
	STRING buildRunWatchers  =    'Gregory.Rose@lexisnexisrisk.com'
								+',Debendra.Kumar@lexisnexisrisk.com'
								+',Gabriel.Marcan@lexisnexisrisk.com'
) := FUNCTION


	filedate := header_quick._config(sourceIP, sourcePathWeekly).get_v_eq_as_of_date;
	getVname (string superfile, string v_end = ':') := FUNCTION
		FileName:= STD.File.GetSuperFileSubName(superfile,1);
		v_strt  := stringlib.stringfind(FileName,'20',1);
		v_endd	:= IF(v_end='',length(FileName),stringlib.stringfind(FileName[v_strt..],v_end,1));
		v_name  := FileName[v_strt..v_strt+if(v_endd<1,length(FileName),v_endd)-2];
		RETURN v_name;
	END;

	keyPrefix := Data_Services.Data_Location.Prefix('LAB_xLink'); // eg ~thor400_44::
	xlink_superfile_ver := getVname(keyPrefix+'key::insuranceheader_xlink::qa::did::refs::name')[1..8];
	header_raw_prod_ver := getVname('~thor_data400::base::header_raw_Prod','')[1..8];

	EM1 := 'Superfiles are not in sync!';

	check_superfiles_are_in_sync := IF( xlink_superfile_ver <> header_raw_prod_ver,
										 sequential(
											 STD.System.Email.SendEmail(buildRunWatchers,'QuickHeader Failed - '+EM1,workunit),
											 fail(EM1)));
	recordSize := 600;
                                                     
	weeklyFileName := STD.File.remotedirectory(sourceIP,sourcePathWeekly,'WEEKLY_HEADER_*.DAT',false)(size != 0 )[1].name;
	
	sprayWeeklyFile := STD.File.sprayfixed(sourceIP,sourcePathWeekly+weeklyFileName,recordSize,destinationGroup,'~thor400_84::in::eq_weekly::'+filedate,-1,,,true,true,true);
	
	monthly_verion := Header.Sourcedata_month.v_version;
	sprayMonthlyFiles := PARALLEL(
		STD.File.sprayfixed(sourceIP,sourcePathMonthly+'MONTHLY_HEADER_E_*.DAT',recordSize,destinationGroup,'~thor_data400::in::hdr_east_'+filedate,-1,,,true,true,true),
		STD.File.sprayfixed(sourceIP,sourcePathMonthly+'MONTHLY_HEADER_W_*.DAT',recordSize,destinationGroup,'~thor_data400::in::hdr_west_'+filedate,-1,,,true,true,true),
		STD.File.sprayfixed(sourceIP,sourcePathMonthly+'MONTHLY_HEADER_S_*.DAT',recordSize,destinationGroup,'~thor_data400::in::hdr_south_'+filedate,-1,,,true,true,true),
		STD.File.sprayfixed(sourceIP,sourcePathMonthly+'MONTHLY_HEADER_C_*.DAT',recordSize,destinationGroup,'~thor_data400::in::hdr_central_'+filedate,-1,,,true,true,true)
	);

	addWeeklySuper := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.addsuperfile('~thor400_84::in::eq_weekly','~thor400_84::in::eq_weekly::'+filedate),
		STD.File.FinishSuperFileTransaction()
	);

	addMonthlySuper := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.clearsuperfile('~thor_data400::in::hdr_raw'),
		STD.File.addsuperfile('~thor_data400::in::quickhdr_raw_history','~thor_data400::in::quickhdr_raw_father',,true),
		STD.File.clearsuperfile('~thor_data400::in::quickhdr_raw_father'),
		STD.File.addsuperfile('~thor_data400::in::quickhdr_raw_father','~thor_data400::in::quickhdr_raw',,true),
		STD.File.clearsuperfile('~thor_data400::in::quickhdr_raw'),
		STD.File.addsuperfile('~thor_data400::in::quickhdr_raw','~thor_data400::in::hdr_east_'+filedate),
		STD.File.addsuperfile('~thor_data400::in::quickhdr_raw','~thor_data400::in::hdr_west_'+filedate),
		STD.File.addsuperfile('~thor_data400::in::quickhdr_raw','~thor_data400::in::hdr_south_'+filedate),
		STD.File.addsuperfile('~thor_data400::in::quickhdr_raw','~thor_data400::in::hdr_central_'+filedate),
		STD.File.addsuperfile('~thor_data400::in::hdr_raw','~thor_data400::in::quickhdr_raw'),
		STD.File.FinishSuperFileTransaction()
	);

	doWeekly := SEQUENTIAL(sprayWeeklyFile,addWeeklySuper);
	
	PromoteSupers.MAC_SF_BuildProcess(
		Header.Mod_CreditBureau_address.flagged_nlr_addresses,
		'~thor_data400::prepped::nlr_addresses',
		bld_prepped,pcompress:=true,numgenerations:='2'
	);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
		Header.Mod_CreditBureau_address.Key_flagged_nlr_addresses,
		'~thor_data400::key::quickheader::flagged_nlr_addresses',
		'~thor_data400::key::quickheader::'+filedate+'::flagged_nlr_addresses',
		bld_key
	);

	doMonthly := IF(
		header_quick._config(sourceIP, sourcePathMonthly).isNewEquifaxMonthlyFile(sourceIP),
		SEQUENTIAL(
			sprayMonthlyFiles,
			addMonthlySuper,
			bld_prepped,
			output(Header.Mod_CreditBureau_address.stats,named('nlr_counts')),
			bld_key,
			_control.fSubmitNewWorkunit('#workunit(\'name\',\'Scrubs_Equifax_Monthly\');\r\n'+'Scrubs_Equifax_Monthly.proc_generate_report();','thor400_44_eclcc')
		),
		output('No Monthly Files available')
	);

	buildAll := header_quick.proc_build_quick_hdr(filedate);

	QA_sample := header_quick.New_records_sample ; 

	Source_Check_rep := header_quick.Proc_source_check_report();

	RETURN SEQUENTIAL(
		check_superfiles_are_in_sync,
		header_quick._config(sourceIP, sourcePathMonthly).set_v_version(overwriteMonthlyFileDate),
		header_quick._config(sourceIP, sourcePathWeekly).set_v_eq_as_of_date(overwriteWeeklyFileDate),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, doWeekly,200),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, doMonthly,300),		
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, header_quick.Inputs_Clear,400),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, header_quick.Inputs_Set(filedate),500),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, notify('Build_Header_Ingest', '*'),600),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, buildAll, 700),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate,QA_sample, 800) /*,Source_Check_rep*/
	);
END;
