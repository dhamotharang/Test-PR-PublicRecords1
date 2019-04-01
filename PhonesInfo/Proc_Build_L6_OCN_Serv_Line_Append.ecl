IMPORT _control, Gong, PhonesPlus_v2, Std;

	//DF-24037: Replace LIDB Use Lerg6 for Carrier Info
	
EXPORT Proc_Build_L6_OCN_Serv_Line_Append(string version) := FUNCTION
	
	//Move Daily File
	moveDaily							:= Std.File.PromoteSuperFileList(['~thor_data400::in::phones::new_phone_daily',
																													'~thor_data400::in::phones::new_phone_daily_delete'], '~thor_data400::in::phones::new_phone_daily_' + version, true);			

	//Check For Daily File
	dailyFile							:= dataset('~thor_data400::in::phones::new_phone_daily_' + version, PhonesInfo.Layout_Lerg.lerg6UpdHist, flat);
	checkDaily						:= if(count(dailyFile)>0,
															moveDaily,
															output('no daily file found'));	

	//Concat Daily File to History File
	concatDailyHistory		:= output(dedup(sort(distribute(PhonesInfo.File_Lerg.Lerg6NewPhone + PhonesInfo.File_Lerg.Lerg6UpdPhoneHist, hash(reference_id)), record, local), record, local),, '~thor_data400::in::phones::lerg6_upd_phone_history_' + version, __compressed__);
	
	//Delete Files 
	clearDeletes 					:= sequential(nothor(fileservices.clearsuperfile('~thor_data400::in::phones::new_phone_daily_delete', true)),
																			nothor(fileservices.clearsuperfile('~thor_data400::in::phones::lerg6_upd_phone_history_delete', true)),
																			nothor(fileservices.clearsuperfile('~thor_data400::base::phones::lerg6_upd_phone_delete', true)));
		
	//Move History Files
	moveDailyHistory			:= Std.File.PromoteSuperFileList(['~thor_data400::in::phones::lerg6_upd_phone_history',
																													'~thor_data400::in::phones::lerg6_upd_phone_history_father',
																													'~thor_data400::in::phones::lerg6_upd_phone_history_grandfather',
																													'~thor_data400::in::phones::lerg6_upd_phone_history_delete'], '~thor_data400::in::phones::lerg6_upd_phone_history_' + version, true);																																																			
	
	//Create Base File
	buildBase							:= output(PhonesInfo.Map_L6_OCN_Serv_Line_Append(version),, '~thor_data400::base::phones::lerg6_upd_phone_' + version, __compressed__);
	
	//Move Base Files
	moveBase							:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::lerg6_upd_phone',
																													'~thor_data400::base::phones::lerg6_upd_phone_father',
																													'~thor_data400::base::phones::lerg6_upd_phone_grandfather',
																													'~thor_data400::base::phones::lerg6_upd_phone_delete'], '~thor_data400::base::phones::lerg6_upd_phone_' + version, true);																						
	//Email Build Status	
	emailDOps							:= ';darren.knowles@lexisnexisrisk.com; charlene.ros@lexisnexisrisk.com; gregory.rose@lexisnexisrisk.com';
	emailDev							:= ';judy.tao@lexisnexisrisk.com';
	
	emailTarget						:= _control.MyInfo.EmailAddressNotify + emailDev;
	emailBuildNotice 			:= if(count(PhonesInfo.File_Lerg.Lerg6UpdPhone(phone<>'')) > 0
																		,fileservices.SendEmail(emailTarget, 'Phones Info: Lerg6 OCN/Serv/Line Append File', 'Phones Info: Lerg6 OCN/Serv/Line Append File Is Now Available.  Please see: ' + 'http://prod_esp.br.seisint.com:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																		,fileservices.SendEmail(emailTarget, 'Phones Info: Lerg6 OCN/Serv/Line Append File', 'There Were No Lerg6 OCN/Serv/Line Append Records In This Build')
																		);		
	
	//Run Actions
	RETURN sequential(checkDaily,
										concatDailyHistory,
										clearDeletes,
										moveDailyHistory,
										buildBase,
										moveBase,
										emailBuildNotice
										);
	
END;