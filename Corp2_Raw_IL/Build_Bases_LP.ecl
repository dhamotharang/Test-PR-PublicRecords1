IMPORT corp2, tools;

EXPORT Build_Bases_LP(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN																					puseprod,	
	DATASET(Corp2_Raw_IL.Layouts.StringLayoutIn)		pInMaster   = Corp2_Raw_IL.Files(pfiledate,pUseProd).Input.LP.MasterString.Logical,
	DATASET(Corp2_Raw_IL.Layouts.StringLayoutBase)	pBaseMaster = IF(Corp2_Raw_IL._Flags.Base.LP.Master, Corp2_Raw_IL.Files(,pUseOtherEnvironment := FALSE).Base.LP.Master.qa, DATASET([], Corp2_Raw_IL.Layouts.StringLayoutBase))
) := MODULE

	Corp2_Raw_IL.Layouts.StringLayoutBase standardize_input(Corp2_Raw_IL.Layouts.StringLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the IL Master update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInMaster, standardize_input(LEFT));

	// Combine update with previous base.
	combined 			:= workingUpdate + pBaseMaster;
	combined_dist := DISTRIBUTE(combined, HASH(payload));
	combined_sort := SORT(combined_dist, payload, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_IL.Layouts.StringLayoutBase rollupBase(	Corp2_Raw_IL.Layouts.StringLayoutBase L,
																										Corp2_Raw_IL.Layouts.StringLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	basefile := ROLLUP(	combined_sort,
											rollupBase(LEFT, RIGHT),
											RECORD,
											EXCEPT dt_first_received, dt_last_received,
											LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_IL.Filenames(pversion).Base.LP.Master.New, basefile, Build_Corporation_Base);

	EXPORT full_build := SEQUENTIAL(	Build_Corporation_Base,
																		Promote(pversion).LP.BuildFiles.New2Built,
																		Promote().LP.BuildFiles.Built2QA);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_IL.Build_Bases_LP attribute')
									);

END;

		
