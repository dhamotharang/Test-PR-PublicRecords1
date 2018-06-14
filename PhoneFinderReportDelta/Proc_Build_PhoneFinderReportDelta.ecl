IMPORT _control, Doxie, PromoteSupers, RoxieKeyBuild, std, ut;

EXPORT Proc_Build_PhoneFinderReportDelta(string version, const varstring eclsourceip, string thor_name, string idType, string oPhType, string rIndType, string trType):= FUNCTION
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Spray PhoneFinder Report Deltabase Files to Thor///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		idSpray							:= if(stringlib.stringtouppercase(trim(idType, left, right)[1]) = 'Y',
																PhoneFinderReportDelta.Spray_PhoneFinderReportDelta(version, eclsourceip,'identities'),
														if(stringlib.stringtouppercase(trim(idType, left, right)[1]) = 'N',
																PhoneFinderReportDelta.Empty_PhoneFinderReport(version, 'identities'),
																output('error_identities')));
														
		oPhSpray						:= if(stringlib.stringtouppercase(trim(oPhType, left, right)[1]) = 'Y',
																PhoneFinderReportDelta.Spray_PhoneFinderReportDelta(version, eclsourceip,'otherphones'),
														if(stringlib.stringtouppercase(trim(oPhType, left, right)[1]) = 'N',
																PhoneFinderReportDelta.Empty_PhoneFinderReport(version, 'otherphones'),
																output('error_otherPhones')));
		
		rIndSpray						:= if(stringlib.stringtouppercase(trim(rIndType, left, right)[1]) = 'Y',
																PhoneFinderReportDelta.Spray_PhoneFinderReportDelta(version, eclsourceip,'riskindicators'),
														if(stringlib.stringtouppercase(trim(rIndType, left, right)[1]) = 'N',
																PhoneFinderReportDelta.Empty_PhoneFinderReport(version, 'riskindicators'),
																output('error_riskIndicators')));
														
		trSpray							:= if(stringlib.stringtouppercase(trim(trType, left, right)[1]) = 'Y',
																PhoneFinderReportDelta.Spray_PhoneFinderReportDelta(version, eclsourceip,'transaction'),
														if(stringlib.stringtouppercase(trim(trType, left, right)[1]) = 'N',
																PhoneFinderReportDelta.Empty_PhoneFinderReport(version, 'transaction'),
																output('error_transaction')));
		
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build/Move Common PhoneFinder Report Deltabase Bases///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		//Identities
		bldDltIdent 				:= output(PhoneFinderReportDelta.Map_Identities(version),,'~thor_data400::base::phonefinderreportdelta::identities_'+version, __compressed__); 

		clrDltIdentDel			:= nothor(Fileservices.ClearSuperFile('~thor_data400::base::phonefinderreportdelta::identities_delete', true));		

		mvDltIdentBase			:= STD.File.PromoteSuperFileList(['~thor_data400::base::phonefinderreportdelta::identities',
																													'~thor_data400::base::phonefinderreportdelta::identities_father',
																													'~thor_data400::base::phonefinderreportdelta::identities_grandfather',
																													'~thor_data400::base::phonefinderreportdelta::identities_great_grandfather',
																													'~thor_data400::base::phonefinderreportdelta::identities_delete'], '~thor_data400::base::phonefinderreportdelta::identities_'+version, true);	
		
		//Other Phones
		bldDltOPhones 			:= output(PhoneFinderReportDelta.Map_OtherPhones(version),,'~thor_data400::base::phonefinderreportdelta::otherphones_'+version, __compressed__); 

		clrDltOPhones				:= nothor(Fileservices.ClearSuperFile('~thor_data400::base::phonefinderreportdelta::otherphones_delete', true));		

		mvDltOPhones				:= STD.File.PromoteSuperFileList(['~thor_data400::base::phonefinderreportdelta::otherphones',
																													'~thor_data400::base::phonefinderreportdelta::otherphones_father',
																													'~thor_data400::base::phonefinderreportdelta::otherphones_grandfather',
																													'~thor_data400::base::phonefinderreportdelta::otherphones_great_grandfather',
																													'~thor_data400::base::phonefinderreportdelta::otherphones_delete'], '~thor_data400::base::phonefinderreportdelta::otherphones_'+version, true);																					
	
		//Risk Indicators
		bldDltRInd 					:= output(PhoneFinderReportDelta.Map_RiskIndicators(version),,'~thor_data400::base::phonefinderreportdelta::riskindicators_'+version, __compressed__); 

		clrDltRInd					:= nothor(Fileservices.ClearSuperFile('~thor_data400::base::phonefinderreportdelta::riskindicators_delete', true));		

		mvDltRInd						:= STD.File.PromoteSuperFileList(['~thor_data400::base::phonefinderreportdelta::riskindicators',
																													'~thor_data400::base::phonefinderreportdelta::riskindicators_father',
																													'~thor_data400::base::phonefinderreportdelta::riskindicators_grandfather',
																													'~thor_data400::base::phonefinderreportdelta::riskindicators_great_grandfather',
																													'~thor_data400::base::phonefinderreportdelta::riskindicators_delete'], '~thor_data400::base::phonefinderreportdelta::riskindicators_'+version, true);	
	
		//Transactions
		bldDltTrans 				:= output(PhoneFinderReportDelta.Map_Transactions(version),,'~thor_data400::base::phonefinderreportdelta::transactions_'+version, __compressed__); 

		clrDltTrans					:= nothor(Fileservices.ClearSuperFile('~thor_data400::base::phonefinderreportdelta::transactions_delete', true));		

		mvDltTrans					:= STD.File.PromoteSuperFileList(['~thor_data400::base::phonefinderreportdelta::transactions',
																													'~thor_data400::base::phonefinderreportdelta::transactions_father',
																													'~thor_data400::base::phonefinderreportdelta::transactions_grandfather',
																													'~thor_data400::base::phonefinderreportdelta::transactions_great_grandfather',
																													'~thor_data400::base::phonefinderreportdelta::transactions_delete'], '~thor_data400::base::phonefinderreportdelta::transactions_'+version, true);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build/Move Raw PhoneFinder Report Deltabase History Files//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		//Identities
		ctDltIdentRaw				:= count(PhoneFinderReportDelta.File_PhoneFinder.Identities_Raw);
	
		//DltIdent - If daily file available, continue processing else use previous day's base file.
		pickDltIdentH				:= if(ctDltIdentRaw>0,
															PhoneFinderReportDelta.File_PhoneFinder.Identities_Raw + PhoneFinderReportDelta.File_PhoneFinder.Identities_History,
															PhoneFinderReportDelta.File_PhoneFinder.Identities_History);
													
		catDltIdentH				:= output(dedup(sort(distribute(pickDltIdentH, hash(transaction_id)), record, local), record, local),,'~thor_data400::in::phonefinderreportdelta::identities_history_'+version,__compressed__);
		
		mvDltIdentH					:= STD.File.PromoteSuperFileList(['~thor_data400::in::phonefinderreportdelta::identities_history',
																													'~thor_data400::in::phonefinderreportdelta::identities_history_father',
																													'~thor_data400::in::phonefinderreportdelta::identities_history_grandfather',
																													'~thor_data400::in::phonefinderreportdelta::identities_history_great_grandfather',
																													'~thor_data400::in::phonefinderreportdelta::identities_history_delete'], '~thor_data400::in::phonefinderreportdelta::identities_history_'+version, true);	
		
		//OtherPhones
		ctDltOPhRaw					:= count(PhoneFinderReportDelta.File_PhoneFinder.OtherPhones_Raw);
	
		//DltOPh - If daily file available, continue processing else use previous day's base file.
		pickDltOPhH					:= if(ctDltOphRaw>0,
															PhoneFinderReportDelta.File_PhoneFinder.OtherPhones_Raw + PhoneFinderReportDelta.File_PhoneFinder.OtherPhones_History,
															PhoneFinderReportDelta.File_PhoneFinder.OtherPhones_History);
													
		catDltOPhH					:= output(dedup(sort(distribute(pickDltOPhH, hash(transaction_id)), record, local), record, local),,'~thor_data400::in::phonefinderreportdelta::otherphones_history_'+version,__compressed__);
		
		mvDltOPhH						:= STD.File.PromoteSuperFileList(['~thor_data400::in::phonefinderreportdelta::otherphones_history',
																													'~thor_data400::in::phonefinderreportdelta::otherphones_history_father',
																													'~thor_data400::in::phonefinderreportdelta::otherphones_history_grandfather',
																													'~thor_data400::in::phonefinderreportdelta::otherphones_history_great_grandfather',
																													'~thor_data400::in::phonefinderreportdelta::otherphones_history_delete'], '~thor_data400::in::phonefinderreportdelta::otherphones_history_'+version, true);	
	
		//RiskIndicators
		ctDltRIndRaw				:= count(PhoneFinderReportDelta.File_PhoneFinder.RiskIndicators_Raw);
	
		//DltOPh - If daily file available, continue processing else use previous day's base file.
		pickDltRIndH				:= if(ctDltRIndRaw>0,
															PhoneFinderReportDelta.File_PhoneFinder.RiskIndicators_Raw + PhoneFinderReportDelta.File_PhoneFinder.RiskIndicators_History,
															PhoneFinderReportDelta.File_PhoneFinder.RiskIndicators_History);
													
		catDltRIndH					:= output(dedup(sort(distribute(pickDltRIndH, hash(transaction_id)), record, local), record, local),,'~thor_data400::in::phonefinderreportdelta::riskindicators_history_'+version,__compressed__);
		
		mvDltRIndH					:= STD.File.PromoteSuperFileList(['~thor_data400::in::phonefinderreportdelta::riskindicators_history',
																													'~thor_data400::in::phonefinderreportdelta::riskindicators_history_father',
																													'~thor_data400::in::phonefinderreportdelta::riskindicators_history_grandfather',
																													'~thor_data400::in::phonefinderreportdelta::riskindicators_history_great_grandfather',
																													'~thor_data400::in::phonefinderreportdelta::riskindicators_history_delete'], '~thor_data400::in::phonefinderreportdelta::riskindicators_history_'+version, true);	
																																																		
	//Transactions
		ctDltTransRaw				:= count(PhoneFinderReportDelta.File_PhoneFinder.Transactions_Raw);
	
		//DltTrans - If daily file available, continue processing else use previous day's base file.
		pickDltTransH				:= if(ctDltTransRaw>0,
															PhoneFinderReportDelta.File_PhoneFinder.Transactions_Raw + PhoneFinderReportDelta.File_PhoneFinder.Transactions_History,
															PhoneFinderReportDelta.File_PhoneFinder.Transactions_History);
													
		catDltTransH				:= output(dedup(sort(distribute(pickDltTransH, hash(transaction_id)), record, local), record, local),,'~thor_data400::in::phonefinderreportdelta::transactions_history_'+version,__compressed__);
		
		mvDltTransH					:= STD.File.PromoteSuperFileList(['~thor_data400::in::phonefinderreportdelta::transactions_history',
																													'~thor_data400::in::phonefinderreportdelta::transactions_history_father',
																													'~thor_data400::in::phonefinderreportdelta::transactions_history_grandfather',
																													'~thor_data400::in::phonefinderreportdelta::transactions_history_great_grandfather',
																													'~thor_data400::in::phonefinderreportdelta::transactions_history_delete'], '~thor_data400::in::phonefinderreportdelta::transactions_history_'+version, true);	
																																																		
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build Common PhoneFinder Report Deltabase Keys/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PhoneFinderReportDelta.Key_Identities
																								,'~thor_data400::key::phonefinderreportdelta::identities'
																								,'~thor_data400::key::'+version+'::PhoneFinderReportDelta::identities'
																								,bkDltIdent
																								);

		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PhoneFinderReportDelta.Key_OtherPhones
																								,'~thor_data400::key::phonefinderreportdelta::otherphones'
																								,'~thor_data400::key::'+version+'::PhoneFinderReportDelta::otherphones'
																								,bkDltOPhones
																								);

		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PhoneFinderReportDelta.Key_RiskIndicators
																								,'~thor_data400::key::phonefinderreportdelta::riskindicators'
																								,'~thor_data400::key::'+version+'::PhoneFinderReportDelta::riskindicators'
																								,bkDltRInd
																								);
																																													
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PhoneFinderReportDelta.Key_Transactions
																								,'~thor_data400::key::phonefinderreportdelta::transactions'
																								,'~thor_data400::key::'+version+'::PhoneFinderReportDelta::transactions'
																								,bkDltTrans
																								);
																																													
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Move PhoneFinder Report Deltabase Keys to Superfiles///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//Identities
		Roxiekeybuild.Mac_SK_Move_to_Built_V2('~thor_data400::key::phonefinderreportdelta::identities'
																					,'~thor_data400::key::'+version+'::PhoneFinderReportDelta::identities'
																					,mvBltDltIdent
																					);

		PromoteSupers.Mac_SK_Move_V2('~thor_data400::key::phonefinderreportdelta::identities', 'Q',	mvQADltIdent, '4');
		
		//Other Phones
		Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonefinderreportdelta::otherphones'
																					,'~thor_data400::key::'+version+'::PhoneFinderReportDelta::otherphones'
																					,mvBltDltOPhones
																					);

		PromoteSupers.Mac_SK_Move_V2('~thor_data400::key::phonefinderreportdelta::otherphones', 'Q',	mvQADltOPhones, '4');

		//Risk Indicators
		Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonefinderreportdelta::riskindicators'
																					,'~thor_data400::key::'+version+'::PhoneFinderReportDelta::riskindicators'
																					,mvBltDltRInd
																					);

		PromoteSupers.Mac_SK_Move_V2('~thor_data400::key::phonefinderreportdelta::riskindicators', 'Q',	mvQADltRInd, '4');
		
		//Transactions
		Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonefinderreportdelta::transactions'
																					,'~thor_data400::key::'+version+'::PhoneFinderReportDelta::transactions'
																					,mvBltDltTrans
																					);

		PromoteSupers.Mac_SK_Move_V2('~thor_data400::key::phonefinderreportdelta::transactions', 'Q',	mvQADltTrans, '4');
		
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Update DOPs Page///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		dopsUpdate 					:= RoxieKeybuild.UpdateVersion('PhoneFinderRptDelta', version, _control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexis.com', , 'N');
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build Strata Reports for Build/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		PhoneFinderReportDelta.Out_Strata_Population_Stats(PhoneFinderReportDelta.File_PhoneFinder.Identities_Main
																												,PhoneFinderReportDelta.File_PhoneFinder.OtherPhones_Main
																												,PhoneFinderReportDelta.File_PhoneFinder.RiskIndicators_Main
																												,PhoneFinderReportDelta.File_PhoneFinder.Transactions_Main
																												,version
																												,buildStrata);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Run Build & Provide Email on Build Status//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		sendEmail						:= sequential(//Spray Input Files
																			parallel(	idSpray, 
																								oPhSpray,
																								rIndSpray,
																								trSpray),
																														
																			//Build Bases
																			parallel(	sequential(bldDltIdent, clrDltIdentDel, mvDltIdentBase),
																								sequential(bldDltOPhones, clrDltOPhones, mvDltOPhones),
																								sequential(bldDltRInd, clrDltRInd, mvDltRInd),
																								sequential(bldDltTrans, clrDltTrans, mvDltTrans)),
																														
																			//Build History Files
																			parallel( sequential(catDltIdentH, mvDltIdentH),
																								sequential(catDltOPhH, mvDltOPhH),
																								sequential(catDltRIndH, mvDltRIndH),
																								sequential(catDltTransH, mvDltTransH)),
																														
																			//Build Keys
																			parallel(	sequential(bkDltIdent, mvBltDltIdent, mvQADltIdent),
																								sequential(bkDltOPhones, mvBltDltOPhones, mvQADltOPhones),
																								sequential(bkDltRInd, mvBltDltRInd, mvQADltRInd), 
																								sequential(bkDltTrans, mvBltDltTrans, mvQADltTrans))
																			)/*, 
																			dopsUpdate,
																			buildStrata)*/:
																														
																			//Send Email Notifications
																			Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexis.com', 'PhoneFinderReportDelta Key Build Succeeded', workunit + ': Build completed.')),
																			Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexis.com', 'PhoneFinderReportDelta Build Failed', workunit + '\n' + FAILMESSAGE));

	RETURN sendEmail;

END;