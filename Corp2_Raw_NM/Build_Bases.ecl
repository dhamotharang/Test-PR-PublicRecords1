IMPORT tools, ut;

EXPORT Build_Bases(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																								puseprod,
	DATASET(Corp2_Raw_NM.Layouts.ImportMasterLayoutIn)		pInImportMasterFile   = Corp2_Raw_NM.Files(pfiledate,puseprod).Input.ImportMaster.Logical,
	DATASET(Corp2_Raw_NM.Layouts.ImportMasterLayoutBase)	pBaseImportMasterFile = IF(Corp2_Raw_NM._Flags.Base.Corporation, Corp2_Raw_NM.Files(,pUseOtherEnvironment := FALSE).Base.ImportMaster.qa, DATASET([], Corp2_Raw_NM.Layouts.ImportMasterLayoutBase))
) := MODULE

	Corp2_Raw_NM.Layouts.ImportMasterLayoutBase standardize_input(Corp2_Raw_NM.Layouts.ImportMasterLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the NM Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInImportMasterFile, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseImportMasterFile;
	combined_dist := DISTRIBUTE(combined, HASH(Corp_Nmscc));
	combined_sort := SORT(combined_dist, corp_nmscc, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_NM.Layouts.ImportMasterLayoutBase rollupBase(	Corp2_Raw_NM.Layouts.ImportMasterLayoutBase L,
																													Corp2_Raw_NM.Layouts.ImportMasterLayoutBase R) := TRANSFORM
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
	tools.mac_WriteFile(Corp2_Raw_NM.Filenames(pversion).Base.ImportMaster.New, basecorporations, Build_Corporation_Base);

	EXPORT full_build := sequential(	Build_Corporation_Base,
																		Promote(pversion).buildfiles.New2Built,	
																		Promote().BuildFiles.Built2QA);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NM.Build_Bases attribute')
									 );

END;
