IMPORT tools, corp2;

EXPORT Build_Bases_f04_Officer(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_OK.Layouts.Officer_04_Layout)		  pInf04_Officer   	= Corp2_Raw_OK.Files(pfiledate,pUseProd).Input.f04_Officer,
	DATASET(Corp2_Raw_OK.Layouts.Officer_04_LayoutBase)	pBasef04_Officer 	= IF(Corp2_Raw_OK._Flags.Base.f04_Officer, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f04_Officer.qa, 	DATASET([], Corp2_Raw_OK.Layouts.Officer_04_LayoutBase))
) := MODULE

	Corp2_Raw_OK.Layouts.Officer_04_LayoutBase standardize_input(Corp2_Raw_OK.Layouts.Officer_04_Layout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the IA f04_Officer update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInf04_Officer, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasef04_Officer;
	combined_dist := DISTRIBUTE(combined, HASH(f04_Filing_Number));
	combined_sort := SORT(combined_dist, f04_Filing_Number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_OK.Layouts.Officer_04_LayoutBase rollupBase(Corp2_Raw_OK.Layouts.Officer_04_LayoutBase L,
																										   Corp2_Raw_OK.Layouts.Officer_04_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basef04_Officer			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_OK.Filenames(pversion).Base.f04_Officer.New, basef04_Officer, Build_f04_Officer_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_f04_Officer_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OK.Build_Bases_f04_Officer attribute')
									 );

END;
