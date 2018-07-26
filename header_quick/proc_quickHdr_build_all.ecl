import _control,ut,RoxieKeyBuild,header,PromoteSupers,Data_Services;
export proc_quickHdr_build_all (string sourceIP) := function
   

   SHARED filedate:=header.Sourcedata_month.v_eq_as_of_date;                                      
   EXPORT getVname (string superfile, string v_end = ':') := FUNCTION

        FileName:= fileservices.GetSuperFileSubName(superfile,1);
        v_strt  := stringlib.stringfind(FileName,'20',1);
        v_endd	:= if(v_end='',length(FileName),stringlib.stringfind(FileName[v_strt..],v_end,1));
        v_name  := FileName[v_strt..v_strt+if(v_endd<1,length(FileName),v_endd)-2];

        RETURN v_name;

    END;
  keyPrefix := Data_Services.Data_Location.Prefix('LAB_xLink'); // eg 	~thor400_44::
  xlink_superfile_ver := getVname(keyPrefix+'key::insuranceheader_xlink::qa::did::refs::name')[1..8];
  header_raw_prod_ver := getVname('~thor_data400::base::header_raw_Prod','')[1..8];
  
  check_superfiles_are_in_sync := if ( xlink_superfile_ver <> header_raw_prod_ver
                                    ,fail('Superfiles are not in sync!'));
	
	destinationGroup	:= _control.TargetGroup.Thor400_44;
	recordSize				:= 600;
  sprayIP           := header_quick._config.sprayIP(sourceIP);
                                                     
	weeklyFileName		:= FileServices.remotedirectory(sprayIP,header_quick._config.sourcePath,'WEEKLY_HEADER_*.DAT',false)(size != 0 )[1].name;
	
	sprayWeeklyFile		:= fileservices.sprayfixed(sprayIP,header_quick._config.sourcePath+weeklyFileName,recordSize,destinationGroup,'~thor400_84::in::eq_weekly::'+filedate,-1,,,true,true,true);
	
	monthly_verion		:= Header.Sourcedata_month.v_version;										 
	sprayMonthlyFiles	:= parallel(
																fileservices.sprayfixed(sprayIP,header_quick._config.sourcePath+'MONTHLY_HEADER_E_'+monthly_verion+'.DAT',recordSize,destinationGroup,'~thor_data400::in::hdr_east_'+filedate,-1,,,true,true,true),
																fileservices.sprayfixed(sprayIP,header_quick._config.sourcePath+'MONTHLY_HEADER_W_'+monthly_verion+'.DAT',recordSize,destinationGroup,'~thor_data400::in::hdr_west_'+filedate,-1,,,true,true,true),
																fileservices.sprayfixed(sprayIP,header_quick._config.sourcePath+'MONTHLY_HEADER_S_'+monthly_verion+'.DAT',recordSize,destinationGroup,'~thor_data400::in::hdr_south_'+filedate,-1,,,true,true,true),
																fileservices.sprayfixed(sprayIP,header_quick._config.sourcePath+'MONTHLY_HEADER_C_'+monthly_verion+'.DAT',recordSize,destinationGroup,'~thor_data400::in::hdr_central_'+filedate,-1,,,true,true,true)
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

	doMonthly := if(header_quick._config.isNewEquifaxMonthlyFile(sourceIP)
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
	
	return sequential(
                     check_superfiles_are_in_sync
                    ,header_quick._config.set_v_version
                    ,header_quick._config.set_v_eq_as_of_date
                    ,doWeekly
                    ,doMonthly
                    ,Inputs_Clear
                    ,Inputs_Set(filedate)
                    ,buildAll
                    ,QA_sample/*,Source_Check_rep*/
                    );
end;