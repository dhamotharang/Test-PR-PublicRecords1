IMPORT tools, corp2;

EXPORT Build_Bases_FLMTCorp(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_CT.Layouts.FLMTCorpLayoutIn)		pInFLMTCorp   	= Corp2_Raw_CT.Files(pfiledate,pUseProd).Input.fFLMTCorp,
	DATASET(Corp2_Raw_CT.Layouts.FLMTCorpLayoutBase)	pBaseFLMTCorp 	= IF(Corp2_Raw_CT._Flags.Base.FLMTCorp, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.FLMTCorp.qa, 	DATASET([], Corp2_Raw_CT.Layouts.FLMTCorpLayoutBase))
) := MODULE

	Corp2_Raw_CT.Layouts.FLMTCorpLayoutBase standardize_input(Corp2_Raw_CT.Layouts.FLMTCorpLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
	end;

	// Take the IA FLMTCorp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInFLMTCorp, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseFLMTCorp;
	combined_dist := DISTRIBUTE(combined, HASH(idBus));
	combined_sort := SORT(combined_dist, idBus, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CT.Layouts.FLMTCorpLayoutBase rollupBase(Corp2_Raw_CT.Layouts.FLMTCorpLayoutBase L,
																										  Corp2_Raw_CT.Layouts.FLMTCorpLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseFLMTCorp			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CT.Filenames(pversion).Base.FLMTCorp.New, baseFLMTCorp, Build_FLMTCorp_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_FLMTCorp_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CT.Build_Bases_FLMTCorp attribute')
									 );

END;
