IMPORT tools, ut;

EXPORT Build_Bases_RA(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																								puseprod,
	DATASET(Corp2_Raw_NV.Layouts.RALayoutIn)							pInRA   	= Corp2_Raw_NV.Files(pfiledate,puseprod).Input.RA.Logical,
	DATASET(Corp2_Raw_NV.Layouts.RALayoutBase)						pBaseRA 	= IF(Corp2_Raw_NV._Flags.Base.RA, Corp2_Raw_NV.Files(,pUseOtherEnvironment := FALSE).Base.RA.qa, DATASET([], Corp2_Raw_NV.Layouts.RALayoutBase))
) := MODULE

	Corp2_Raw_NV.Layouts.RALayoutBase standardize_input(Corp2_Raw_NV.Layouts.RALayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the NV RA update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInRA, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseRA;
	combined_dist := DISTRIBUTE(combined, HASH(ra_id));
	combined_sort := SORT(combined_dist, ra_id, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_NV.Layouts.RALayoutBase rollupBase(	Corp2_Raw_NV.Layouts.RALayoutBase L,
																								Corp2_Raw_NV.Layouts.RALayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= ut.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Max	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basera					 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_first_received, dt_last_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_NV.Filenames(pversion).Base.RA.New, basera, Build_RA_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_RA_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NV.Build_Bases_RA attribute')
									 );

END;
