IMPORT tools, ut;

EXPORT Build_Bases_Actions(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																								puseprod,
	DATASET(Corp2_Raw_NV.Layouts.ActionsLayoutIn)					pInActions   	= Corp2_Raw_NV.Files(pfiledate,puseprod).Input.Actions.Logical,
	DATASET(Corp2_Raw_NV.Layouts.ActionsLayoutBase)				pBaseActions 	= IF(Corp2_Raw_NV._Flags.Base.Actions, Corp2_Raw_NV.Files(,pUseOtherEnvironment := FALSE).Base.Actions.qa, 	DATASET([], Corp2_Raw_NV.Layouts.ActionsLayoutBase))
) := MODULE

	Corp2_Raw_NV.Layouts.ActionsLayoutBase standardize_input(Corp2_Raw_NV.Layouts.ActionsLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the NV Actions update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInActions, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseActions;
	combined_dist := DISTRIBUTE(combined, HASH(Corp_id));
	combined_sort := SORT(combined_dist, corp_id, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_NV.Layouts.ActionsLayoutBase rollupBase(	Corp2_Raw_NV.Layouts.ActionsLayoutBase L,
																											Corp2_Raw_NV.Layouts.ActionsLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= ut.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Max	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_first_received, dt_last_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_NV.Filenames(pversion).Base.Actions.New, baseactions, Build_Actions_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Actions_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NV.Build_Bases_Actions attribute')
									 );

END;
