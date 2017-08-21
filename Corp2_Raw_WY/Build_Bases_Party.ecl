IMPORT corp2, tools, ut;

EXPORT Build_Bases_Party(
	STRING																						pfiledate,
	STRING																						pversion,
	BOOLEAN																						puseprod,	
	DATASET(Corp2_Raw_WY.Layouts.PartyLayoutIn)				pInCorps   = Corp2_Raw_WY.Files(pfiledate,pUseProd).Input.Party.Sprayed,
	DATASET(Corp2_Raw_WY.Layouts.PartyLayoutBase)			pBaseCorps = IF(Corp2_Raw_WY._Flags.Base.Party, Corp2_Raw_WY.Files(,pUseOtherEnvironment := FALSE).Base.Party.qa, DATASET([], Corp2_Raw_WY.Layouts.PartyLayoutBase))
) := MODULE

	Corp2_Raw_WY.Layouts.PartyLayoutBase standardize_input(Corp2_Raw_WY.Layouts.PartyLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the WY Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorps, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorps;
	combined_dist := DISTRIBUTE(combined, HASH(source_id));
	combined_sort := SORT(combined_dist, source_id, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_WY.Layouts.PartyLayoutBase rollupBase(	Corp2_Raw_WY.Layouts.PartyLayoutBase L,
																										Corp2_Raw_WY.Layouts.PartyLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baserollup 								:= ROLLUP(combined_sort,
																			rollupBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_WY.Filenames(pversion).Base.Party.New, baserollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_WY.Build_Bases_Party attribute')
									 );

END;

