import _control, VersionControl, INQL_FFD, ut, std;

// Booleans that drive the build process 

export _Flags(string pVersion = '', boolean isUpdate = true, boolean isFCRA = true)  := module
	
  export LastKeyVersionApproved   		:= (INQL_FFD.Fn_Get_Current_Version.fcra_keys_dops_prod = 
																				 INQL_FFD.Fn_Get_Current_Version.fcra_keys_dops_certQA) or 
																				 trim(INQL_FFD.Fn_Get_Current_Version.fcra_keys_dops_certQA) = '';
  
  export LastFullKeyVersionApproved   := INQL_FFD.Fn_Get_Current_Version.fcra_full_keys_dops_prod = 
																				 INQL_FFD.Fn_Get_Current_Version.fcra_full_keys_dops_certQA;

	export ExistFilesToProcess   		:= 	nothor(fileservices.GetSuperFileSubCount(INQL_FFD.Filenames(isUpdate,isFCRA,pVersion).Input)) +
																			nothor(fileservices.GetSuperFileSubCount(INQL_FFD.Filenames(isUpdate,isFCRA,pVersion).InputBuilding)) > 0; 

  export DailyBaseFileExist				:=  if(nothor(fileservices.FileExists(inql_ffd.filenames(true,isFCRA,pVersion).Base.new)),true,false);
	export WeeklyBaseFileExist			:=  if(nothor(fileservices.FileExists(inql_ffd.filenames(false,isFCRA,pVersion).Base.new)),true,false);
	
	export versionsInDailyBase    	:= table(INQL_FFD.Files(true,isFCRA,pVersion).Base.qa,{version,count(group)},version,few,merge);
	setVersionsInDailyBase 					:= SET(versionsInDailyBase,version);
	versionsInWeeklyBase   					:= table(INQL_FFD.Files(false,isFCRA,pVersion).Base.qa,{version,count(group)},version,few,merge)
																					(version in setVersionsInDailyBase);
	export isDailyBaseToFlush     	:= count(versionsInDailyBase) = count(versionsInWeeklyBase) and LastFullKeyVersionApproved;
	
	export existDeltaKey            := nothor(fileservices.GetSuperFileSubCount(inql_ffd.keynames(true).lexid.qa)) > 1; 

	
	export dt1yearago  := ut.date_math(pVersion,-365);
	
	export dt2yearsago := ut.date_math(pVersion,-730);
	
	next_full_version:= ut.date_math(INQL_FFD.Fn_Get_Current_Version.fcra_full_keys_dops_certQA,7);
	todaydate:= (STRING8)Std.Date.Today();
	export timetobuildfull					:=next_full_version<=todaydate;
	
	no_input_file_msg								:= if (ExistFilesToProcess = False,'There is no new input file to process','');
  wrong_version_msg								:= if (VersionControl.IsValidVersion(pversion), '', 'No Valid version parameter passed'); 
  daily_base_exist_msg 						:= if (DailyBaseFileExist, pVersion + ' Daily Base File already exists','');													 
  weekly_base_exist_msg						:= if (WeeklyBaseFileExist, pVersion + ' Weekly Base File already exists','');

	
  export DontBuildMsg   	:= stringlib.stringcleanspaces
																(
																	no_input_file_msg + 
																	if(wrong_version_msg <> ''		,'\n\n'+ wrong_version_msg,'') +
																	if(daily_base_exist_msg <> ''	,'\n\n'+ daily_base_exist_msg,'') +		
																	if(weekly_base_exist_msg <> '','\n\n'+ weekly_base_exist_msg,'')
																);	
  export weekday          := 	ut.weekday((UNSIGNED)ut.getdate) NOT IN ['SATURDAY','SUNDAY'];
	
end;
