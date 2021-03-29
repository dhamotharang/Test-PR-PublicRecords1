IMPORT _control, Doxie, dx_PhoneFinderReportDelta, PromoteSupers, RoxieKeyBuild, std, ut, scrubs, Scrubs_PhoneFinder, Orbit3;

EXPORT Proc_Build_PhoneFinderReportDelta(string version, const varstring eclsourceip, string thor_name, string idType, string oPhType, string rIndType, string trType, string srcType):= FUNCTION
	
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
																
		srcSpray						:= if(stringlib.stringtouppercase(trim(srcType, left, right)[1]) = 'Y',
																PhoneFinderReportDelta.Spray_PhoneFinderReportDelta(version, eclsourceip,'sources'),
														if(stringlib.stringtouppercase(trim(srcType, left, right)[1]) = 'N',
																PhoneFinderReportDelta.Empty_PhoneFinderReport(version, 'sources'),
																output('error_sources')));
		
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
	
	//Sources
		bldDltSrcs 					:= output(PhoneFinderReportDelta.Map_Sources(version),,'~thor_data400::base::phonefinderreportdelta::sources_'+version, __compressed__); 

		clrDltSrcs					:= nothor(Fileservices.ClearSuperFile('~thor_data400::base::phonefinderreportdelta::sources_delete', true));		

		mvDltSrcs						:= STD.File.PromoteSuperFileList(['~thor_data400::base::phonefinderreportdelta::sources',
																													'~thor_data400::base::phonefinderreportdelta::sources_father',
																													'~thor_data400::base::phonefinderreportdelta::sources_grandfather',
																													'~thor_data400::base::phonefinderreportdelta::sources_great_grandfather',
																													'~thor_data400::base::phonefinderreportdelta::sources_delete'], '~thor_data400::base::phonefinderreportdelta::sources_'+version, true);	
	
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
																																																		
	//Sources
		ctDltSrcsRaw			:= count(PhoneFinderReportDelta.File_PhoneFinder.Sources_Raw);
	
		//DltSrc - If daily file available, continue processing else use previous day's base file.
		pickDltSrcsH			:= if(ctDltSrcsRaw>0,
															PhoneFinderReportDelta.File_PhoneFinder.Sources_Raw + PhoneFinderReportDelta.File_PhoneFinder.Sources_History,
															PhoneFinderReportDelta.File_PhoneFinder.Sources_History);
													
		catDltSrcsH				:= output(dedup(sort(distribute(pickDltSrcsH, hash(transaction_id)), record, local), record, local),,'~thor_data400::in::phonefinderreportdelta::sources_history_'+version,__compressed__);
		
		mvDltSrcsH				:= STD.File.PromoteSuperFileList(['~thor_data400::in::phonefinderreportdelta::sources_history',
																													'~thor_data400::in::phonefinderreportdelta::sources_history_father',
																													'~thor_data400::in::phonefinderreportdelta::sources_history_grandfather',
																													'~thor_data400::in::phonefinderreportdelta::sources_history_great_grandfather',
																													'~thor_data400::in::phonefinderreportdelta::sources_history_delete'], '~thor_data400::in::phonefinderreportdelta::sources_history_'+version, true);		
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build Common PhoneFinder Report Deltabase Keys/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		//DF-23251: Add 'dx_' Prefix to Index Definitions
		//DF-23286: Update Keys
		//DF-27859: Delta Updates
		pBuildType			:= IF(ut.weekday((integer)version[1..8]) = 'SUNDAY',
													phonefinderreportDelta.Constants.buildType.FullBuild,
													phonefinderreportDelta.Constants.buildType.Daily);	
						 
		BOOLEAN isDelta	:= pBuildType=phonefinderreportDelta.Constants.buildType.Daily;	
	
		BuildKeys 			:= phonefinderreportDelta.proc_build_keys(version, isDelta);																	

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Update DOPs Page///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		pUpdateFlag			:=	IF(isDelta,'D','F');
		
		dopsUpdate 			:= IF(
													Scrubs.mac_ScrubsFailureTest('Scrubs_PhoneFinder_Identities,Scrubs_PhoneFinder_OtherPhones,Scrubs_PhoneFinder_RiskIndicators,Scrubs_PhoneFinder_Transactions,Scrubs_PhoneFinder_Sources',version),
													RoxieKeybuild.UpdateVersion('PhoneFinderRptDeltaKeys', version, _control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexis.com,darren.knowles@lexisnexisrisk.com',, 'N',,updateflag:=pUpdateFlag), 
													OUTPUT('Dops update failed due to reject warning(s)!',NAMED('Scrubs_Status'))
													);
	
		orbitupdate			:= Orbit3.proc_Orbit3_CreateBuild_AddItem('PhoneFinder Report Delta',version,'N', 'darren.knowles@lexisnexisrisk.com');
	
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
	//RUN SCRUBS/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		run_scrubs := Scrubs_PhoneFinder.Fn_RunScrubs(version);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Run Build & Provide Email on Build Status//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		sendEmail						:= sequential(
																			//Spray Input Files
																			parallel(	idSpray, 
																								oPhSpray,
																								rIndSpray,
																								trSpray,
																								srcSpray),

																			//Run Scrubs
																			run_scrubs;
																														
																			//Build Bases
																			parallel(	sequential(bldDltIdent, clrDltIdentDel, mvDltIdentBase),
																								sequential(bldDltOPhones, clrDltOPhones, mvDltOPhones),
																								sequential(bldDltRInd, clrDltRInd, mvDltRInd),
																								sequential(bldDltTrans, clrDltTrans, mvDltTrans),
																								sequential(bldDltSrcs, clrDltSrcs, mvDltSrcs)),
																														
																			//Build History Files
																			parallel( sequential(catDltIdentH, mvDltIdentH),
																								sequential(catDltOPhH, mvDltOPhH),
																								sequential(catDltRIndH, mvDltRIndH),
																								sequential(catDltTransH, mvDltTransH),
																								sequential(catDltSrcsH, mvDltSrcsH)),
																														
																			//Build Keys
																		  BuildKeys,																	
																			
																		  dopsUpdate,
																			
																			//Orbit Update
																			orbitupdate)
																			/*buildStrata)*/:
																														
																			//Send Email Notifications
																			Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexis.com'/*,darren.knowles@lexisnexisrisk.com'*/, 'PhoneFinderReportDelta Key Build Succeeded', workunit + ': Build completed.')),
																			Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexis.com'/*,darren.knowles@lexisnexisrisk.com'*/, 'PhoneFinderReportDelta Build Failed', workunit + '\n' + FAILMESSAGE));


	RETURN sendEmail;

END;