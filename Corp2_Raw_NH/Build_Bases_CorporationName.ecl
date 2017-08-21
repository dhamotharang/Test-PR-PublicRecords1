IMPORT corp2, tools;

EXPORT Build_Bases_CorporationName(
	STRING																										pfiledate,
	STRING																										pversion,
	BOOLEAN																										puseprod,
	DATASET(Corp2_Raw_NH.Layouts.CorporationNameLayoutIn)			pInCorporationName   		= Corp2_Raw_NH.Files(pfiledate,puseprod).Input.CorporationName.Logical,
	DATASET(Corp2_Raw_NH.Layouts.CorporationNameLayoutBase)		pBaseCorporationName 		= IF(Corp2_Raw_NH._Flags.Base.CorporationName, Corp2_Raw_NH.Files(,pUseOtherEnvironment := FALSE).Base.CorporationName.qa, DATASET([], Corp2_Raw_NH.Layouts.CorporationNameLayoutBase))
) := MODULE

	Corp2_Raw_NH.Layouts.CorporationNameLayoutBase standardize_input(Corp2_Raw_NH.Layouts.CorporationNameLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self 										:= 	 L;
	end;

	// Take the NM Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorporationName, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorporationName;
	combined_dist := DISTRIBUTE(combined, HASH(mergerid));
	combined_sort := SORT(combined_dist, mergerid, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_NH.Layouts.CorporationNameLayoutBase rollupBase(	Corp2_Raw_NH.Layouts.CorporationNameLayoutBase L,
																															Corp2_Raw_NH.Layouts.CorporationNameLayoutBase R) := TRANSFORM
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
	tools.mac_WriteFile(Corp2_Raw_NH.Filenames(pversion).Base.CorporationName.New, baserollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NH.Build_Bases_CorporationName attribute')
									 );

END;
