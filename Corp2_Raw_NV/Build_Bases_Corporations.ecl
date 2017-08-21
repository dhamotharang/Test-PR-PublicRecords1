IMPORT tools, ut;

EXPORT Build_Bases_Corporations(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																								puseprod,
	DATASET(Corp2_Raw_NV.Layouts.CorporationsLayoutIn)		pInCorporation   = Corp2_Raw_NV.Files(pfiledate,puseprod).Input.Corporation.Logical,
	DATASET(Corp2_Raw_NV.Layouts.CorporationsLayoutBase)	pBaseCorporation = IF(Corp2_Raw_NV._Flags.Base.Corporation, Corp2_Raw_NV.Files(,pUseOtherEnvironment := FALSE).Base.Corporation.qa, DATASET([], Corp2_Raw_NV.Layouts.CorporationsLayoutBase))
) := MODULE

	Corp2_Raw_NV.Layouts.CorporationsLayoutBase standardize_input(Corp2_Raw_NV.Layouts.CorporationsLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the NV Corporation update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorporation, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorporation;
	combined_dist := DISTRIBUTE(combined, HASH(corp_id));
	combined_sort := SORT(combined_dist, corp_id, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_NV.Layouts.CorporationsLayoutBase rollupBase(	Corp2_Raw_NV.Layouts.CorporationsLayoutBase L,
																													Corp2_Raw_NV.Layouts.CorporationsLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= ut.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Max	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basecorporations := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_first_received, dt_last_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_NV.Filenames(pversion).Base.Corporation.New, basecorporations, Build_Corporation_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Corporation_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NV.Build_Bases_Corporations attribute')
									 );

END;
