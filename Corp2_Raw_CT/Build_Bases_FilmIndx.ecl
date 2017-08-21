IMPORT tools, corp2;

EXPORT Build_Bases_FilmIndx(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_CT.Layouts.FilmIndxLayoutIn)		pInFilmIndx   	= Corp2_Raw_CT.Files(pfiledate,pUseProd).Input.fFilmIndx,
	DATASET(Corp2_Raw_CT.Layouts.FilmIndxLayoutBase)	pBaseFilmIndx 	= IF(Corp2_Raw_CT._Flags.Base.FilmIndx, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.FilmIndx.qa, 	DATASET([], Corp2_Raw_CT.Layouts.FilmIndxLayoutBase))
) := MODULE

	Corp2_Raw_CT.Layouts.FilmIndxLayoutBase standardize_input(Corp2_Raw_CT.Layouts.FilmIndxLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
	end;

	// Take the IA FilmIndx update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInFilmIndx, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseFilmIndx;
	combined_dist := DISTRIBUTE(combined, HASH(idFlngNbr));
	combined_sort := SORT(combined_dist, idFlngNbr, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CT.Layouts.FilmIndxLayoutBase rollupBase(Corp2_Raw_CT.Layouts.FilmIndxLayoutBase L,
																										  Corp2_Raw_CT.Layouts.FilmIndxLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseFilmIndx			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CT.Filenames(pversion).Base.FilmIndx.New, baseFilmIndx, Build_FilmIndx_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_FilmIndx_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CT.Build_Bases_FilmIndx attribute')
									 );

END;
