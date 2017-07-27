import Business_Header;

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
	
	// Build record set from the best businesee header file it pUseBusHeader is true, otherwise create empty record set
	dPrepBusHeaderFile := if(pUseBusHeader,Prep_File().BusHeader(),dataset([],Layouts.base)); 

	base_file								:= project(pBaseFile, transform(Layouts.Base, self.record_type := 'H'; self := left));
	
	update_combined					:= if(pShouldUpdate
																,dStandardizedInputRSIHFile + dStandardizedInputCCFile + dPrepBusHeaderFile + base_file
																,dStandardizedInputRSIHFile + dStandardizedInputCCFile + dPrepBusHeaderFile
															);
															
	dAppendIds							:= Append_Ids.fAll				(update_combined			);
	dRollup									:= Rollup_Base						(dAppendIds						);
	return dRollup;

end;