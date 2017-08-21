IMPORT tools, corp2;

EXPORT Build_Bases_FLMLPart(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_CT.Layouts.FLMLPartLayoutIn)		pInFLMLPart   	= Corp2_Raw_CT.Files(pfiledate,pUseProd).Input.fFLMLPart,
	DATASET(Corp2_Raw_CT.Layouts.FLMLPartLayoutBase)	pBaseFLMLPart 	= IF(Corp2_Raw_CT._Flags.Base.FLMLPart, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.FLMLPart.qa, 	DATASET([], Corp2_Raw_CT.Layouts.FLMLPartLayoutBase))
) := MODULE

	Corp2_Raw_CT.Layouts.FLMLPartLayoutBase standardize_input(Corp2_Raw_CT.Layouts.FLMLPartLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
	end;

	// Take the IA FLMLPart update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInFLMLPart, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseFLMLPart;
	combined_dist := DISTRIBUTE(combined, HASH(idBus));
	combined_sort := SORT(combined_dist, idBus, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CT.Layouts.FLMLPartLayoutBase rollupBase(Corp2_Raw_CT.Layouts.FLMLPartLayoutBase L,
																										  Corp2_Raw_CT.Layouts.FLMLPartLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseFLMLPart			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CT.Filenames(pversion).Base.FLMLPart.New, baseFLMLPart, Build_FLMLPart_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_FLMLPart_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CT.Build_Bases_FLMLPart attribute')
									 );

END;
