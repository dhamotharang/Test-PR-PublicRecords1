import Business_Header, Mdr;

export Update_Base(

	 string																			pversion
	,dataset(Layouts.Input.RSIH								)	pSprayedRSIHFile		= Files().InputRSIH.using
	,dataset(Layouts.Input.CC									)	pSprayedCCFile			= Files().InputCC.using
	,boolean																		pUseBusHeader				= _Flags.UseBusinessHeader
	,dataset(Layouts.Base											)	pBaseFile						= Files().base.qa
	,boolean																		pShouldUpdate				= _Flags.Update
	,dataset(Business_Header.Layout_BH_Best)		pBusHeaderBestFile 	= Business_Header.Files().Base.Business_Header_Best.QA
	,dataset(Business_Header.Layout_SIC_Code)		pBusSICRecs 				= Business_Header.Persists().BHBDIDSIC
) :=
function

	dPrepCCFile								:= Prep_File().CC(pSprayedCCFile);
	dStandardizedInputCCFile	:= Standardize_Input.fAllCC	(dPrepCCFile,pversion);

	dPrepRSIHFile								:= Prep_File().RSIH(pSprayedRSIHFile);
	dStandardizedInputRSIHFile	:= Standardize_Input.fAllRSIH	(dPrepRSIHFile,pversion);
	
	// Build record set from the best business header file if pUseBusHeader is true, otherwise create empty record set
	dPrepBusHeaderFile := if(pUseBusHeader,Prep_File().BusHeader(,pBusHeaderBestFile,pBusSICRecs),dataset([],Layouts.base)); 

	base_file								:= project(pBaseFile, transform(Layouts.Base, self.record_type := 'H'; self := left));
	
	update_combined					:= if(pShouldUpdate
																,dStandardizedInputRSIHFile + dStandardizedInputCCFile + dPrepBusHeaderFile + base_file
																,dStandardizedInputRSIHFile + dStandardizedInputCCFile + dPrepBusHeaderFile
															);
	
	//DF-26534: Add Global_SID to Non-BusinessHeader Records
	busHeader_file					:= update_combined(rawfields.source='BusinessHeader');	
	nonBusHeader_gs					:= update_combined(rawfields.source<>'BusinessHeader' and global_sid<>0);	
	nonBusHeader_no_gs			:= update_combined(rawfields.source<>'BusinessHeader' and global_sid=0);
	addGlobalSID 						:= mdr.macGetGlobalSID(nonBusHeader_no_gs, 'Debt_Settlement', '', 'global_sid');	
	concat_file							:= busHeader_file + nonBusHeader_gs + addGlobalSID;
															
	dAppendIds							:= Append_Ids.fAll				(concat_file			);
	dRollup									:= Rollup_Base						(dAppendIds						);
	return dRollup;

end;