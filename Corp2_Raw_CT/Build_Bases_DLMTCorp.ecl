IMPORT tools, corp2;

EXPORT Build_Bases_DLMTCorp(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_CT.Layouts.DLMTCorpLayoutIn)		pInDLMTCorp   	= Corp2_Raw_CT.Files(pfiledate,pUseProd).Input.fDLMTCorp,
	DATASET(Corp2_Raw_CT.Layouts.DLMTCorpLayoutBase)	pBaseDLMTCorp 	= IF(Corp2_Raw_CT._Flags.Base.DLMTCorp, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.DLMTCorp.qa, 	DATASET([], Corp2_Raw_CT.Layouts.DLMTCorpLayoutBase))
) := MODULE

	Corp2_Raw_CT.Layouts.DLMTCorpLayoutBase standardize_input(Corp2_Raw_CT.Layouts.DLMTCorpLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
	end;

	// Take the IA DLMTCorp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInDLMTCorp, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseDLMTCorp;
	combined_dist := DISTRIBUTE(combined, HASH(idBus));
	combined_sort := SORT(combined_dist, idBus, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CT.Layouts.DLMTCorpLayoutBase rollupBase(Corp2_Raw_CT.Layouts.DLMTCorpLayoutBase L,
																										  Corp2_Raw_CT.Layouts.DLMTCorpLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseDLMTCorp			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CT.Filenames(pversion).Base.DLMTCorp.New, baseDLMTCorp, Build_DLMTCorp_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_DLMTCorp_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CT.Build_Bases_DLMTCorp attribute')
									 );

END;
