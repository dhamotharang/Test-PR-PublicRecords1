IMPORT corp2, tools;

EXPORT Build_Bases_Filing(
	STRING																						pfiledate,
	STRING																						pversion,
	BOOLEAN																						puseprod,
	DATASET(Corp2_Raw_NH.Layouts.FilingLayoutIn)			pInFiling   	= Corp2_Raw_NH.Files(pfiledate,puseprod).Input.Filing.Logical,
	DATASET(Corp2_Raw_NH.Layouts.FilingLayoutBase)		pBaseFiling 	= IF(Corp2_Raw_NH._Flags.Base.Filing, Corp2_Raw_NH.Files(,pUseOtherEnvironment := FALSE).Base.Filing.qa, DATASET([], Corp2_Raw_NH.Layouts.FilingLayoutBase))
) := MODULE

	Corp2_Raw_NH.Layouts.FilingLayoutBase standardize_input(Corp2_Raw_NH.Layouts.FilingLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self 										:= 	 L;
	end;

	// Take the NM Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInFiling, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseFiling;
	combined_dist := DISTRIBUTE(combined, HASH(filingid));
	combined_sort := SORT(combined_dist, filingid, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_NH.Layouts.FilingLayoutBase rollupBase(	Corp2_Raw_NH.Layouts.FilingLayoutBase L,
																										Corp2_Raw_NH.Layouts.FilingLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate	(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate		(L.dt_last_received, 	R.dt_last_received);

	  SELF := L;
	END;
	
	baserollup			 					:= ROLLUP(combined_sort,
																			rollupBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_NH.Filenames(pversion).Base.Filing.New, baserollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NH.Build_Bases_Filing attribute')
									 );

END;
